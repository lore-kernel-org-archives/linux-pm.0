From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH] PM / devfreq: tegra: Register governor on module init
Date: Mon, 30 Mar 2015 14:54:38 +0200
Message-ID: <1427720078-28836-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1040887254.91981427710975821.JavaMail.weblogic@epmlwas08a>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1040887254.91981427710975821.JavaMail.weblogic@epmlwas08a>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

So this driver builds as a module.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Hi,

sorry, I hadn't tested building as a module in the latest iterations but it's something that I would like to work.

This patch should fix it.

Thanks,

Tomeu
---
 drivers/devfreq/tegra-devfreq.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 8e633a6..ed94a5d 100644
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
@@ -755,7 +749,32 @@ static struct platform_driver tegra_devfreq_driver = {
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
+	return platform_driver_register(&tegra_devfreq_driver);
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
