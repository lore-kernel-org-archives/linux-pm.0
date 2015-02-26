From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] idle / sleep: Avoid excessive interrupts disabling and enabling
Date: Fri, 27 Feb 2015 00:39:21 +0100
Message-ID: <1903605.mzgLz6Rq43@vostro.rjw.lan>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <4425438.YlYNQyf1hp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4425438.YlYNQyf1hp@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Disabling interrupts at the end of cpuidle_enter_freeze() is not
useful, because its caller, cpuidle_idle_call(), re-enables them
right away after invoking it.

To avoid that unnecessary back and forth dance with interrupts,
make cpuidle_enter_freeze() enable interrupts after calling
enter_freeze_proper() and drop the local_irq_disable() at its
end, so that all of the code paths in it end up with interrupts
enabled.  Then, cpuidle_idle_call() will not need to re-enable
interrupts after calling cpuidle_enter_freeze() any more, because
the latter will return with interrupts enabled, in analogy with
cpuidle_enter().

Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    6 +++---
 kernel/sched/idle.c       |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -117,6 +117,8 @@ static void enter_freeze_proper(struct c
  * If there are states with the ->enter_freeze callback, find the deepest of
  * them and enter it with frozen tick.  Otherwise, find the deepest state
  * available and enter it normally.
+ *
+ * Returns with enabled interrupts.
  */
 void cpuidle_enter_freeze(void)
 {
@@ -132,6 +134,7 @@ void cpuidle_enter_freeze(void)
 	index = cpuidle_find_deepest_state(drv, dev, true);
 	if (index >= 0) {
 		enter_freeze_proper(drv, dev, index);
+		local_irq_enable();
 		return;
 	}
 
@@ -144,9 +147,6 @@ void cpuidle_enter_freeze(void)
 		cpuidle_enter(drv, dev, index);
 	else
 		arch_cpu_idle();
-
-	/* Interrupts are enabled again here. */
-	local_irq_disable();
 }
 
 /**
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -116,7 +116,6 @@ static void cpuidle_idle_call(void)
 	 */
 	if (idle_should_freeze()) {
 		cpuidle_enter_freeze();
-		local_irq_enable();
 		goto exit_idle;
 	}
 
