From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] Auto-promotion logic for cpuidle states
Date: Fri,  5 Apr 2019 04:16:45 -0500
Message-ID: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Currently, the cpuidle governors (menu/ladder) determine what idle state a
idling CPU should enter into based on heuristics that depend on the idle
history on that CPU. Given that no predictive heuristic is perfect, there
are cases where the governor predicts a shallow idle state, hoping that
the CPU will be busy soon. However, if no new workload is scheduled on
that CPU in the near future, the CPU will end up in the shallow state.

Motivation
----------
In case of POWER, this is problematic, when the predicted state in the
aforementioned scenario is a lite stop state, as such lite states will
inhibit SMT folding, thereby depriving the other threads in the core from
using the core resources.

To address this, such lite states need to be autopromoted. The cpuidle-core
can queue timer to correspond with the residency value of the next
available state. Thus leading to auto-promotion to a deeper idle state as
soon as possible.

Experiment
----------
I performed experiments for three scenarios to collect some data.

case 1 :
Without this patch and without tick retained, i.e. in a upstream kernel,
It would spend more than even a second to get out of stop0_lite.

case 2 : With tick retained(as suggested) -

Generally, we have a sched tick at 4ms(CONF_HZ = 250). Ideally I expected
it to take 8 sched tick to get out of stop0_lite. Experimentally,
observation was

=========================================================
sample		min            max           99percentile
20		4ms            12ms          4ms
=========================================================
*ms = milliseconds

It would take atleast one sched tick to get out of stop0_lite.

case 2 :  With this patch (not stopping tick, but explicitly queuing a
 	  timer)

============================================================
sample		min		max		99percentile
============================================================
20		144us		192us     	144us
============================================================
*us = microseconds

In this patch, we queue a timer just before entering into a stop0_lite
state. The timer fires at (residency of next available state + exit latency
of next available state * 2). Let's say if next state(stop0) is available
which has residency of 20us, it should get out in as low as (20+2*2)*8
[Based on the forumla (residency + 2xlatency)*history length] microseconds
= 192us. Ideally we would expect 8 iterations, it was observed to get out
in 6-7 iterations. Even if let's say stop2 is next available state(stop0
and stop1 both are unavailable), it would take (100+2*10)*8 = 960us to get
into stop2.

So, We are able to get out of stop0_lite generally in 150us(with this
patch) as compared to 4ms(with tick retained). As stated earlier, we do not
want to get stuck into stop0_lite as it inhibits SMT folding for other
sibling threads, depriving them of core resources. Current patch is using
auto-promotion only for stop0_lite, as it gives performance benefit(primary
reason) along with lowering down power consumption. We may extend this
model for other states in future.

Abhishek Goel (2):
  cpuidle : auto-promotion for cpuidle states
  cpuidle : Add auto-promotion flag to cpuidle flags

 arch/powerpc/include/asm/opal-api.h |  1 +
 drivers/cpuidle/Kconfig             |  4 ++
 drivers/cpuidle/cpuidle-powernv.c   | 13 +++++-
 drivers/cpuidle/cpuidle.c           | 68 ++++++++++++++++++++++++++++-
 drivers/cpuidle/governors/ladder.c  |  3 +-
 drivers/cpuidle/governors/menu.c    | 22 +++++++++-
 include/linux/cpuidle.h             | 10 ++++-
 7 files changed, 115 insertions(+), 6 deletions(-)

-- 
2.17.1
