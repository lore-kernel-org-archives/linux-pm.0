Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E9246770
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777871007; cv=none; b=AIzi3AcC/6y5N0mJ8k5VJs4T5jN8Q/z5i2boZPZbMhY71pc/35RPpSuyRLx8tg7XbCOXwelHRBj1HcMLog4GTGWfAEexbBsfSHVa/4mUKM/kHSfadB17/XfWVWa4nwQtvVTUV/gKjeIF7akh5/L1ZzwqL25EHoXtcwAdWbvlcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777871007; c=relaxed/simple;
	bh=e+V2hd+ejnpH4qk2aVtlzrEBe/9p2o5z8qY/F+AU6ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqdwNm8VfM4zQWuteglOqR9lpEuUZgFn3Cll2t4brBQZ1ivsYy8W1lXM17Zpxui3x2mh65E0g3qyep434jr9DgtzCl5kAphMJBGTalb28EWYGHCJ+vYhjoL+htHSmk07CDIlDUqVBUEi5yw6pBV9LHC1uuCc2ZZkBsrqFs9JAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0xgX5XE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0xgX5XE"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so2234672a91.0
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 22:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777871006; x=1778475806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+hY6I1QbsBJjzyv0BxYALLJHQ4yccrLD8dnNfVypx8=;
        b=N0xgX5XEbv+x2/qiAtv12NzzVpO40XcDThdA2fHvhCnxKbfgmB0qh4lVSHSRoR6uSA
         sMmXk5Fl1CRUU74D11b35UtDXqNoxMUYVIzRE6hqgMWbtwng3yMvrS1YPjjALy5aivVz
         T7qHWhoCYwZ27Q/5USqmyV57vuQaUQT4yeiSaUmUnXesdwGQW7HRWTRvDRRaMLsQqbkc
         r9k5BR8iWK3jRXzWj8NXDz44nDi6mHXxPw4NzZi5e22yjDV2HNaCEl20u8O1E/mdVNyg
         6qGDW3NWRcNKYumCj/9y61cBiRv1awYoGKxhuddqEnkYuq5L8ZMvnpTCdM5JjrdfPBuP
         GtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777871006; x=1778475806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+hY6I1QbsBJjzyv0BxYALLJHQ4yccrLD8dnNfVypx8=;
        b=TV1LJqKFj7QKK3oNJrjdiSBPKbg/HGuX894gI2RlACoO9IxE04JIXWNg21I4xpzRPi
         8groPr8Y7UQuCXzTK8dq2lnnGypXKjylzCUSwyBgbAQA9/GK4PueJKOg41hu7E2NAjxq
         Ga/nZyazNjih0Nkp0HFHaQRT1okG1y10lCSmKsk/JrvzRGcm+rTgL+19/RT8nafgsZr5
         plK5vxI++2TAEwj2oYOpsZSh8vSigY6QFtbTaHmgTSCI9FiVxXxMhrvI8A6/MVVdfc1+
         FAtWhEm4+pHB59jf2zMyTG5QkhSTClmP231hgbEW7wCt8vmsn4qUPbBbiKFyvPsSxAge
         6nZg==
X-Gm-Message-State: AOJu0YwklRbCf9P+tfwbp16EbyB42sBXprQR5TDXY+BdHpj5UGmPVfaa
	g4SpV7YQ3NgP4njJl3ordy4fj9dIFWkZhTPC8+OqQ0Jr0ZFbaKjjhhFv
X-Gm-Gg: AeBDies1rQLRVkZfoTjh1E+7+Gnw9ypplr591of2o8FpRNNseNLKtX2XN2WhO+e+sZ3
	G0PUwLC9d3arsnfeNVx1wpOWFtCVHCL8CWXc+r1ILrc27SV5Uw79YtVYBOlV5D8xt61u1p/TgMs
	mQO/QCn/7hoN86NWQJZ+Q9i1ixg9tRgfR4cxkGSWhqe/wF4MUqWbsOa5gCYPiwvGzJ6w2GZ5ads
	Fz/AoJ9FWvbRoivewRN5Chjht/yQfZV9MKUGPJ9//ZUoTtqOdNF6HeqIwppU6Cg+6tUDry1Y2cT
	KUvQnBL31+0HZEnhlFHr/Kb6Jcu9BQ29J1MI32nbt74EotHKJ9bcnI0/Zbua8S1rxtHVDwmwn8W
	R0ZqF2JDVwYPgyfgTN+rz0+yCsfgAa9z3WSbLlDcgcqAAt98Var+lQWUQWHDbN8XY8nRLEbUv1O
	EVeA==
X-Received: by 2002:a17:90b:4f82:b0:35d:93c7:e386 with SMTP id 98e67ed59e1d1-364c44b65e7mr14781931a91.4.1777871005911;
        Sun, 03 May 2026 22:03:25 -0700 (PDT)
Received: from archlinux ([2605:e440:15::152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365437b50b0sm2662908a91.0.2026.05.03.22.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 22:03:25 -0700 (PDT)
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
Subject: [PATCH v4 1/5] dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
Date: Mon,  4 May 2026 13:02:41 +0800
Message-ID: <20260504050245.646078-2-iuncuim@gmail.com>
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

Add dt-bindings description of the thermal sensors in the A523 processor.
The controllers require activation of the additional frequency of the
associated gpadc controller, so a mod clock property required.

The calibration data is split into two cells that are in different areas
of nvmem. Both controllers require access to both memory cell, so a new
property nvmem-cells has been added. To maintain backward compatibility,
the name of the old cell remains the same and the new nvmem-cell-names is
called calibration-second-part

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 54 +++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 3e61689f6..6020413c3 100644
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
@@ -132,6 +140,29 @@ allOf:
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
+        clocks:
+          minItems: 2
+        nvmem-cells:
+          minItems: 2
+        nvmem-cell-names:
+          minItems: 2
+    else:
+      properties:
+        nvmem-cells:
+          maxItems: 1
+        nvmem-cell-names:
+          items:
+            - const: calibration
+
 required:
   - compatible
   - reg
@@ -176,4 +207,21 @@ examples:
         #thermal-sensor-cells = <1>;
     };
 
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sun55i-a523-ccu.h>
+    #include <dt-bindings/reset/sun55i-a523-ccu.h>
+
+    thermal-sensor@2009400 {
+      compatible = "allwinner,sun55i-a523-ths1";
+      reg = <0x02009400 0x400>;
+      interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC1>;
+      clock-names = "bus", "mod";
+      resets = <&ccu RST_BUS_THS>;
+      nvmem-cells = <&ths_calibration0>, <&ths_calibration1>;
+      nvmem-cell-names = "calibration",
+             "calibration-second-part";
+      #thermal-sensor-cells = <1>;
+    };
 ...
-- 
2.54.0

