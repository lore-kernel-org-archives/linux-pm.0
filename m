From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v4 0/7] cpufreq:boost: CPU Boost mode support
Date: Wed, 19 Jun 2013 19:12:41 +0200
Message-ID: <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
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

- Boost related code is compiled-in unconditionally and disabled by default
The cpufreq_driver is responsibile for setting boost_supported flag and
providing enable_boost callback(if HW support is needed)

- struct cpufreq_driver has been extended with boost related fields:
        -- boost_supported - when driver supports boosting
        -- enable_boost - callback to function, which is necessary to
           enable boost in the processor (like it is done at Intel)

- Boost sysfs attribute (/sys/devices/system/cpu/cpufreq/boost) is always
provided.
It will be read only, until either cpufreq_driver defines boost_supported
flag or device tree's cpufreq "boost_mode" attribute is defined. It is
consistent with legacy acpi API.

- No special spin_lock for Boost was created. The one from cpufreq core
was reused.

- All available policies are now stored in a list.

- The Boost code doesn't rely on any policy. When boost state is changed,
then the policy list is iterated and proper adjustements are done.

- Number of busy cpus (with load > 90%) is calculated and exported as a
global sysfs attribute.

- The SW based boost can be only enabled when up to one core is regarded as 
a "busy" one. For safety reasons boost is disabled when more cores comes 
into play.

- To improve safety level, the thermal framework is also extended to disable
software boosting, when thermal trip point is reached.

New patches for v4:
cpufreq: Store cpufreq policies in a list
cpufreq: Calculate number of busy CPUs
cpufreq: Enable software boost only when up to one busy core is running
thermal:boost: Disable boost when trip point is reached

Tested at: HW:
        Exynos 4412 3.10 linux
        Exynos 4210 3.10 linux
Compile tested x86_64 defconfig (acpi) - help with HW (Intel Nehalem) test
 needed


Lukasz Majewski (7):
  cpufreq: Store cpufreq policies in a list
  cpufreq: Add boost frequency support in core
  cpufreq:acpi:x86: Adjust the acpi-cpufreq.c code to work with common
    boost solution
  cpufreq:exynos:Extend Exynos cpufreq driver to support boost
    framework
  cpufreq: Calculate number of busy CPUs
  cpufreq: Enable software boost only when up to one busy core is
    running
  thermal:boost: Disable boost when trip point is reached

 drivers/cpufreq/acpi-cpufreq.c     |   61 ++++++-----------
 drivers/cpufreq/cpufreq.c          |  132 ++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq_governor.c |    4 ++
 drivers/cpufreq/exynos-cpufreq.c   |    4 ++
 drivers/cpufreq/freq_table.c       |   43 ++++++++++--
 drivers/thermal/cpu_cooling.c      |    3 +
 include/linux/cpufreq.h            |   15 ++++
 7 files changed, 215 insertions(+), 47 deletions(-)

-- 
1.7.10.4
