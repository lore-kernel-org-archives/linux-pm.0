From: Jia Hongtao <hongtao.jia@nxp.com>
Subject: [PATCH V3 2/2] cpufreq: qoriq: Fix cooling device registration issue during suspend
Date: Tue, 19 Apr 2016 17:00:07 +0800
Message-ID: <1461056407-22542-2-git-send-email-hongtao.jia@nxp.com>
References: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bon0068.outbound.protection.outlook.com ([157.56.111.68]:48740
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752547AbcDSJYM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Apr 2016 05:24:12 -0400
In-Reply-To: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com, yuantian.tang@nxp.com, hongtao.jia@nxp.com

Cooling device is registered by ready callback. It's also invoked while
system resuming from sleep (Enabling non-boot cpus). Thus cooling device
may be multiple registered. Matchable unregistration is added to exit
callback to fix this issue.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
 drivers/cpufreq/qoriq-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3a3fe39..0b85f90 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -305,6 +305,7 @@ static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cpu_data *data = policy->driver_data;
 
+	cpufreq_cooling_unregister(data->cdev);
 	kfree(data->pclk);
 	kfree(data->table);
 	kfree(data);
-- 
2.1.0.27.g96db324

