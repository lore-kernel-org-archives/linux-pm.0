From: Jia Hongtao <hongtao.jia@nxp.com>
Subject: [PATCH 1/2] cpufreq: qoriq: Fix cooling device registration issue during suspend
Date: Mon, 18 Apr 2016 15:59:31 +0800
Message-ID: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2on0084.outbound.protection.outlook.com ([207.46.100.84]:26215
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751075AbcDRIIt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Apr 2016 04:08:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com, yuantian.tang@nxp.com, hongtao.jia@nxp.com

Cooling device is registered by ready callback. It's also invoked while
system resuming from sleep (Enabling non-boot cpus). Thus cooling device
may be multiple registered. Stop_cpu callback is invoked during suspend
(Disabling non-boot cpus). So matchable unregistration is added to fix
this issue.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
 drivers/cpufreq/qoriq-cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index b23e525..1c2fdc1 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -305,6 +305,7 @@ static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cpu_data *data = policy->driver_data;
 
+	cpufreq_cooling_unregister(data->cdev);
 	kfree(data->pclk);
 	kfree(data->table);
 	kfree(data);
@@ -323,6 +324,12 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
 	return clk_set_parent(policy->clk, parent);
 }
 
+static void qoriq_cpufreq_stop_cpu(struct cpufreq_policy *policy)
+{
+	struct cpu_data *cpud = policy->driver_data;
+
+	cpufreq_cooling_unregister(cpud->cdev);
+}
 
 static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
 {
@@ -352,6 +359,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qoriq_cpufreq_target,
 	.get		= cpufreq_generic_get,
+	.stop_cpu	= qoriq_cpufreq_stop_cpu,
 	.ready		= qoriq_cpufreq_ready,
 	.attr		= cpufreq_generic_attr,
 };
-- 
2.1.0.27.g96db324

