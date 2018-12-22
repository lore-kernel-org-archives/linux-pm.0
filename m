From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 8/9] i2c: exynos5: don't open code to reject transfers when suspended
Date: Sat, 22 Dec 2018 21:26:22 +0100
Message-ID: <20181222202623.4521-9-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is handled by the I2C core meanwhile.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-exynos5.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index c1ce2299a76e..81b9c3cf4e75 100644
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
@@ -847,10 +841,7 @@ static int exynos5_i2c_suspend_noirq(struct device *dev)
 {
 	struct exynos5_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->suspended = 1;
-
 	clk_unprepare(i2c->clk);
-
 	return 0;
 }
 
@@ -871,7 +862,6 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
 
 	exynos5_i2c_init(i2c);
 	clk_disable(i2c->clk);
-	i2c->suspended = 0;
 
 	return 0;
 }
-- 
2.19.1
