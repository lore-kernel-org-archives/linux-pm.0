From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 13/17] PCI: tegra: remove the power sequence from driver
Date: Thu, 12 Mar 2015 20:15:14 +0800
Message-ID: <1426162518-7405-14-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

We have the generic PM domain support for Tegra SoCs now. So remove the
duplicated power sequence here.

Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
v2: enable pex clock when powering on

 drivers/pci/host/pci-tegra.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 00e92720d7f7..b1e2794d6dfa 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -931,12 +931,6 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 	if (err < 0)
 		dev_warn(pcie->dev, "failed to power off PHY: %d\n", err);
 
-	reset_control_assert(pcie->pcie_xrst);
-	reset_control_assert(pcie->afi_rst);
-	reset_control_assert(pcie->pex_rst);
-
-	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
-
 	err = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
 		dev_warn(pcie->dev, "failed to disable regulators: %d\n", err);
@@ -947,27 +941,17 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
 	int err;
 
-	reset_control_assert(pcie->pcie_xrst);
-	reset_control_assert(pcie->afi_rst);
-	reset_control_assert(pcie->pex_rst);
-
-	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
-
 	/* enable regulators */
 	err = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
 		dev_err(pcie->dev, "failed to enable regulators: %d\n", err);
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
-						pcie->pex_clk,
-						pcie->pex_rst);
-	if (err) {
-		dev_err(pcie->dev, "powerup sequence failed: %d\n", err);
+	err = clk_prepare_enable(pcie->pex_clk);
+	if (err < 0) {
+		dev_err(pcie->dev, "failed to enable PEX clock: %d\n", err);
 		return err;
 	}
 
-	reset_control_deassert(pcie->afi_rst);
-
 	err = clk_prepare_enable(pcie->afi_clk);
 	if (err < 0) {
 		dev_err(pcie->dev, "failed to enable AFI clock: %d\n", err);
-- 
2.1.4
