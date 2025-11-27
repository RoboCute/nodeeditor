target("qt_node_editor")
    add_rules("qt.shared")
    add_frameworks("QtGui", "QtWidgets", "QtCore", "QtOpenGL")
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