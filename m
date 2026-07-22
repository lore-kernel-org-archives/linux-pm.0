Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99B345EC6
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754080; cv=none; b=iyW4+sTCLbAvnXCxE8iTIkLXMUD2eni3HOO552TovcL2L+nPtuWraF+YO7RE9lG//n/fpN9XFWOFfB6X+t9as7K0mVGCHKRwqFBuBv2wqbawz/vEBIk1NAUX5luJhtpH9NaKbCXShvW5mfcp53qTvh9H2NJoZyyBQSs/MLqJGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754080; c=relaxed/simple;
	bh=H7gc8EHhrE54TIGFPE01knw9jDcZnFRii3hzkCBNdj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajJZnrDQMFv2S4rSW7mECJph06QDbmIz3PFMU4jKfxq1jS3Fg21I3hOJ3P+KUVC473rZgombLFlPsteF+VvvEKUUsANo6Bixz68mLM5qW25EE7/1EfDii0tod9Gfj9kT+9P5mTOa6kx//w1YBdBa5+P1sqtDnNTLZuvaRN8Omnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH8S4vZf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH8S4vZf"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso8568151f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784754076; x=1785358876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xSx084TFnzGFnpguxyZxDPEBlEGv6khf3RChBzg4a7A=;
        b=RH8S4vZfb50yXjg0ty/ETibkY8ORHiSmDI+54v6XsHEn4gnCjABpKFB7BheWkuQHgI
         WsbxkgNhGoxbO/1gOvc0JCAmOAIY8wg/B0jsDPESfUGYOARrJNdEP2qkLLpgrlUDMarK
         n34jIxg1/HMXxv7ITHrI+dSk7yB7sIAw/H2dNF/NezpWUla8+OmEWHHx6hiyrX4WtRgw
         UxDwHZorsd5aGprtRpqy99fIxr3NrGDmKuW/hpZAZ1Fz4YX9LRrn/LnKzGXcYar1caMM
         zQkVeEPrH9SIk4wTtx7ewEU23Yi0XRxYJYL6IwXH5pcI2qtgSieeKeN1WTHV7WawnTi8
         BgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754076; x=1785358876;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xSx084TFnzGFnpguxyZxDPEBlEGv6khf3RChBzg4a7A=;
        b=BH2pjK7Z7Vn+usVlase/UC2csAI+cGl4IwtZjwkvL+3L5JzBDIQ+sGYKfy5739Qb4c
         VkhQ8QZxeuO9oY7YdG64rIChKv/HDAYlEie6J6wIO8xOoe80lBPGqVXRXv3iWAPi9sGb
         PyN+cUGnUN73uUEZ8hWP1y8XdudMi5d9GfO7431SxFyOov6TZUeRjPl2nc6ifVkiNFOd
         rpjRuSh0TfLkjmN4m1FYuCrNXTttlqvf9oJQWJFwMxi/86KwgEViHSjFb4+cY6r7jBRK
         NmSbH03MiOUxfF3TlYFs1cnAfKWpDsIgTxCWfiRG/SYZdDkIOfX9T6P6wmGSqpp5CLJH
         4HFQ==
X-Gm-Message-State: AOJu0YydmGo1a4LCDwyEkyeMI9fCyY3ZzFZQ76HoLL/8/Vs7e78YHVSa
	ZPn2TNxX23eCG2yYF9DWYXPiTuTfLPFBlu28OcKMDxIhU8Du3xuAjaMydvXsA8yVkIgCSQ==
X-Gm-Gg: AR+sD13sFQfDhIdCZLwEeP6GvPG/cuZDwlTjpJbHBHIjsCGy1gIC8ytO5E9SDzdGMDr
	cQ4BQjRplT+XdL7iKRLVSKwXqJoaNR/bLG7uUK15MoY5xKZuRO7IqcKNW+//cUldVieF0m8t6IM
	BBWR2Qea5TK7z5RykMND+6WqOIKFffhATjGooLHE2L3veRVkFj0jslNLColdVR53LqDrDh9RCiC
	dZA8QxzDcK4WLwHOv9G1tT3jnfMZQa//RyHFkEfxoDyouC2cbMgwNsX8wc08R2C6dDUpOo1MwLQ
	zCks+spVkIHRKQSqJxr4IuZIj0QnXLLVCSo8kvPnLhM8DAh9q8Yxu5MA9COKKVz2IxHXCG2Ifjk
	V0Xzt0sIlVCDGqk2zKVGttyIX7Z1C/aqRL2MC8dr8iHA06yyePZOYQZMWffisP3pfQd3QuJNNZ6
	1a58ZYASHif9U6CP4bJJvulBgj
X-Received: by 2002:a05:6000:4282:b0:462:ce05:c5e4 with SMTP id ffacd0b85a97d-47f8d755525mr573989f8f.37.1784754075574;
        Wed, 22 Jul 2026 14:01:15 -0700 (PDT)
Received: from coolemuke.fritz.box ([2a00:6020:b320:1a00:c256:1463:a40b:d8c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63678sm8610812f8f.29.2026.07.22.14.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:01:15 -0700 (PDT)
From: "=?UTF-8?q?S=C3=B6ren=20Hantel?=" <fugininsane@gmail.com>
X-Google-Original-From: =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>
To: linux-pm@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Rossak <embed3d@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>,
	Claude Fable 5 <noreply@anthropic.com>
Subject: [PATCH v2 1/3] dt-bindings: thermal: sun8i: Add binding for the A80 THS controller
Date: Wed, 22 Jul 2026 23:00:44 +0200
Message-ID: <20260722210046.2932498-2-fugininsane@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722210046.2932498-1-fugininsane@googlemail.com>
References: <20260722203341.2917852-1-fugininsane@googlemail.com>
 <20260722210046.2932498-1-fugininsane@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Allwinner A80 has a thermal sensor with four channels which shares
its MMIO block, bus gate, module clock and reset line with the GPADC.
Register-wise it is an early version of the THS found in the A83T and
later SoCs, with the THS registers starting at offset 0x40 of the
shared block.

Add the compatible to the sun8i THS binding. The A80 takes a bus and a
module clock plus a reset line, so the existing conditionals already
describe it correctly.

Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Sören Hantel <fugininsane@googlemail.com>
---
 .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 3e61689..718c44d 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -18,6 +18,7 @@ properties:
       - allwinner,sun8i-a83t-ths
       - allwinner,sun8i-h3-ths
       - allwinner,sun8i-r40-ths
+      - allwinner,sun9i-a80-ths
       - allwinner,sun20i-d1-ths
       - allwinner,sun50i-a64-ths
       - allwinner,sun50i-a100-ths
-- 
2.43.0

