From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] thermal: cpu_cooling: small memory leak on error
Date: Wed, 17 Dec 2014 02:55:53 +0300
Message-ID: <20141216235553.GG31467@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37348 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbaLPX4R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 18:56:17 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

There was a left over return here so the error handling isn't run.
It leads to a small memory leak and a static checker warning.

	drivers/thermal/cpu_cooling.c:351 __cpufreq_cooling_register()
	info: ignoring unreachable code.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 051eb48..9b45f64 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -347,7 +347,6 @@ __cpufreq_cooling_register(struct device_node *np,
 	cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev->freq_table) *
 					  cpufreq_dev->max_level, GFP_KERNEL);
 	if (!cpufreq_dev->freq_table) {
-		return ERR_PTR(-ENOMEM);
 		cool_dev = ERR_PTR(-ENOMEM);
 		goto free_cdev;
 	}
