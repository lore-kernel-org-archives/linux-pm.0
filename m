From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v7 05/10] i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
Date: Thu, 15 Jun 2017 21:59:33 +0800
Message-ID: <1497535178-12001-6-git-send-email-preid@electromag.com.au>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add a call to of_i2c_setup_smbus_alert when a i2c adapter is registered
so the the smbalert driver can be registered.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/i2c-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d2402bb..626471b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -40,6 +40,7 @@
 #include <linux/gpio.h>
 #include <linux/hardirq.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
@@ -2045,6 +2046,9 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		dev_warn(&adap->dev,
 			 "Failed to create compatibility class link\n");
 #endif
+	res = of_i2c_setup_smbus_alert(adap);
+	if (res)
+		goto out_list;
 
 	i2c_init_recovery(adap);
 
-- 
1.8.3.1
