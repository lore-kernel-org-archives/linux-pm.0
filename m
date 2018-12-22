From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 4/9] i2c: brcmstb: don't open code to reject transfers when suspended
Date: Sat, 22 Dec 2018 21:26:18 +0100
Message-ID: <20181222202623.4521-5-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-pm@vger.kernel.org

This is handled by the I2C core meanwhile.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 826d32049996..f6fd5dd638ac 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -170,7 +170,6 @@ struct brcmstb_i2c_dev {
 	struct bsc_regs *bsc_regmap;
 	struct i2c_adapter adapter;
 	struct completion done;
-	bool is_suspended;
 	u32 clk_freq_hz;
 	int data_regsz;
 };
@@ -467,9 +466,6 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 	int xfersz = brcmstb_i2c_get_xfersz(dev);
 	u32 cond, cond_per_msg;
 
-	if (dev->is_suspended)
-		return -EBUSY;
-
 	/* Loop through all messages */
 	for (i = 0; i < num; i++) {
 		pmsg = &msgs[i];
@@ -685,32 +681,16 @@ static int brcmstb_i2c_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int brcmstb_i2c_suspend(struct device *dev)
-{
-	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
-
-	i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
-	i2c_dev->is_suspended = true;
-	i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
-
-	return 0;
-}
-
 static int brcmstb_i2c_resume(struct device *dev)
 {
 	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
 	brcmstb_i2c_set_bsc_reg_defaults(i2c_dev);
-	i2c_dev->is_suspended = false;
-	i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
-
 	return 0;
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(brcmstb_i2c_pm, brcmstb_i2c_suspend,
-			 brcmstb_i2c_resume);
+static SIMPLE_DEV_PM_OPS(brcmstb_i2c_pm, NULL, brcmstb_i2c_resume);
 
 static const struct of_device_id brcmstb_i2c_of_match[] = {
 	{.compatible = "brcm,brcmstb-i2c"},
-- 
2.19.1
