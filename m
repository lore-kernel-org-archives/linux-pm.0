Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153D54652;
	Mon, 10 Aug 2026 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786322889; cv=none; b=G6ZX2NdihR5mggu9XsHVEWegRM8bmZx4VOfzx1TJUvfS/krVjArUhj154JuMVPzVf+FvpTcoeTQ2wlUjyz5MmhaTtWJmQx2tTG2exZxRVa5PX9jGEt5QIptpiwNklyOpL/FNnb8ivU8aOHFaIYHdR5eEdYNxPxsnWr01iflaKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786322889; c=relaxed/simple;
	bh=HuHu7KVTMzPYxED6TsNAwslY60ivxd00YD4yTBhWTFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G6yXGAusZ8KDzHnFSqHpG5j+hFxTPWXzvnaKl/6GwNDZufzIaiJGa0VjSw3e9iy30OrnXEWMJ+yfz7z+ujLxKvE+dXscQH6xrre0DahuTDkpN1mI7DglHp2i3KEfkChChnxM47jl44oRpBEH9TTUeIwHU6gDczB2nBA9pT/d/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NLzJSnu7; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NLzJSnu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Tl
	kqCScpMkU/tVXKRfXYJHoFgk2O31q1yvzoi7cJrWA=; b=NLzJSnu7niBroGIGCn
	MP62MYiJiizDL9Cme+SXLHGjIAP4OrPEifOYtH0h4xoauMsAVsLfN+ec3zgbPu9q
	fJtasJLArB1FyZzyl0DSO9hK+BqPNhjqfWvk+8jz/3dlj9RJQfnsDPjavysoZ+vi
	6O5JZp/oF1yTZmdhTULp5qBSQ=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDH48eUH3lqcp2dOw--.7024S2;
	Mon, 10 Aug 2026 08:47:19 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>
Subject: [PATCH] power: supply: max17040: synchronize work cancellation on suspend
Date: Mon, 10 Aug 2026 08:47:01 +0800
Message-Id: <20260810004701.1683-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH48eUH3lqcp2dOw--.7024S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw4fXF1UCr1kGr18uw4rXwb_yoW8JF1fp3
	y3WrZ0k34UXFW5C3sFqa1rCFyUG390yay2krZ7A3sI9F43AF45t345KFy5K3Wjyrn5AF4S
	vrWSva4fWrs8C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUg2-nUUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC3xflIGp5H5cdJQAA3u

max17040_work() requeues itself after every poll. cancel_delayed_work()
only cancels a pending instance and does not wait for a callback that is
already running.

If system suspend races with the polling callback, the callback can
continue accessing the fuel gauge and requeue itself after the suspend
callback returns.

Use cancel_delayed_work_sync() to ensure polling is quiesced before
suspend completes.

Fixes: c6f4a42de60b ("Add MAX17040 Fuel Gauge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
---
 drivers/power/supply/max17040_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 03ac569e1..5599dcc7a 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -568,7 +568,7 @@ static int max17040_suspend(struct device *dev)
 		// disable soc alert to prevent wakeup
 		max17040_set_soc_alert(chip, 0);
 	else
-		cancel_delayed_work(&chip->work);
+		cancel_delayed_work_sync(&chip->work);
 
 	if (client->irq && device_may_wakeup(dev))
 		enable_irq_wake(client->irq);
-- 
2.23.0.windows.1

