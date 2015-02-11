From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] ltc2941-battery-gauge: Fix typo in conversion formula  (58 instead of 85)
Date: Wed, 11 Feb 2015 12:36:51 +0100
Message-ID: <1423654611-10906-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, Mike Looijmans <mike.looijmans@topic.nl>
List-Id: linux-pm@vger.kernel.org

The driver reported 30% less than actually measured. This turned out to
be caused by a simple typo in the formula to calculate the LSB quantity.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/power/ltc2941-battery-gauge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/ltc2941-battery-gauge.c b/drivers/power/ltc2941-battery-gauge.c
index e4a9c87..784ff0b 100644
--- a/drivers/power/ltc2941-battery-gauge.c
+++ b/drivers/power/ltc2941-battery-gauge.c
@@ -439,7 +439,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	} else {
 		if (prescaler_exp > LTC2941_MAX_PRESCALER_EXP)
 			prescaler_exp = LTC2941_MAX_PRESCALER_EXP;
-		info->Qlsb = ((58 * 50000) / r_sense) /
+		info->Qlsb = ((85 * 50000) / r_sense) /
 				(128 / (1 << prescaler_exp));
 	}
 
-- 
1.9.1
