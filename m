Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978444C652;
	Wed, 29 Jul 2026 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322028; cv=none; b=nLa3bfaBBKkJbp3ry2ZmltlT3k1hEzMJrCADlixjxRfOFw0mjcwoJy7A20LDaycnckBCrsb2L2g3jcXpmYDNrOhGFOKnlZzJD9KXsjV51nu2p/k+/paiIWKdq8PkbOrdk0fK4zW/AyKWMsu3WowCx6+l9dXJ1xLhMq+MM08++NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322028; c=relaxed/simple;
	bh=+h3jDllb4+KaH1RdxrVO9IlBEbSJ7INP8mO0V7oEOik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pw3fD/fO1641Mzyx5euoYjAza8pMFpwDshJHoH79rx2lZdeFo1feBM5sD+L9wl3u1+9UzIr3slMvmUSvxh55WLI32klgAS3uqnnkx/dhJ+hUKgltGKnXFyvTTLGCoFHN3OibSAIkekHs2nK+w9BwzFQZ/emWiNn708XVPT/P5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=AB6tDCvm; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="AB6tDCvm"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4805ec6e7;
	Wed, 29 Jul 2026 18:47:01 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: sre@kernel.org,
	orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: [PATCH v2] power: supply: sc2731_charger: cancel work on remove
Date: Wed, 29 Jul 2026 18:46:59 +0800
Message-ID: <5d48b827687168cb1b1bfe85f17945566b42829d.1785321763.git.getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fad7c219403a1kunm3420595e117c22
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGR5KVkhKS0tMTUtLSkwYTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	5VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=AB6tDCvm9QyDTV5frvAkCOXERg6rgnINVJ4MOYCQl+Q5Mu51QJhY/Ph25hy33/aDhihCe1l+R2dzs64IOIGAnSLePZHeGAKuridfGhmv67KL1H1xExT1q4VwNXAhXonEqrrkoT6PAVo9UBZzjAizmUhTbHQ2d6qBC+s2SQ3tQ2M=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=xdHIcNpo2LsO9tly5GEqPe5wq3/0x+A4kcUrd5ShpIo=;
	h=date:mime-version:subject:message-id:from;

The USB notifier and initial charger detection can schedule info->work.
The remove path unregisters the notifier, but does not cancel queued or
running work before the devm-allocated driver data is released.

Set the platform drvdata used by remove, then cancel the work after
unregistering the notifier.

This issue was found by a static analysis tool.

Fixes: 8ac1091ed18b ("power: supply: sc2731_charger: Add one work to charge/discharge")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
Changes in v2:
- Add the Fixes tag requested by Baolin Wang.
- Add Baolin Wang's Reviewed-by tag.

Link to v1: https://lore.kernel.org/r/20260728123423.781-6-getshell@seu.edu.cn

 drivers/power/supply/sc2731_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 58b86fd..2b25e44 100644
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
