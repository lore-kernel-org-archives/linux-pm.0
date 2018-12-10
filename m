From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC/RFT 05/10] i2c: zx2967: use core helper to mark adapter suspended
Date: Mon, 10 Dec 2018 22:03:03 +0100
Message-ID: <20181210210310.12677-6-wsa+renesas@sang-engineering.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rejecting transfers should be handled by the core. Also, this will
ensure proper locking which was forgotten in this open coded version
and make sure resume mark is set after enabling clocks (not before).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-zx2967.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-zx2967.c b/drivers/i2c/busses/i2c-zx2967.c
index b8f9e020d80e..9fa48bbe0719 100644
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
@@ -470,7 +466,7 @@ static int __maybe_unused zx2967_i2c_suspend(struct device *dev)
 {
 	struct zx2967_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->is_suspended = true;
+	i2c_mark_adapter_suspended(&i2c->adap, true);
 	clk_disable_unprepare(i2c->clk);
 
 	return 0;
@@ -480,8 +476,8 @@ static int __maybe_unused zx2967_i2c_resume(struct device *dev)
 {
 	struct zx2967_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->is_suspended = false;
 	clk_prepare_enable(i2c->clk);
+	i2c_mark_adapter_suspended(&i2c->adap, false);
 
 	return 0;
 }
-- 
2.11.0
