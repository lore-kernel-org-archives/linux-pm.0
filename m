Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29236E494
	for <linux-pm@vger.kernel.org>; Sat,  4 Jul 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185338; cv=none; b=Ea71X9E925on30nUS94EyENPJBLkhQE1v81s1/8bOrZiaO0kZJNFMnR2VUYxuJCRjdJ1sZwn5k4hez3D4+DRxO3PsARI21tD6REAx4Jp2/KPC3P24JpCgwp2pvRt3tu6r/MGjSrGVldZ1pG8V/cdR78+AB5ITIvGrC0Io0u5E1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185338; c=relaxed/simple;
	bh=NL0+DczK+bX7h5aeTAoVt3cN5b8jI07kISjmFCzG0dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMHMOeRQA4UlkhvvMWDqTgGC4ULIvJmaZ1Ake26o9kR385jKuOxaq2CMZjnJ89sHlGgrSCyCDH8aVE62QusB+a36ylSHUv/OvUexW2Gkkp+j8KUppom0mk/r0fDK5ysRxYOcq2EeODPA4jnFNycpElDDHZ8y8sq5zPCzyZ0lX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka/d2E4n; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka/d2E4n"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845eb7b96feso1505756b3a.0
        for <linux-pm@vger.kernel.org>; Sat, 04 Jul 2026 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783185336; x=1783790136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsQaU9uZZtvn5+lIZrSejmQfTd4zI1y5dE5Iy0qO9rc=;
        b=Ka/d2E4ndWwH8xyqTyI3x5s9987AxA5ijuEEJxZuXre0Yt6r16Xx1prOxtBvYZTYyT
         E4lUUIPox88dz8qz7VOis23Ulrb0HqHl6S00YSwAxrcvuw6Yv30hMjPTCn1xQ4uQtl6h
         yWfP+xDkqPC/UFGWXuSnpM935LFKS6c6n23oOTnRY8/Ah0CQIOKwdwFePxAClT7cmC60
         vZIFJrOOqy7ezC+7aq9fMuRPP5iUPSAE09kV2ZrcxWouLh32BqqcInkQflFRRqcVd87I
         2KhYdO4UA8vvilOIvCk1dnIOIOR/h+H/CKvmiDsfpw7bgbLxIyWiPHpxmjuY95P2rOgT
         dqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783185336; x=1783790136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JsQaU9uZZtvn5+lIZrSejmQfTd4zI1y5dE5Iy0qO9rc=;
        b=UIoZaVWaMbqJbc+XVeVm5bWulCaAlNSSePbr03MKsSHisPHfmkQlamKuHBrqqO/agb
         64n8jB2vX+JzOoHbrqcUeAxN06beOLEaYZF+Hl3MAC3CPpRuwfErUNUXFOZ0tB6CSK6b
         Ozaf4EMe4H9aE7TfYfRC7A6bW9cU+dGtQXtHM2/5r5sOMYe7BmLD7ugeo+SBLMBdud8T
         PmJdFAsLjskYwAYHoHll4RT2+ggnHiJ5Duc/Mx38buSl74HueULNHB0iXqgBVmE7JJK1
         UZEc8baeE53Gf2ovDBkX82euUhYvOgn/LZDbpz2CfQBfBOaDyL88u7VZZKHuWscWfxV1
         BNGA==
X-Gm-Message-State: AOJu0Ywq9GgV1vfhVP9VPNCgt4X2w+J1EOEZLkuKxjR9UP2A3uTp51ye
	7nV9vTsvTkOHYiypR9hJmKqoVKNWj4CaPuRMqIHP6+mFgPZ04bUDncOe
X-Gm-Gg: AfdE7ckdMJXbe+hJoj4cYX6hAwSCJAquYWWwuI2VLhpuX6JleFhVHzZ6yDq17QCyGd9
	++VskrURtBW+SH2Np36gPeqnky9hvzi/D0fkydYVL8mwjhmIR84kqSQ3Wb6UdKbHE5asvkcnYkC
	9LQM+9I23rkd5HA0IQ+OpCwraPfmWau9KK8ykaHB5CslTNebI11umY1kjFQ6SRacPFoSxsMXDHA
	8pj3yAHzBe0FHY/8Th/0d+OGWVzP+fFD5L5FeBymkdX4XLZMGnHqFsA1EphIt8m8DngiiURKf9m
	iYLN63FjPI8TwFGc20GBtdpxpTJPWeYmQOdHmUmNCxxklc4lwLGpOeimPngq2yqrjjhUH7t3abc
	sASf/Ic8z4HJBShLTZUJzDqWkyLral+8UsVw0vYYjUI4JSe1YRu/S4AfXvg3znCKm+Kebig1Dnd
	pXEPkb
X-Received: by 2002:a05:6a00:3305:b0:847:902a:57c1 with SMTP id d2e1a72fcca58-847f6f84d6fmr4092931b3a.57.1783185336159;
        Sat, 04 Jul 2026 10:15:36 -0700 (PDT)
Received: from archlinux ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498adsm1379101b3a.32.2026.07.04.10.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 10:15:35 -0700 (PDT)
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] thermal/drivers/sun8i: get calibration data from two nvmem cells
Date: Sun,  5 Jul 2026 01:14:09 +0800
Message-ID: <20260704171411.1413349-4-iuncuim@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704171411.1413349-1-iuncuim@gmail.com>
References: <20260704171411.1413349-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A523 processor has calibration data in two nvmem cells. To be able to
add support, the ability to add data from two cells into one array must be
added.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 80 +++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index df0c26970..3bdd62aa8 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -301,43 +301,65 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 
 static int sun8i_ths_calibrate(struct ths_device *tmdev)
 {
-	struct nvmem_cell *calcell;
+	struct nvmem_cell *calcell = NULL;
 	struct device *dev = tmdev->dev;
-	u16 *caldata;
-	size_t callen;
+	struct device_node *np = dev_of_node(dev);
+	struct property *prop;
+	const char *cellname;
+	u8 *caldata = NULL;
+	size_t callen = 0;
 	int ret = 0;
 
-	calcell = nvmem_cell_get(dev, "calibration");
-	if (IS_ERR(calcell)) {
-		if (PTR_ERR(calcell) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		/*
-		 * Even if the external calibration data stored in sid is
-		 * not accessible, the THS hardware can still work, although
-		 * the data won't be so accurate.
-		 *
-		 * The default value of calibration register is 0x800 for
-		 * every sensor, and the calibration value is usually 0x7xx
-		 * or 0x8xx, so they won't be away from the default value
-		 * for a lot.
-		 *
-		 * So here we do not return error if the calibration data is
-		 * not available, except the probe needs deferring.
-		 */
-		goto out;
-	}
+	of_property_for_each_string(np, "nvmem-cell-names", prop, cellname) {
+		size_t len;
+		u8 *caldatapart;
+
+		calcell = of_nvmem_cell_get(np, cellname);
+		if (IS_ERR(calcell)) {
+			if (PTR_ERR(calcell) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			/*
+			 * Even if the external calibration data stored in sid is
+			 * not accessible, the THS hardware can still work, although
+			 * the data won't be so accurate.
+			 *
+			 * The default value of calibration register is 0x800 for
+			 * every sensor, and the calibration value is usually 0x7xx
+			 * or 0x8xx, so they won't be away from the default value
+			 * for a lot.
+			 *
+			 * So here we do not return error if the calibration data is
+			 * not available, except the probe needs deferring.
+			 */
+			goto out;
+		}
+
+		caldatapart = nvmem_cell_read(calcell, &len);
+		nvmem_cell_put(calcell);
+		calcell = NULL;
+		if (IS_ERR(caldatapart)) {
+			ret = PTR_ERR(caldatapart);
+			goto out;
+		}
+
+		caldata = devm_krealloc(dev, caldata, callen + len, GFP_KERNEL);
+		if (!caldata) {
+			kfree(caldatapart);
+			ret = -ENOMEM;
+			goto out;
+		}
 
-	caldata = nvmem_cell_read(calcell, &callen);
-	if (IS_ERR(caldata)) {
-		ret = PTR_ERR(caldata);
-		goto out;
+		memcpy(caldata + callen, caldatapart, len);
+		callen += len;
+		kfree(caldatapart);
 	}
 
-	tmdev->chip->calibrate(tmdev, caldata, callen);
+	tmdev->chip->calibrate(tmdev, (u16 *)caldata, callen);
 
-	kfree(caldata);
+	devm_kfree(dev, caldata);
+	caldata = NULL;
 out:
-	if (!IS_ERR(calcell))
+	if (!IS_ERR_OR_NULL(calcell))
 		nvmem_cell_put(calcell);
 	return ret;
 }
-- 
2.55.0

