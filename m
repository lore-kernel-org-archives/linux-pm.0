From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 3/3] drivers:power:twl4030-charger: remove nonstandard max_current sysfs attribute
Date: Fri, 14 Apr 2017 20:25:57 +0200
Message-ID: <38afc4e7faaeabb32f153a0956899fa8e97c1b3a.1492194356.git.hns@goldelico.com>
References: <cover.1492194356.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1492194356.git.hns@goldelico.com>
In-Reply-To: <cover.1492194356.git.hns@goldelico.com>
References: <cover.1492194356.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/twl4030_charger.c | 63 ----------------------------------
 1 file changed, 63 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index e70c4ed..e02e150 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -624,63 +624,6 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-/*
- * Provide "max_current" attribute in sysfs.
- */
-static ssize_t
-twl4030_bci_max_current_store(struct device *dev, struct device_attribute *attr,
-	const char *buf, size_t n)
-{
-	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
-	int cur = 0;
-	int status = 0;
-	status = kstrtoint(buf, 10, &cur);
-	if (status)
-		return status;
-	if (cur < 0)
-		return -EINVAL;
-	if (dev == &bci->ac->dev)
-		bci->ac_cur = cur;
-	else
-		bci->usb_cur_target = cur;
-
-	twl4030_charger_update_current(bci);
-	return n;
-}
-
-/*
- * sysfs max_current show
- */
-static ssize_t twl4030_bci_max_current_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	int status = 0;
-	int cur = -1;
-	u8 bcictl1;
-	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
-
-	if (dev == &bci->ac->dev) {
-		if (!bci->ac_is_active)
-			cur = bci->ac_cur;
-	} else {
-		if (bci->ac_is_active)
-			cur = bci->usb_cur_target;
-	}
-	if (cur < 0) {
-		cur = twl4030bci_read_adc_val(TWL4030_BCIIREF1);
-		if (cur < 0)
-			return cur;
-		status = twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
-		if (status < 0)
-			return status;
-		cur = regval2ua(cur, bcictl1 & TWL4030_CGAIN);
-	}
-	return scnprintf(buf, PAGE_SIZE, "%u\n", cur);
-}
-
-static DEVICE_ATTR(max_current, 0644, twl4030_bci_max_current_show,
-			twl4030_bci_max_current_store);
-
 static void twl4030_bci_usb_work(struct work_struct *data)
 {
 	struct twl4030_bci *bci = container_of(data, struct twl4030_bci, work);
@@ -1118,14 +1061,10 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "failed to unmask interrupts: %d\n", ret);
 
 	twl4030_charger_update_current(bci);
-	if (device_create_file(&bci->usb->dev, &dev_attr_max_current))
-		dev_warn(&pdev->dev, "could not create sysfs file\n");
 	if (device_create_file(&bci->usb->dev, &dev_attr_mode))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 	if (device_create_file(&bci->ac->dev, &dev_attr_mode))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
-	if (device_create_file(&bci->ac->dev, &dev_attr_max_current))
-		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
 	twl4030_charger_enable_ac(bci, true);
 	if (!IS_ERR_OR_NULL(bci->transceiver))
@@ -1157,9 +1096,7 @@ static int __exit twl4030_bci_remove(struct platform_device *pdev)
 
 	iio_channel_release(bci->channel_vac);
 
-	device_remove_file(&bci->usb->dev, &dev_attr_max_current);
 	device_remove_file(&bci->usb->dev, &dev_attr_mode);
-	device_remove_file(&bci->ac->dev, &dev_attr_max_current);
 	device_remove_file(&bci->ac->dev, &dev_attr_mode);
 	/* mask interrupts */
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
-- 
2.7.3
