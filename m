From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH v3 0/4] scheduler-driven cpu frequency selection
Date: Fri, 26 Jun 2015 16:53:40 -0700
Message-ID: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org, abelvesa@gmail.com, pebolle@tiscali.nl, Michael Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

This series addresses the comments from v2 and rearranges the code to
separate the bits that are safe to merge from the bits that are not. In
particular the simplified governor no longer implements any policy of
its own. That code is migrated to fair.c and marked as RFC. The
capacity-selection code in fair.c (patch #4) is a placeholder and can be
replaced by something more sophisticated, and it illustrates the use of
the new governor api's for anyone that wants to play around with
crafting a new policy.

Patch #1 is a re-post from Morten, as it is the only dependency these
patches have on his EAS series. Please consider merging patches #2 and
#3 if they do not appear too controversial. Without enabling the feature
in Kconfig will be no impact on existing code.

Michael Turquette (3):
  cpufreq: introduce cpufreq_driver_might_sleep
  sched: scheduler-driven cpu frequency selection
  [RFC] sched: cfs: cpu frequency scaling policy

Morten Rasmussen (1):
  arm: Frequency invariant scheduler load-tracking support

 arch/arm/include/asm/topology.h |   7 +
 arch/arm/kernel/smp.c           |  53 ++++++-
 arch/arm/kernel/topology.c      |  17 +++
 drivers/cpufreq/Kconfig         |  24 ++++
 drivers/cpufreq/cpufreq.c       |   6 +
 include/linux/cpufreq.h         |  12 ++
 kernel/sched/Makefile           |   1 +
 kernel/sched/cpufreq_sched.c    | 308 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c             |  41 ++++++
 kernel/sched/sched.h            |   8 ++
 10 files changed, 475 insertions(+), 2 deletions(-)
 create mode 100644 kernel/sched/cpufreq_sched.c

-- 
1.9.1
