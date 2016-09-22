From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/2] power/reset: at91-reset: remove leftover platform_device_id
Date: Fri, 23 Sep 2016 00:53:22 +0200
Message-ID: <20160922225322.31677-2-alexandre.belloni@free-electrons.com>
References: <20160922225322.31677-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40660 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753466AbcIVWxi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2016 18:53:38 -0400
In-Reply-To: <20160922225322.31677-1-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, =?UTF-8?q?Szemz=C5=91=20Andr=C3=A1s?= <sza@esh.hu>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

commit eacd8d09db7f ("power/reset: at91-reset: remove useless
at91_reset_platform_probe()") removed non DT probe support but forgot to
remove the now useless id_table. Do that now.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/at91-reset.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 563722e64d7b..b8005cc18a54 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -247,19 +247,12 @@ static int __exit at91_reset_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id at91_reset_plat_match[] = {
-	{ "at91-sam9260-reset", (unsigned long)at91sam9260_restart },
-	{ "at91-sam9g45-reset", (unsigned long)at91sam9g45_restart },
-	{ /* sentinel */ }
-};
-
 static struct platform_driver at91_reset_driver = {
 	.remove = __exit_p(at91_reset_remove),
 	.driver = {
 		.name = "at91-reset",
 		.of_match_table = at91_reset_of_match,
 	},
-	.id_table = at91_reset_plat_match,
 };
 module_platform_driver_probe(at91_reset_driver, at91_reset_probe);
 
-- 
2.9.3

