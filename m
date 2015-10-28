From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/5] cpufreq: imx6q: Fix wrong device in devm_kzalloc
Date: Wed, 28 Oct 2015 08:59:11 +0100
Message-ID: <1446019154-16384-3-git-send-email-s.hauer@pengutronix.de>
References: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52092 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932449AbbJ1H7q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 03:59:46 -0400
In-Reply-To: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

devm_kzalloc must be called with the device that is actually probed,
not with cpu_dev which resources are not freed when probe fails.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/cpufreq/imx6q-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index fabd144..6fefd19 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -260,7 +260,8 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	/* Make imx6_soc_volt array's size same as arm opp number */
-	imx6_soc_volt = devm_kzalloc(cpu_dev, sizeof(*imx6_soc_volt) * num, GFP_KERNEL);
+	imx6_soc_volt = devm_kzalloc(&pdev->dev,
+				     sizeof(*imx6_soc_volt) * num, GFP_KERNEL);
 	if (imx6_soc_volt == NULL) {
 		ret = -ENOMEM;
 		goto free_freq_table;
-- 
2.6.1

