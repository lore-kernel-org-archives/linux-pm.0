From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] cpuidle: coupled: fix race condition between pokes and safe state
Date: Fri, 23 Aug 2013 12:45:12 -0700
Message-ID: <1377287112-12018-3-git-send-email-ccross@android.com>
References: <1377287112-12018-1-git-send-email-ccross@android.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377287112-12018-1-git-send-email-ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Neil Zhang <zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The coupled cpuidle waiting loop clears pending pokes before
entering the safe state.  If a poke arrives just before the
pokes are cleared, but after the while loop condition checks,
the poke will be lost and the cpu will stay in the safe state
until another interrupt arrives.  This may cause the cpu that
sent the poke to spin in the ready loop with interrupts off
until another cpu receives an interrupt, and if no other cpus
have interrupts routed to them it can spin forever.

Change the return value of cpuidle_coupled_clear_pokes to
return if a poke was cleared, and move the need_resched()
checks into the callers.  In the waiting loop, if
a poke was cleared restart the loop to repeat the while
condition checks.

Reported-by: Neil Zhang <zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
CC: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/cpuidle/coupled.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index bbc4ba5..c91230b 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -408,19 +408,22 @@ static void cpuidle_coupled_set_done(int cpu, struct cpuidle_coupled *coupled)
  * been processed and the poke bit has been cleared.
  *
  * Other interrupts may also be processed while interrupts are enabled, so
- * need_resched() must be tested after turning interrupts off again to make sure
+ * need_resched() must be tested after this function returns to make sure
  * the interrupt didn't schedule work that should take the cpu out of idle.
  *
- * Returns 0 if need_resched was false, -EINTR if need_resched was true.
+ * Returns 0 if no poke was pending, 1 if a poke was cleared.
  */
 static int cpuidle_coupled_clear_pokes(int cpu)
 {
+	if (!cpumask_test_cpu(cpu, &cpuidle_coupled_poke_pending))
+		return 0;
+
 	local_irq_enable();
 	while (cpumask_test_cpu(cpu, &cpuidle_coupled_poke_pending))
 		cpu_relax();
 	local_irq_disable();
 
-	return need_resched() ? -EINTR : 0;
+	return 1;
 }
 
 static bool cpuidle_coupled_any_pokes_pending(struct cpuidle_coupled *coupled)
@@ -464,7 +467,8 @@ int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
 		return -EINVAL;
 
 	while (coupled->prevent) {
-		if (cpuidle_coupled_clear_pokes(dev->cpu)) {
+		cpuidle_coupled_clear_pokes(dev->cpu);
+		if (need_resched()) {
 			local_irq_enable();
 			return entered_state;
 		}
@@ -503,7 +507,10 @@ retry:
 	 */
 	while (!cpuidle_coupled_cpus_waiting(coupled) ||
 			!cpumask_test_cpu(dev->cpu, &cpuidle_coupled_poked)) {
-		if (cpuidle_coupled_clear_pokes(dev->cpu)) {
+		if (cpuidle_coupled_clear_pokes(dev->cpu))
+			continue;
+
+		if (need_resched()) {
 			cpuidle_coupled_set_not_waiting(dev->cpu, coupled);
 			goto out;
 		}
@@ -518,7 +525,8 @@ retry:
 		local_irq_disable();
 	}
 
-	if (cpuidle_coupled_clear_pokes(dev->cpu)) {
+	cpuidle_coupled_clear_pokes(dev->cpu);
+	if (need_resched()) {
 		cpuidle_coupled_set_not_waiting(dev->cpu, coupled);
 		goto out;
 	}
-- 
1.8.3
