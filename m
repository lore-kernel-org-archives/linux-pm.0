From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/4] ACPI / idle: remove usage of the statedata
Date: Mon,  4 Feb 2013 23:44:43 +0100
Message-ID: <1360017883-9544-4-git-send-email-daniel.lezcano@linaro.org>
References: <1360017883-9544-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:47320 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab3BDWoz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 17:44:55 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so5066189wgi.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Feb 2013 14:44:53 -0800 (PST)
In-Reply-To: <1360017883-9544-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org

Len Brown sent a patch to remove this field in the intel_idle driver.
The other user of this field is the davinci cpuidle driver and a
patch has been sent to remove the usage of it.

This patch removes the last user of this field.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6837065..8b433cb 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -66,6 +66,8 @@ module_param(latency_factor, uint, 0644);
 
 static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
 
+static struct acpi_processor_cx *acpi_cstate[CPUIDLE_STATE_MAX];
+
 static int disabled_by_idle_boot_param(void)
 {
 	return boot_option_idle_override == IDLE_POLL ||
@@ -721,8 +723,7 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor *pr;
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct acpi_processor_cx *cx = cpuidle_get_statedata(state_usage);
+	struct acpi_processor_cx *cx = acpi_cstate[index];
 
 	pr = __this_cpu_read(processors);
 
@@ -745,8 +746,7 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
  */
 static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 {
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct acpi_processor_cx *cx = cpuidle_get_statedata(state_usage);
+	struct acpi_processor_cx *cx = acpi_cstate[index];
 
 	ACPI_FLUSH_CPU_CACHE();
 
@@ -776,8 +776,7 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor *pr;
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct acpi_processor_cx *cx = cpuidle_get_statedata(state_usage);
+	struct acpi_processor_cx *cx = acpi_cstate[index];
 
 	pr = __this_cpu_read(processors);
 
@@ -835,8 +834,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor *pr;
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct acpi_processor_cx *cx = cpuidle_get_statedata(state_usage);
+	struct acpi_processor_cx *cx = acpi_cstate[index];
 
 	pr = __this_cpu_read(processors);
 
@@ -935,7 +933,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 {
 	int i, count = CPUIDLE_DRIVER_STATE_START;
 	struct acpi_processor_cx *cx;
-	struct cpuidle_state_usage *state_usage;
 
 	if (!pr->flags.power_setup_done)
 		return -EINVAL;
@@ -954,7 +951,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
 		cx = &pr->power.states[i];
-		state_usage = &dev->states_usage[count];
 
 		if (!cx->valid)
 			continue;
@@ -965,8 +961,7 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
 			continue;
 #endif
-
-		cpuidle_set_statedata(state_usage, cx);
+		acpi_cstate[count] = cx;
 
 		count++;
 		if (count == CPUIDLE_STATE_MAX)
-- 
1.7.9.5

