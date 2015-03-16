From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 06/35 linux-next] power: constify of_device_id array
Date: Mon, 16 Mar 2015 20:17:12 +0100
Message-ID: <1426533469-25458-7-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Santosh Shilimkar <ssantosh@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/power/charger-manager.c         | 2 +-
 drivers/power/reset/at91-poweroff.c     | 2 +-
 drivers/power/reset/at91-reset.c        | 4 ++--
 drivers/power/reset/hisi-reboot.c       | 2 +-
 drivers/power/reset/keystone-reset.c    | 2 +-
 drivers/power/reset/st-poweroff.c       | 2 +-
 drivers/power/reset/syscon-reboot.c     | 2 +-
 drivers/power/reset/vexpress-poweroff.c | 2 +-
 drivers/power/reset/xgene-reboot.c      | 2 +-
 drivers/power/tps65090-charger.c        | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 14b0d85..bfd3842 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1459,7 +1459,7 @@ static int cm_init_thermal_data(struct charger_manager *cm,
 	return ret;
 }
 
-static struct of_device_id charger_manager_match[] = {
+static const struct of_device_id charger_manager_match[] = {
 	{
 		.compatible = "charger-manager",
 	},
diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index 4b72ea5..9847cfb 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -140,7 +140,7 @@ static int at91_poweroff_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id at91_poweroff_of_match[] = {
+static const struct of_device_id at91_poweroff_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-shdwc", },
 	{ .compatible = "atmel,at91sam9rl-shdwc", },
 	{ .compatible = "atmel,at91sam9x5-shdwc", },
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 13584e2..68b1896 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -152,14 +152,14 @@ static void __init at91_reset_status(struct platform_device *pdev)
 	pr_info("AT91: Starting after %s\n", reason);
 }
 
-static struct of_device_id at91_ramc_of_match[] = {
+static const struct of_device_id at91_ramc_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-sdramc", },
 	{ .compatible = "atmel,at91sam9g45-ddramc", },
 	{ .compatible = "atmel,sama5d3-ddramc", },
 	{ /* sentinel */ }
 };
 
-static struct of_device_id at91_reset_of_match[] = {
+static const struct of_device_id at91_reset_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9260_restart },
 	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
 	{ /* sentinel */ }
diff --git a/drivers/power/reset/hisi-reboot.c b/drivers/power/reset/hisi-reboot.c
index 5385460..9ab7f56 100644
--- a/drivers/power/reset/hisi-reboot.c
+++ b/drivers/power/reset/hisi-reboot.c
@@ -64,7 +64,7 @@ static int hisi_reboot_probe(struct platform_device *pdev)
 	return err;
 }
 
-static struct of_device_id hisi_reboot_of_match[] = {
+static const struct of_device_id hisi_reboot_of_match[] = {
 	{ .compatible = "hisilicon,sysctrl" },
 	{}
 };
diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index faedf16..c70f1bf 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -70,7 +70,7 @@ static struct notifier_block rsctrl_restart_nb = {
 	.priority = 128,
 };
 
-static struct of_device_id rsctrl_of_match[] = {
+static const struct of_device_id rsctrl_of_match[] = {
 	{.compatible = "ti,keystone-reset", },
 	{},
 };
diff --git a/drivers/power/reset/st-poweroff.c b/drivers/power/reset/st-poweroff.c
index 27383de..a488877 100644
--- a/drivers/power/reset/st-poweroff.c
+++ b/drivers/power/reset/st-poweroff.c
@@ -97,7 +97,7 @@ static struct notifier_block st_restart_nb = {
 	.priority = 192,
 };
 
-static struct of_device_id st_reset_of_match[] = {
+static const struct of_device_id st_reset_of_match[] = {
 	{
 		.compatible = "st,stih415-restart",
 		.data = (void *)&stih415_reset,
diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index c4049f4..d3c7d24 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -76,7 +76,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	return err;
 }
 
-static struct of_device_id syscon_reboot_of_match[] = {
+static const struct of_device_id syscon_reboot_of_match[] = {
 	{ .compatible = "syscon-reboot" },
 	{}
 };
diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index be12d9b..6a9bf70 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -80,7 +80,7 @@ DEVICE_ATTR(active, S_IRUGO | S_IWUSR, vexpress_reset_active_show,
 
 enum vexpress_reset_func { FUNC_RESET, FUNC_SHUTDOWN, FUNC_REBOOT };
 
-static struct of_device_id vexpress_reset_of_match[] = {
+static const struct of_device_id vexpress_reset_of_match[] = {
 	{
 		.compatible = "arm,vexpress-reset",
 		.data = (void *)FUNC_RESET,
diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index b0e5002..f07e93c 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -87,7 +87,7 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 	return err;
 }
 
-static struct of_device_id xgene_reboot_of_match[] = {
+static const struct of_device_id xgene_reboot_of_match[] = {
 	{ .compatible = "apm,xgene-reboot" },
 	{}
 };
diff --git a/drivers/power/tps65090-charger.c b/drivers/power/tps65090-charger.c
index 0f4e597..1c2edcd 100644
--- a/drivers/power/tps65090-charger.c
+++ b/drivers/power/tps65090-charger.c
@@ -344,7 +344,7 @@ static int tps65090_charger_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id of_tps65090_charger_match[] = {
+static const struct of_device_id of_tps65090_charger_match[] = {
 	{ .compatible = "ti,tps65090-charger", },
 	{ /* end */ }
 };
-- 
2.1.0
