From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH] tps65090-charger: Fix module autoload for OF platform driver
Date: Fri, 18 Sep 2015 18:54:07 +0200
Message-ID: <20150918165407.GA27491@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36692 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbbIRQyJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2015 12:54:09 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hello,

This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

 drivers/power/tps65090-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/tps65090-charger.c b/drivers/power/tps65090-charger.c
index 7e8fbd2..1b4b5e0 100644
--- a/drivers/power/tps65090-charger.c
+++ b/drivers/power/tps65090-charger.c
@@ -353,6 +353,7 @@ static const struct of_device_id of_tps65090_charger_match[] = {
 	{ .compatible = "ti,tps65090-charger", },
 	{ /* end */ }
 };
+MODULE_DEVICE_TABLE(of, of_tps65090_charger_match);
 
 static struct platform_driver tps65090_charger_driver = {
 	.driver	= {
-- 
2.4.6

