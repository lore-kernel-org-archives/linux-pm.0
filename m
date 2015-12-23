From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] i2c: always enable RuntimePM for the adapter device
Date: Wed, 23 Dec 2015 18:19:28 +0100
Message-ID: <1450891169-13708-2-git-send-email-wsa@the-dreams.de>
References: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The adapter device is a logical device. Because of that, it already uses
pm_runtime_no_callbacks() in the core. To ensure proper propagation from
the children (i2c devices) to the parent of the adapter (the HW device),
make sure RuntimePM is enabled in any case.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e94d2ca2aab4aa..55159e8e53283a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1610,6 +1610,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	pm_runtime_no_callbacks(&adap->dev);
+	pm_runtime_enable(&adap->dev);
 
 #ifdef CONFIG_I2C_COMPAT
 	res = class_compat_create_link(i2c_adapter_compat_class, &adap->dev,
@@ -1864,6 +1865,8 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	/* device name is gone after device_unregister */
 	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
 
+	pm_runtime_disable(&adap->dev);
+
 	/* wait until all references to the device are gone
 	 *
 	 * FIXME: This is old code and should ideally be replaced by an
-- 
2.1.4
