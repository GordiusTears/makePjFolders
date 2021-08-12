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
    
    folders = ["data", "docs\\emf", "figs", "models", "scripts", "libraries", "work\\cache", "work\\codegen"];
    PathedFolders = ["data",  "models", "scripts", "libraries"];

    %%
    currentDir = pwd;

    %%
    for ii = 1:numel(folders)
        folder = folders(ii);
        if isfolder(folder) == 0
            [status, ~, ~] = mkdir(folder);
            if status
                fprintf("%s is created.\n", folder)
            else
                fprintf("make %s is failed.\n", folder)
            end
        end
    end

    %% プロジェクト名の設定
    proj = matlab.project.createProject(currentDir);
    if PjName ~= ""
        proj.Name = PjName;
    end

    %% フォルダをPjに追加
    for ii = 1:numel(folders)
        folder = folders(ii);
        addFile(proj, folder)
    end

    %% パスを追加
    for ii = 1:numel(PathedFolders)
        folder = PathedFolders(ii);
        newfolderPath = addPath(proj, folder);
    end

    %% キャッシュ・コード生成フォルダの指定
    cacheDir   = sprintf("%s\\work\\cache",    proj.RootFolder);
    codeGenDir = sprintf("%s\\work\\codegen",  proj.RootFolder);
    proj.SimulinkCacheFolder  = cacheDir;
    proj.SimulinkCodeGenFolder= codeGenDir;

    %% プロジェクトファイル名の変更
    proj.close
    if PjName ~= ""
        PjFileName = PjName + ".prj";
        movefile("Blank_project.prj", PjFileName)
        proj = matlab.project.loadProject(currentDir);
    end

end