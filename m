From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/2] cpufreq: scpi: use new scpi_ops functions to remove duplicate code
Date: Fri, 28 Apr 2017 10:21:36 +0100
Message-ID: <1493371296-12465-2-git-send-email-sudeep.holla@arm.com>
References: <1493371296-12465-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755505AbdD1JVw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Apr 2017 05:21:52 -0400
In-Reply-To: <1493371296-12465-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

scpi_ops now provide APIs to get the transition_latency and to add
OPPs to the devices making those logic redundant here.

This patch makes use of those APIs and removes the redunant code in
this driver.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index ea7a4e1b68c2..8de2364b5995 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -30,46 +30,20 @@
 
 static struct scpi_ops *scpi_ops;
 
-static struct scpi_dvfs_info *scpi_get_dvfs_info(struct device *cpu_dev)
-{
-	int domain = topology_physical_package_id(cpu_dev->id);
-
-	if (domain < 0)
-		return ERR_PTR(-EINVAL);
-	return scpi_ops->dvfs_get_info(domain);
-}
-
 static int scpi_get_transition_latency(struct device *cpu_dev)
 {
-	struct scpi_dvfs_info *info = scpi_get_dvfs_info(cpu_dev);
-
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-	return info->latency;
+	return scpi_ops->get_transition_latency(cpu_dev);
 }
 
 static int scpi_init_opp_table(const struct cpumask *cpumask)
 {
-	int idx, ret;
-	struct scpi_opp *opp;
+	int ret;
 	struct device *cpu_dev = get_cpu_device(cpumask_first(cpumask));
-	struct scpi_dvfs_info *info = scpi_get_dvfs_info(cpu_dev);
-
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	if (!info->opps)
-		return -EIO;
 
-	for (opp = info->opps, idx = 0; idx < info->count; idx++, opp++) {
-		ret = dev_pm_opp_add(cpu_dev, opp->freq, opp->m_volt * 1000);
-		if (ret) {
-			dev_warn(cpu_dev, "failed to add opp %uHz %umV\n",
-				 opp->freq, opp->m_volt);
-			while (idx-- > 0)
-				dev_pm_opp_remove(cpu_dev, (--opp)->freq);
-			return ret;
-		}
+	ret = scpi_ops->add_opps_to_device(cpu_dev);
+	if (ret) {
+		dev_warn(cpu_dev, "failed to add opps to the device\n");
+		return ret;
 	}
 
 	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, cpumask);
-- 
2.7.4
