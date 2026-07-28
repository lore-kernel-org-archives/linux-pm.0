Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10F3B1009;
	Tue, 28 Jul 2026 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242074; cv=none; b=G9IqNQ/SDdp8j9F6CMJDBNsIIwUihRG+oC4PV+l8MRxqf/ENfkiVhz6eYAQolGZIoqEus/kUIIrJgq1ucb1/CdefmT/t5KOYduEiPTnQ3St6nCU2TBgipEz9qXcEeDOMxEzybZBTMWCdhqIvay6hCxiTVt3p4KQzBjh6cJ6hp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242074; c=relaxed/simple;
	bh=yFTbbFbqLdfV28g5SZGhbXNTM7jyNPINBDDvDyUaxWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofL8a9UBC48X+tFPaaWhmTEbmrv4uh0Lj5P3Pt9ekijYYJXTsBv6AGHbydV4eNX73QPwc/+G/NfjGZr9XfMsSr+aijMEDoDjgnbBZOtdwDJ+KbXzGc8M5F2g2v0Izd+hBwDbg/cUxSlr7MA82ykTepIss3IRu23H3HTidWqYquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=aB4hG851; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="aB4hG851"
Received: from LAPTOP-99KJFSET (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47e10a90d;
	Tue, 28 Jul 2026 20:34:28 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: sre@kernel.org,
	orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com
Cc: Hongyan Xu <getshell@seu.edu.cn>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] power: supply: sc2731_charger: cancel work on remove
Date: Tue, 28 Jul 2026 20:33:40 +0800
Message-ID: <20260728123423.781-6-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa8b8263203a1kunm4c64fbaeeecf4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHU9CVk9NTUxPTx1PH0JPSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=aB4hG851M+d9O82gSfIbERPm4v9lWhlXqtGk6u2TkTgCjPdzqNnMd5QJSv1x7yXk1KdJizlxmAm98cr3nn7XaLzPi+i4u1cyw3rZW8L4Oa+DdvUt/iY7swEGeQOgK2998/1uJfuMY557PsX7PfPeU3zPT185tu2C4eAqkWRTyt4=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=xuvBHwlD8qSnI4Cz4MhPnIudkuSX5PpCqi79h3O+uhw=;
	h=date:mime-version:subject:message-id:from;

The USB notifier and initial charger detection can schedule info->work.
The remove path unregisters the notifier, but does not cancel queued or
running work before the devm-allocated driver data is released.

Set the platform drvdata used by remove, then cancel the work after
unregistering the notifier.

This issue was found by a static analysis tool.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/power/supply/sc2731_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 58b86fd78..2b25e44da 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -466,6 +466,7 @@ static int sc2731_charger_probe(struct platform_device *pdev)
 	mutex_init(&info->lock);
 	info->dev = &pdev->dev;
 	INIT_WORK(&info->work, sc2731_charger_work);
+	platform_set_drvdata(pdev, info);
 
 	info->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!info->regmap) {
@@ -516,6 +517,7 @@ static void sc2731_charger_remove(struct platform_device *pdev)
 	struct sc2731_charger_info *info = platform_get_drvdata(pdev);
 
 	usb_unregister_notifier(info->usb_phy, &info->usb_notify);
+	cancel_work_sync(&info->work);
 }
 
 static const struct of_device_id sc2731_charger_of_match[] = {
-- 
2.50.1.windows.1
