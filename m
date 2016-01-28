From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V5 01/14] soc: tegra: pmc: Restore base address on probe failure
Date: Thu, 28 Jan 2016 16:33:39 +0000
Message-ID: <1453998832-27383-2-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

During early initialisation, the PMC registers are mapped and the PMC SoC
data is populated in the PMC data structure. This allows other drivers
access the PMC register space, via the public tegra PMC APIs, prior to
probing the PMC device.

When the PMC device is probed, the PMC registers are mapped again and if
successful the initial mapping is freed. If the probing of the PMC device
fails after the registers are remapped, then the registers will be
unmapped and hence the pointer to the PMC registers will be invalid. This
could lead to a potential crash, because once the PMC SoC data pointer is
populated, the driver assumes that the PMC register mapping is also valid
and a user calling any of the public tegra PMC APIs could trigger an
exception because these APIs don't check that the mapping is still valid.

Fix this by restoring the original mapping for the PMC registers if the
probe on the PMC device fails and only unmapping the original mapping if
the probe succeeds.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/soc/tegra/pmc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 88c7e506177e..85b4e166273a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -821,13 +821,11 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	if (IS_ERR(pmc->base))
 		return PTR_ERR(pmc->base);
 
-	iounmap(base);
-
 	pmc->clk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(pmc->clk)) {
 		err = PTR_ERR(pmc->clk);
 		dev_err(&pdev->dev, "failed to get pclk: %d\n", err);
-		return err;
+		goto error;
 	}
 
 	pmc->dev = &pdev->dev;
@@ -839,7 +837,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		err = tegra_powergate_debugfs_init();
 		if (err < 0)
-			return err;
+			goto error;
 	}
 
 	err = register_restart_handler(&tegra_pmc_restart_handler);
@@ -847,10 +845,17 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		debugfs_remove(pmc->debugfs);
 		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
 			err);
-		return err;
+		goto error;
 	}
 
+	iounmap(base);
+
 	return 0;
+
+error:
+	pmc->base = base;
+
+	return err;
 }
 
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
