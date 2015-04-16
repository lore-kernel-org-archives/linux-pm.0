From: weiyj_lk@163.com
Subject: [PATCH] power/reset: at91: fix return value check in at91_reset_platform_probe()
Date: Thu, 16 Apr 2015 20:19:43 +0800
Message-ID: <1429186783-20895-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m12-16.163.com ([220.181.12.16]:34409 "EHLO m12-16.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704AbbDPMVa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Apr 2015 08:21:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Guenter Roeck <linux@roeck-us.net>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-pm@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap() returns NULL
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/power/reset/at91-reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 13584e2..4d7d60e 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -212,9 +212,9 @@ static int at91_reset_platform_probe(struct platform_device *pdev)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, idx + 1 );
 		at91_ramc_base[idx] = devm_ioremap(&pdev->dev, res->start,
 						   resource_size(res));
-		if (IS_ERR(at91_ramc_base[idx])) {
+		if (!at91_ramc_base[idx]) {
 			dev_err(&pdev->dev, "Could not map ram controller address\n");
-			return PTR_ERR(at91_ramc_base[idx]);
+			return -ENOMEM;
 		}
 	}
 

