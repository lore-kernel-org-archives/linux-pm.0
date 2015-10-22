From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] cpufreq: scpi-cpufreq: signedness bug in scpi_get_dvfs_info()
Date: Thu, 22 Oct 2015 22:52:08 +0300
Message-ID: <20151022195208.GB24439@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37958 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758029AbbJVTwv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2015 15:52:51 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

The "domain" variable needs to be signed for the error handling to work.

Fixes: 8def31034d03 ('cpufreq: arm_big_little: add SCPI interface driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 2c3b16f..de5e89b 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -31,7 +31,7 @@ static struct scpi_ops *scpi_ops;
 
 static struct scpi_dvfs_info *scpi_get_dvfs_info(struct device *cpu_dev)
 {
-	u8 domain = topology_physical_package_id(cpu_dev->id);
+	int domain = topology_physical_package_id(cpu_dev->id);
 
 	if (domain < 0)
 		return ERR_PTR(-EINVAL);
