Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247334250D
	for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2026 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781985662; cv=none; b=tDa8djzFODZBW5LXimqsxtyfeP8yg8b3zSAZUfVNfL54ASXZ/n9h6uzi74I72IjiozNtGyBuIgMiXj3kdK7tkakXhiBORP70SqAOqvgZV2bp7xPXRtfDhEFb5XaXWvU15DKIH/2vxkOS1Kg9FFTbPNRB1ZUrfxb4YSBvs2avNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781985662; c=relaxed/simple;
	bh=C2RPz9317K2x8HNeQWBbIdy3Fw2SwyRLehH0arAHRro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZORjFtzPYjQjx8mDPkfcgZp0AF0gEMHNI8/+kSf5uLrraykXBrPEzqf4sueYQD27ic9GKRKwTamt+vNHhkCG86t4+Vo801UgJsxRc2Qqki7+sLBmktJm16QMLi12QyNZf26ZZHiIsGnuiZtPlzuHxJlnyATqAdXuLedhK6iHtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T783SSeZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T783SSeZ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eeba68948so2318360f8f.1
        for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2026 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781985659; x=1782590459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKF7GqpNUTdJMAXxQG18bCaWMljaCNKHwPc7AyjKQ9w=;
        b=T783SSeZ/wVUkpbMJvQ9kCaXYcEIj2tCZlhli5cmMzUBy7jLWS0o2wvmSsGRCAtfCn
         IDUDz4nHzI3aaYlY6f2PLz1glUCQmsAqkEqTCSifvY80/5Pizg/xXNuZ3F/g0SOJ3kuJ
         d4E+2nNdr1bauGXGpSW2HA7XJMxQfryVmlf595AOL/Np9Cqa5IyregArb3kgWo/n5loU
         Lg7Y+WQTqHIoEz6T+HNhlNvA2wUhy7vEelvxtWjZ1iAX9YlKT+0DdQNrQ03qKvHFNJ7M
         G1H1lBOE/MtnQhj+m3thvV3A3yFtWuSzo+wvF8/RedF9CiPA65WChteBNM/U4UG8oRdL
         /2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781985659; x=1782590459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OKF7GqpNUTdJMAXxQG18bCaWMljaCNKHwPc7AyjKQ9w=;
        b=bDlc7tIqiv2JtCRSe/DCALqVPtfIAQnjBvo8ryErF/i4qcTwRhJQNZEN35h/ht9yuz
         k9W68Nc3momSlLIaPPJgtSvlZVlcaHSrasHOZyNJB9nY31slIMbk6wtS89uSaHzBEN3D
         P+0JVUgOmznOJJweuxsnP04N1uaI9GDiqQbXegPSfDO8XJkM0dSiVEr4qSgnrKZIWW7r
         CfJFyNyPWAGZB9X+kZSAHHqN+HPWMGBz9quLrkKheCXoj4kWW+0oz7e3JBlx6PmETqZ9
         W9cSvXClcXdSfCBOv3OY8geLd5EC/CuPr9wfCQ4dqIrVKVp7+Ie5aI4s5qpi8bOaWlib
         iJXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7qTRCIkXh88sg7uEIGTb2TzE4LaRmmQnjBxYsa/7W47slI8F1mlHLHE5dwa/kA27jF8OzMDQSnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QzriQlXzJjzowtfL5DR1ntpvoeJGRnzidLfRmZsIlvm5Ztpm
	U4J/2RgkJonL556xMOKB598SgUy+O5UWUlG/it83YjB096ykow/5/pbR
X-Gm-Gg: AfdE7cn5cBKNoS8GLnO4Y1U3MqqClXJA5kcfHoo4BztyDKdLRIsn/CnX89ehe0sOz8k
	4eiD17YkJTcrJHS6yJPXazqFg6PebU/hrBo+NrrVg3X45XjGWTaqoPr07HIOoIR139Es0Q1++0s
	K/aC3DsThF04/82mLMVERGVh4E8wNrm71ojYSVrbgVmPe5uHR/NXb/p43JnG2iXzbQv2Nf98ic3
	cQB9BhyA0NA2RYfBTtM4aGqqoyQb+qgbspUqz6w6WABQswex46YfguqKm4+fyGsRKfYCPBd+1uz
	+aZqA8cPCZs4e8LrI9S7onzM7KMrkqzNZVyjIaIxjFlxP0NEb3VrPoXJaXq9pxFwqLllrLE6/OD
	9htYpNFhWVFKWbXr2VYGCRXYA5XbJB6+uYxrarIfoT+uWkhESagFXltk5NyXpWXAwU/ip6e9bKx
	fr5zZMfA==
X-Received: by 2002:a05:600c:3112:b0:492:450c:57cf with SMTP id 5b1f17b1804b1-492450c5d26mr106314955e9.31.1781985659503;
        Sat, 20 Jun 2026 13:00:59 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm10708354f8f.23.2026.06.20.13.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 13:00:58 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v8 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Sat, 20 Jun 2026 21:56:47 +0200
Message-ID: <20260620200032.334192-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620200032.334192-1-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the MT6392 PMIC and its RTC and regulator devices. This device
is mostly based on MT6323 with some similarities to MT6397 and is usually
found on boards using the MT8516/MT8167 SoC.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../bindings/mfd/mediatek,mt6397.yaml         | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..927df823d640 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -40,6 +40,10 @@ properties:
           - mediatek,mt6358
           - mediatek,mt6359
           - mediatek,mt6397
+      - items:
+          - enum:
+              - mediatek,mt6392
+          - const: mediatek,mt6323
       - items:
           - enum:
               - mediatek,mt6366
@@ -72,6 +76,10 @@ properties:
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
@@ -99,6 +107,7 @@ properties:
               - mediatek,mt6331-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
@@ -663,3 +672,68 @@ examples:
             compatible = "mediatek,mt6397-rtc";
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmic {
+        compatible = "mediatek,mt6392", "mediatek,mt6323";
+
+        interrupts-extended = <&pio 28 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        keys {
+          compatible = "mediatek,mt6392-keys";
+
+          key-power {
+            linux,keycodes = <KEY_POWER>;
+            wakeup-source;
+          };
+
+          key-home {
+            linux,keycodes = <KEY_HOME>;
+            wakeup-source;
+          };
+        };
+
+        pinctrl {
+          compatible = "mediatek,mt6392-pinctrl";
+
+          gpio-controller;
+          #gpio-cells = <2>;
+        };
+
+        regulators {
+          compatible = "mediatek,mt6392-regulator";
+
+          vproc {
+            regulator-allowed-modes = <0 1>;
+            regulator-initial-mode = <0>;
+            regulator-min-microvolt = < 700000>;
+            regulator-max-microvolt = <1350000>;
+            regulator-always-on;
+            regulator-boot-on;
+          };
+
+          // ...
+
+          vadc18 {
+            regulator-allowed-modes = <0 2>;
+            regulator-initial-mode = <0>;
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          vefuse {
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <2000000>;
+          };
+        };
+
+        rtc {
+          compatible = "mediatek,mt6392-rtc", "mediatek,mt6323-rtc";
+        };
+    };
-- 
2.43.0

