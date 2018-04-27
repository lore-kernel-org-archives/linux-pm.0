From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/4] regulator: max8998: Fix platform data retrieval.
Date: Fri, 27 Apr 2018 18:02:59 +0200
Message-ID: <1524844982-4714-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-pm@vger.kernel.org

Since the max8998 MFD driver supports instantiation by DT, platform data
retrieval is handled in MFD probe and cell drivers should get use
the pdata field of max8998_dev struct to obtain them.

Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/regulator/max8998.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 3027e7ce100b..6a2b61c012b5 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -309,8 +309,7 @@ static int max8998_set_voltage_buck_sel(struct regulator_dev *rdev,
 					unsigned selector)
 {
 	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
-	struct max8998_platform_data *pdata =
-		dev_get_platdata(max8998->iodev->dev);
+	struct max8998_platform_data *pdata = max8998->iodev->pdata;
 	struct i2c_client *i2c = max8998->iodev->i2c;
 	int buck = rdev_get_id(rdev);
 	int reg, shift = 0, mask, ret, j;
-- 
2.7.4
