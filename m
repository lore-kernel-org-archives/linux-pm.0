From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH] cpufreq: integrator: Fix module autoload for OF platform
 driver
Date: Wed, 16 Sep 2015 22:24:46 +0200
Message-ID: <20150916202446.GA4303@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35350 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbbIPUYt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 16:24:49 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hello,

This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

 drivers/cpufreq/integrator-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
index 2faa421..79e3ff2 100644
--- a/drivers/cpufreq/integrator-cpufreq.c
+++ b/drivers/cpufreq/integrator-cpufreq.c
@@ -221,6 +221,8 @@ static const struct of_device_id integrator_cpufreq_match[] = {
 	{ },
 };
 
+MODULE_DEVICE_TABLE(of, integrator_cpufreq_match);
+
 static struct platform_driver integrator_cpufreq_driver = {
 	.driver = {
 		.name = "integrator-cpufreq",
-- 
2.4.6

