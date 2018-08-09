From: Leo Yan <leo.yan@linaro.org>
Subject: [RESEND PATCH v1 0/2] Optimization CPU idle state impacted by tick
Date: Fri, 10 Aug 2018 01:20:01 +0800
Message-ID: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

After Rafael's patch series 'sched/cpuidle: Idle loop rework' has been
merged in mainline kernel, it perfectly resolved the Powernightmares
issue [1] with not stopping the tick during the idle loop; we verified
this patch series on Arm platform (96boards Hikey620 with octa CA53
CPUs) with the rt-app [2] program to generate workloads: a single task
with below combinded configurations with period 5ms and duty cycle
1%/3%/5%/10%/20%/30%/40%.

After run these testing cases, we found the CPU cannot stay in deepest
idle state as expected, the issues essentialy are related with sched
tick:

The prominent issue is the criteria for decision stopping tick; now
the criteria is checking expected interval is less than TICK_USEC, but
this doesn't consider from the perspective of idle state parameters, so
we can observe the CPU even has enough sleeping time but it cannot run
into deepest idle state; this is very serious for some specific ducy
cycle cases.

Another issue is after tick keeping running in idle state, the tick
can heavily impact on 'menu' governor metrics, especially it will
introduce many noise for next event correction factors.

This patch series tries to fix these two issues; patch 0001 wants to
define a time point to distinguish for stopping or not, this time point
consideres the factors from tick period and the maximum target residency
and use prediction period to compare this time point to decide if need
to stop tick.  Patch 0002 wants to always to give compensation for tick
event so that dimiss the tick impaction on correction factors for next
time prediction.

Blow table are comparison results for testing cases between without and
with this patch series; we run the test case with single task with period
5ms with different dutycycle, the total running time is 10s.  Based on
the tracing log, we do statistics for all CPUs for all idle states
duration, the unit is second (s), on Hikey board the result shows the C2
state (the CPU deepest state) selection improvement.

Some notations are used in the table:

state: C0: WFI; C1: CPU OFF; C2: Cluster OFF

All testing cases have single task with 5ms period:

		 Without patches                  With patches                   Difference
            -----------------------------  -----------------------------  -------------------------------
Duty cycle      C0        C1        C2         C0        C1         C2         C0        C1         C2
  1%        0.218589  4.208460  87.995606  0.119723  0.847116  91.940569  -0.098866  -3.361344  +3.944963
  3%        0.801521  5.031361  86.444753  0.147346  0.820276  91.761191  -0.654175  -4.211085  +5.316438
  5%        0.590236  2.733048  88.284541  0.149237  1.042383  90.490482  -0.440999  -1.690665  +2.205941
 10%        0.601922  6.282368  84.899870  0.169491  1.304985  89.725754  -0.432431  -4.977383  +4.825884
 20%        1.381870  8.531687  80.627691  0.307390  3.302562  86.686887  -1.074480  -5.229125  +6.059196
 30%        1.785221  6.974483  81.083312  0.548050  5.319929  83.551747  -1.237171  -1.654554  +2.468435
 40%        1.403247  6.474203  80.577176  0.467686  6.366482  81.983384  -0.935561  -0.107721  +1.406208


Leo Yan (2):
  cpuidle: menu: Correct the criteria for stopping tick
  cpuidle: menu: Dismiss tick impaction on correction factors

 drivers/cpuidle/governors/menu.c | 55 ++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 10 deletions(-)

-- 
2.7.4
