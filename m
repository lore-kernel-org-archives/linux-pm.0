From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] cpufreq: dt: Add zynqmp to the cpufreq dt platdev
Date: Thu, 13 Jul 2017 11:19:10 +0200
Message-ID: <3a2d9e482adc907a03a55c99aa1583cc2618077c.1499937548.git.michal.simek@xilinx.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34149 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdGMJTN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 05:19:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id p204so3785891wmg.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2017 02:19:12 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add zynqmp to the cpufreq dt platform device.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1c262923fe58..2eb40d46d357 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -94,6 +94,7 @@
 	{ .compatible = "ti,omap5", },
 
 	{ .compatible = "xlnx,zynq-7000", },
+	{ .compatible = "xlnx,zynqmp", },
 
 	{ .compatible = "zte,zx296718", },
 
-- 
1.9.1
