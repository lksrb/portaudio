project "PortAudio"
	kind "StaticLib"
	language "C"
    staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-obj/" .. outputdir .. "/%{prj.name}")

	defines {
		"_CRT_SECURE_NO_WARNINGS"
	}

	includedirs {
		"include",
		"src/common"
	}

	files {
		"src/common/**.h",
		"src/common/**.c"
	}

	filter "system:windows"
		systemversion "latest"

		defines {
			"PA_USE_WMME",
			"PA_LITTLE_ENDIAN"
		}

		includedirs {
			"src/os/win",
			"src/hostapi/wmme"
		}

		files {
			"src/os/win/**.h",
			"src/os/win/**.c",
			"src/hostapi/wmme/pa_win_wmme.c"
		}

	filter "system:linux"
		pic "On"
		systemversion "latest"

		defines {
			"PA_USE_ALSA",
			"PA_LITTLE_ENDIAN"
		}

		includedirs {
			"src/os/unix",
			"src/hostapi/alsa"
		}

		files {
			"src/unix/**.h",
			"src/unix/**.c",
			"src/hostapi/alsa/pa_linux_alsa.c"
		}

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
		symbols "on"

	filter "configurations:Dist"
		runtime "Release"
		optimize "on"
		symbols "off"
