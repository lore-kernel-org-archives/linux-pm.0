From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/4] ACPI / idle: pass the cpuidle_device parameter
Date: Mon,  4 Feb 2013 23:44:42 +0100
Message-ID: <1360017883-9544-3-git-send-email-daniel.lezcano@linaro.org>
References: <1360017883-9544-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:42415 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab3BDWov (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 17:44:51 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm14so3578177wib.16
        for <linux-pm@vger.kernel.org>; Mon, 04 Feb 2013 14:44:50 -0800 (PST)
In-Reply-To: <1360017883-9544-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org

The cpuidle_device is retrieved in the function by using directly
the global variable. But the caller of this function already have
this device and it can be passed as a parameter. That is one small
step to encapsulate the code more.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 82626e9..6837065 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -928,13 +928,14 @@ struct cpuidle_driver acpi_idle_driver = {
  * device i.e. per-cpu data
  *
  * @pr: the ACPI processor
+ * @dev : the cpuidle device
  */
-static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr)
+static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
+					   struct cpuidle_device *dev)
 {
 	int i, count = CPUIDLE_DRIVER_STATE_START;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state_usage *state_usage;
-	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
 
 	if (!pr->flags.power_setup_done)
 		return -EINVAL;
@@ -1089,7 +1090,7 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
 	cpuidle_disable_device(dev);
 	acpi_processor_get_power_info(pr);
 	if (pr->flags.power) {
-		acpi_processor_setup_cpuidle_cx(pr);
+		acpi_processor_setup_cpuidle_cx(pr, dev);
 		ret = cpuidle_enable_device(dev);
 	}
 	cpuidle_resume_and_unlock();
@@ -1147,8 +1148,8 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 				continue;
 			acpi_processor_get_power_info(_pr);
 			if (_pr->flags.power) {
-				acpi_processor_setup_cpuidle_cx(_pr);
 				dev = per_cpu(acpi_cpuidle_device, cpu);
+				acpi_processor_setup_cpuidle_cx(_pr, dev);
 				cpuidle_enable_device(dev);
 			}
 		}
@@ -1217,7 +1218,7 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr)
 			return -ENOMEM;
 		per_cpu(acpi_cpuidle_device, pr->id) = dev;
 
-		acpi_processor_setup_cpuidle_cx(pr);
+		acpi_processor_setup_cpuidle_cx(pr, dev);
 
 		/* Register per-cpu cpuidle_device. Cpuidle driver
 		 * must already be registered before registering device
-- 
1.7.9.5

