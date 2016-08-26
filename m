From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH 0/2] utilization changes for schedutil
Date: Fri, 26 Aug 2016 11:40:46 -0700
Message-ID: <1472236848-17038-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

The first patch (which is a re-send) corrects an issue with utilization on SMT
platforms. Currently CFS utilization is being roughly doubled on these
platforms due to differences in the way PELT and overall max CPU capacity are
calculated.

The second patch moves away from the policy of going to fmax during RT task
activity, instead using rt_avg as an estimate of RT utilization.

Steve Muckle (2):
  sched: cpufreq: ignore SMT when determining max cpu capacity
  sched: cpufreq: use rt_avg as estimate of required RT CPU capacity

 kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

-- 
2.7.3
