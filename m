From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH] thermal: db8500_cpufreq_cooling: Fix module autoload for OF
 platform driver
Date: Thu, 3 Sep 2015 13:10:14 +0200
Message-ID: <20150903111014.GA17660@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36766 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbbICLKR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 07:10:17 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---

Hello,

This patch adds the missing MODULE_DEVICE_TABLE() for OF to eport
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

 drivers/thermal/db8500_cpufreq_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/db8500_cpufreq_cooling.c b/drivers/thermal/db8500_cpufreq_cooling.c
index 607b62c..e58bd0b 100644
--- a/drivers/thermal/db8500_cpufreq_cooling.c
+++ b/drivers/thermal/db8500_cpufreq_cooling.c
@@ -72,6 +72,7 @@ static const struct of_device_id db8500_cpufreq_cooling_match[] = {
 	{ .compatible = "stericsson,db8500-cpufreq-cooling" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, db8500_cpufreq_cooling_match);
 #endif
 
 static struct platform_driver db8500_cpufreq_cooling_driver = {
-- 
2.4.6

