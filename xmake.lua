rule("qt.mywidget")
    add_deps("qt.ui", "qt.moc", "qt._wasm_app", "qt.qrc", "qt.ts")

    on_config(function (target)
        -- get qt sdk version
        local qt = target:data("qt")
        local qt_sdkver = nil
        if qt.sdkver then
            import("core.base.semver")
            qt_sdkver = semver.new(qt.sdkver)
        end
        local frameworks = {"QtGui", "QtWidgets", "QtCore", "QtOpenGL"}
        import("load")(target, {gui = true, frameworks = frameworks})
    end)

    -- deploy application
    after_build("android", "deploy.android")
    after_build("macosx", "deploy.macosx")

    -- install application for android
    on_install("android", "install.android")
    after_install("windows", "install.windows")
    after_install("mingw", "install.mingw")
rule_end()


target("qt_node_editor")
    set_kind("shared")
    add_rules("qt.mywidget")
    add_headerfiles("include/QtNodes/internal/*.hpp")
    add_files("include/QtNodes/internal/*.hpp")
    add_files("resources/resources.qrc")
    add_files("src/*.cpp") -- source file
    add_includedirs("include", { public = true})
    add_includedirs("src", "include/QtNodes/internal", { private = true})
    add_defines("NODE_EDITOR_SHARED", { public = true})
    add_defines("NODE_EDITOR_EXPORTS", "QT_NO_KEYWORDS", { private = true})
target_end()

-- includes("examples/calculator")