From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 12/17] drm/tegra: dc: remove the power sequence from driver
Date: Thu, 12 Mar 2015 20:15:13 +0800
Message-ID: <1426162518-7405-13-git-send-email-vinceh@nvidia.com>
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
 drivers/gpu/drm/tegra/dc.c | 46 +++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 1a52522f5da7..838bb8634da7 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -28,7 +28,6 @@ struct tegra_dc_soc_info {
 	bool supports_cursor;
 	bool supports_block_linear;
 	unsigned int pitch_align;
-	bool has_powergate;
 };
 
 struct tegra_plane {
@@ -1786,7 +1785,6 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.supports_cursor = false,
 	.supports_block_linear = false,
 	.pitch_align = 8,
-	.has_powergate = false,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
@@ -1795,7 +1793,6 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.supports_cursor = false,
 	.supports_block_linear = false,
 	.pitch_align = 8,
-	.has_powergate = false,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
@@ -1804,7 +1801,6 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.supports_cursor = false,
 	.supports_block_linear = false,
 	.pitch_align = 64,
-	.has_powergate = true,
 };
 
 static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
@@ -1813,7 +1809,6 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.supports_cursor = true,
 	.supports_block_linear = true,
 	.pitch_align = 64,
-	.has_powergate = true,
 };
 
 static const struct of_device_id tegra_dc_of_match[] = {
@@ -1906,33 +1901,18 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		return PTR_ERR(dc->rst);
 	}
 
-	if (dc->soc->has_powergate) {
-		if (dc->pipe == 0)
-			dc->powergate = TEGRA_POWERGATE_DIS;
-		else
-			dc->powergate = TEGRA_POWERGATE_DISB;
-
-		err = tegra_powergate_sequence_power_up(dc->powergate, dc->clk,
-							dc->rst);
-		if (err < 0) {
-			dev_err(&pdev->dev, "failed to power partition: %d\n",
-				err);
-			return err;
-		}
-	} else {
-		err = clk_prepare_enable(dc->clk);
-		if (err < 0) {
-			dev_err(&pdev->dev, "failed to enable clock: %d\n",
-				err);
-			return err;
-		}
+	err = clk_prepare_enable(dc->clk);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to enable clock: %d\n",
+			err);
+		return err;
+	}
 
-		err = reset_control_deassert(dc->rst);
-		if (err < 0) {
-			dev_err(&pdev->dev, "failed to deassert reset: %d\n",
-				err);
-			return err;
-		}
+	err = reset_control_deassert(dc->rst);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to deassert reset: %d\n",
+			err);
+		return err;
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1987,10 +1967,6 @@ static int tegra_dc_remove(struct platform_device *pdev)
 	}
 
 	reset_control_assert(dc->rst);
-
-	if (dc->soc->has_powergate)
-		tegra_powergate_power_off(dc->powergate);
-
 	clk_disable_unprepare(dc->clk);
 
 	return 0;
-- 
2.1.4
