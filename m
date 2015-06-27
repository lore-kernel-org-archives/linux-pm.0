From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 08/16] arm: domain: Handle CPU online reference counting
Date: Fri, 26 Jun 2015 21:02:28 -0600
Message-ID: <1435374156-19214-9-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35888 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbF0DC5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:02:57 -0400
Received: by pdcu2 with SMTP id u2so84846735pdc.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:02:56 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Ensure that the CPU device usage count is incremented for a CPU that
just came online. CPUs coming online do not follow the same code path as
CPUs warm booting back to CPUIdle. Register for hotplug notifier and
ensure the reference count is incremented correctly.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/kernel/domains.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/kernel/domains.c b/arch/arm/kernel/domains.c
index 59b0180..680c3fb 100644
--- a/arch/arm/kernel/domains.c
+++ b/arch/arm/kernel/domains.c
@@ -41,10 +41,49 @@ static void run_cpu(void *unused)
 	pm_runtime_get_noresume(cpu_dev);
 }
 
+static int cpu_online_notifier(struct notifier_block *n,
+		unsigned long action, void *hcpu)
+{
+	int cpu = (unsigned long)hcpu;
+	struct device *dev = get_cpu_device(cpu);
+
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		/*
+		 * Attach the cpu to its domain if the cpu is coming up
+		 * for the first time.
+		 * Called from the cpu that is coming up.
+		 */
+		pm_runtime_set_active(dev);
+		pm_runtime_get_noresume(dev);
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block hotplug_notifier = {
+	.notifier_call = cpu_online_notifier,
+};
+
 static int arm_domain_cpu_init(void)
 {
 	int cpuid, ret = 0;
 
+	/*
+	 * Register for hotplug notifier, because not all CPUs
+	 * may be online at this time. Also, hotplug entry path is not
+	 * the same as warm boot. So the reference counting would have
+	 * to be adjusted here accordingly.
+	 * Register early, incase, a core comes online,
+	 * while we are executing this.
+	 */
+	register_cpu_notifier(&hotplug_notifier);
+
 	/* Find any CPU nodes with a phandle to this power domain */
 	for_each_possible_cpu(cpuid) {
 		struct device *cpu_dev;
-- 
2.1.4

