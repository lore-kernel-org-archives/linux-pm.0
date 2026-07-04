Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17304374E55
	for <linux-pm@vger.kernel.org>; Sat,  4 Jul 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185317; cv=none; b=mo5Dy2fSS0tNYc+PTzS55DT/qqz7A3Uy5x6+7A6Di6+rOae17bqrUvgFyV6sIHhLEhLRl3hPhz6aPiE/2fBIQ3zTo3aRxRni1Ng4ewpm4yg9TKuDBihtzBA4DbSzIX2LeaMFuxIegDzlrkqabgPzZZjrm7YafkMuDVLWaH6a7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185317; c=relaxed/simple;
	bh=hiDqfxEwo2m08vVR+XmTBBNvFPcoR44JVTQtfXJLBKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHxqCF6FXQFyK/L+rol0ivuG1eBwPYR/n8bU9QZMc26EUeeQKuV8JoJZ9TtlcCNT53SDZsVD3ZxMZJcpHvS189MPQ0eq37aPgrxmtMAy6y48HAkHXbGvaDs4pcpxQxxjn5g5GphYgFhXp+XCcPqJ0Rc1SYz/YeokSa8m+OCy9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzAyaGoY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzAyaGoY"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8475eca3a66so2302523b3a.2
        for <linux-pm@vger.kernel.org>; Sat, 04 Jul 2026 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783185315; x=1783790115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baNPOtnreWkoR3AhhTVFf+uOWjoLtova69oE/tcCCJk=;
        b=pzAyaGoYVxV9mic82r2ywwZ8C1KB2oxpJZosNFQzBJuOjkSymmYiQbs/N7ZMyB7gP5
         bHGFfFHvHj8Dobn1e/QP2wEsuhr7D+zhU3UI/JySUPVJOfBsfU1wkQ6Xzd7QoGaGBgbK
         YicXQPiZvfOg4su8i46vB9EtWUvZcFemGnFg9B6iWgMTsgZ9BDlTimpdHH0+ia+GJazn
         eu0SxEI1jeVWuC1RPyibEl6+M91bas8Mc2gJyCpXN39NyU7ZiRa1LOgI9USsqk/xK0eV
         5f2JtlgWRKznGvmFicbFe+EwvhUyqH45HEc2l4gT6klnFTNvrCJqYkHUVHfFSiQXN0Xo
         KOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783185315; x=1783790115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=baNPOtnreWkoR3AhhTVFf+uOWjoLtova69oE/tcCCJk=;
        b=tXluLZrETUJvCp0zTWtOv4w/Mpp2Rf+a9qIGMIvTEInB5LKvI8DHKCvXQtqY4S1NCy
         +9kbe6LudrVZQSkg6EfA8sOrbEuyfY4l75nIJokjak+s1K4Fal6YTWBLWRBv800wQ3BL
         Saqsr+TFxJtD3MFJbw6BJCFUt/tsZRniQCTlHqwjjF09laaa4DZINnVPoAQbAIjUVUZW
         ntl13T2YbzvLjyG+aBY68LvpjU8tKuL2XLxLkRN7KKED1uWvU1XOlqoYtE+K30ClqWNP
         2ICbG5PQySKx+Xu+co151bNjD9JbyRydfXKUJrpwpQqH9iZYWGdz8qnXyPKkdPar6/bQ
         mNbQ==
X-Gm-Message-State: AOJu0YxiH356YiG0Vp12BDFW6h3dBKb35MvnPqPXwRaWb6AK7fMzlxYj
	QGlBVSLr0dDrRN+6JiXoORHLALtWX8qjcAIjBmWe2e1VN/apV15fXrQC
X-Gm-Gg: AfdE7cl/n20U+5nPnzDnInP5Sqj64MS2513jLeAXfF+/PWH1EtLJelwQInWJl82Mozp
	E3pY5g9vhSA0zIVDBUw7I/ghc2EANq7i3e4zAVdmOVU5d+LvOTX7NbDBv/1n/ofUux9iEceCrjc
	EKvqBNgkcMg/Z5aXFv/wHWWcXK3UHB4crtGhgko7gXCfElELPW57vMmrTaWwx99U00zdhr1ffVl
	oka9I2omcp6yq6vkxS+4YsiXDTmSjbCXkwGu9ieApMmW8jG28Pg9WcGNfs4QxFQVWKZ1K9Ezwxm
	PNX8tSVNxJw9S8HzzCn9OTaIWNPFEx+RPZ5bUrg8ALmfjv0vEjejJn7P1B0PvZo8F4e8PrRMzaq
	YgKWDw1XkMYW43tWrIpcV5wm6dxFukdcISaWkwWZXBKUn1e+a7qT65oPFCc692y2u7wvseNl2Jw
	rzgqeT
X-Received: by 2002:a05:6a00:1c86:b0:82f:9407:d167 with SMTP id d2e1a72fcca58-847f6ee42c4mr3927100b3a.38.1783185315280;
        Sat, 04 Jul 2026 10:15:15 -0700 (PDT)
Received: from archlinux ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498adsm1379101b3a.32.2026.07.04.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 10:15:14 -0700 (PDT)
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
Subject: [PATCH v5 2/5] thermal/drivers/sun8i: replace devm_reset_control_get to devm_reset_control_get_shared_deasserted
Date: Sun,  5 Jul 2026 01:14:08 +0800
Message-ID: <20260704171411.1413349-3-iuncuim@gmail.com>
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

The A523 processor has two temperature controllers, but they share a
common reset line. Make it shared with the shared variant of
devm_reset_control_get(), and also simplify the driver by switching to
devm_reset_control_get_shared_deasserted().

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
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
2.55.0

