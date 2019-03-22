From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Auto-promotion logic for cpuidle states
Date: Fri, 22 Mar 2019 01:25:28 -0500
Message-ID: <20190322062530.7586-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au, Abhishek Goel <huntbag@linux.vnet.ibm.com>
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
Without this patch -
It was seen that for a idle system, a cpu may remain in stop0_lite for few
seconds and then directly goes to a deeper state such as stop2.

With this patch -
A cpu will not remain in stop0_lite for more than the residency of next
available state, and thus it will go to a deeper state in conservative
fashion. Using this, we may spent even less than 20 milliseconds if
susbsequent stop states are enabled. In the worst case, we may end up
spending more than a second, as was the case without this patch. The
worst case will occur in the scenario when no other shallow states are
enbaled, and only deep states are available for auto-promotion.

Abhishek Goel (2):
  cpuidle : auto-promotion for cpuidle states
  cpuidle : Add auto-promotion flag to cpuidle flags

 arch/powerpc/include/asm/opal-api.h |  1 +
 drivers/cpuidle/Kconfig             |  4 ++++
 drivers/cpuidle/cpuidle-powernv.c   | 13 +++++++++++--
 drivers/cpuidle/cpuidle.c           |  3 ---
 4 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.17.1
