From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v10 04/10] i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
Date: Tue, 25 Jul 2017 11:40:18 +0800
Message-ID: <1500954024-6860-5-git-send-email-preid@electromag.com.au>
References: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add a call to of_i2c_setup_smbus_alert when a i2c adapter is registered
so the the smbalert driver can be registered.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/i2c-core-base.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 033b7b9..7006486 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -29,6 +29,7 @@
 #include <linux/errno.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
@@ -1273,6 +1274,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		goto out_list;
 	}
 
+	res = of_i2c_setup_smbus_alert(adap);
+	if (res)
+		goto out_reg;
+
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	pm_runtime_no_callbacks(&adap->dev);
@@ -1304,6 +1309,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	return 0;
 
+out_reg:
+	init_completion(&adap->dev_released);
+	device_unregister(&adap->dev);
+	wait_for_completion(&adap->dev_released);
 out_list:
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
-- 
1.8.3.1
