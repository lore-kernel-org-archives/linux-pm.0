From: Michael Turquette <mturquette@linaro.org>
Subject: [PATCH RFC v2 0/4] scheduler-driven cpu frequency selection
Date: Mon, 11 May 2015 19:13:11 -0700
Message-ID: <1431396795-32439-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, abelvesa@gmail.com, Michael Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

This series implements an event-driven cpufreq governor that scales cpu
frequency as a function of cfs runqueue utilization. The intent of this RFC is
to get some discussion going about how the scheduler can become the policy
engine for selecting cpu frequency, what limitations exist and what design do
we want to take to get to a solution.

V2 changes the interface exposed from the governor to cfs. Instead of being a
"pull" model where get_cpu_usage is used to fetch the utilization, that
information is pushed into the governor. After making this change it becomes
clear that selecting a new capacity target for a cpu can be done entirely
within fair.c without any knowledge of cpufreq or the hardware. I didn't go
that far in this version of the series, but it is something to consider. Such a
change would mean that we do not pass in a utilization value but instead a
capacity target.

RFC v1 from May 4, 2015:
http://lkml.kernel.org/r/<1430777441-15087-1-git-send-email-mturquette@linaro.org>

Old, original idea from October/November of 2014:
http://lkml.kernel.org/r/<1413958051-7103-1-git-send-email-mturquette@linaro.org>

This series depends on having frequency-invariant representations for load.
This requires Vincent's recently merged cpu capacity rework patches, as well as
a new patch from Morten included here. Morten's patch will likely make an
appearance in his energy aware scheduling v4 series.

Thanks to Juri Lelli <juri.lelli@arm.com> for contributing to the development
of the governor.

A git branch with these patches can be pulled from here:
https://git.linaro.org/people/mike.turquette/linux.git sched-freq

Smoke testing has been done on an OMAP4 Pandaboard and an Exynos 5800
Chromebook2. Extensive benchmarking and regression testing has not yet been
done.

Michael Turquette (3):
  sched: sched feature for cpu frequency selection
  sched: expose capacity_of in sched.h
  sched: cpufreq_cfs: pelt-based cpu frequency scaling

Morten Rasmussen (1):
  arm: Frequency invariant scheduler load-tracking support

 arch/arm/include/asm/topology.h |   7 +
 arch/arm/kernel/smp.c           |  53 ++++++-
 arch/arm/kernel/topology.c      |  17 ++
 drivers/cpufreq/Kconfig         |  24 +++
 include/linux/cpufreq.h         |   3 +
 kernel/sched/Makefile           |   1 +
 kernel/sched/cpufreq_cfs.c      | 343 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c             |  24 ++-
 kernel/sched/features.h         |   6 +
 kernel/sched/sched.h            |  13 ++
 10 files changed, 484 insertions(+), 7 deletions(-)
 create mode 100644 kernel/sched/cpufreq_cfs.c

-- 
1.9.1
