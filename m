From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC/RFT 08/10] i2c: exynos5: use core helper to mark adapter suspended
Date: Mon, 10 Dec 2018 22:03:06 +0100
Message-ID: <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rejecting transfers should be handled by the core. Also, this will
ensure proper locking which was forgotten in this open coded version.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-exynos5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index c1ce2299a76e..fe2f2031ea36 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -183,7 +183,6 @@ enum i2c_type_exynos {
 
 struct exynos5_i2c {
 	struct i2c_adapter	adap;
-	unsigned int		suspended:1;
 
 	struct i2c_msg		*msg;
 	struct completion	msg_complete;
@@ -715,11 +714,6 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
 	struct exynos5_i2c *i2c = adap->algo_data;
 	int i, ret;
 
-	if (i2c->suspended) {
-		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
-		return -EIO;
-	}
-
 	ret = clk_enable(i2c->clk);
 	if (ret)
 		return ret;
@@ -847,8 +841,7 @@ static int exynos5_i2c_suspend_noirq(struct device *dev)
 {
 	struct exynos5_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->suspended = 1;
-
+	i2c_mark_adapter_suspended(&i2c->adap, true);
 	clk_unprepare(i2c->clk);
 
 	return 0;
@@ -871,7 +864,7 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
 
 	exynos5_i2c_init(i2c);
 	clk_disable(i2c->clk);
-	i2c->suspended = 0;
+	i2c_mark_adapter_suspended(&i2c->adap, false);
 
 	return 0;
 }
-- 
2.11.0
