From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: [PATCH 2/2] bq2415x_charger: Add support for bq24157s
Date: Thu,  5 Mar 2015 13:23:57 +0200
Message-ID: <1425554637-26782-3-git-send-email-anda-maria.nicolae@intel.com>
References: <1425554637-26782-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425554637-26782-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: anda-maria.nicolae@intel.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds bq24157s charger in the list of supported chargers.
bq24157s is similar to bq24158, except for Bit6 from Special Charger
Voltage/Enable Pin Status register, but this register is currently
not used by bq2415x_charger.

Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
---
 drivers/power/bq2415x_charger.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index 628a2ed..41f6c4c 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -26,6 +26,8 @@
  * http://www.ti.com/product/bq24153
  * http://www.ti.com/product/bq24153a
  * http://www.ti.com/product/bq24155
+ * http://www.ti.com/product/bq24157s
+ * http://www.ti.com/product/bq24158
  */
 
 #include <linux/kernel.h>
@@ -147,6 +149,7 @@ enum bq2415x_chip {
 	BQ24155,
 	BQ24156,
 	BQ24156A,
+	BQ24157S,
 	BQ24158,
 };
 
@@ -162,6 +165,7 @@ static char *bq2415x_chip_name[] = {
 	"bq24155",
 	"bq24156",
 	"bq24156a",
+	"bq24157s",
 	"bq24158",
 };
 
@@ -448,6 +452,8 @@ static enum bq2415x_chip bq2415x_detect_chip(struct bq2415x_device *bq)
 				return bq->chip;
 			return BQ24156;
 		case 2:
+			if (bq->chip == BQ24157S)
+				return bq->chip;
 			return BQ24158;
 		default:
 			return BQUNKNOWN;
@@ -480,6 +486,7 @@ static int bq2415x_detect_revision(struct bq2415x_device *bq)
 	case BQ24153A:
 	case BQ24156:
 	case BQ24156A:
+	case BQ24157S:
 	case BQ24158:
 		if (ret == 3)
 			return 0;
@@ -1716,6 +1723,7 @@ static const struct i2c_device_id bq2415x_i2c_id_table[] = {
 	{ "bq24155", BQ24155 },
 	{ "bq24156", BQ24156 },
 	{ "bq24156a", BQ24156A },
+	{ "bq24157s", BQ24157S },
 	{ "bq24158", BQ24158 },
 	{},
 };
-- 
1.7.9.5
