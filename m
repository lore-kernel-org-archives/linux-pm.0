Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A8E381B0D
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333907; cv=none; b=rF4bgxixcyegM+AS79Icnwgk34+kUgTp3Zs3VgyZuykg99FgIR7NoLn5mx7UgHgFyYR28okrd+6Hwmk2+1uywoom498nuWnnAuw/53HFH4UixRXnBam/j+skJOUa9QQRzjljfSB43V2xpyfcVh95awxINUrvzp1XtrvTtafgBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333907; c=relaxed/simple;
	bh=S9wsoFfpviCH54ht1kILwTO8iq9EJE4/9BCGA0UKyVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GnBPJO5zYv3wSQWmrsAbL0E2JmSutOrY7feEBbAaTqu1y5jzjqB49A06XJTEL98QYHpOg+DT5DYdi87U+/Mz696tevOhInFacan54k/3R63Q3lv3ntaQyBOB1b3ZOK6ve8DWGFMFzWcHOAAONtkT5/DT+mJdvnI1c/n7/IX4GpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzZAJPDo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzZAJPDo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso11114075e9.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333904; x=1781938704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eG0rTodn0DU81UbM7Y7nOdcQ/eVn9TOf7zlRSmencCY=;
        b=NzZAJPDoub8JKbkpYZOO5scC8qwSzATbqOq4dIWqis12jqfxoUVPcGK3FhBfHNL/vm
         JbM5F7fsFCe0tnAUCMyFBIP2IVpNhL2vyCwb9kOmwnIv4nZkzaKsDfARbYBGc7OqBm6c
         LbinWMSKkKGYnpk+Cyid3khEgg7Y/WfLr/HG5l0bmGlLX8d040kyHWiETYFyeC4y7+Ih
         v1YkAe9FZWY1TcATI10is3yN38CoEMtU0z8gOHXT+hJjoQsFPRyqY8kYzgFb9/rUTgwa
         NXHoaiMwQwqGjYad6/rqoCHLf3kryTacIJGfjP/xb9ZppDg1bqZCN1cZCaUqhj74vLp3
         xfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333904; x=1781938704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eG0rTodn0DU81UbM7Y7nOdcQ/eVn9TOf7zlRSmencCY=;
        b=Qq6/fpyjPTNezKRjD+SYgZaULoLv/KLYE3mlGUG7TOSwJgd8CZHd+in24BfafKIZHH
         /MjHgXCnEYAKAyWA87Km7RknWzXixKcIQbfffi5L47la3SFanSFno+pWVIkJSgmPezPR
         q6QPSONV/aY2ZIcLBWNenwO+YncCFcRRxP+tjsNkh6OyCYziWqKzwTs8O0EzKKmkR8SF
         aDg99wPzOOPdJ7AICfhkUyvsV5pUq8FnbNnKVHeUVz+MAOg/kCx7ufnkYTBMot2ZTQw+
         ZW0wZGF2D+PhzSYEl4KUp981xurXx9FvgMrNWTGZvAVZlx5pOLGlR+0fX+TTk51IxpWl
         y1Fg==
X-Forwarded-Encrypted: i=1; AFNElJ+99B4D4usJm7bR8qRCixypL8scHP0UUmd9UQ0YfmUDX3Z32A2Kor5hcILIk9ysl5UDIpIZCr5fqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcF2O8ewDJKBoPtcFxaphP61MxQkuUuzW3QMPfT+Tkay49IdO
	XyUXaq0GVvMvQfWz7ACZWnYh/zHHeM7JH0tdwfe1GsO7SLYlOlYhKn0X
X-Gm-Gg: Acq92OFkQ3WA7jvLviHPWv8wyJGgQTpFBYOpUE+Iz4mMju3JxY77BtEj8DXZrU3gJsu
	paIp2KUlYJm79y/QRBZDyU3khCuBcD7MtkL3Rf0H1g1t5imi8sRkzi6bELQmHgnuEqQaGMGh97S
	N/GzwaCa1pwfDf1D4b6wbWb2POgluHLUqXuK4rzOmuqeIjbPtK9KmVQ97L2r4pRAGggjGIzcGAE
	4DvdO3WthCx/8K7MFgAzv6SaLl7+olRld5bgUGJ9awzfpqxpdgN1UetO+FlTrN75gA4n4kBtoKS
	QP9ASuuB3UlRblklYGR1w+rRZv5Tk6mS8KWABEGFm8MmjOgKSiyQUD2Sr78bQjc8xdG7gyYRpmh
	SYBwmg4gGSLAxSvZ3sXvw/hodYxEgJBiqXABpnAlPLzzwHGcMW0wCVyRBa3fWW3GTQ+E5hmYdeA
	C63qktx8NdELMuzPGqYUdgZ+COg1zULtqfTMqI9xDKew==
X-Received: by 2002:a05:600c:820c:b0:490:45bb:8dd9 with SMTP id 5b1f17b1804b1-490ec4cde5bmr72801305e9.8.1781333904245;
        Fri, 12 Jun 2026 23:58:24 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:23 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 1/9] accel: rocket: Introduce per-SoC rocket_soc_data
Date: Sat, 13 Jun 2026 09:01:08 +0200
Message-Id: <20260613070116.438906-2-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

Add a per-SoC data structure carried in the OF match table, currently
holding only the NPU AXI address width, and use it for the per-core DMA
mask instead of a hardcoded 40-bit value.  No functional change: the
RK3588 AXI master is 40-bit.  This prepares for SoCs with a narrower
address width.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c |  7 ++++++-
 drivers/accel/rocket/rocket_core.h | 11 +++++++++++
 drivers/accel/rocket/rocket_drv.c  |  6 +++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b3b2fa9ba645a..09c445af7de73 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/iommu.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -21,6 +22,10 @@ int rocket_core_init(struct rocket_core *core)
 	u32 version;
 	int err = 0;
 
+	core->soc_data = of_device_get_match_data(dev);
+	if (!core->soc_data)
+		return dev_err_probe(dev, -EINVAL, "missing SoC match data\n");
+
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
 	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
@@ -52,7 +57,7 @@ int rocket_core_init(struct rocket_core *core)
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
-	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(core->soc_data->dma_bits));
 	if (err)
 		return err;
 
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d7382854ca9..8ee105a0be40e 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -12,6 +12,16 @@
 
 #include "rocket_registers.h"
 
+struct rocket_core;
+
+/**
+ * struct rocket_soc_data - per-SoC configuration data
+ * @dma_bits: Physical address width reachable by the NPU's AXI master.
+ */
+struct rocket_soc_data {
+	unsigned int dma_bits;
+};
+
 #define rocket_pc_readl(core, reg) \
 	readl((core)->pc_iomem + (REG_PC_##reg))
 #define rocket_pc_writel(core, reg, value) \
@@ -31,6 +41,7 @@ struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
 	unsigned int index;
+	const struct rocket_soc_data *soc_data;
 
 	int irq;
 	void __iomem *pc_iomem;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594883e..384c38e13acce 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -213,8 +213,12 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+static const struct rocket_soc_data rk3588_soc_data = {
+	.dma_bits = 40,
+};
+
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "rockchip,rk3588-rknn-core" },
+	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.39.5

