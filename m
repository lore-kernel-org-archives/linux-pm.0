Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779A3ED3B4;
	Tue, 28 Jul 2026 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242075; cv=none; b=V5QXV2KO3bbeIt4AjSaJpzc/1YfUOwMI9BoiACIYihae9K7vRA4WZdKMjOwJTP58OZaeYuLdx61TSa/irCAV7M/io0NJCgJpn+4Lv7+uymvl2y1jD+taQ1z1l0eiva0faFeO0HjOR1gU5ucpg/blZYIq5V+r2WetWIBPSWoXt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242075; c=relaxed/simple;
	bh=sYjj1yi0spDh6qCyCDNJSHYVQ0NCgJKPecZ7xdQXqbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYrwVTKa7ffAoI8WJpiFUrMPjO4+eawjrKH4cwZ3Mlh0hor9mYKhynpuwPtRjMPOEOqzf3nKNfWo32oliMZHSLH/bbNzxArvp/CqXBKo71hbvhBj7lLtQ7yGgi80POPGVBPoZ0LXvqVhZHQl02xsbOn/xbzJrUyfKh9Mg+9+INQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=kGZ6bLR3; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="kGZ6bLR3"
Received: from LAPTOP-99KJFSET (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47e10a90b;
	Tue, 28 Jul 2026 20:34:27 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: sre@kernel.org
Cc: Hongyan Xu <getshell@seu.edu.cn>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] power: supply: cros_pchg: unregister EC notifier
Date: Tue, 28 Jul 2026 20:33:38 +0800
Message-ID: <20260728123423.781-4-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa8b821c603a1kunm4c64fbaeeecf2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTBpOVk4aHx1IGh4ZQk1MQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=kGZ6bLR3Z5X6SvDaKCry/+0IsZwggyQ1lsUYJdAIxqijN9pwzzVa3pLvJaNCQXStQh069kJo+FFKit8l8O4fw+n5MoTcEHtv/qiZYN6i6d4xfQVUWTuH42nNYVWLVCEdoYKY9D7i0Ne+ifMXza7++2mhFS69FrVAOV6CuJEaVk0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Ng2CTcRMoVhoe6z4IDz6hg3MiZVsYfAdJb/iddhcKIw=;
	h=date:mime-version:subject:message-id:from;

cros_pchg_probe() registers charger->notifier on the EC event notifier
chain. The driver has no remove hook, so the notifier can outlive the
devm-allocated charger.

Use devm_add_action_or_reset() to unregister the notifier on detach, and
fail probe if notifier registration fails.

This issue was found by a static analysis tool.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/power/supply/cros_peripheral_charger.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
index 962a6fd29..219cd13d6 100644
--- a/drivers/power/supply/cros_peripheral_charger.c
+++ b/drivers/power/supply/cros_peripheral_charger.c
@@ -259,6 +259,14 @@ static int cros_ec_notify(struct notifier_block *nb,
 	return cros_pchg_event(charger);
 }
 
+static void cros_pchg_unregister_notifier(void *data)
+{
+	struct charger_data *charger = data;
+
+	blocking_notifier_chain_unregister(&charger->ec_dev->ec_dev->event_notifier,
+					   &charger->notifier);
+}
+
 static int cros_pchg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -346,7 +354,13 @@ static int cros_pchg_probe(struct platform_device *pdev)
 	ret = blocking_notifier_chain_register(&ec_dev->ec_dev->event_notifier,
 					       nb);
 	if (ret < 0)
-		dev_err(dev, "Failed to register notifier (err:%d)\n", ret);
+		return dev_err_probe(dev, ret,
+				     "Failed to register notifier\n");
+
+	ret = devm_add_action_or_reset(dev, cros_pchg_unregister_notifier,
+				       charger);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.50.1.windows.1
