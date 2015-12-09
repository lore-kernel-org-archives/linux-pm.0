From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v6 00/10] cpufreq: Introduce ST's CPUFreq driver
Date: Wed,  9 Dec 2015 15:58:07 +0000
Message-ID: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35296 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbbLIP6f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 10:58:35 -0500
Received: by wmuu63 with SMTP id u63so228661946wmu.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2015 07:58:34 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

This is a re-write of the original submission, hence why the
change-log is omitted.  Basically almost everything has changed.
We are now using the new OPP framework and generic bindings
written by Viresh.

There are 'ARM' patches in the set which are not necessarily
related to CPUFreq, but are required to get it to work. Anyone
who is not interested in general STi DT changes can safely
ignore these.

v5 => v6:
 - Converted Kconfig and header comment to describe new driver
 - Complete re-write, using new Generic OPP framework
 - Supply description for "suitable for ALL versions" DEFINE
 - Pedantically re-ordered the #include files
 - Removed platform device registration in arch/arm/mach-sti

v4 => v5:
 - Converted driver away from being a platform device

v1 => v2 => v3 => v4:
 - Moot

Lee Jones (10):
  ARM: multi_v7_defconfig: Enable ST's PWM driver
  ARM: multi_v7_defconfig: Enable ST's Power Reset driver
  ARM: multi_v7_defconfig: Enable support for PWM Regulators
  ARM: STi: STiH407: Provide generic (safe) DVFS configuration
  ARM: STi: STiH407: Provide CPU with clocking information
  ARM: STi: STiH407: Link CPU with its voltage supply
  ARM: STi: STiH407: Provide CPU with a means to look-up Major number
  cpufreq: st: Provide runtime initialised driver for ST's platforms
  dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation
  MAINTAINERS: Add ST's CPUFreq driver to the STI file list

 .../devicetree/bindings/cpufreq/cpufreq-st.txt     |  91 +++++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stih407-family.dtsi              |  20 ++
 arch/arm/configs/multi_v7_defconfig                |   5 +-
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/sti-cpufreq.c                      | 293 +++++++++++++++++++++
 7 files changed, 419 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
 create mode 100644 drivers/cpufreq/sti-cpufreq.c

-- 
1.9.1

