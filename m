From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH 0/1] Forced-wakeup for stop lite states on Powernv
Date: Mon, 22 Apr 2019 01:32:30 -0500
Message-ID: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com, dja@axtens.net, Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Currently, the cpuidle governors determine what idle state a idling CPU
should enter into based on heuristics that depend on the idle history on
that CPU. Given that no predictive heuristic is perfect, there are cases
where the governor predicts a shallow idle state, hoping that the CPU will
be busy soon. However, if no new workload is scheduled on that CPU in the
near future, the CPU will end up in the shallow state.

Motivation
----------
In case of POWER, this is problematic, when the predicted state in the
aforementioned scenario is a lite stop state, as such lite states will
inhibit SMT folding, thereby depriving the other threads in the core from
using the core resources.

So we do not want to get stucked in such states for longer duration. To
address this, the cpuidle-core can queue timer to correspond with the
residency value of the next available state. This timer will forcefully
wakeup the cpu. Few such iterations will essentially train the governor to
select a deeper state for that cpu, as the timer here corresponds to the
next available cpuidle state residency. Cpu will be kicked out of the lite
state and end up in a non-lite state.

Experiment
----------
I performed experiments for three scenarios to collect some data.

case 1 :
Without this patch and without tick retained, i.e. in a upstream kernel,
It would spend more than even a second to get out of stop0_lite.

case 2 : With tick retained in a upstream kernel -

Generally, we have a sched tick at 4ms(CONF_HZ = 250). Ideally I expected
it to take 8 sched tick to get out of stop0_lite. Experimentally,
observation was

=========================================================
sample          min            max           99percentile
20              4ms            12ms          4ms
=========================================================

It would take atleast one sched tick to get out of stop0_lite.

case 2 :  With this patch (not stopping tick, but explicitly queuing a
          timer)

============================================================
sample          min             max             99percentile
============================================================
20              144us           192us           144us
============================================================

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
forced-wakeup only for stop0_lite, as it gives performance benefit(primary
reason) along with lowering down power consumption. We may extend this
model for other states in future.

Abhishek Goel (1):
  cpuidle-powernv : forced wakeup for stop lite states

 arch/powerpc/include/asm/opal-api.h |  1 +
 drivers/cpuidle/cpuidle-powernv.c   | 71 ++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.17.1
