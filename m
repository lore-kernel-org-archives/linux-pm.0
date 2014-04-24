From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/3] sched: idle: Provide the basis to integrate cpuidle
Date: Thu, 24 Apr 2014 14:24:48 +0200
Message-ID: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

This patchset provides three patches for the basis to integrate cpuidle with
the scheduler.

The first patch is a cleanup.
The second one adds the sched balance option as requested by Ingo.
The third one stores the idle state a cpu is and adds a rcu_barrier() to
 prevent races when using the pointed object.

This patchset is based on top of v3.15-rc2.

This patchset does not modify the behavior of the scheduler.

Taking into account the cpuidle information from the scheduler will be
posted in a separate patchset in order to keep focused on the right decisions
the scheduler should take regarding the policy vs idle parameters.

Daniel Lezcano (3):
  sched: idle: Encapsulate the code to compile it out
  sched: idle: Add sched balance option
  sched: idle: Store the idle state the cpu is

 drivers/cpuidle/cpuidle.c    |    6 ++
 include/linux/sched/sysctl.h |   14 ++++
 kernel/sched/fair.c          |   92 ++++++++++++++++++++++-
 kernel/sched/idle.c          |  169 +++++++++++++++++++++++-------------------
 kernel/sched/sched.h         |    5 ++
 kernel/sysctl.c              |   11 +++
 6 files changed, 220 insertions(+), 77 deletions(-)

-- 
1.7.9.5
