Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A732F76D
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311371; cv=none; b=EHpwAkvfqGGbD/qx3VhNo/EZaH0DVJaSAMSF63Jp+l+nYm+HQIY/ha4tKb1/qE4ZhZYnC1YIjxfQeobkz/wSaS9HVlMf9Px7yyxxIzAbLhSYxMF6MeqDbQYN/23fpb4W7byYfwK/UMgZkDujUkBmcb4JdvQO/W0dlb7tg3/iIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311371; c=relaxed/simple;
	bh=c0FwilGJH257Vmi4WBaFoyoKQXfgT/wqYU4kh/brsPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSoxuetYpnVO0WK5xoSxg0vZTg38ytUGLt62uzAA7xXDHKfEC3ZoVd5K7dGAOKOKzh4AydxLbQ3u++KVS2bAwVtC0syI0JXKxWCiwd/VVxRk0irk7il+go3PTUeOgFlrS5DnCDGlalEkC74dRc6JfFxJ/BHYgxqLZUrog7s34/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLIX36Kt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLIX36Kt"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so713611a12.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311368; x=1789916168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z/z4QNBtUdI4E15ZNXPZtkbjaHvGmUhKoMr+O5uGaIE=;
        b=MLIX36KtvIrguZxHl4EIN4ZYIT5d/rtKSSQDUPsisRKi+NQnTebcXHH+K3HunAlv7a
         2bocY7STE+TrXzmT2T7v09GLH2t5A7O3YPZ9c/dBr3oZlmKcArlNJn+BnUp71k1nH46y
         7ur6zghuzwFXN/uHcYKeny6LR/AbP53U+fLtEa2ZBnqZCCiTEhTm8+HwVv3rJykr2caW
         cgDq/DfNdwaOcPjlGbMZXm5/XeTV/7yWJGbESGuk7hT4E0bQzE0VyTPzyB0nJz6yo6nc
         qWJ9FRlH6xnDT+B8Vxg9woD3B7bNxp4JVoJqvTqCu22YYAPL+ui++kZPfv9LWQDyqQFg
         aBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311368; x=1789916168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z/z4QNBtUdI4E15ZNXPZtkbjaHvGmUhKoMr+O5uGaIE=;
        b=diOgzFmwEJA7SwPkkjqO6Z6qZofUATiI8nZEScy8KfTKZjTJ069igyRr/qjvLvqRO9
         aHGcbiiO9qru48RcZFmEQjcoyEeTwTeOhIt7pXs5cB4PSoPbSKXGK4uVuF65usJdQovL
         aJ+uM1xAUpW2clEWto4Nve+7EpGgmE3G973/fXDyvLJ7Okk0dxfXkIkgD24DaTYKvaQ2
         bAIQlEHCG+K8jj3A5BbbDd3Bf89MUpsH7WJWIR84MXkLnfpNhcYvTwxoiUPlpkOzMDHk
         0jLfgydjR+eALy+8E1g3FKl3b/4By+Xv30/4Mpy69TQOo0XDIf98Z4UwhI2D/we81qPM
         Fh1g==
X-Gm-Message-State: AFuF++mzKLNXP0SpZ5E/SOTuJW5cy5sZpKUIi3f+WWBh9CVpmYe0mPGi
	EfyLelFX+VKBA4GDN9GyKiuQQW0Rm4mbwt6gyWroJphNfLiOOGzinLaQ
X-Gm-Gg: AYBFou3hbwdNAiKZRrm8h8hDsXk+cCOpws5hN6vP1wFy7okLZcLqQX+GXy52uj6Z0JK
	uJmeODq5ZuX2Aw4efzSUdo0+JwLLJriJ7aaCPSGqMcHWtpZyDDEuhs9a/Q4cQlH9Ciep/mRq69/
	W/3APhFZHEi9sfwMedefIt9r8aHHwscmnf4D3o1QuFVIIFaDkayaZQOCufDcBBIB2lkcoqgnEQv
	7pwQEfDILuNbH6LfQd6LsFuLadGYpAgA63M5Lk3p0OJFq5NjeeH+1D7wSA86EFZoy3T0A1t+2c0
	usUX7nn3O3fmKyCjJxx6b4tjX8jizZmoi16q9jtGkURpp18vvEYB6oGAM/mhwkjbdy3P1B+oB9t
	KX3MP16a8u7EXljNaYpN5W1nt+41FCeF5GX3QzOWquribNv0FZ/oG4Z2n1oriuxSaCKyBHyBedn
	V5Mp3/FfmgA9Zm/EJBhS5KQCEGJ97UVYZvcPuVJB39Jm+uszNOlUMW/V99Oc4lAuaM
X-Received: by 2002:a05:6a21:46c5:b0:3d1:60d3:99f8 with SMTP id adf61e73a8af0-3daed46ad42mr25849990637.5.1789311368455;
        Sun, 13 Sep 2026 07:56:08 -0700 (PDT)
Received: from archlinux ([207.90.239.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm21467366eec.31.2026.09.13.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:56:08 -0700 (PDT)
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	=?UTF-8?q?Juan=20Manuel=20L=C3=B3pez=20Carrillo?= <juanmanuellopezcarrillo@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v6 1/5] dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
Date: Sun, 13 Sep 2026 22:55:23 +0800
Message-ID: <20260913145527.18148-2-iuncuim@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913145527.18148-1-iuncuim@gmail.com>
References: <20260913145527.18148-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

Add dt-bindings description of the thermal sensors in the A523 processor.

The calibration data for both thermal controllers (THS0, THS1) is split
across two nvmem cells at different offsets, requiring the two cells
to be read and merged. To maintain backward compatibility, the name of
the old cell remains "calibration" and the new cell is named
"calibration-second-part".

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 34 +++++++++++++++++--
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 3e61689f6..792081af5 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -24,6 +24,8 @@ properties:
       - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
       - allwinner,sun50i-h616-ths
+      - allwinner,sun55i-a523-ths0
+      - allwinner,sun55i-a523-ths1
 
   clocks:
     minItems: 1
@@ -47,11 +49,16 @@ properties:
     maxItems: 1
 
   nvmem-cells:
-    maxItems: 1
-    description: Calibration data for thermal sensors
+    minItems: 1
+    items:
+      - description: Calibration data for thermal sensors
+      - description: Additional cell in case of separate calibration data
 
   nvmem-cell-names:
-    const: calibration
+    minItems: 1
+    items:
+      - const: calibration
+      - const: calibration-second-part
 
   allwinner,sram:
     maxItems: 1
@@ -107,6 +114,7 @@ allOf:
             enum:
               - allwinner,sun8i-h3-ths
               - allwinner,sun20i-d1-ths
+              - allwinner,sun55i-a523-ths0
 
     then:
       properties:
@@ -132,6 +140,26 @@ allOf:
         - clock-names
         - resets
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun55i-a523-ths0
+              - allwinner,sun55i-a523-ths1
+    then:
+      properties:
+        nvmem-cells:
+          minItems: 2
+        nvmem-cell-names:
+          minItems: 2
+    else:
+      properties:
+        nvmem-cells:
+          maxItems: 1
+        nvmem-cell-names:
+          maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.55.0

