From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: [PATCH 3/4] extcon: palmas: Fix NULL pointer error
Date: Fri, 19 Jun 2015 15:35:50 +0900
Message-ID: <1434695751-25631-4-git-send-email-cw00.choi@samsung.com>
References: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35066 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbbFSGgF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 02:36:05 -0400
Received: by pacyx8 with SMTP id yx8so78694427pac.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 23:36:05 -0700 (PDT)
In-Reply-To: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cwchoi00@gmail.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com

This patch fixes NULL pointer error by removing the unneeded kfree() call
of edev->name because extcon-palmas no longer allocate the memory for edev->name.

Fixes: d71aadda19f8 ("extcon: Remove the optional name of extcon device")
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-palmas.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 080d5cc..4e7335f 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -200,7 +200,6 @@ static int palmas_usb_probe(struct platform_device *pdev)
 	status = devm_extcon_dev_register(&pdev->dev, palmas_usb->edev);
 	if (status) {
 		dev_err(&pdev->dev, "failed to register extcon device\n");
-		kfree(palmas_usb->edev->name);
 		return status;
 	}
 
@@ -214,7 +213,6 @@ static int palmas_usb_probe(struct platform_device *pdev)
 		if (status < 0) {
 			dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
 					palmas_usb->id_irq, status);
-			kfree(palmas_usb->edev->name);
 			return status;
 		}
 	}
@@ -229,7 +227,6 @@ static int palmas_usb_probe(struct platform_device *pdev)
 		if (status < 0) {
 			dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
 					palmas_usb->vbus_irq, status);
-			kfree(palmas_usb->edev->name);
 			return status;
 		}
 	}
@@ -241,10 +238,6 @@ static int palmas_usb_probe(struct platform_device *pdev)
 
 static int palmas_usb_remove(struct platform_device *pdev)
 {
-	struct palmas_usb *palmas_usb = platform_get_drvdata(pdev);
-
-	kfree(palmas_usb->edev->name);
-
 	return 0;
 }
 
-- 
2.2.0.GIT

