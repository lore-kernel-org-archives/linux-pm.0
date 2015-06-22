From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/8] cpufreq: Introduce support for ST's cpufreq functionality
Date: Mon, 22 Jun 2015 16:43:49 +0100
Message-ID: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This driver reads very platform specific information in from Device Tree
and translates it into frequency tables.  The generic drivers then use the
tables to conduct frequency and voltage scaling in the normal way.

Lee Jones (8):
  ARM: STi: STiH407: Provide generic (safe) DVFS configuration
  ARM: STi: STiH407: Provide CPU with clocking information
  ARM: STi: STiH407: Link CPU with its voltage supply
  ARM: STi: STiH407: Provide a node for CPUFreq
  ARM: STi: STiH407: Move PWM nodes STiH407 => STiH407-family
  ARM: multi_v7_defconfig: Enable support for PWM Regulators
  cpufreq: st: Provide runtime initialised driver for ST's platforms
  dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation

 .../devicetree/bindings/cpufreq/cpufreq-st.txt     |  48 +++
 arch/arm/boot/dts/stih407-family.dtsi              |  49 +++
 arch/arm/boot/dts/stih407.dtsi                     |  28 --
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/cpufreq/Kconfig.arm                        |   7 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/st-cpufreq.c                       | 450 +++++++++++++++++++++
 7 files changed, 556 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
 create mode 100644 drivers/cpufreq/st-cpufreq.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
