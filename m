From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 14/17] ata: ahci_tegra: remove power sequence from driver
Date: Thu, 12 Mar 2015 20:15:15 +0800
Message-ID: <1426162518-7405-15-git-send-email-vinceh@nvidia.com>
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
duplicated sequence here.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
 drivers/ata/ahci_tegra.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 3a62eb246d80..8151587ddb70 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -120,12 +120,6 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	if (ret)
 		return ret;
 
-	ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
-						tegra->sata_clk,
-						tegra->sata_rst);
-	if (ret)
-		goto disable_regulators;
-
 	reset_control_assert(tegra->sata_oob_rst);
 	reset_control_assert(tegra->sata_cold_rst);
 
@@ -140,10 +134,6 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 
 disable_power:
 	clk_disable_unprepare(tegra->sata_clk);
-
-	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
-
-disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
 
 	return ret;
@@ -160,7 +150,6 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
 	reset_control_assert(tegra->sata_cold_rst);
 
 	clk_disable_unprepare(tegra->sata_clk);
-	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
 	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
 }
-- 
2.1.4
