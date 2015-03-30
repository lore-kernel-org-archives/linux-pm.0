From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2] PM / devfreq: tegra: Register governor on module init
Date: Mon, 30 Mar 2015 17:33:23 +0200
Message-ID: <1427729603-20955-1-git-send-email-tomeu.vizoso@collabora.com>
References: <20150330150828.GA18428@ulmo.nvidia.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37073 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbbC3PeP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2015 11:34:15 -0400
In-Reply-To: <20150330150828.GA18428@ulmo.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-pm@vger.kernel.org

So this driver builds as a module.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

v2:	* Remove governor if driver registration fails
---
 drivers/devfreq/tegra-devfreq.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 8e633a6..13a1a6e 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -606,12 +606,6 @@ static struct devfreq_governor tegra_devfreq_governor = {
 	.event_handler = tegra_governor_event_handler,
 };
 
-static int __init tegra_governor_init(void)
-{
-	return devfreq_add_governor(&tegra_devfreq_governor);
-}
-subsys_initcall(tegra_governor_init);
-
 static int tegra_devfreq_probe(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra;
@@ -755,7 +749,36 @@ static struct platform_driver tegra_devfreq_driver = {
 		.of_match_table = tegra_devfreq_of_match,
 	},
 };
-module_platform_driver(tegra_devfreq_driver);
+
+static int __init tegra_devfreq_init(void)
+{
+	int ret = 0;
+
+	ret = devfreq_add_governor(&tegra_devfreq_governor);
+	if (ret) {
+		pr_err("%s: failed to add governor: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = platform_driver_register(&tegra_devfreq_driver);
+	if (ret)
+		devfreq_remove_governor(&tegra_devfreq_governor);
+
+	return ret;
+}
+module_init(tegra_devfreq_init)
+
+static void __exit tegra_devfreq_exit(void)
+{
+	int ret = 0;
+
+	platform_driver_unregister(&tegra_devfreq_driver);
+
+	ret = devfreq_remove_governor(&tegra_devfreq_governor);
+	if (ret)
+		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
+}
+module_exit(tegra_devfreq_exit)
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Tegra devfreq driver");
-- 
2.1.0

