From: Jason Baron <jbaron@akamai.com>
Subject: [PATCH] intel_idle: replace conditionals with static_cpu_has(X86_FEATURE_ARAT)
Date: Fri,  6 Oct 2017 13:19:45 -0400
Message-ID: <1507310385-22388-1-git-send-email-jbaron@akamai.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:47298 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751487AbdJFRUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2017 13:20:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

If the 'arat' cpu flag is set, then the conditionals in intel_idle() that
guard calling tick_broadcast_enter()/exit() will never be true. Use
static_cpu_has(X86_FEATURE_ARAT) to create a fast path to replace
the conditional.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5dc7ea4..5db5e31 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -913,8 +913,7 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	struct cpuidle_state *state = &drv->states[index];
 	unsigned long eax = flg2MWAIT(state->flags);
 	unsigned int cstate;
-
-	cstate = (((eax) >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) + 1;
+	bool uninitialized_var(tick);
 
 	/*
 	 * NB: if CPUIDLE_FLAG_TLB_FLUSHED is set, this idle transition
@@ -923,12 +922,19 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	 * useful with this knowledge.
 	 */
 
-	if (!(lapic_timer_reliable_states & (1 << (cstate))))
-		tick_broadcast_enter();
+	if (!static_cpu_has(X86_FEATURE_ARAT)) {
+		cstate = (((eax) >> MWAIT_SUBSTATE_SIZE) &
+				MWAIT_CSTATE_MASK) + 1;
+		tick = false;
+		if (!(lapic_timer_reliable_states & (1 << (cstate)))) {
+			tick = true;
+			tick_broadcast_enter();
+		}
+	}
 
 	mwait_idle_with_hints(eax, ecx);
 
-	if (!(lapic_timer_reliable_states & (1 << (cstate))))
+	if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
 		tick_broadcast_exit();
 
 	return index;
-- 
2.6.1
