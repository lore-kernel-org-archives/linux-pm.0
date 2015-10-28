From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/5] cpufreq: imx6q: Fix goto wrong error label
Date: Wed, 28 Oct 2015 08:59:10 +0100
Message-ID: <1446019154-16384-2-git-send-email-s.hauer@pengutronix.de>
References: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45875 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbbJ1H7X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 03:59:23 -0400
In-Reply-To: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

After the call to dev_pm_opp_init_cpufreq_table() we have to go to
out_free_opp because we have already allocated the opp.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/cpufreq/imx6q-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index ef1fa81..fabd144 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -256,7 +256,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
-		goto put_reg;
+		goto out_free_opp;
 	}
 
 	/* Make imx6_soc_volt array's size same as arm opp number */
-- 
2.6.1

