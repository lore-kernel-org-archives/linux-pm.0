From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 17/17] mfd : ab8500/db8500: fix the abuse of IRQF_NO_SUSPEND
Date: Mon, 21 Sep 2015 16:47:13 +0100
Message-ID: <1442850433-5903-18-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
be left enabled so as to allow them to work as expected during the
suspend-resume cycle, but doesn't guarantee that it will wake the system
from a suspended state, enable_irq_wake is recommended to be used for
the wakeup.

This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
enable_irq_wake instead.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mfd/ab8500-core.c        | 11 +++++++++--
 drivers/mfd/ab8500-debugfs.c     |  2 +-
 drivers/mfd/ab8500-gpadc.c       | 15 +++++++++++----
 drivers/mfd/db8500-prcmu.c       | 24 +++++++++++++++++-------
 drivers/power/ab8500_btemp.c     |  6 ++++--
 drivers/power/ab8500_charger.c   |  6 ++++--
 drivers/power/ab8500_fg.c        |  9 ++++++---
 drivers/thermal/db8500_thermal.c |  5 ++---
 drivers/usb/phy/phy-ab8500-usb.c | 10 ++++++----
 9 files changed, 60 insertions(+), 28 deletions(-)

Hi Linus,

This just compile tested and need proper testing as the changes are more
invasive compared to other patches in the series. Any review/testing
is much appreciated.

Regards,
Sudeep

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index fefbe4cfa61d..640c1854c953 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -435,6 +435,13 @@ static int ab8500_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+static int ab8500_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	struct ab8500 *ab8500 = irq_data_get_irq_chip_data(data);
+
+	return irq_set_irq_wake(ab8500->irq, on);
+}
+
 static struct irq_chip ab8500_irq_chip = {
 	.name			= "ab8500",
 	.irq_bus_lock		= ab8500_irq_lock,
@@ -443,6 +450,7 @@ static struct irq_chip ab8500_irq_chip = {
 	.irq_disable		= ab8500_irq_mask,
 	.irq_unmask		= ab8500_irq_unmask,
 	.irq_set_type		= ab8500_irq_set_type,
+	.irq_set_wake		= ab8500_irq_set_wake,
 };
 
 static void update_latch_offset(u8 *offset, int i)
@@ -1744,8 +1752,7 @@ static int ab8500_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = devm_request_threaded_irq(&pdev->dev, ab8500->irq, NULL,
-			ab8500_hierarchical_irq,
-			IRQF_ONESHOT | IRQF_NO_SUSPEND,
+			ab8500_hierarchical_irq, IRQF_ONESHOT,
 			"ab8500", ab8500);
 	if (ret)
 		return ret;
diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 0236cd7cdce4..9a2c37041b9e 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -2885,7 +2885,7 @@ static ssize_t ab8500_subscribe_write(struct file *file,
 	}
 
 	err = request_threaded_irq(user_val, NULL, ab8500_debug_handler,
-				   IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
+				   IRQF_SHARED | IRQF_ONESHOT,
 				   "ab8500-debug", &dev->kobj);
 	if (err < 0) {
 		pr_info("request_threaded_irq failed %d, %lu\n",
diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index c51c1b188d64..69a8122a334f 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -948,7 +948,7 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 	if (gpadc->irq_sw >= 0) {
 		ret = request_threaded_irq(gpadc->irq_sw, NULL,
 			ab8500_bm_gpadcconvend_handler,
-			IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
+			IRQF_SHARED | IRQF_ONESHOT,
 			"ab8500-gpadc-sw",
 			gpadc);
 		if (ret < 0) {
@@ -962,7 +962,7 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 	if (gpadc->irq_hw >= 0) {
 		ret = request_threaded_irq(gpadc->irq_hw, NULL,
 			ab8500_bm_gpadcconvend_handler,
-			IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
+			IRQF_SHARED | IRQF_ONESHOT,
 			"ab8500-gpadc-hw",
 			gpadc);
 		if (ret < 0) {
@@ -994,6 +994,9 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_set_active(gpadc->dev);
 	pm_runtime_enable(gpadc->dev);
 
+	enable_irq_wake(gpadc->irq_sw);
+	enable_irq_wake(gpadc->irq_hw);
+
 	ab8500_gpadc_read_calibration_data(gpadc);
 	list_add_tail(&gpadc->node, &ab8500_gpadc_list);
 	dev_dbg(gpadc->dev, "probe success\n");
@@ -1015,10 +1018,14 @@ static int ab8500_gpadc_remove(struct platform_device *pdev)
 	/* remove this gpadc entry from the list */
 	list_del(&gpadc->node);
 	/* remove interrupt  - completion of Sw ADC conversion */
-	if (gpadc->irq_sw >= 0)
+	if (gpadc->irq_sw >= 0) {
+		disable_irq_wake(gpadc->irq_sw);
 		free_irq(gpadc->irq_sw, gpadc);
-	if (gpadc->irq_hw >= 0)
+	}
+	if (gpadc->irq_hw >= 0) {
+		disable_irq_wake(gpadc->irq_hw);
 		free_irq(gpadc->irq_hw, gpadc);
+	}
 
 	pm_runtime_get_sync(gpadc->dev);
 	pm_runtime_disable(gpadc->dev);
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index e6e4bacb09ee..d568ecd66f7e 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -266,6 +266,7 @@ static struct {
 } fw_info;
 
 static struct irq_domain *db8500_irq_domain;
+static int prcmu_irq;
 
 /*
  * This vector maps irq numbers to the bits in the bit field used in
@@ -2599,12 +2600,20 @@ static void noop(struct irq_data *d)
 {
 }
 
+static int prcmu_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	int *irq = irq_data_get_irq_chip_data(data);
+
+	return irq_set_irq_wake(*irq, on);
+}
+
 static struct irq_chip prcmu_irq_chip = {
 	.name		= "prcmu",
 	.irq_disable	= prcmu_irq_mask,
 	.irq_ack	= noop,
 	.irq_mask	= prcmu_irq_mask,
 	.irq_unmask	= prcmu_irq_unmask,
+	.irq_set_wake	= prcmu_irq_set_wake,
 };
 
 static __init char *fw_project_name(u32 project)
@@ -2652,6 +2661,7 @@ static __init char *fw_project_name(u32 project)
 static int db8500_irq_map(struct irq_domain *d, unsigned int virq,
 				irq_hw_number_t hwirq)
 {
+	irq_set_chip_data(virq, d->host_data);
 	irq_set_chip_and_handler(virq, &prcmu_irq_chip,
 				handle_simple_irq);
 
@@ -2669,7 +2679,7 @@ static int db8500_irq_init(struct device_node *np)
 
 	db8500_irq_domain = irq_domain_add_simple(
 		np, NUM_PRCMU_WAKEUPS, 0,
-		&db8500_irq_ops, NULL);
+		&db8500_irq_ops, &prcmu_irq);
 
 	if (!db8500_irq_domain) {
 		pr_err("Failed to create irqdomain\n");
@@ -3134,7 +3144,7 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct prcmu_pdata *pdata = dev_get_platdata(&pdev->dev);
-	int irq = 0, err = 0;
+	int err = 0;
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "prcmu");
@@ -3166,14 +3176,14 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 	/* Clean up the mailbox interrupts after pre-kernel code. */
 	writel(ALL_MBOX_BITS, PRCM_ARM_IT1_CLR);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	prcmu_irq = platform_get_irq(pdev, 0);
+	if (prcmu_irq <= 0) {
 		dev_err(&pdev->dev, "no prcmu irq provided\n");
-		return irq;
+		return prcmu_irq;
 	}
 
-	err = request_threaded_irq(irq, prcmu_irq_handler,
-	        prcmu_irq_thread_fn, IRQF_NO_SUSPEND, "prcmu", NULL);
+	err = request_threaded_irq(prcmu_irq, prcmu_irq_handler,
+				   prcmu_irq_thread_fn, 0, "prcmu", NULL);
 	if (err < 0) {
 		pr_err("prcmu: Failed to allocate IRQ_DB8500_PRCMU1.\n");
 		return err;
diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index 8f8044e1acf3..ab838b35c7be 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -1032,6 +1032,7 @@ static int ab8500_btemp_remove(struct platform_device *pdev)
 	/* Disable interrupts */
 	for (i = 0; i < ARRAY_SIZE(ab8500_btemp_irq); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_btemp_irq[i].name);
+		disable_irq_wake(irq);
 		free_irq(irq, di);
 	}
 
@@ -1149,14 +1150,14 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(ab8500_btemp_irq); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_btemp_irq[i].name);
 		ret = request_threaded_irq(irq, NULL, ab8500_btemp_irq[i].isr,
-			IRQF_SHARED | IRQF_NO_SUSPEND,
-			ab8500_btemp_irq[i].name, di);
+			IRQF_SHARED, ab8500_btemp_irq[i].name, di);
 
 		if (ret) {
 			dev_err(di->dev, "failed to request %s IRQ %d: %d\n"
 				, ab8500_btemp_irq[i].name, irq, ret);
 			goto free_irq;
 		}
+		enable_irq_wake(irq);
 		dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
 			ab8500_btemp_irq[i].name, irq, ret);
 	}
@@ -1175,6 +1176,7 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	/* We also have to free all successfully registered irqs */
 	for (i = i - 1; i >= 0; i--) {
 		irq = platform_get_irq_byname(pdev, ab8500_btemp_irq[i].name);
+		disable_irq_wake(irq);
 		free_irq(irq, di);
 	}
 free_btemp_wq:
diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index e388171f4e58..734fe43181ab 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -3406,6 +3406,7 @@ static int ab8500_charger_remove(struct platform_device *pdev)
 	/* Disable interrupts */
 	for (i = 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
+		disable_irq_wake(irq);
 		free_irq(irq, di);
 	}
 
@@ -3680,14 +3681,14 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
 		ret = request_threaded_irq(irq, NULL, ab8500_charger_irq[i].isr,
-			IRQF_SHARED | IRQF_NO_SUSPEND,
-			ab8500_charger_irq[i].name, di);
+			IRQF_SHARED, ab8500_charger_irq[i].name, di);
 
 		if (ret != 0) {
 			dev_err(di->dev, "failed to request %s IRQ %d: %d\n"
 				, ab8500_charger_irq[i].name, irq, ret);
 			goto free_irq;
 		}
+		enable_irq_wake(irq);
 		dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
 			ab8500_charger_irq[i].name, irq, ret);
 	}
@@ -3721,6 +3722,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	/* We also have to free all successfully registered irqs */
 	for (i = i - 1; i >= 0; i--) {
 		irq = platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
+		disable_irq_wake(irq);
 		free_irq(irq, di);
 	}
 put_usb_phy:
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 3830dade5d69..8f0193e7c42c 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -3168,14 +3168,14 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq_th); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_fg_irq_th[i].name);
 		ret = request_irq(irq, ab8500_fg_irq_th[i].isr,
-				  IRQF_SHARED | IRQF_NO_SUSPEND,
-				  ab8500_fg_irq_th[i].name, di);
+				  IRQF_SHARED, ab8500_fg_irq_th[i].name, di);
 
 		if (ret != 0) {
 			dev_err(di->dev, "failed to request %s IRQ %d: %d\n",
 				ab8500_fg_irq_th[i].name, irq, ret);
 			goto free_irq;
 		}
+		enable_irq_wake(irq);
 		dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
 			ab8500_fg_irq_th[i].name, irq, ret);
 	}
@@ -3183,7 +3183,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* Register threaded interrupt handler */
 	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
 	ret = request_threaded_irq(irq, NULL, ab8500_fg_irq_bh[0].isr,
-				IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
+				IRQF_SHARED | IRQF_ONESHOT,
 			ab8500_fg_irq_bh[0].name, di);
 
 	if (ret != 0) {
@@ -3191,6 +3191,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 			ab8500_fg_irq_bh[0].name, irq, ret);
 		goto free_irq;
 	}
+	enable_irq_wake(irq);
 	dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
 		ab8500_fg_irq_bh[0].name, irq, ret);
 
@@ -3233,9 +3234,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* We also have to free all registered irqs */
 	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq_th); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_fg_irq_th[i].name);
+		disable_irq_wake(irq);
 		free_irq(irq, di);
 	}
 	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
+	disable_irq_wake(irq);
 	free_irq(irq, di);
 free_inst_curr_wq:
 	destroy_workqueue(di->fg_wq);
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 652acd8fbe48..27b534374d29 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -423,8 +423,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, low_irq, NULL,
-		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_low", pzone);
+		prcmu_low_irq_handler, IRQF_ONESHOT, "dbx500_temp_low", pzone);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to allocate temp low irq.\n");
 		goto out_unlock;
@@ -438,7 +437,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, high_irq, NULL,
-		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
+		prcmu_high_irq_handler, IRQF_ONESHOT,
 		"dbx500_temp_high", pzone);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to allocate temp high irq.\n");
diff --git a/drivers/usb/phy/phy-ab8500-usb.c b/drivers/usb/phy/phy-ab8500-usb.c
index 0c912d3950a5..425bb4e171e7 100644
--- a/drivers/usb/phy/phy-ab8500-usb.c
+++ b/drivers/usb/phy/phy-ab8500-usb.c
@@ -1179,12 +1179,13 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 				ab8500_usb_link_status_irq,
-				IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
+				IRQF_SHARED | IRQF_ONESHOT,
 				"usb-link-status", ab);
 		if (err < 0) {
 			dev_err(ab->dev, "request_irq failed for link status irq\n");
 			return err;
 		}
+		enable_irq_wake(irq);
 	}
 
 	if (ab->flags & AB8500_USB_FLAG_USE_ID_WAKEUP_IRQ) {
@@ -1195,12 +1196,12 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 				ab8500_usb_disconnect_irq,
-				IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
-				"usb-id-fall", ab);
+				IRQF_SHARED | IRQF_ONESHOT, "usb-id-fall", ab);
 		if (err < 0) {
 			dev_err(ab->dev, "request_irq failed for ID fall irq\n");
 			return err;
 		}
+		enable_irq_wake(irq);
 	}
 
 	if (ab->flags & AB8500_USB_FLAG_USE_VBUS_DET_IRQ) {
@@ -1211,12 +1212,13 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 				ab8500_usb_disconnect_irq,
-				IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
+				IRQF_SHARED | IRQF_ONESHOT,
 				"usb-vbus-fall", ab);
 		if (err < 0) {
 			dev_err(ab->dev, "request_irq failed for Vbus fall irq\n");
 			return err;
 		}
+		enable_irq_wake(irq);
 	}
 
 	return 0;
-- 
1.9.1
