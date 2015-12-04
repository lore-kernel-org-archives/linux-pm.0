From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 04/16] soc: tegra: pmc: Remove debugfs entry on probe failure
Date: Fri, 4 Dec 2015 14:57:05 +0000
Message-ID: <1449241037-22193-5-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The debugfs entry for the PMC device will not be removed if the probe of
the device fails on registering the restart handler and so fix this so
that it is removed.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 5b6125ecd69a..e60fc2d33c94 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -117,6 +117,7 @@ struct tegra_pmc_soc {
  * @base: pointer to I/O remapped register region
  * @clk: pointer to pclk clock
  * @soc: pointer to SoC data structure
+ * @debugfs: pointer to debugfs entry
  * @rate: currently configured rate of pclk
  * @suspend_mode: lowest suspend mode available
  * @cpu_good_time: CPU power good time (in microseconds)
@@ -136,6 +137,7 @@ struct tegra_pmc {
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
+	struct dentry *debugfs;
 
 	const struct tegra_pmc_soc *soc;
 
@@ -447,11 +449,9 @@ static const struct file_operations powergate_fops = {
 
 static int tegra_powergate_debugfs_init(void)
 {
-	struct dentry *d;
-
-	d = debugfs_create_file("powergate", S_IRUGO, NULL, NULL,
-				&powergate_fops);
-	if (!d)
+	pmc->debugfs = debugfs_create_file("powergate", S_IRUGO, NULL, NULL,
+					   &powergate_fops);
+	if (!pmc->debugfs)
 		return -ENOMEM;
 
 	return 0;
@@ -844,6 +844,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 	err = register_restart_handler(&tegra_pmc_restart_handler);
 	if (err) {
+		debugfs_remove(pmc->debugfs);
 		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
 			err);
 		return err;
-- 
2.1.4
