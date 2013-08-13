From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v7 0/7] cpufreq:boost: CPU Boost mode support
Date: Tue, 13 Aug 2013 12:08:18 +0200
Message-ID: <1376388505-30233-1-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

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
  boost_supported flag and providing set_boost callback(if HW support
  is needed). For software managed boost, special Kconfig flag -
  CONFIG_CPU_FREQ_BOOST_SW has been defined. It will be selected only
  when a target platform has thermal framework properly configured.

- struct cpufreq_driver has been extended with boost related fields:
        -- boost_supported - when driver supports boosting
        -- boost_enabled - boost state
        -- set_boost - callback to function, which is necessary to
           enable/disable boost

- Boost sysfs attribute (/sys/devices/system/cpu/cpufreq/boost) is visible
  _only_ when cpufreq driver supports Boost.

- No special spin_lock for Boost was created. The one from cpufreq core
  was reused.

- The Boost code doesn't rely on any policy. When boost state is changed,
  then the policy list is iterated and proper adjustements are done.

- To improve safety level, the thermal framework is also extended to disable
  software boosting, when thermal trip point is reached. Then it starts
  monitoring target temperature to evaluate if boost can be enabled
  again. This emulates behaviour similar to HW managed boost (like x86)

Tested at HW:
       Exynos 4412 3.11-rc4 Linux
       Intel Core i7-3770 3.11-rc4 Linux

Above patches were posted on top of linux_pm/linux-next with following
patches applied:

cpufreq: exynos5440: Fix to skip when new frequency same as current
cpufreq: fix EXYNOS drivers selection

Lukasz Majewski (7):
  cpufreq: Add boost frequency support in core
  cpufreq:acpi:x86: Adjust the acpi-cpufreq.c code to work with common
    boost solution
  thermal:boost: Automatic enable/disable of BOOST feature
  cpufreq:boost:Kconfig: Provide support for software managed BOOST
  cpufreq:exynos:Extend Exynos cpufreq driver to support boost
    framework
  Documentation:cpufreq:boost: Update BOOST documentation
  cpufreq:exynos4x12: Change L0 driver data to CPUFREQ_BOOST_FREQ

 Documentation/cpu-freq/boost.txt     |   26 ++++----
 drivers/cpufreq/Kconfig              |    4 ++
 drivers/cpufreq/Kconfig.arm          |   15 +++++
 drivers/cpufreq/acpi-cpufreq.c       |   86 +++++++++----------------
 drivers/cpufreq/cpufreq.c            |  115 +++++++++++++++++++++++++++++++++-
 drivers/cpufreq/exynos-cpufreq.c     |    6 ++
 drivers/cpufreq/exynos4x12-cpufreq.c |    2 +-
 drivers/cpufreq/freq_table.c         |   53 +++++++++++++---
 drivers/thermal/thermal_core.c       |   55 ++++++++++++++++
 include/linux/cpufreq.h              |   26 +++++++-
 include/linux/thermal.h              |    2 +
 11 files changed, 310 insertions(+), 80 deletions(-)

-- 
1.7.10.4

