From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 2/4] restore w1 slave bq27000 code of v4.3-rc4
Date: Wed,  7 Oct 2015 20:42:37 +0200
Message-ID: <91a44e6510cf34d4744eb95887ce4b956a734c0c.1444243358.git.hns@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:55394 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbJGSsn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 14:48:43 -0400
In-Reply-To: <cover.1444243358.git.hns@goldelico.com>
In-Reply-To: <cover.1444243358.git.hns@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/w1/slaves/w1_bq27000.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/w1/slaves/w1_bq27000.c
index 745bd6e..caafb17 100644
--- a/drivers/w1/slaves/w1_bq27000.c
+++ b/drivers/w1/slaves/w1_bq27000.c
@@ -49,8 +49,6 @@ static int w1_bq27000_add_slave(struct w1_slave *sl)
 	int ret;
 	struct platform_device *pdev;
 
-	request_module("bq27x00_battery");  /* load as module if needed */
-
 	pdev = platform_device_alloc("bq27000-battery", -1);
 	if (!pdev) {
 		ret = -ENOMEM;
-- 
2.5.1

