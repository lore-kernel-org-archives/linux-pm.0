From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v3 0/3] cpufreq:boost: CPU Boost mode support
Date: Fri, 14 Jun 2013 09:38:57 +0200
Message-ID: <1371195540-2991-1-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
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
The cpufreq_driver is responsibile for providing set_boost_freq callback
(if needed)

- struct cpufreq_driver has been extended with boost related fields:
	-- boost_supported - when driver supports boosting
	-- set_boost_freq - callback to function, which is necessary to
	   enable boost at the processor (like it is done at Intel)
	
- Boost sysfs attributies are seen only when cpufreq driver supports them.
They will not show up until either cpufreq_driver defines boost_supported 
flag or device tree's cpufreq "boost_mode" attribute.

- No special spin_lock for Boost was created. The one from cpufreq_driver
was reused.

- The Boost code doesn't rely on any policy. When boost state is changed,
then policies attached to each CPU are updated.


Tested at: HW:
        Exynos 4412 3.10 linux
        Exynos 4210 3.10 linux
Compile tested x86_64 defconfig (acpi) - help with HW (Intel Nehalem) test
 needed


Lukasz Majewski (3):
  cpufreq: Add boost frequency support in core
  cpufreq:acpi:x86: Adjust the acpi-cpufreq.c code to work with common
    boost solution
  cpufreq:exynos:Extend Exynos cpufreq driver to support boost
    framework

 arch/arm/mach-s3c24xx/cpufreq.c              |    2 +-
 arch/powerpc/platforms/pasemi/cpufreq.c      |    2 +-
 arch/powerpc/platforms/powermac/cpufreq_32.c |    2 +-
 arch/powerpc/platforms/powermac/cpufreq_64.c |    2 +-
 drivers/cpufreq/acpi-cpufreq.c               |   62 +++++++-----------
 drivers/cpufreq/arm_big_little.c             |    3 +-
 drivers/cpufreq/blackfin-cpufreq.c           |    2 +-
 drivers/cpufreq/cpufreq-cpu0.c               |    2 +-
 drivers/cpufreq/cpufreq.c                    |   87 ++++++++++++++++++++++++++
 drivers/cpufreq/cris-artpec3-cpufreq.c       |    2 +-
 drivers/cpufreq/cris-etraxfs-cpufreq.c       |    2 +-
 drivers/cpufreq/davinci-cpufreq.c            |    2 +-
 drivers/cpufreq/dbx500-cpufreq.c             |    2 +-
 drivers/cpufreq/e_powersaver.c               |    3 +-
 drivers/cpufreq/elanfreq.c                   |    2 +-
 drivers/cpufreq/exynos-cpufreq.c             |    7 ++-
 drivers/cpufreq/exynos5440-cpufreq.c         |    2 +-
 drivers/cpufreq/freq_table.c                 |   44 ++++++++++---
 drivers/cpufreq/ia64-acpi-cpufreq.c          |    2 +-
 drivers/cpufreq/imx6q-cpufreq.c              |    2 +-
 drivers/cpufreq/kirkwood-cpufreq.c           |    3 +-
 drivers/cpufreq/longhaul.c                   |    2 +-
 drivers/cpufreq/loongson2_cpufreq.c          |    2 +-
 drivers/cpufreq/maple-cpufreq.c              |    2 +-
 drivers/cpufreq/omap-cpufreq.c               |    2 +-
 drivers/cpufreq/p4-clockmod.c                |    2 +-
 drivers/cpufreq/powernow-k6.c                |    2 +-
 drivers/cpufreq/powernow-k7.c                |    2 +-
 drivers/cpufreq/powernow-k8.c                |    2 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c            |    2 +-
 drivers/cpufreq/pxa2xx-cpufreq.c             |    4 +-
 drivers/cpufreq/pxa3xx-cpufreq.c             |    2 +-
 drivers/cpufreq/s3c2416-cpufreq.c            |    2 +-
 drivers/cpufreq/s3c64xx-cpufreq.c            |    2 +-
 drivers/cpufreq/s5pv210-cpufreq.c            |    2 +-
 drivers/cpufreq/sc520_freq.c                 |    2 +-
 drivers/cpufreq/sh-cpufreq.c                 |    2 +-
 drivers/cpufreq/sparc-us2e-cpufreq.c         |    2 +-
 drivers/cpufreq/sparc-us3-cpufreq.c          |    2 +-
 drivers/cpufreq/spear-cpufreq.c              |    3 +-
 drivers/cpufreq/speedstep-centrino.c         |    2 +-
 drivers/cpufreq/speedstep-ich.c              |    2 +-
 drivers/cpufreq/speedstep-smi.c              |    2 +-
 drivers/cpufreq/tegra-cpufreq.c              |    4 +-
 include/linux/cpufreq.h                      |   18 +++++-
 45 files changed, 211 insertions(+), 95 deletions(-)

-- 
1.7.10.4

