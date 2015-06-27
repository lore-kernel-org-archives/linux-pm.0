From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 07/16] arm: domain: Synchronize CPU device runtime PM usage with idle state
Date: Fri, 26 Jun 2015 21:02:27 -0600
Message-ID: <1435374156-19214-8-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34462 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbbF0DCz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:02:55 -0400
Received: by pdbep18 with SMTP id ep18so63070409pdb.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:02:55 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

When a CPU is running, the runtime PM usage count should be incremented
and decremented when the CPU is powers down. To ensure that this happens
correctly, increment the runtime usage from that CPU.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/kernel/domains.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/domains.c b/arch/arm/kernel/domains.c
index a27f825..59b0180 100644
--- a/arch/arm/kernel/domains.c
+++ b/arch/arm/kernel/domains.c
@@ -33,6 +33,14 @@ static int arm_pd_power_up(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static void run_cpu(void *unused)
+{
+	struct device *cpu_dev = get_cpu_device(smp_processor_id());
+
+	/* We are running, increment the usage count */
+	pm_runtime_get_noresume(cpu_dev);
+}
+
 static int arm_domain_cpu_init(void)
 {
 	int cpuid, ret = 0;
@@ -50,13 +58,27 @@ static int arm_domain_cpu_init(void)
 
 		if (cpu_online(cpuid)) {
 			pm_runtime_set_active(cpu_dev);
-			pm_runtime_get_noresume(cpu_dev);
+			/*
+			 * Execute the below on that 'cpu' to ensure that the reference
+			 * counting is correct. Its possible that while this code is
+			 * executing, the 'cpu' may be powerd down, but we may incorrectly
+			 * increment the usage. By executing the get_cpu on the 'cpu',
+			 * we can ensure that the 'cpu' and its usage count are matched.
+			 */
+			smp_call_function_single(cpuid, run_cpu, NULL, true);
 		} else {
 			pm_runtime_set_suspended(cpu_dev);
 		}
 		pm_runtime_irq_safe(cpu_dev);
 		pm_runtime_enable(cpu_dev);
 
+		/*
+		 * We attempt to attach the device to genpd again. We would
+		 * have failed in our earlier attempt to attach to the domain
+		 * provider as the CPU device would not have been IRQ safe,
+		 * while the domain is defined as IRQ safe. IRQ safe domains
+		 * can only have IRQ safe devices.
+		 */
 		ret = genpd_dev_pm_attach(cpu_dev);
 		if (ret) {
 			dev_warn(cpu_dev, "%s: Unable to attach to power-domain: %d\n", __func__, ret);
-- 
2.1.4

