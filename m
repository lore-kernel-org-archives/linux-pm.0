From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 4/4] w1:slaves:bq27000: load battery driver kernel module if required
Date: Wed,  7 Oct 2015 20:42:39 +0200
Message-ID: <c9ee31c641a8612c49172123cd56407484e699d6.1444243358.git.hns@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:33328 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600AbbJGSmr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 14:42:47 -0400
In-Reply-To: <cover.1444243358.git.hns@goldelico.com>
In-Reply-To: <cover.1444243358.git.hns@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

Explicitly call request_module() in the wrapper so that the bq27x00_battery
driver is loded on demand, when compiled as module.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/w1/slaves/w1_bq27000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/w1/slaves/w1_bq27000.c
index caafb17..745bd6e 100644
--- a/drivers/w1/slaves/w1_bq27000.c
+++ b/drivers/w1/slaves/w1_bq27000.c
@@ -49,6 +49,8 @@ static int w1_bq27000_add_slave(struct w1_slave *sl)
 	int ret;
 	struct platform_device *pdev;
 
+	request_module("bq27x00_battery");  /* load as module if needed */
+
 	pdev = platform_device_alloc("bq27000-battery", -1);
 	if (!pdev) {
 		ret = -ENOMEM;
-- 
2.5.1

