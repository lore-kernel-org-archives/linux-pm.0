From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 15/17] drm/tegra: remove GR3D power sequence from driver
Date: Thu, 12 Mar 2015 20:15:16 +0800
Message-ID: <1426162518-7405-16-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, Vince Hsu <vinceh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

We have the generic PM domain support for Tegra SoCs now. So remove the
duplicated power sequence here.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
 drivers/gpu/drm/tegra/gr3d.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 0b3f2b977ba0..fd8642cdc42f 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -281,21 +281,17 @@ static int gr3d_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_3D, gr3d->clk,
-						gr3d->rst);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to power up 3D unit\n");
+	err = clk_prepare_enable(gr3d->clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable clk\n");
 		return err;
 	}
 
 	if (gr3d->clk_secondary) {
-		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_3D1,
-							gr3d->clk_secondary,
-							gr3d->rst_secondary);
-		if (err < 0) {
-			dev_err(&pdev->dev,
-				"failed to power up secondary 3D unit\n");
-			return err;
+		err = clk_prepare_enable(gr3d->clk_secondary);
+		if (err) {
+			dev_err(&pdev->dev, "failed to enable secondary clk\n");
+			goto err_clk_sec;
 		}
 	}
 
@@ -313,7 +309,7 @@ static int gr3d_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
 			err);
-		return err;
+		goto err_host1x;
 	}
 
 	/* initialize address register map */
@@ -323,6 +319,13 @@ static int gr3d_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, gr3d);
 
 	return 0;
+
+err_clk_sec:
+	clk_disable_unprepare(gr3d->clk);
+err_host1x:
+	clk_disable_unprepare(gr3d->clk_secondary);
+
+	return err;
 }
 
 static int gr3d_remove(struct platform_device *pdev)
@@ -337,12 +340,9 @@ static int gr3d_remove(struct platform_device *pdev)
 		return err;
 	}
 
-	if (gr3d->clk_secondary) {
-		tegra_powergate_power_off(TEGRA_POWERGATE_3D1);
+	if (gr3d->clk_secondary)
 		clk_disable_unprepare(gr3d->clk_secondary);
-	}
 
-	tegra_powergate_power_off(TEGRA_POWERGATE_3D);
 	clk_disable_unprepare(gr3d->clk);
 
 	return 0;
-- 
2.1.4
