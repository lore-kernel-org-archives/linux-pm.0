From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] cpufreq: scpi-cpufreq: signedness bug in scpi_get_dvfs_info()
Date: Tue, 15 Dec 2015 11:16:44 +0000
Message-ID: <1450178204-26172-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47975 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964803AbbLOLQ7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Dec 2015 06:16:59 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>

From: Dan Carpenter <dan.carpenter@oracle.com>

The "domain" variable needs to be signed for the error handling to work.

Fixes: 8def31034d03 ('cpufreq: arm_big_little: add SCPI interface driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Rafael,

This patch seem to have slipped through the cracks somehow. I don't see
in patchwork too. So I am resending so that you can pick for your next
rc fix if you plan to send one else for -next

Regards,
Sudeep

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 2c3b16fd3a01..de5e89b2eaaa 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -31,7 +31,7 @@ static struct scpi_ops *scpi_ops;

 static struct scpi_dvfs_info *scpi_get_dvfs_info(struct device *cpu_dev)
 {
-	u8 domain = topology_physical_package_id(cpu_dev->id);
+	int domain = topology_physical_package_id(cpu_dev->id);

 	if (domain < 0)
 		return ERR_PTR(-EINVAL);
--
1.9.1

