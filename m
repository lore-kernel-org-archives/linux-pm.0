Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398E43F0BE
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228754; cv=none; b=sXIiO+ii+Rk2hHf3ZIMEovZkvRd1zMrJf5RV5gL0zXoJhU8sNNLr6nzbyi3EWHZ9r/emDK4G9Eg9zCga++DkjODrvHc+H/H/XfWMEolpHnXQ2LwjtO30Imb/AjrFqUdaKmlC13C7tt5Gn0QQS09ny2Nxo3m0EHP7557NOMDlzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228754; c=relaxed/simple;
	bh=tfTNd5tjFz9L3yETKktoI1guJcDo130AJeYFbFp3xqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDux4UbXM5K9UUWtSuQTb9nPsIkl34tX4Xrn/kNj/K934iF03AT+Ak+aSdWJQ6kvOofHXy4jdDNrSnxNeKsnJfMOIpP1VIG7GelQ9F8uJQ4y2fdrcsMYI9A35P7A7AknMmWZzDpX/vvqlQwcNe4RF6XYTbWYTYBmNZYpjofQXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgVMhno2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgVMhno2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so1455945f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228751; x=1787833551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8IxgyMnm2Ery9SpdEpzGlw+pytPm84L4YPgJiijvQrI=;
        b=ZgVMhno2QaNMwLTiXdlwRcP/jtOJCaZCd7Iq0fuJE4H6TWjFuU0hVw59yXw7Qdt4Kt
         S45NpwNWnJDNg3FSH4PLkpXXgDanX+lz4MGe58L4pb+heCVmNhYntVPgZvYGJFNMVWGK
         QTMweDWNVXOoTXzS2wXSN2wc9DJNVdZL0qNb1TRoQOzaoS74MjAPYwxrjYZPStCdpLp7
         0nJB3Djw+3YyGt5gszqeKZ2ucxWX4gsJzP9/Debv0W21kQ6f9fXSHeRdjyKxCBfHjhdL
         NCvBrrhEx4hAQ1QPrYn3xAAEXealQwY2WbcbSy/HUA+d7YRUgHonTls1LkOHxQxpLbL+
         4qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228751; x=1787833551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8IxgyMnm2Ery9SpdEpzGlw+pytPm84L4YPgJiijvQrI=;
        b=ddaR3M6rVgTm4fjhRgBL7NMyVpJDHfAlalzboWX+iDtjOlQUJF3bjwasiO3cHL6oxU
         +r8fR6dlHlIw+cM/53ODrjVZpa9TTuKqXNoT6/qPwXcl5a+IwWFR359jnjEgjeMhcVUu
         sow6LLoxmfpHPeNCXBL12vW3mdYbdU3l1oaA3TaUMpczuNWX3lpuBCinFchiwVUF2tA5
         Zt+uLClpUZNzkUexZI9JOTog0DrDIqaezdmqjzNIz64BzkP0zjcPRmcx5CZIrnDUOyl6
         AqWt7vTXXYP5u2xn24+11Gyq9394RWq05i6hyfDr+XzqxGcKgwjUdjgMnVctoj61UkIy
         Dwlg==
X-Forwarded-Encrypted: i=1; AHgh+RpSQ5bfI4pSxBeNKEg7FEw8vV4dG+s03vBuM+VwkUuKSXSLMaJ2bIrGi/5rKEf2uW2R+zRl+Bt4XA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCyZ7HPGIkPlVBKz8GC2z2QDCa658wslDNuUL5LPD5aCZfdfn
	MQ/xTsPqarfjSlOE6QE2X6RjHaKvfcgn8+v2dgmZZ37kCHK9UIboC8z/
X-Gm-Gg: AR+sD11p9QAB44ETs36FvR+e9sLeV2UrN6q2A7xjQLczWwN+eor3fXD9ruM/xaPgbg1
	aAeKmvcUdr01ZjfQE51/sQNZOUkClqfh8rM1AmaesMjdikBgCiNyZU/HwCpU+/TUYm1hMA7ISEn
	j4srZ1XRF110v8y5hpVH6UsCEixDacvs2PJKe6+jG0vylJCk/5DRKst+lOA54yo8DGgZGG7bXKH
	1csJJqMkNARB0BfN6skJZfw8JlGm2G5YGv409TeKj6GDdpS/kHVfJSxRnt7A5CvI+RT4Xzi8adY
	JgFNIHyZxnPP0STi+MEr8+drlFDF/TdE2zfjanJa71hxsfxP7K75dDxZOldKm56r5u3Q8ye32ik
	OYUiVVdLo7Khb7P7h+tQKnfewPtSBemVDWBoSTW5EBFaE5HlwVQce2V9sXqtATTkbKTLAjwllp+
	pJzBe2FcboUXTnSduqSjHG/J0kSyt3ka5WzPX9E+4ysbOgwmCFP474mA==
X-Received: by 2002:a05:600c:5288:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-499aa1ea46dmr243508505e9.13.1787228750345;
        Thu, 20 Aug 2026 05:25:50 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm170494645e9.8.2026.08.20.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:25:49 -0700 (PDT)
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
	Julien Massot <julien.massot@collabora.com>,
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
Subject: [PATCH v9 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Thu, 20 Aug 2026 14:19:59 +0200
Message-ID: <20260820122242.120039-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820122242.120039-1-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/mfd/mediatek,mt6397.yaml         | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..fd4b41bd3716 100644
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
@@ -663,3 +672,69 @@ examples:
             compatible = "mediatek,mt6397-rtc";
         };
     };
+
+  - |
+    #include <dt-bindings/input/input.h>
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

