From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 2/2] power:bq27xxx: fix register numbers of bq27500
Date: Thu, 17 Dec 2015 11:12:54 +0100
Message-ID: <dd1c67a7c8a2cabed0433f2d7b30f91bb0b06b78.1450347172.git.hns@goldelico.com>
References: <cover.1450347172.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:52711 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478AbbLQKNB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 05:13:01 -0500
In-Reply-To: <cover.1450347172.git.hns@goldelico.com>
In-Reply-To: <cover.1450347172.git.hns@goldelico.com>
References: <cover.1450347172.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com, "H. Nikolaus Schaller" <hns@goldelico.com>

bug: according to data sheet some register numbers are wrong.

tested: no

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/bq27xxx_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index e54a125..f9a5f4f 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -198,10 +198,10 @@ static u8 bq27500_regs[] = {
 	INVALID_REG_ADDR,	/* TTECP - NA	*/
 	0x0c,	/* NAC		*/
 	0x12,	/* LMD(FCC)	*/
-	0x1e,	/* CYCT		*/
+	0x2a,	/* CYCT		*/
 	INVALID_REG_ADDR,	/* AE - NA	*/
-	0x20,	/* SOC(RSOC)	*/
-	0x2e,	/* DCAP(ILMD)	*/
+	0x2c,	/* SOC(RSOC)	*/
+	0x3c,	/* DCAP(ILMD)	*/
 	INVALID_REG_ADDR,	/* AP - NA	*/
 };
 
-- 
2.5.1

