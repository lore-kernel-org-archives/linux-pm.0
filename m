From: weiyj_lk@163.com
Subject: [PATCH -next] ipaq_micro_battery: fix sparse non static symbol warning
Date: Mon, 28 Jul 2014 21:14:21 +0800
Message-ID: <1406553261-29495-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m12-15.163.com ([220.181.12.15]:54159 "EHLO m12-15.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbaG1NPQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Jul 2014 09:15:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-pm@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

drivers/power/ipaq_micro_battery.c:278:24: warning:
 symbol 'micro_batt_device_driver' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/power/ipaq_micro_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/ipaq_micro_battery.c b/drivers/power/ipaq_micro_battery.c
index 54632ea..9d69460 100644
--- a/drivers/power/ipaq_micro_battery.c
+++ b/drivers/power/ipaq_micro_battery.c
@@ -275,7 +275,7 @@ static const struct dev_pm_ops micro_batt_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(micro_batt_suspend, micro_batt_resume)
 };
 
-struct platform_driver micro_batt_device_driver = {
+static struct platform_driver micro_batt_device_driver = {
 	.driver		= {
 		.name	= "ipaq-micro-battery",
 		.pm	= &micro_batt_dev_pm_ops,

