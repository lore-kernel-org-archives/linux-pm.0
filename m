Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075E246770
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777871021; cv=none; b=J+WqMmpQ3U2tvHP5VjvgpcZzrrN/LX9ivkKOKIip1PS8P3Eqm/2mAKsEtpjFZ7Eby0Hs57xEmcWWFcV16ZV5q4NsPydzAcEGqrukxU3i65g6zuoA1cc5toSRNjt3pQ9DPIgqX+MAOtNmaFb9pYEb3qhUMu82hgCQ4I4Vt8P/Cdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777871021; c=relaxed/simple;
	bh=2TFX3CXq6/rmxkKsrdpy4I6/+x+PNEWuxGgifaViL0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfb/+V5TNp4MlXJizs5Pa5JCb7wblIFQFRmx07lEn2HuktLPgi0OZ0nydbyrNdwSfeqtWitJnosjSu9Oe3azmVL4rYJzqrK+hZrDNP8dFQQpjpTP7jfwOCWAT1jJ/kMxkKBEsLvejb1iCJYKfKH/7Nz8DVzCS39Xo46qZkhdhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esh3epTG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esh3epTG"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-364ff382b0bso2335722a91.2
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 22:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777871020; x=1778475820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCX5Iqac13O3XfLY0RNkBX2Gq9jD0l1ObowJKbWU4OM=;
        b=esh3epTGDpOuzQ45KdAeKPOM3vsP4ueVSpVV19Rpm//sUFPS5v4JsOCYWaVsvgxEy0
         tcedw8gqku/TS8OpTQEbUxDATIMkHp4hQHrTJY4k74BnQbE5lm47m+v67WuGgp463129
         v5+GclCgcGuXb4SLx/RSQ8LiryM0V97J80Y6q+0DS4d9SvDxiakTLsqIFudZBvSSSkt2
         Bsab4neJUalaHGjAdzqW+Rew5t8bYn1exOKTwUcnA3CuXLVX87WIk4YgO7nRf9u3KK89
         G/imQxGXbK4r+5/Bb7ms9VwIwCZy0IBA2T/J/ZcCVk9MH1g/Z293BQwJx+7PduePi7qI
         S5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777871020; x=1778475820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tCX5Iqac13O3XfLY0RNkBX2Gq9jD0l1ObowJKbWU4OM=;
        b=snIoVYIffMMhRbvrMhhWZG4ejxngSqYDYAEJa9/lFYzo+3SZsMGIh0KTMMmILiaWvO
         uTFJ6YW49PD7uFli9ySUxFc4vD87c9qXl7ephE6Ca1Gyk9O2ucwltMiox5hSvJZzKPWU
         FDFGPCb2TAMT8XCpa9yNP2n0iH+AKAAyqfPZJPDdPao9rqzHJmsWjK97tfaAXz2p9jsw
         11AXWruzCX99iHaLU5fb1OF1Diqx83fW3licNcln5M7q6e50xKpbU8cBXD6PL3xEbNC3
         rN+ARDOHewNZ+hBhr0kBObLuQIFKEwtMN9XincSP0lnwW3E+r4GbOG8EVjFZUdrjyVW9
         OzuQ==
X-Gm-Message-State: AOJu0Yw54J/bBfq5Txl2+01N7DkH5v3hC+tWebY/++ZZ3FDzpBqrCscW
	oJMoc5MTHXY7drQQqzG2V+9YCJt+uE8905VshBfRv78kHZ1/6Dl0LjJa
X-Gm-Gg: AeBDieu6lkEh8vHllZXP5jzm4KCt3xse/DXxGpO8pKBfYo+TgMhGwN1TnVKeBZ1XNMa
	88+7rgO5rv01vH/5IEtIs1m/r/+NnF3KT2LG8482gyr2xbAMKCDB4yzjpyVlMoGphDEvqlrtA8w
	CNAEgXMbiKxh+Fp8ClPaAFr0yvUAEtTKtgjnOXezoa0NWnmRHdyzA7ize3Waw0dSLXI0/W/zZNt
	NKEMV6MMguH/QxhvIynjyxRi5e+VqO80WQXUOl+7J7sLefPCxzkHzSCBugUHRRDgC52sSC0GtGr
	Ea44xPmEQbIBvJ23iWmVRPUDIkX0sT4P6kw8W7Tb859r/I9GEeuGfhboL74F6q8wA1tMFMwUmDW
	3b2gV8StkXi/0vHyfB7tIYjHgxgioV431gMt5ZVxPO+wkGU+YZ4luHzA3PRbtVmbKd9GJgCpYyC
	+Q4JxaMhPpZEy2
X-Received: by 2002:a17:90b:3b4f:b0:35e:3e86:e2d1 with SMTP id 98e67ed59e1d1-3650cdbaa39mr8265243a91.7.1777871019885;
        Sun, 03 May 2026 22:03:39 -0700 (PDT)
Received: from archlinux ([2605:e440:15::152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365437b50b0sm2662908a91.0.2026.05.03.22.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 22:03:39 -0700 (PDT)
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
Subject: [PATCH v4 2/5] thermal/drivers/sun8i: replace devm_reset_control_get  to devm_reset_control_get_shared_deasserted
Date: Mon,  4 May 2026 13:02:42 +0800
Message-ID: <20260504050245.646078-3-iuncuim@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504050245.646078-1-iuncuim@gmail.com>
References: <20260504050245.646078-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A523 processor has two temperature controllers, but they share a
common reset line. Make it shared with the shared variant of
devm_reset_control_get(), and also simplify the driver by switching to
devm_reset_control_get_shared_deasserted().

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/thermal/sun8i_thermal.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 226747906..df0c26970 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -342,11 +342,6 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 	return ret;
 }
 
-static void sun8i_ths_reset_control_assert(void *data)
-{
-	reset_control_assert(data);
-}
-
 static struct regmap *sun8i_ths_get_sram_regmap(struct device_node *node)
 {
 	struct platform_device *sram_pdev;
@@ -389,19 +384,10 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 		return PTR_ERR(tmdev->regmap);
 
 	if (tmdev->chip->has_bus_clk_reset) {
-		tmdev->reset = devm_reset_control_get(dev, NULL);
+		tmdev->reset = devm_reset_control_get_shared_deasserted(dev, NULL);
 		if (IS_ERR(tmdev->reset))
 			return PTR_ERR(tmdev->reset);
 
-		ret = reset_control_deassert(tmdev->reset);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
-					       tmdev->reset);
-		if (ret)
-			return ret;
-
 		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
 		if (IS_ERR(tmdev->bus_clk))
 			return PTR_ERR(tmdev->bus_clk);
-- 
2.54.0

