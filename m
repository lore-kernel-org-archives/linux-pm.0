From: Nicolas JOURDEN <nicolas.jourden@laposte.net>
Subject: [PATCH] TWL4030 charger
Date: Sat, 21 Feb 2015 22:15:57 +0100
Message-ID: <54E8F58D.8060506@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtpoutz303.laposte.net ([178.22.154.203]:44546 "EHLO
	smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751784AbbBUVjz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Feb 2015 16:39:55 -0500
Received: from smtp.laposte.net (localhost [127.0.0.1])
	by lpn-prd-vrout015 (Postfix) with ESMTP id 1EF351B917C
	for <linux-pm@vger.kernel.org>; Sat, 21 Feb 2015 22:16:08 +0100 (CET)
Received: from lpn-prd-vrin001 (unknown [10.128.63.2])
	by lpn-prd-vrout015 (Postfix) with ESMTP id 192551B908E
	for <linux-pm@vger.kernel.org>; Sat, 21 Feb 2015 22:16:08 +0100 (CET)
Received: from lpn-prd-vrin001 (localhost [127.0.0.1])
	by lpn-prd-vrin001 (Postfix) with ESMTP id 0B720352BA1
	for <linux-pm@vger.kernel.org>; Sat, 21 Feb 2015 22:16:08 +0100 (CET)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, notasas@gmail.com

Hello,

This patch fix the TWL4030 charger module for the RTC battery.

Cheers,
Nicolas


Signed-off-by: Nicolas JOURDEN <nicolas.jourden@laposte.net>
---
diff --git a/drivers/power/twl4030_charger.c=20
b/drivers/power/twl4030_charger.c
index 2598c58..89184ae 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -719,10 +719,11 @@ static struct platform_driver twl4030_bci_driver =
=3D {
                 .owner  =3D THIS_MODULE,
                 .of_match_table =3D of_match_ptr(twl_bci_of_match),
         },
+       .probe  =3D twl4030_bci_probe,
         .remove =3D __exit_p(twl4030_bci_remove),
  };

-module_platform_driver_probe(twl4030_bci_driver, twl4030_bci_probe);
+module_platform_driver(twl4030_bci_driver);

  MODULE_AUTHOR("Gra=C5=BEvydas Ignotas");
  MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");


