From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4/9] ACPI / cpuidle: fix max idle state handling with hotplug
 CPU support
Date: Tue, 20 Aug 2013 16:23:42 +0200
Message-ID: <1377008627-32691-5-git-send-email-b.zolnierkie@samsung.com>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59118 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab3HTOZy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 10:25:54 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU00DJ32QJD2P0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Aug 2013 23:25:54 +0900 (KST)
In-reply-to: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, Len Brown <lenb@kernel.org>

acpi_processor_hotplug() calls acpi_processor_setup_cpuidle_cx()
without calling acpi_processor_setup_cpuidle_states() first so it
is possible that dev->state_count becomes different from
drv->state_count (in case of SMP system with unsupported C2/C3
states + enabled CPU hotplug and num_online_cpus() becoming > 1).

The driver code assumes that cpuidle core will handle such cases
but currently this is untrue (dev->state_count is used only for
handling cpuidle state sysfs entries and drv->state_count is used
for all other cases) and will not be fixed in the future as
dev->state_count is planned to be removed.

Fix the issue by checking for the max supported idle state in
C2/C3 state's ->enter handler (acpi_idle_enter_simple() for C2/C3
and acpi_idle_enter_bm() for C3 + bm_check flag set) and setting
the C1 state (instead of higher states) when needed.

Also remove no longer needed max idle state checks from
acpi_processor_setup_cpuidle_[states,cx]().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/processor_idle.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f98dd00..853fe86 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -790,6 +790,13 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return -EINVAL;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+	    !pr->flags.has_cst &&
+	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
+		return acpi_idle_enter_c1(dev, drv, CPUIDLE_DRIVER_STATE_START);
+#endif
+
 	if (cx->entry_method != ACPI_CSTATE_FFH) {
 		current_thread_info()->status &= ~TS_POLLING;
 		/*
@@ -848,6 +855,13 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return -EINVAL;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+	    !pr->flags.has_cst &&
+	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
+		return acpi_idle_enter_c1(dev, drv, CPUIDLE_DRIVER_STATE_START);
+#endif
+
 	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
 		if (drv->safe_state_index >= 0) {
 			return drv->states[drv->safe_state_index].enter(dev,
@@ -961,12 +975,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 		if (!cx->valid)
 			continue;
 
-#ifdef CONFIG_HOTPLUG_CPU
-		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
-		    !pr->flags.has_cst &&
-		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
-			continue;
-#endif
 		per_cpu(acpi_cstate[count], dev->cpu) = cx;
 
 		count++;
@@ -1016,13 +1024,6 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 		if (!cx->valid)
 			continue;
 
-#ifdef CONFIG_HOTPLUG_CPU
-		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
-		    !pr->flags.has_cst &&
-		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
-			continue;
-#endif
-
 		state = &drv->states[count];
 		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d", i);
 		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
-- 
1.8.2.3

