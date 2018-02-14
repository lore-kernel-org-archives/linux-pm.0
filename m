From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-pci: Get rid of glk_cqe_enable()
Date: Wed, 14 Feb 2018 15:57:44 +0200
Message-ID: <1518616664-14342-3-git-send-email-adrian.hunter@intel.com>
References: <1518616664-14342-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1518616664-14342-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-pm@vger.kernel.org

Now that tuning no longer leaves the Buffer Read Enable bit set (refer
intel_execute_tuning()), glk_cqe_enable() is no longer needed. Get rid of
it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index ba725580e944..bd6ee968bcd9 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -719,26 +719,8 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
 	return ret;
 }
 
-static void glk_cqe_enable(struct mmc_host *mmc)
-{
-	struct sdhci_host *host = mmc_priv(mmc);
-	u32 reg;
-
-	/*
-	 * CQE gets stuck if it sees Buffer Read Enable bit set, which can be
-	 * the case after tuning, so ensure the buffer is drained.
-	 */
-	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
-	while (reg & SDHCI_DATA_AVAILABLE) {
-		sdhci_readl(host, SDHCI_BUFFER);
-		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
-	}
-
-	sdhci_cqe_enable(mmc);
-}
-
 static const struct cqhci_host_ops glk_cqhci_ops = {
-	.enable		= glk_cqe_enable,
+	.enable		= sdhci_cqe_enable,
 	.disable	= sdhci_cqe_disable,
 	.dumpregs	= sdhci_pci_dumpregs,
 };
-- 
1.9.1

