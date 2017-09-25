From: Johannes Stezenbach <js@sig21.net>
Subject: [RFC PATCH 1/2] platform/x86: add Atom PMC quirk to disable SATA
Date: Mon, 25 Sep 2017 21:21:09 +0200
Message-ID: <20170925192109.rty2fnm7c4jnj3vx@sig21.net>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <4254964.MfDMP6QAfg@aspire.rjw.lan>
 <20170922080453.3bwad4ale4zizf42@sig21.net>
 <1555462.9U3gvkyXAX@aspire.rjw.lan>
 <20170925191749.2oamusbajgs6clcg@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:49077 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965005AbdIYTVV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Sep 2017 15:21:21 -0400
Content-Disposition: inline
In-Reply-To: <20170925191749.2oamusbajgs6clcg@sig21.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org

SATA controller is enabled on Asus E200HA even though the
machine doesn't use it (it has eMMC storage), however
SATA being on blocks S0ix entry so we need to disable it.

Signed-off-by: Johannes Stezenbach <js@sig21.net>
---
 drivers/platform/x86/pmc_atom.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 8d13c86cc418..b5dd38712268 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -17,6 +17,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_data/x86/clk-pmc-atom.h>
@@ -57,6 +58,9 @@ struct pmc_dev {
 static struct pmc_dev pmc_device;
 static u32 acpi_base_addr;
 
+static u32 quirks;
+#define QUIRK_DISABLE_SATA BIT(0)
+
 static const struct pmc_clk byt_clks[] = {
 	{
 		.name = "xtal",
@@ -271,6 +275,15 @@ static void pmc_hw_reg_setup(struct pmc_dev *pmc)
 	 * - GPIO_SCORE shared IRQ
 	 */
 	pmc_reg_write(pmc, PMC_S0IX_WAKE_EN, (u32)PMC_WAKE_EN_SETTING);
+
+	if (quirks & QUIRK_DISABLE_SATA) {
+		u32 func_dis;
+
+		pr_info("pmc: disable SATA IP\n");
+		func_dis = pmc_reg_read(pmc, PMC_FUNC_DIS);
+		func_dis |= BIT_SATA;
+		pmc_reg_write(pmc, PMC_FUNC_DIS, func_dis);
+	}
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -500,6 +513,24 @@ static struct pmc_notifier_block pmc_freeze_nb = {
 };
 #endif
 
+static int cht_asus_e200ha_cb(const struct dmi_system_id *id)
+{
+	pr_info("pmc: Asus E200HA detected\n");
+	quirks |= QUIRK_DISABLE_SATA;
+	return 1;
+}
+
+static const struct dmi_system_id cht_table[] = {
+	{
+		.callback = cht_asus_e200ha_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E200HA"),
+		},
+	},
+	{ }
+};
+
 static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct pmc_dev *pmc = &pmc_device;
@@ -526,6 +557,8 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pmc->map = map;
 
+	dmi_check_system(cht_table);
+
 	/* PMC hardware registers setup */
 	pmc_hw_reg_setup(pmc);
 
-- 
2.14.1
