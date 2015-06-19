From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: [PATCH 4/4] extcon: palmas: Remove the mutually_exclusive array
Date: Fri, 19 Jun 2015 15:35:51 +0900
Message-ID: <1434695751-25631-5-git-send-email-cw00.choi@samsung.com>
References: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36736 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbbFSGgI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 02:36:08 -0400
Received: by pdjm12 with SMTP id m12so83867124pdj.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 23:36:07 -0700 (PDT)
In-Reply-To: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cwchoi00@gmail.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com

This patch removes the mutually_exclusive array of extcon-palmas.c.
After used the unique id of each external connector on 2a9de9c0f08d
("extcon: Use the unique id for external connector instead of string"),
extcon driver can't directly handle the bit value indicating the external
connectors.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-palmas.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 4e7335f..12ce2a3 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -35,8 +35,6 @@ static const unsigned int palmas_extcon_cable[] = {
 	EXTCON_NONE,
 };
 
-static const int mutually_exclusive[] = {0x3, 0x0};
-
 static void palmas_usb_wakeup(struct palmas *palmas, int enable)
 {
 	if (enable)
@@ -195,7 +193,6 @@ static int palmas_usb_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to allocate extcon device\n");
 		return -ENOMEM;
 	}
-	palmas_usb->edev->mutually_exclusive = mutually_exclusive;
 
 	status = devm_extcon_dev_register(&pdev->dev, palmas_usb->edev);
 	if (status) {
-- 
2.2.0.GIT

