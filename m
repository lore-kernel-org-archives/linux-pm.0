From: Johannes Stezenbach <js@sig21.net>
Subject: [RFC PATCH 2/2] clk: x86: Disable unused clocks to fix S0ix
Date: Mon, 25 Sep 2017 21:23:52 +0200
Message-ID: <20170925192352.ihzakshd7yofowdd@sig21.net>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <4254964.MfDMP6QAfg@aspire.rjw.lan>
 <20170922080453.3bwad4ale4zizf42@sig21.net>
 <1555462.9U3gvkyXAX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555462.9U3gvkyXAX@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

d31fd43c0f9a "clk: x86: Do not gate clocks enabled by the firmware"
exposed an issue on Asus E200HA where BIOS enables unused
Atom PMC clocks which prevent the system from entering S0ix.
Add a quirk to disable these clocks on E200HA.

Signed-off-by: Johannes Stezenbach <js@sig21.net>
---
 drivers/clk/x86/clk-pmc-atom.c                 | 10 +++++++---
 drivers/platform/x86/pmc_atom.c                |  7 ++++++-
 include/linux/platform_data/x86/clk-pmc-atom.h |  2 ++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
index 08ef69945ffb..213e71b905eb 100644
--- a/drivers/clk/x86/clk-pmc-atom.c
+++ b/drivers/clk/x86/clk-pmc-atom.c
@@ -166,7 +166,8 @@ static const struct clk_ops plt_clk_ops = {
 static struct clk_plt *plt_clk_register(struct platform_device *pdev, int id,
 					void __iomem *base,
 					const char **parent_names,
-					int num_parents)
+					int num_parents,
+					bool disable_unused)
 {
 	struct clk_plt *pclk;
 	struct clk_init_data init;
@@ -190,7 +191,7 @@ static struct clk_plt *plt_clk_register(struct platform_device *pdev, int id,
 	 * If the clock was already enabled by the firmware mark it as critical
 	 * to avoid it being gated by the clock framework if no driver owns it.
 	 */
-	if (plt_clk_is_enabled(&pclk->hw))
+	if (!disable_unused && plt_clk_is_enabled(&pclk->hw))
 		init.flags |= CLK_IS_CRITICAL;
 
 	ret = devm_clk_hw_register(&pdev->dev, &pclk->hw);
@@ -324,6 +325,7 @@ static int plt_clk_probe(struct platform_device *pdev)
 	struct clk_plt_data *data;
 	unsigned int i;
 	int err;
+	bool disable_unused;
 
 	pmc_data = dev_get_platdata(&pdev->dev);
 	if (!pmc_data || !pmc_data->clks)
@@ -337,9 +339,11 @@ static int plt_clk_probe(struct platform_device *pdev)
 	if (IS_ERR(parent_names))
 		return PTR_ERR(parent_names);
 
+	disable_unused = !!(pmc_data->flags & PMC_CLK_DATA_DISABLE_UNUSED);
 	for (i = 0; i < PMC_CLK_NUM; i++) {
 		data->clks[i] = plt_clk_register(pdev, i, pmc_data->base,
-						 parent_names, data->nparents);
+						 parent_names, data->nparents,
+						 disable_unused);
 		if (IS_ERR(data->clks[i])) {
 			err = PTR_ERR(data->clks[i]);
 			goto err_unreg_clk_plt;
diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index b5dd38712268..d81ada1a6f27 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -59,7 +59,8 @@ static struct pmc_dev pmc_device;
 static u32 acpi_base_addr;
 
 static u32 quirks;
-#define QUIRK_DISABLE_SATA BIT(0)
+#define QUIRK_DISABLE_SATA		BIT(0)
+#define QUIRK_DISABLE_UNUSED_CLOCKS	BIT(1)
 
 static const struct pmc_clk byt_clks[] = {
 	{
@@ -447,6 +448,8 @@ static int pmc_setup_clks(struct pci_dev *pdev, void __iomem *pmc_regmap,
 
 	clk_data->base = pmc_regmap; /* offset is added by client */
 	clk_data->clks = pmc_data->clks;
+	if (quirks & QUIRK_DISABLE_UNUSED_CLOCKS)
+		clk_data->flags = PMC_CLK_DATA_DISABLE_UNUSED;
 
 	clkdev = platform_device_register_data(&pdev->dev, "clk-pmc-atom",
 					       PLATFORM_DEVID_NONE,
@@ -517,6 +520,8 @@ static int cht_asus_e200ha_cb(const struct dmi_system_id *id)
 {
 	pr_info("pmc: Asus E200HA detected\n");
 	quirks |= QUIRK_DISABLE_SATA;
+	/* BIOS enables some clocks at boot which are not needed but block S0ix */
+	quirks |= QUIRK_DISABLE_UNUSED_CLOCKS;
 	return 1;
 }
 
diff --git a/include/linux/platform_data/x86/clk-pmc-atom.h b/include/linux/platform_data/x86/clk-pmc-atom.h
index 3ab892208343..e481878ef238 100644
--- a/include/linux/platform_data/x86/clk-pmc-atom.h
+++ b/include/linux/platform_data/x86/clk-pmc-atom.h
@@ -37,6 +37,8 @@ struct pmc_clk {
  * @clks:	pointer to set of registered clocks, typically 0..5
  */
 struct pmc_clk_data {
+	int flags;
+#define PMC_CLK_DATA_DISABLE_UNUSED 1
 	void __iomem *base;
 	const struct pmc_clk *clks;
 };
-- 
2.14.1

