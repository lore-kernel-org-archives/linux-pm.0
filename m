From: Nicolas JOURDEN <nicolas.jourden@laposte.net>
Subject: Re: [PATCH] TWL4030 charger
Date: Sun, 22 Feb 2015 12:50:09 +0100
Message-ID: <54E9C271.1080902@laposte.net>
References: <54E8F58D.8060506@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtpoutz298.laposte.net ([178.22.154.198]:46176 "EHLO
	smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751934AbbBVLuO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Feb 2015 06:50:14 -0500
Received: from smtp.laposte.net (localhost [127.0.0.1])
	by lpn-prd-vrout010 (Postfix) with ESMTP id 1492444EA22
	for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2015 12:50:12 +0100 (CET)
Received: from lpn-prd-vrin001 (unknown [10.128.63.2])
	by lpn-prd-vrout010 (Postfix) with ESMTP id 0FB6C44EA1A
	for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2015 12:50:12 +0100 (CET)
Received: from lpn-prd-vrin001 (localhost [127.0.0.1])
	by lpn-prd-vrin001 (Postfix) with ESMTP id F35CC352BA4
	for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2015 12:50:11 +0100 (CET)
In-Reply-To: <54E8F58D.8060506@laposte.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, notasas@gmail.com

Hello,

Looks like my mailer changed the format/indent for the patch.
This patch fix the TWL4030 charger module for the RTC battery.


Signed-off-by: Nicolas JOURDEN <nicolas.jourden@laposte.net>
---
diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_ch=
arger.c
index 2598c58..89184ae 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -719,10 +719,11 @@ static struct platform_driver twl4030_bci_driver =
=3D {
 		.owner	=3D THIS_MODULE,
 		.of_match_table =3D of_match_ptr(twl_bci_of_match),
 	},
+	.probe  =3D twl4030_bci_probe,
 	.remove	=3D __exit_p(twl4030_bci_remove),
 };
=20
-module_platform_driver_probe(twl4030_bci_driver, twl4030_bci_probe);
+module_platform_driver(twl4030_bci_driver);
=20
 MODULE_AUTHOR("Gra=C3=85=C2=BEvydas Ignotas");
 MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");
