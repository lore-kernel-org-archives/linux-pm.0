From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [RFC v2 0/3] LAB: Support for Legacy Application Booster governor
Date: Fri, 03 May 2013 23:07:49 +0900
Message-ID: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vicent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Lukasz Majewski <l.majewski@samsung.com>

The purpose of this series is to discuss assumptions and idea of implementing
LAB governor support. It shall be treated as a proof-of-concept code for new
(fresh) view on power consumption reduction.

It is divided to three big parts:
1. Low-level code for supporting frequency overclocking at Exynos4 SoCs.
Moreover support for cpufreq_overclock_* interface functions has been added.
This feature is implemented in a way to reduce number of changes at cpufreq
core driver to minimum. 

It alters entries at SoC specific frequency table to allow above the standard 
limits frequency. Exynos TMU (Thermal Management Unit) is a "safe valve" to 
disable overclocking when overheating is detected.

Despite, that this solution is Exynos4 specific it can be easily ported to other 
SoCs.

2. New LAB governor.
It calculates number of idle CPUs (based on scheduler data). On this basis it 
chose proper first level polynomial function for approximation.
Moreover it enables overclocking when single, heavy loaded CPU is running.

Those new heuristics allow for more platform tight frequency level decision.
To work efficienty this governor relies on scheduler to pack as much tasks as 
possible to running cores and put other to IDLE.
Following patches are helpful (one of):
- Vincent Guittot's "packing small tasks" patch
- Alex Shi's power-aware scheduling patch

3. Set of changes needed at core cpufreq code.
The only relevant change is to store idle_time value for each CPU.

Tested at 3.8 linux kernel, Exynos4412 Device

For more details please see respect log messages.


Lukasz Majewski (3):
  cpufreq:overclocking: Overclocking support at Exynos4 SoC
  cpufreq:LAB: Introduce new cpufreq LAB(Legacy Application Boost)
    governor
  cpufreq:LAB: Modify cpufreq_governor to support LAB Governor


 drivers/cpufreq/Kconfig              |   33 +++
 drivers/cpufreq/Makefile             |    1 +
 drivers/cpufreq/cpufreq_governor.c   |    7 +
 drivers/cpufreq/cpufreq_governor.h   |   15 ++
 drivers/cpufreq/cpufreq_lab.c        |  450 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/exynos-cpufreq.c     |  108 ++++++++
 drivers/cpufreq/exynos-cpufreq.h     |    7 +
 drivers/cpufreq/exynos4x12-cpufreq.c |   15 ++
 include/linux/cpufreq.h              |   35 +++
 9 files changed, 671 insertions(+)
 create mode 100644 drivers/cpufreq/cpufreq_lab.c

-- 
1.7.9.5
