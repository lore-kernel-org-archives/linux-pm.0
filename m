From: "winton.liu" <18502523564@163.com>
Subject: [PATCH] power: supply: 88pm860x_battery array_soc first number is in mV
Date: Thu, 26 Oct 2017 13:21:50 +0800
Message-ID: <1508995310-3834-1-git-send-email-18502523564@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "winton.liu" <18502523564@163.com>
List-Id: linux-pm@vger.kernel.org

Fix wrong comments of array_soc description.
First number is mV not mAh.

Signed-off-by: winton.liu <18502523564@163.com>
---
 drivers/power/supply/88pm860x_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index 63c57dc..8f867fd 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -123,7 +123,7 @@ struct ccnt {
 
 /*
  * State of Charge.
- * The first number is mAh(=3.6C), and the second number is percent point.
+ * The first number is mV, and the second number is percent point.
  */
 static int array_soc[][2] = {
 	{4170, 100}, {4154, 99}, {4136, 98}, {4122, 97}, {4107, 96},
-- 
1.9.1
