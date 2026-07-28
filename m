Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A47439F90;
	Tue, 28 Jul 2026 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242079; cv=none; b=mjli6ce2b1PESK2WHjoNwv3nQjzIraxT7KOK/+moJz9LO/PnxKlp9+myBMxiiULmVNLS9z+fEVHm9DL9r1Pui9xpSvzyhxKGrIAIkxPcI6DERwzZShd1hqaSIbwGXTzCM3L1XNrtry0AJRzOHQOw9wYL2n+a/h/E8aAJ5tDfN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242079; c=relaxed/simple;
	bh=srDHrrYHNHqXcgd8UvzqgeQEK3hizWRslW5D7hLWoyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWaR08BttEL4m8dIO1/HtZBtjd5U91vTWJOpTjoMEuTehT0GRpLf9wN4BApkk1LOWPRNY2/MslFGrjy6eVRkyOftKislbdxlAa55eYzsgNH+XdMwgRA4Xaaa2rBpO3yaeCvuT3kbwQeboZggkAtpxqRIKSJBXez/fa02ove/ntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=EOj3hA4u; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="EOj3hA4u"
Received: from LAPTOP-99KJFSET (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47e10a90f;
	Tue, 28 Jul 2026 20:34:29 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: sre@kernel.org
Cc: Hongyan Xu <getshell@seu.edu.cn>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] power: supply: twl4030_charger: cancel work on remove
Date: Tue, 28 Jul 2026 20:33:41 +0800
Message-ID: <20260728123423.781-7-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa8b828f303a1kunm4c64fbaeeecf6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkxKVklDQx5LTktIGEsdGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=EOj3hA4u+/qYZV8jT3fgij47047yU/1N0YDSpMKGrQZrHpRhoImaj5jYk8010E8nkeUhY9yNASkvO3xorTz9BKAlqIQDjugm9xe0zkrd3HAHG9g86Wo0CKR7oFPlF3B3rKyq6XLO70e4//2ux15F6LcUwNP0L727RoPc5NNzwlo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=dUIx2K9aKvDHpEc8tdZ804T27tJDAnvaPEp+ayPa+CM=;
	h=date:mime-version:subject:message-id:from;

The USB notifier schedules bci->work and the charger current path can
requeue bci->current_worker. Both work items use bci, but bci is
devm-allocated and remove did not stop them before devres cleanup.

Get the USB PHY without a managed notifier, register the notifier
explicitly, then unregister it and mask external event sources before
cancelling both work items in remove.

This issue was found by a static analysis tool.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/power/supply/twl4030_charger.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 9dcb5457b..0142259ec 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -116,6 +116,7 @@ struct twl4030_bci {
 	struct usb_phy		*transceiver;
 	struct notifier_block	usb_nb;
 	struct work_struct	work;
+	bool			usb_nb_registered;
 	int			irq_chg;
 	int			irq_bci;
 	int			usb_enabled;
@@ -1024,7 +1025,7 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		if (phynode) {
 			bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
 			bci->transceiver = devm_usb_get_phy_by_node(
-				bci->dev, phynode, &bci->usb_nb);
+				bci->dev, phynode, NULL);
 			of_node_put(phynode);
 			if (IS_ERR(bci->transceiver)) {
 				ret = PTR_ERR(bci->transceiver);
@@ -1033,6 +1034,15 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 				dev_warn(&pdev->dev, "could not request transceiver (%d)",
 					ret);
 				bci->transceiver = NULL;
+			} else {
+				ret = usb_register_notifier(bci->transceiver,
+							    &bci->usb_nb);
+				if (ret)
+					dev_warn(&pdev->dev,
+						 "could not register USB notifier (%d)\n",
+						 ret);
+				else
+					bci->usb_nb_registered = true;
 			}
 		}
 	}
@@ -1112,17 +1122,25 @@ static void twl4030_bci_remove(struct platform_device *pdev)
 {
 	struct twl4030_bci *bci = platform_get_drvdata(pdev);
 
-	twl4030_charger_enable_ac(bci, false);
-	twl4030_charger_enable_usb(bci, false);
-	twl4030_charger_enable_backup(0, 0);
+	if (bci->usb_nb_registered)
+		usb_unregister_notifier(bci->transceiver, &bci->usb_nb);
 
 	device_remove_file(&bci->usb->dev, &dev_attr_mode);
 	device_remove_file(&bci->ac->dev, &dev_attr_mode);
+
 	/* mask interrupts */
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
 			 TWL4030_INTERRUPTS_BCIIMR1A);
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
 			 TWL4030_INTERRUPTS_BCIIMR2A);
+
+	cancel_work_sync(&bci->work);
+	bci->usb_cur_target = 0;
+	cancel_delayed_work_sync(&bci->current_worker);
+
+	twl4030_charger_enable_ac(bci, false);
+	twl4030_charger_enable_usb(bci, false);
+	twl4030_charger_enable_backup(0, 0);
 }
 
 static const struct of_device_id twl_bci_of_match[] __maybe_unused = {
-- 
2.50.1.windows.1
