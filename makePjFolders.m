function makePjFolders(varargin)
% MAKEPJFOLDER プロジェクトのフォルダの作成・パス設定・プロジェクト生成
%
    PjName = "";
    if nargin > 0
        input_1 = varargin{1};
        if regexp(input_1, "^[a-zA-Z].*")
            PjName = input_1;
        else
            disp("先頭がアルファベット以外です。")
        end
    end

    % OS非依存のパス指定（fullfileを利用）
    folders = [ ...
        "data", ...
        fullfile("docs","emf"), ...
        "figs", ...
        "models", ...
        "scripts", ...
        "libraries", ...
        fullfile("work","cache"), ...
        fullfile("work","codegen") ...
    ];

    % パス追加対象
    PathedFolders = [ ...
	    "data","models","scripts","libraries", ...
		fullfile("work","cache"), ...
        fullfile("work","codegen") ...
    ];

    currentDir = pwd;

    % 必要フォルダ作成
    for ii = 1:numel(folders)
        folder = folders(ii);
        if ~isfolder(folder)
            [status, ~, ~] = mkdir(folder);
            if status
                fprintf("%s is created.\n", char(folder));
            else
                fprintf("make %s is failed.\n", char(folder));
            end
        end
    end

    % プロジェクト作成
    proj = matlab.project.createProject(currentDir);
    if PjName ~= ""
        proj.Name = PjName;
    end

    % フォルダをプロジェクトに追加
    for ii = 1:numel(folders)
        folder = folders(ii);
        addFile(proj, folder);
    end

    % パスを追加
    for ii = 1:numel(PathedFolders)
        folder = PathedFolders(ii);
        addPath(proj, folder);
    end

    % キャッシュ・コード生成フォルダ（OS非依存に）
    cacheDir   = fullfile(proj.RootFolder, "work", "cache");
    codeGenDir = fullfile(proj.RootFolder, "work", "codegen");
    proj.SimulinkCacheFolder   = cacheDir;
    proj.SimulinkCodeGenFolder = codeGenDir;

    % プロジェクトファイル名の変更
    proj.close
    if PjName ~= ""
        PjFileName = PjName + ".prj";
        movefile(char("Blank_project.prj"), char(PjFileName));
        proj = matlab.project.loadProject(currentDir);
    end
end
