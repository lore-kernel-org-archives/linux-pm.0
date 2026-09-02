Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35054A9D6D
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377679; cv=none; b=do0kbeCLy/iURcYrDGJA864Z/SYZd5+fCAu3jC5yQ/x1Cr5Jl2GnTcfgA2ALzMkQ6OSoHN3FlyYuafRMSy/zzb0wrIMVT+3+KDbx3f7qdKTgQRL2Ygm3Dhi2DLZrQoVVNkBF50Ssv3sEglMEI/IPWrqvENVbJ2gTq8wfSjLX+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377679; c=relaxed/simple;
	bh=dCN4MSGnNu9qg2o82cMQqSPCzo+02NG8UMe2Xwsmd1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxax9Bzd+AttvgymnMZLMXmJ8qAGB7PLFotWye6LL36rmCxUbTY+pCNNR9358L8F6Tp3B7AVeDYyNY4oIwciricp2olcNwvN4ZwRh7IDpUVLgnMw1gD86gSHeLlxfKj/OJJ+sFLCQ0U0fzBYF9l9txJLORmpib1bzChW8yJllT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ru+rMLAj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru+rMLAj"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-482f9309813so1461213f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377669; x=1788982469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=caCex+BmvEH7ghZImY6FVecBuOi80GskXDf2a1gswus=;
        b=ru+rMLAjiINO7EaHjU814dGHl+ynYGkwqDSOqR2J6F7nxjMDgXiN63Ulp40yzY6SBP
         /8onhapFUKnQcpemxMjb3P6iJJtZvG/05JX6hGiHhwlid31rId401GjRmELfEOjntnax
         Jh5h2LvMYSD/h43tttfJ4mMpSUD2S/9VKA38qZPZLde8uQkihvnMNkCZsAsykdBbTnz5
         GspW2VD64CvwT852vtSrumyjAlwLUaH7vqieCgDh2lhzMDhITet3oFSNCSYn9y+9V3HR
         tra8l9W+vOip+RCwFKVuF3C18qW+dechV7mTQsaUzZAKIjWSV9DG8j1pzzEFvogODY58
         wfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377669; x=1788982469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=caCex+BmvEH7ghZImY6FVecBuOi80GskXDf2a1gswus=;
        b=qdczI38aqKAsJU2gWepLeMmZPtd60sQtHQjXMh4cyV6ngiEM75umsJoUEcM0fsh5xa
         UofcocbuUTQl20wPjq7D4OsqLvInqhtJl3ehQu1h8f0Z/SreBgsWsxl3xJ2P+/bG4sMb
         r6ZG4Ala108ag4xQPNyicWN0yc1o30Avv++0CcIRPMSTZ0KvVtyKPF3QZws/JLjckmvT
         iZ8Plbpc23uUiZhjxsi8Rr8V6EpaK2H9ZGxst/hhW7Lr7WkzTObxjSYdifGeGlTJ1eTJ
         NwdecwTkqE60bhP/QWavRrDBqzHMHeUrgNJpyJNjRGIauerNbFw7Vda66JkrAVsnYTk4
         lKlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzr9vCjX1Tj9PYBNBL0gVribdxw5H2SNqhKjzcNxHHqcKrBkJIiMfD/b4QvvC9rjRATXPVqMp/7bg==@vger.kernel.org
X-Gm-Message-State: AFuF++nWgPuqql1Aq7LnIVJfez8n4IKR1VKjpKsIISayyvsnlh2ohPxN
	VFAp8wBl9s2OE9z5gLWl59r1IKt3LVlOPFqvwv/fZvjekC0sVC+07N9r
X-Gm-Gg: AYBFou2D1RFNEqmWDm8zT4IZYZ49CDArrvoK4A5grgyFBq5PCZAn86oCYyNKYor3UUX
	lkJSzRdxThX8p3uT/Ae2PdnRyBhMCuAwXZ1cQNsAA/TOxRxYuxJNkEoEuowkFx4QJQ7PZ4mfzZ9
	ev2Oa1OFXSdV2AxKMP4WHgOEzoRcphxP0N2oS06vblcDYwRcKA/uGj7MfpwK1jDNDfEJPESAUB2
	sxJ0pdqLI90MKblyzCowmCFX83xAbChredTBS9RShIGnj2IA/pfSuvqv6khf77r/SxzWqAY7xxY
	BDYgY9lWmggB8tipKBtza0SNhvNOKfnTDitG1TnYAcEQr8MwVUqk9DCsQYrzVj+geFXaZk9Tepo
	eY2DXGUFnNj2rTL8Kr9jEWHjWZZyIBMc2OBe8YWD0u/qY/y+YFJDVWAVgRF07iY3lWvQ8xnCCK7
	HJbCl13wrSE74aU8kBjX+XgJzQqDurPpvCaPT+5VnXaxkbkWLiWVnqAWe6
X-Received: by 2002:a05:6000:4819:b0:47f:e748:3ae3 with SMTP id ffacd0b85a97d-48488deedc7mr13797916f8f.3.1788377668785;
        Wed, 02 Sep 2026 12:34:28 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm8889191f8f.34.2026.09.02.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:28 -0700 (PDT)
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
	Julien Massot <julien.massot@collabora.com>,
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
Subject: [PATCH v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Wed,  2 Sep 2026 21:25:37 +0200
Message-ID: <20260902193351.185771-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902193351.185771-1-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
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
Previous version of this patch had the PMIC device declared with a
fallback compatible to "mediatek,mt6323". Sashiko pointed out in [1]
that it would have been wrong as the fallback device is not really
compatible with the new PMIC.

Since the change is significant I have not included the Reviewed-by tag
that Krzysztof Kozlowski kindly provided in v9 of this patch, I hope
this is the right thing. I really want to get the bindings right as they
are harder to fix in later commits if the need arises.

[1] https://sashiko.dev/#/message/20260820125850.3B34D1F000E9%40smtp.kernel.org

 .../bindings/mfd/mediatek,mt6397.yaml         | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..06e93c545e3b 100644
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
@@ -663,3 +669,69 @@ examples:
             compatible = "mediatek,mt6397-rtc";
         };
     };
+
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmic {
+        compatible = "mediatek,mt6392";
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

