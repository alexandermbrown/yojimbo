
libs = { "sodium", "mbedtls", "mbedx509", "mbedcrypto" }

project "yojimbo"
    kind "StaticLib"
    language "C++"
    staticruntime "on"

    targetdir ("build/" .. outputdir .. "/%{prj.name}")
    objdir ("build-int/" .. outputdir .. "/%{prj.name}")

    defines { 
        "NETCODE_ENABLE_TESTS=1", 
        "RELIABLE_ENABLE_TESTS=1" 
    }

    files { 
        "yojimbo.h", 
        "yojimbo.cpp",
        "tlsf/tlsf.h", 
        "tlsf/tlsf.c", 
        "netcode.io/netcode.c", 
        "netcode.io/netcode.h", 
        "reliable.io/reliable.c", 
        "reliable.io/reliable.h" 
    }

    links { libs }

    if os.istarget "windows" then
        includedirs { ".", "./windows", "netcode.io", "reliable.io" }
        libdirs { "./windows" }
    else
        includedirs { ".", "/usr/local/include", "netcode.io", "reliable.io" }
        targetdir "bin/"  
    end

    warnings "Extra"
    floatingpoint "Fast"
    vectorextensions "SSE2"

    filter "configurations:Debug"
        defines "LI_DEBUG"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "LI_RELEASE"
        runtime "Release"
        optimize "on"
    
    filter "configurations:Dist"
        defines "LI_DIST"
        runtime "Release"
        optimize "on"