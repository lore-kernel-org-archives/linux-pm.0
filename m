From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 2/5] power/reset: at91-reset: allow compiling as a module
Date: Tue, 11 Aug 2015 11:12:47 +0200
Message-ID: <1439284370-13803-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54482 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933835AbbHKJM6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 05:12:58 -0400
In-Reply-To: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

It was not possible to compile at91-reset as a module. Implement .remove()
to allow it. Also switch to module_platform_driver_probe() as it is not
hotpluggable.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/Kconfig      |  2 +-
 drivers/power/reset/at91-reset.c | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 17d93a73c513..e41da4a80a05 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -23,7 +23,7 @@ config POWER_RESET_AT91_POWEROFF
 	  SoCs
 
 config POWER_RESET_AT91_RESET
-	bool "Atmel AT91 reset driver"
+	tristate "Atmel AT91 reset driver"
 	depends on ARCH_AT91
 	default SOC_AT91SAM9 || SOC_SAMA5
 	help
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 3225c8590ed0..120f3dec9574 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -169,7 +169,7 @@ static struct notifier_block at91_restart_nb = {
 	.priority = 192,
 };
 
-static int at91_reset_probe(struct platform_device *pdev)
+static int __init at91_reset_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device_node *np;
@@ -202,6 +202,13 @@ static int at91_reset_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __exit at91_reset_remove(struct platform_device *pdev)
+{
+	unregister_restart_handler(&at91_restart_nb);
+
+	return 0;
+}
+
 static const struct platform_device_id at91_reset_plat_match[] = {
 	{ "at91-sam9260-reset", (unsigned long)at91sam9260_restart },
 	{ "at91-sam9g45-reset", (unsigned long)at91sam9g45_restart },
@@ -209,11 +216,15 @@ static const struct platform_device_id at91_reset_plat_match[] = {
 };
 
 static struct platform_driver at91_reset_driver = {
-	.probe = at91_reset_probe,
+	.remove = __exit_p(at91_reset_remove),
 	.driver = {
 		.name = "at91-reset",
 		.of_match_table = at91_reset_of_match,
 	},
 	.id_table = at91_reset_plat_match,
 };
-module_platform_driver(at91_reset_driver);
+module_platform_driver_probe(at91_reset_driver, at91_reset_probe);
+
+MODULE_AUTHOR("Atmel Corporation");
+MODULE_DESCRIPTION("Reset driver for Atmel SoCs");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

