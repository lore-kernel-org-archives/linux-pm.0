From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 5/9] i2c: zx2967: don't open code to reject transfers when suspended
Date: Sat, 22 Dec 2018 21:26:19 +0100
Message-ID: <20181222202623.4521-6-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

This is handled by the I2C core meanwhile.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-zx2967.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-zx2967.c b/drivers/i2c/busses/i2c-zx2967.c
index b8f9e020d80e..cb1f45647a8b 100644
--- a/drivers/i2c/busses/i2c-zx2967.c
+++ b/drivers/i2c/busses/i2c-zx2967.c
@@ -66,7 +66,6 @@ struct zx2967_i2c {
 	int			msg_rd;
 	u8			*cur_trans;
 	u8			access_cnt;
-	bool			is_suspended;
 	int			error;
 };
 
@@ -313,9 +312,6 @@ static int zx2967_i2c_xfer(struct i2c_adapter *adap,
 	int ret;
 	int i;
 
-	if (i2c->is_suspended)
-		return -EBUSY;
-
 	zx2967_set_addr(i2c, msgs->addr);
 
 	for (i = 0; i < num; i++) {
@@ -470,9 +466,7 @@ static int __maybe_unused zx2967_i2c_suspend(struct device *dev)
 {
 	struct zx2967_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->is_suspended = true;
 	clk_disable_unprepare(i2c->clk);
-
 	return 0;
 }
 
@@ -480,9 +474,7 @@ static int __maybe_unused zx2967_i2c_resume(struct device *dev)
 {
 	struct zx2967_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->is_suspended = false;
 	clk_prepare_enable(i2c->clk);
-
 	return 0;
 }
 
-- 
2.19.1
