From: Jia Hongtao <hongtao.jia@nxp.com>
Subject: [PATCH V3 1/2] cpufreq: qoriq: Remove __exit macro from .exit callback
Date: Tue, 19 Apr 2016 17:00:06 +0800
Message-ID: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bon0079.outbound.protection.outlook.com ([157.56.111.79]:37920
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752387AbcDSJJZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Apr 2016 05:09:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com, yuantian.tang@nxp.com, hongtao.jia@nxp.com

.exit callback (qoriq_cpufreq_cpu_exit()) is also used during suspend.
So __exit macro should be removed or the function will be discarded.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
 drivers/cpufreq/qoriq-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index b23e525..3a3fe39 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -301,7 +301,7 @@ err_np:
 	return -ENODEV;
 }
 
-static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cpu_data *data = policy->driver_data;
 
@@ -348,7 +348,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.name		= "qoriq_cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.init		= qoriq_cpufreq_cpu_init,
-	.exit		= __exit_p(qoriq_cpufreq_cpu_exit),
+	.exit		= qoriq_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qoriq_cpufreq_target,
 	.get		= cpufreq_generic_get,
-- 
2.1.0.27.g96db324

