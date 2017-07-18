From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v8 3/9] i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
Date: Tue, 18 Jul 2017 16:19:38 +0800
Message-ID: <1500365984-61404-4-git-send-email-preid@electromag.com.au>
References: <1500365984-61404-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500365984-61404-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add a call to of_i2c_setup_smbus_alert when a i2c adapter is registered
so the the smbalert driver can be registered.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
