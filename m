From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 0/9] cpufreq: Introduce support for ST's cpufreq functionality
Date: Wed, 24 Jun 2015 14:58:59 +0100
Message-ID: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This driver reads very platform specific information in from Device Tree
and translates it into frequency tables.  The generic drivers then use the
tables to conduct frequency and voltage scaling in the normal way.

There are 'ARM' patches in the set which are not necessarily related to CPUFreq,
but are required to get it to work.  Anyone who is not interested in general STi
DT changes can safely ignore these.

v1 => v2:
 - CPUFreq is no longer it's own device in DT; instead:
   - It is probed from the platform area
   - Key properties have been moved into the CPU's node
 - Driver is less generic [ST => STI]
 - Documentation has been updated
   - Point one (above) has been accounted for
   - Example of bootloader supplied node has been provided
 - GPL licensing has been updated to reflected the header
 - Kconfig disparity has been rectified [bool => tristate]

Lee Jones (9):
  ARM: STi: STiH407: Provide generic (safe) DVFS configuration
  ARM: STi: STiH407: Provide CPU with clocking information
  ARM: STi: STiH407: Link CPU with its voltage supply
  ARM: STi: STiH407: Provide CPU with a means to look-up Major number
  ARM: STi: Register CPUFreq device
  ARM: STi: STiH407: Move PWM nodes STiH407 => STiH407-family
  ARM: multi_v7_defconfig: Enable support for PWM Regulators
  dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation
  cpufreq: st: Provide runtime initialised driver for ST's platforms

 .../devicetree/bindings/cpufreq/cpufreq-st.txt     |  72 ++++
 arch/arm/boot/dts/stih407-family.dtsi              |  45 +++
 arch/arm/boot/dts/stih407.dtsi                     |  28 --
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/mach-sti/Makefile                         |   2 +-
 arch/arm/mach-sti/board-dt.c                       |   3 +-
 arch/arm/mach-sti/{platsmp.c => cpu.c}             |  17 +-
 arch/arm/mach-sti/{smp.h => cpu.h}                 |   2 +
 drivers/cpufreq/Kconfig.arm                        |   7 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/sti-cpufreq.c                      | 447 +++++++++++++++++++++
 11 files changed, 593 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
 rename arch/arm/mach-sti/{platsmp.c => cpu.c} (91%)
 rename arch/arm/mach-sti/{smp.h => cpu.h} (92%)
 create mode 100644 drivers/cpufreq/sti-cpufreq.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
