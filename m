From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Thermal: cpufreq cooling: endian bug in
 cpufreq_get_max_state()
Date: Wed, 17 Apr 2013 10:18:28 +0300
Message-ID: <20130417071828.GD7923@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:28820 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757796Ab3DQHSs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2013 03:18:48 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

This code doesn't work on big endian systems because we're storing low
values in the high bits of the unsigned long.  It makes it a very high
value instead.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 5f5c780..768b508 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -303,12 +303,12 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
 	struct cpumask *mask = &cpufreq_device->allowed_cpus;
 	unsigned int cpu;
-	unsigned long count = 0;
+	unsigned int count = 0;
 	int ret;
 
 	cpu = cpumask_any(mask);
 
-	ret = get_property(cpu, 0, (unsigned int *)&count, GET_MAXL);
+	ret = get_property(cpu, 0, &count, GET_MAXL);
 
 	if (count > 0)
 		*state = count;
