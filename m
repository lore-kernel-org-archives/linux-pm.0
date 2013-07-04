From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v5 0/7] cpufreq:boost: CPU Boost mode support
Date: Thu, 04 Jul 2013 10:50:23 +0200
Message-ID: <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16694 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab3GDIuy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2013 04:50:54 -0400
In-reply-to: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>

This patch series introduces support for CPU overclocking technique
called Boost.

It is a follow up of a LAB governor proposal. Boost is a LAB component:
http://thread.gmane.org/gmane.linux.kernel/1484746/match=cpufreq

Boost unifies hardware based solution (e.g. Intel Nehalem) with
software oriented one (like the one done at Exynos).
For this reason cpufreq/freq_table code has been reorganized to include
common code.

Important design decisions:

- Boost related code is compiled-in unconditionally to cpufreq core and 
  disabled by default. The cpufreq_driver is responsibile for setting 
  boost_supported flag and providing enable_boost callback(if HW support
  is needed). For software managed boost, special Kconfig flag - 
  CONFIG_CPU_FREQ_BOOST_SW has been defined. It will be selectable only
  when a target platform has thermal framework properly configured.

- struct cpufreq_driver has been extended with boost related fields:
        -- boost_supported - when driver supports boosting
        -- enable_boost - callback to function, which is necessary to
           enable boost

- Boost sysfs attribute (/sys/devices/system/cpu/cpufreq/boost) is visible
  _only_ when cpufreq driver supports Boost.

- No special spin_lock for Boost was created. The one from cpufreq core
  was reused.

- All available policies are now stored in a list.

- The Boost code doesn't rely on any policy. When boost state is changed,
  then the policy list is iterated and proper adjustements are done.

- To improve safety level, the thermal framework is also extended to disable
  software boosting, when thermal trip point is reached. Then it starts 
  monitoring of target temperature to evaluate if boost can be enabled 
  again. This emulates behaviour similar to HW managed boost (like x86)

New patches for v5:
cpufreq:boost:Kconfig: Enable software managed BOOST support at Kconfig
Documentation:cpufreq:boost: Update BOOST documentation

Patches dropped at v5:
cpufreq: Calculate number of busy CPUs
cpufreq: Enable software boost only when up to one busy core is running

Tested at: HW:
        Exynos 4412 3.10 linux
        Exynos 4210 3.10 linux
Compile tested x86_64 defconfig (acpi) - help with HW (Intel Nehalem) test
 needed

The code has been rebased on top of kernel_pm/bleeding-edge (3.11-rc1)


Lukasz Majewski (7):
  cpufreq: Store cpufreq policies in a list
  cpufreq: Add boost frequency support in core
  cpufreq:acpi:x86: Adjust the acpi-cpufreq.c code to work with common
    boost solution
  cpufreq:exynos:Extend Exynos cpufreq driver to support boost
    framework
  thermal:boost: Automatic enable/disable of BOOST feature
  cpufreq:boost:Kconfig: Enable software managed BOOST support at
    Kconfig
  Documentation:cpufreq:boost: Update BOOST documentation

 Documentation/cpu-freq/boost.txt |   26 ++++-----
 drivers/cpufreq/Kconfig          |   14 +++++
 drivers/cpufreq/acpi-cpufreq.c   |   69 +++++++----------------
 drivers/cpufreq/cpufreq.c        |  115 ++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/exynos-cpufreq.c |    9 ++-
 drivers/cpufreq/freq_table.c     |   47 +++++++++++++---
 drivers/thermal/thermal_core.c   |   31 ++++++++++
 include/linux/cpufreq.h          |   13 +++++
 include/linux/thermal.h          |    2 +
 9 files changed, 257 insertions(+), 69 deletions(-)

-- 
1.7.10.4

