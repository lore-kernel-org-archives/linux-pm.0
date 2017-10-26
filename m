From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] power: supply: 88pm860x_battery array_soc first number
 is in mV
Date: Wed, 25 Oct 2017 22:41:18 -0700
Message-ID: <1508996478.10651.28.camel@perches.com>
References: <1508995310-3834-1-git-send-email-18502523564@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:49932 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750884AbdJZFlV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2017 01:41:21 -0400
In-Reply-To: <1508995310-3834-1-git-send-email-18502523564@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "winton.liu" <18502523564@163.com>, sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2017-10-26 at 13:21 +0800, winton.liu wrote:
> Fix wrong comments of array_soc description.
> First number is mV not mAh.
[]
> diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
[]
> @@ -123,7 +123,7 @@ struct ccnt {
>  
>  /*
>   * State of Charge.
> - * The first number is mAh(=3.6C), and the second number is percent point.
> + * The first number is mV, and the second number is percent point.
>   */
>  static int array_soc[][2] = {
>  	{4170, 100}, {4154, 99}, {4136, 98}, {4122, 97}, {4107, 96},

OK, but why not change the declaration to a struct
and make it obvious?

Also, the array or struct should be const.

Perhaps:
---
 drivers/power/supply/88pm860x_battery.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index 63c57dc82ac1..973c5f7b07ba 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -123,9 +123,12 @@ struct ccnt {
 
 /*
  * State of Charge.
- * The first number is mAh(=3.6C), and the second number is percent point.
+ * The first number is mV(=3.6C), and the second number is percent point.
  */
-static int array_soc[][2] = {
+static const struct {
+	u16 mv;
+	u8 percent;
+} array_soc[] = {
 	{4170, 100}, {4154, 99}, {4136, 98}, {4122, 97}, {4107, 96},
 	{4102, 95}, {4088, 94}, {4081, 93}, {4070, 92}, {4060, 91},
 	{4053, 90}, {4044, 89}, {4035, 88}, {4028, 87}, {4019, 86},
@@ -388,14 +391,14 @@ static int calc_soc(struct pm860x_battery_info *info, int state, int *soc)
 		return ret;
 
 	count = ARRAY_SIZE(array_soc);
-	if (ocv < array_soc[count - 1][0]) {
+	if (ocv < array_soc[count - 1].mv) {
 		*soc = 0;
 		return 0;
 	}
 
 	for (i = 0; i < count; i++) {
-		if (ocv >= array_soc[i][0]) {
-			*soc = array_soc[i][1];
+		if (ocv >= array_soc[i].mv) {
+			*soc = array_soc[i].percent;
 			break;
 		}
 	}
