From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] staging: board: Migrate away from __pm_genpd_name_add_device()
Date: Tue,  8 Sep 2015 19:06:03 +0200
Message-ID: <1441731963-18271-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

The named genpd APIs are deprecated. Hence convert the board staging
code from using genpd names to DT node paths.

For now this supports PM domains with "#power-domain-cells = <0>" only.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Rafael, Greg: If Greg provides his Acked-by, Rafael can apply this patch
to the linux-pm tree as a prerequisite for Ulf's patches to remove the
named genpd APIs.

Thanks!

v2:
  - Add Reviewed-by.
---
 drivers/staging/board/armadillo800eva.c |  2 +-
 drivers/staging/board/board.c           | 36 ++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/board/armadillo800eva.c b/drivers/staging/board/armadillo800eva.c
index 81df77bd55cc9868..9c41652ee908b5e8 100644
--- a/drivers/staging/board/armadillo800eva.c
+++ b/drivers/staging/board/armadillo800eva.c
@@ -91,7 +91,7 @@ static const struct board_staging_dev armadillo800eva_devices[] __initconst = {
 		.pdev		= &lcdc0_device,
 		.clocks		= lcdc0_clocks,
 		.nclocks	= ARRAY_SIZE(lcdc0_clocks),
-		.domain		= "a4lc",
+		.domain		= "/system-controller@e6180000/pm-domains/c5/a4lc@1"
 	},
 };
 
diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
index 29d456e29f38feac..3eb5eb8f069c236d 100644
--- a/drivers/staging/board/board.c
+++ b/drivers/staging/board/board.c
@@ -135,6 +135,40 @@ int __init board_staging_register_clock(const struct board_staging_clk *bsc)
 	return error;
 }
 
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+static int board_staging_add_dev_domain(struct platform_device *pdev,
+					const char *domain)
+{
+	struct of_phandle_args pd_args;
+	struct generic_pm_domain *pd;
+	struct device_node *np;
+
+	np = of_find_node_by_path(domain);
+	if (!np) {
+		pr_err("Cannot find domain node %s\n", domain);
+		return -ENOENT;
+	}
+
+	pd_args.np = np;
+	pd_args.args_count = 0;
+	pd = of_genpd_get_from_provider(&pd_args);
+	if (IS_ERR(pd)) {
+		pr_err("Cannot find genpd %s (%ld)\n", domain, PTR_ERR(pd));
+		return PTR_ERR(pd);
+
+	}
+	pr_debug("Found genpd %s for device %s\n", pd->name, pdev->name);
+
+	return pm_genpd_add_device(pd, &pdev->dev);
+}
+#else
+static inline int board_staging_add_dev_domain(struct platform_device *pdev,
+					       const char *domain)
+{
+	return 0;
+}
+#endif
+
 int __init board_staging_register_device(const struct board_staging_dev *dev)
 {
 	struct platform_device *pdev = dev->pdev;
@@ -161,7 +195,7 @@ int __init board_staging_register_device(const struct board_staging_dev *dev)
 	}
 
 	if (dev->domain)
-		__pm_genpd_name_add_device(dev->domain, &pdev->dev, NULL);
+		board_staging_add_dev_domain(pdev, dev->domain);
 
 	return error;
 }
-- 
1.9.1

