From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 05/16] soc: tegra: pmc: Avoid extra remapping of PMC registers
Date: Fri, 4 Dec 2015 14:57:06 +0000
Message-ID: <1449241037-22193-6-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14392 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbbLDPAX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2015 10:00:23 -0500
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

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

Rather than adding a test to see if the PMC register mapping is valid,
fix this by removing the second mapping of the PMC registers and reserve
the memory region for the PMC registers during early initialisation where
the initial mapping is created. During the probing of the PMC simply check
that the PMC registers have been mapped.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index e60fc2d33c94..fdd1a8d0940f 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -807,22 +807,17 @@ out:
 
 static int tegra_pmc_probe(struct platform_device *pdev)
 {
-	void __iomem *base = pmc->base;
-	struct resource *res;
 	int err;
 
+	if (!pmc->base) {
+		dev_err(&pdev->dev, "base address is not configured\n");
+		return -ENXIO;
+	}
+
 	err = tegra_pmc_parse_dt(pmc, pdev->dev.of_node);
 	if (err < 0)
 		return err;
 
-	/* take over the memory region from the early initialization */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pmc->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pmc->base))
-		return PTR_ERR(pmc->base);
-
-	iounmap(base);
-
 	pmc->clk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(pmc->clk)) {
 		err = PTR_ERR(pmc->clk);
@@ -1126,8 +1121,12 @@ static int __init tegra_pmc_early_init(void)
 		pmc->soc = match->data;
 	}
 
+	if (!request_mem_region(regs.start, resource_size(&regs), regs.name))
+		return -ENOMEM;
+
 	pmc->base = ioremap_nocache(regs.start, resource_size(&regs));
 	if (!pmc->base) {
+		release_mem_region(regs.start, resource_size(&regs));
 		pr_err("failed to map PMC registers\n");
 		return -ENXIO;
 	}
-- 
2.1.4

