Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA826F293
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029857; cv=none; b=oO1dK1+NOs2QndtNCIRjDcfsD4v1WbOE+yytJLFp9d21K5gb066e2wKtl04Bg7bzI77Tk7YNFsT9qsGVMY9U6ho7o0BXnW34qwu0BDb9Brf7R0ptRnwcNGsAbNau1TD71mDYUVusCjUu7p434+LTPJGWoj+i0PxK/dMitlqtIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029857; c=relaxed/simple;
	bh=F1QcPOat0RlFGGRV77vX76GE3Dt2kaecn3iVPXEQx1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czeGAXW3OODll84EvuOc8Jm0muaSkJsYlmGMHdesweIFs9g0Qkn11ISyEs74O05ry4uNN9w7m61RfY5Lt4KOJvLtqVXKC66t3qXsbDEyzq2hjtRyJMWBJw0n136/vKLMDdUsvbVGddKlrNURcgtDCD1xk9l5ekuk5SJIylt7OWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SV8xpK6r; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV8xpK6r"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso21587065e9.1
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 01:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782029855; x=1782634655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr3pdjQhJUwUIpy3MtQLNp8w7Jmlbm2OlpXRHc3g1wU=;
        b=SV8xpK6rcliFYMNL1/dsunswNzQjAqMWqlS/ICaJ725GNJ7VnRBol8RMm1p/6sFlhH
         9dCPi1dlYmP/bX7M20TUNJmzAG7Z7fFKZsKSuuXLmM4344twB8yDVgNymG05MAi6WpNu
         +LmMYq3c1DGd8GB485TFjhp/AAxXGoHUA+KfaRolNxYDnlUD4HBY+Awjm6q37orlpyps
         qrf5qG9xNCiSTxQa1/vQ8VpHYxnylASWsDlWqrEjNXE2t1HfPkanWPN5q3OL5yu3vbZQ
         q0Pk3goVr4E+eQOA9jel94CX+sayn4YmLH8m6wKKTrvzBSLOuNxsiZ1ENqb01It4fWkU
         aj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782029855; x=1782634655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cr3pdjQhJUwUIpy3MtQLNp8w7Jmlbm2OlpXRHc3g1wU=;
        b=AvK7vjo1XKf2hXKsXhg+oiD1QZ4yH4/yyyWtEioLcT3b7yeFBx//LqtyYk5PVk3FXp
         7w9lb27aXsxzUWVzIPLsOC5vW5rqAxjOK5gzYkt/tskJHBOZ3PUcXCQKRrkIJ1PK1Ph0
         rN1k/w0UauZgw4ziEg3yurD13hSiqmWHMjazJpgIdZTUIHWhPYf6J98cqK/KTVYJBRgT
         wpuBM+8bgIN/PMUh6hQUwbxIDEEUy5k5DJ/tT5RSjKbKg+d8F+77AUVx4j49tPcs/EjV
         bhuoAUp8fPwwLgguATOGy1dEbmR4U6SCOJbb5VPbSUrOMdO2Mj6GOptsqLLpRV814Rg8
         LoTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ozuE2exFt8NIf1Fl+Met6wtig0bfsd4K2H8Ec9fuymgjVDFMX2irv7sIBlOh2AlD64frelO+AkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGEVnOIQB15YKQncJIftumAi1/jfNXqk0dtAP+b0c1G6Ze/Nv
	JJOBzXIOhFoPssJVrYeXs41Lsua/+efk5eg2LInqfL+swOjryf4Yd5qs
X-Gm-Gg: AfdE7clTMzj1vr5osLxzP921SebgQ4ddZ9Ad39PM28XbNNanVIs1FKGR57x/LFyWPSi
	Ubd0V0OFCvCLGoZqeJCED7hSEQkOE3pwpdRBdl44nnSTnj1+w0BQ0ILk9+YOQVpLTePVGj/210j
	AZIdLpI/Tfj+lRZNB/sLoXR/uwj5N6p90fa4lT6txWVtTIqu1CedN/2V4X3/Sb014DEkJdfyaxU
	kUKTMIXKyt7LtX9YWEXWvwlKSew0acUXJcyNs86WYLP7qqjxYmx5lHitjBLUcrCbuqnKmoRATr1
	SaTYgAJJnUY5ATtk4UWmG//kh03I0/VQMMqu6WfNxoFBWatsiHJnei4oKTFknAVl7Ica/YXL99j
	EhC35W3ciO4EKwhqwsD8iE8mHRilKJg+24e9nr3PsKMJ+0qBBF4q0dMIQkHdiWDsPgRgOl+bxVM
	rtiks2ow==
X-Received: by 2002:a05:600c:8b4c:b0:490:be1e:6ce6 with SMTP id 5b1f17b1804b1-4924908ab39mr81863715e9.9.1782029854882;
        Sun, 21 Jun 2026 01:17:34 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b9e5sm194100445e9.10.2026.06.21.01.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 01:17:33 -0700 (PDT)
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
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v9 3/9] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Date: Sun, 21 Jun 2026 10:13:28 +0200
Message-ID: <20260621081634.467858-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621081634.467858-1-l.scorcia@gmail.com>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the regulators found in the MediaTek MT6392 PMIC,
usually found in board designs using the MediaTek MT8516/MT8167 SoCs.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../regulator/mediatek,mt6392-regulator.yaml  | 112 ++++++++++++++++++
 .../regulator/mediatek,mt6392-regulator.h     |  23 ++++
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
new file mode 100644
index 000000000000..d74721d8f2ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6392-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6392 regulator
+
+maintainers:
+  - Luca Leonardo Scorcia <l.scorcia@gmail.com>
+
+description:
+  MT6392 is a power management system chip containing three buck converters and
+  23 LDOs. All voltage regulators provided by the PMIC are described as
+  sub-nodes of this node.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt6392-regulator
+
+  vproc-supply:
+    description: Supply for buck regulator vproc
+  vcore-supply:
+    description: Supply for buck regulator vcore
+  vsys-supply:
+    description: Supply for buck regulator vsys
+  avddldo-supply:
+    description:
+      Supply for AVDD LDOs (vm, vio18, vcn18, vcamd, vcamio). According to the data sheet
+      this is an internal supply derived from vsys.
+  ldo1-supply:
+    description: Supply for LDOs group 1 (vaud28, vxo22, vaud22, vadc18, vcama, vrtc)
+  ldo2-supply:
+    description: Supply for LDOs group 2 (vcn35, vio28, vmc, vmch, vefuse, vdig18)
+  ldo3-supply:
+    description: Supply for LDOs group 3 (vusb, vemc3v3, vcamaf, vgp1, vgp2, vm25)
+
+patternProperties:
+  "^v(core|proc|sys)$":
+    description: Buck regulators
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes:
+        description:
+          BUCK regulators can set regulator-allowed-modes to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 1]
+        minItems: 1
+        maxItems: 2
+      regulator-initial-mode:
+        description:
+          BUCK regulators can set regulator-initial-mode to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        enum: [0, 1]
+
+  "^v(adc18|camio|cn18|io18|xo22|m25|aud28|io28|usb)$":
+    description: LDOs with fixed output and mode setting
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes:
+        description:
+          LDO regulators can set regulator-allowed-modes to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 2]
+        minItems: 1
+        maxItems: 2
+      regulator-initial-mode:
+        description:
+          LDO regulators can set regulator-initial-mode to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        enum: [0, 2]
+
+  "^v(cama|dig18|rtc)$":
+    description: LDOs with fixed output without mode setting
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes: false
+      regulator-initial-mode: false
+
+  "^v(aud22|camaf|camd|cn35|efuse|emc3v3|gp1|gp2|m|mc|mch)$":
+    description: LDOs with adjustable output and mode setting
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes:
+        description:
+          LDO regulators can set regulator-allowed-modes to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 2]
+        minItems: 1
+        maxItems: 2
+      regulator-initial-mode:
+        description:
+          LDO regulators can set regulator-initial-mode to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        enum: [0, 2]
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/include/dt-bindings/regulator/mediatek,mt6392-regulator.h b/include/dt-bindings/regulator/mediatek,mt6392-regulator.h
new file mode 100644
index 000000000000..2e1f41e0ebfe
--- /dev/null
+++ b/include/dt-bindings/regulator/mediatek,mt6392-regulator.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_REGULATOR_MEDIATEK_MT6392_H_
+#define _DT_BINDINGS_REGULATOR_MEDIATEK_MT6392_H_
+
+/*
+ * Buck mode constants which may be used in devicetree properties (eg.
+ * regulator-initial-mode, regulator-allowed-modes).
+ * See the manufacturer's datasheet for more information on these modes.
+ */
+
+#define MT6392_REGULATOR_MODE_NORMAL	0
+#define MT6392_BUCK_MODE_FORCE_PWM	1
+
+/*
+ * LDO mode constants which may be used in devicetree properties (eg.
+ * regulator-initial-mode, regulator-allowed-modes).
+ * See the manufacturer's datasheet for more information on these modes.
+ */
+
+#define MT6392_LDO_MODE_LP		2
+
+#endif
-- 
2.43.0

