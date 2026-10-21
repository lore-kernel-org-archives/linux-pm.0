Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579911;
	b=lrKxSiZ8dDPLsE8kPppoG8yRDc8B/rR6tyYUbT+MTDGsjjdJ4gsly8tccwgWbOAU9yyM
	 FRHzdnXDvSomnrED5Trdsyod4OmngraDlFYCxzRRS9tPRFBLPALi6cjXPYYZpS3wRq3Zf
	 U3JxcG5am6w58TqiMdCr5YKRKiVesHyC85apyX0yLpscWPdL0biClEq2xBxWeIf9ylOmc
	 ltC5xydxPUGvRiWzAmS02Ixso5U7oPnxpG74SuyN6mMyZtdBTyG6IjkGhU4XwfOUSP4Gw
	 C3vX0ygOEJXeWCXO2eFblgDhK2CGQAdYeDf9q+IkeKrFmp76Djg8twIj53fqwtxGhpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LPY8vdhVi6Xj88wwWO8EGGblZmNfcIUJaJL4gRNaJy8=;
	b=xGIKDHv8l4lIkHU0ZELs0Z1ARk40z4IO6sNKISZwsd/3Vcbpj40goc9PKzZoZfe7wF4n
	 0px5WjPUrtvoK0BuyoAyf5gLiY0e04Paw2Ff0eugdPoQ3s+YkZpQMl/nS+7zXIeLWko6t
	 lqIb/a6ULSnVag6FBklHfEoruZHXtoUZDeiaIJd5OYzUhDfnvvDkrOyTMdTLNkN5ge8Qu
	 XSeWDs/nr0jB2RMbazALhXKSmTdrc0SPR/Vfa+wy2Awb175Njy+PX8Vl62Q/ioYLqfRUM
	 87IgFpuo57VykDWcCSDb18nObSpqBD9O89yF/ABkpKc4MVF8C7Nn9Yfidlz8Jd6cgWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YogfN1+C;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D0606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C8D0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YogfN1+C
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so3229065e9.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579910; x=1793184710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LPY8vdhVi6Xj88wwWO8EGGblZmNfcIUJaJL4gRNaJy8=;
        b=YogfN1+CAf8JdXWXwZ7r6WzUlJC6+9QrZ2QzvQ7egcgdx4YlcjZmr8Wkq9xMSirwrX
         TQ3akbrh2/vSRJO7DX6s/eGHPkvD7n3zkOkFJMTFj4IvhQAEpMrUQBJEPwa4oP+CzXuY
         vowBguEv9A5WkWSVU6lpkVFR6GWylkbKA1AmGL1KfURAgMOX9BIgeG+lJ0Q3YnvsVK6+
         bvInFcxanHjXF9lDsdu/eX5D4W9tKVUUSpJ90nfpnp2+oBi+QIGjPSVvqP0feb/LGVTU
         Bzte3AyM/xczq1BDIOsPD3Qf15Ssq55++QBt+U6CAhg6W54uPhdf5R+7R81UiF0BbWku
         jB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579910; x=1793184710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LPY8vdhVi6Xj88wwWO8EGGblZmNfcIUJaJL4gRNaJy8=;
        b=vCRQTFLOl89YM+K0Yc9ikTqTYEjvUZSmhR7ihI0XQp7YpDixo8lucx4Ns5sRL9nXyI
         D3nxxi0VfGrH66fddGM0dFJj1H9GYDd4iZFWYw0vvtzdkNOjs8aPaglWlmGUBzJEpEjc
         3sPFDDcX6qQ7I6ZzbupV4Q2Yn64V+mwT9rQV4iWzWqE9TuPbNm7/53LBiAy38JaasDai
         9bw9oEixgGRp2NI4uwBo2ob9tlS5GtSd5yoNbrFyOOhijToDf4hQbxHxGqPVRC71gbFH
         EEHZNF+H2n44HikAncmDhEmMN8Dr4d7/Fsm434Js4k658ZuVoqZi6I+04TFG3CQ+35aL
         Wr2g==
X-Forwarded-Encrypted: i=1; AKwUvByKezPNO0y3LLQPQfloZfZGCxSA09ED+f9B/mE5pVqghEmKylsELSoRfB0K5cJLBLCrCohvBbhjrA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK55Ug6KSW1WuF13Bwr+LnEzL3ohOr7KmUkvm9RWCAnS5kc09W9
	2IvF/w3NMsooGkQ5LS3bFZJHkWCWfC836/JnBOeKP4VsXvdAMgUyve+F
X-Gm-Gg: AYBFou2EVUnI1QYsq2oRzbGQkzLvuBW1CCDOoEtOFRuWPEtzKM9DnfSCAjOv5UdyHY5
	e2a/AMTHwQ+ZhZPX+3eQS87Lm5097f8pkYweqFRtYNHZ8DA1yR7l+XM0Gou5hoXo8ihv1UzN3JI
	MZ0bw5N79dEPsaSizxn8EhZKgvRlPRr8pZyCjxZLUxP9xI2pOwvL5+eh+7GOqfX4PYYv9oaFHAS
	MGHe9zV5fh8iEegLm3HcnfMU5PRCjec/8fsjDLr/cYs/itV6AGjHE0Z1CaHq7q4nkYb0thZjZXi
	YXSZDIhMOUPafM2pw5G/ZPfcYKfM82d6fA3tPCtTwPIrJJs2VAh8Nep135FxOnVWGZNC3oejsGJ
	XHvKd8/aAQitypQQAcq+d9tsGZUyKXpjG7eBdFjf8z7Sc8k9uIiBgnZVcvvlCzyWkkJKFURMVqT
	e0JM5/9yoNIunj37NJcxNIiZt/fJsQg/XJcY8V4JwQAhD8WVCS/byC4gQASMgsaYaaArfNk3j/g
	BH//dqgAplvjn1JXE82rCaS/FYBq/4d/sIj5/WFzUs3jboXdFY=
X-Received: by 2002:a05:600d:4447:10b0:4a1:d1f7:bea with SMTP id 5b1f17b1804b1-4a1fdd1e568mr25614785e9.17.1792579909764;
        Wed, 21 Oct 2026 03:51:49 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm153388305e9.13.2026.10.21.03.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:51:49 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v11 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Wed, 21 Oct 2026 12:47:19 +0200
Message-ID: <20261021105109.199886-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021105109.199886-1-l.scorcia@gmail.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the MT6392 PMIC and its RTC and regulator devices. This device
is mostly based on MT6323 with some similarities to MT6397 and is usually
found on boards using the MT8516/MT8167 SoC.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..da534fa324a8 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -39,6 +39,7 @@ properties:
           - mediatek,mt6328
           - mediatek,mt6358
           - mediatek,mt6359
+          - mediatek,mt6392
           - mediatek,mt6397
       - items:
           - enum:
@@ -72,6 +73,10 @@ properties:
               - mediatek,mt6331-rtc
               - mediatek,mt6358-rtc
               - mediatek,mt6397-rtc
+          - items:
+              - enum:
+                  - mediatek,mt6392-rtc
+              - const: mediatek,mt6323-rtc
           - items:
               - enum:
                   - mediatek,mt6359-rtc
@@ -99,6 +104,7 @@ properties:
               - mediatek,mt6331-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0

