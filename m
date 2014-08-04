From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] cpufreq: cpu0: Do not print error message when deferring
Date: Mon,  4 Aug 2014 14:48:03 +0200
Message-ID: <1407156483-15730-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48918 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaHDMsY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Aug 2014 08:48:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

-EPROBE_DEFER is no real error. We are just waiting unti the necessary
components are ready. The driver core infrastructure will also print an
appropriate info message.

This patch changes the error message to a debug message.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/cpufreq/cpufreq-cpu0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index ee1ae303a07c..26405d5c7a1f 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -137,7 +137,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 		 * not yet registered, we should try defering probe.
 		 */
 		if (PTR_ERR(cpu_reg) == -EPROBE_DEFER) {
-			dev_err(cpu_dev, "cpu0 regulator not ready, retry\n");
+			dev_dbg(cpu_dev, "cpu0 regulator not ready, retry\n");
 			ret = -EPROBE_DEFER;
 			goto out_put_node;
 		}
-- 
2.0.1

