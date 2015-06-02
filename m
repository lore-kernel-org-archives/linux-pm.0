From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: [PATCH] power_supply: bq25890: make chip_id int
Date: Tue,  2 Jun 2015 13:36:51 +0300
Message-ID: <1433241411-27423-1-git-send-email-laurentiu.palcu@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50492 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598AbbFBKgr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Jun 2015 06:36:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Smatch static checker correctly detected an impossible condition because
chip_id was declared as u8, instead of int:

drivers/power/bq25890_charger.c:843 bq25890_probe()
warn: impossible condition '(bq->chip_id < 0) => (0-255 < 0)'

Also, while at it, fix the return value too.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/power/bq25890_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/bq25890_charger.c b/drivers/power/bq25890_charger.c
index c7b4903..16b7c7bc 100644
--- a/drivers/power/bq25890_charger.c
+++ b/drivers/power/bq25890_charger.c
@@ -99,7 +99,7 @@ struct bq25890_device {
 	struct regmap *rmap;
 	struct regmap_field *rmap_fields[F_MAX_FIELDS];
 
-	u8 chip_id;
+	int chip_id;
 	struct bq25890_init_data init_data;
 	struct bq25890_state state;
 
@@ -842,7 +842,7 @@ static int bq25890_probe(struct i2c_client *client,
 	bq->chip_id = bq25890_field_read(bq, F_PN);
 	if (bq->chip_id < 0) {
 		dev_err(dev, "Cannot read chip ID.\n");
-		return ret;
+		return bq->chip_id;
 	}
 
 	if (bq->chip_id != BQ25890_ID) {
-- 
1.9.1

