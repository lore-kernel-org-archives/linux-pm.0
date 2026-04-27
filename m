Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094E34FF5D
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309905; cv=none; b=SmZ9jLg5JS2wO9nEkkPb6CHzU+5UBOj+XQE9V1CRuKHpGKJJtj+C83NFq3NtcZm4b5RU2CQe1aB2bGICCDe3W4ZrAi2eACKGCD1ATskJouYJlhOATXayytFWZwetLu4suXP/b1C05BIbW9bn0Ogcw2k7dwQl0RogSFpsnxmapqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309905; c=relaxed/simple;
	bh=40Q0FHycVkAdCD38Shu/5+j+bUm15rAf8Tgbi3I7ne4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgN709hnoHN8/qxIqQfiPsJWKdMTKMjkhuMRDpIzAtMdPXUBWagZtMKwewSxjXPKjBagiCswgV8CEk+FomMmcdOpyfq+AH3R9IWSt8uhLsD4T7ucuMKAerCfZIhilqAnLnpXYBAxDfmLKzIR1ZcooSuifKF7YLLlBd0eIM1r0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gskxJ04+; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gskxJ04+"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6948ed7139eso3788696eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777309903; x=1777914703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ff3Oah9+sf3dvTFmRGJs44c/nx8rxOEtIEmQFlJnbJA=;
        b=gskxJ04+coOCiPrR4pJXvQaV4ywOpEyj7Poddp2UOk+ddMQ4pThEs3FOV0Z6BelAr7
         MRzCnHGHYxM+V30bIgGdxLY+BZCCU6dQYBaQ3O0gkm9whMZjXwSomHdNbNF1qyof1otb
         FpAapNJMgSEySJ0TbG1FpSaeXxXizUAioF6reI+89HFBzFjnblj+/VHegxlJRy/J0mf+
         0Xdv/qfsBtJ2RuHbVfo42JQdvJtn0fj9gdElDUz4S0zUnj4m8OgLyvSC2XWwmD/vHMc0
         nY+25piHPBaHUNMpyh85krHKuPap5500+iwlv7WtjqiGehRpdgO1hjJ8a0R3c+e9QkJp
         Vw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309903; x=1777914703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ff3Oah9+sf3dvTFmRGJs44c/nx8rxOEtIEmQFlJnbJA=;
        b=EthNejBsotC1vQ0RHCOjVcorIi738JCBFF9J3h3pcS5kdD6VTclPsGivHKihsJ3y38
         Rej3ZwyWYPFxDIT67Mox3Cojjd5F7Wo/aAyFU7i7SezXAKC1npbunWnvLP/tYd6hdAPL
         z3Uwa2IaeSc2WyJzL6f9T+If5Z3598aXhyzX9dw7Vjz0yuBaoI5PXqOfkUidkXC2C0o/
         C7Hyk52qGp8B75oL9Hgf5l5acQzjbLdqcfCtdZOb866yPpy5mOZ3sLtzoWFXu53Cg3K3
         K4w6EBEE2n8RsHnkw7aZ8AgbiFlIV3j3RJ2nqngePyuLMPqKYjDPAJlAYMAp8IuAyhDI
         hOtA==
X-Gm-Message-State: AOJu0Ywj3IgjmGF6KADR5BEeyyj/EsvbaIboEXnP7f6efnKb/Xy20+Aj
	5qRId/i1QuJ4Jj1ptzXFid9Vtp1GvIeaE4miuL7+ekvR8dy24cl8NOUM
X-Gm-Gg: AeBDietLVsSey6gshB+PHozFtjKEQyWmzBIK25bb4CyU5LR/J+XN5b4oNAORGzBujyd
	jfxAyRQT8kaeTXQh/ojBrGR6SNvxDGgzyFPanAJgPnyZVXDhkk/Y54fpcD2BiPsBK0UNriWp3Qm
	bOtCFwc2gbyntJUYhraLtPBxtwuVq1Yn5c7dlJYP3o2tM/P6BtB6CCvPAhRU9qva1R6uVndqspa
	HJnhUP4bKHE/Cx5UBsaLoY7wm/JTWJkoJV6Zg/z12vNpPHh6/NHND8d6SBcUDrvqwpNMD60LyJd
	bNi4qMr/0QPRklr1XS/JYueFg903AeljQKCApRllMt5AyxD5ExbFv9DdO2pxKUZuA8NKMbNjQJD
	sd0mfy841loXIGdJOHmIMJc0JdrG+Kug5GHI4OsXt9NDRRDlXSJJPkso0p9PClP6XV4kRRfyBvI
	Tgj5Y2o/MjI1f4S9fjyNyVQZtcctxKHVQ=
X-Received: by 2002:a05:6820:1b10:b0:684:5041:9296 with SMTP id 006d021491bc7-69462de2716mr23720910eaf.10.1777309903103;
        Mon, 27 Apr 2026 10:11:43 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6955036558esm10261236eaf.14.2026.04.27.10.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:11:42 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	xsf@rock-chips.com,
	sre@kernel.org,
	simona@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	jesszhan0024@gmail.com,
	neil.armstrong@linaro.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/6] dt-bindings: power: supply: sgm41542: document sgm41542
Date: Mon, 27 Apr 2026 12:09:09 -0500
Message-ID: <20260427170914.5062-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427170914.5062-1-macroalpha82@gmail.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Document the SG Micro sgm41542 battery charger/boost converter.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../supply/sgmicro,sgm41542-charger.yaml      | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
new file mode 100644
index 000000000000..3e5041e5b551
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/sgmicro,sgm41542-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SGM41542 Battery Charger
+
+description: |
+  The SGMicro SGM41542 is a single cell battery charger/boost controller.
+
+maintainers:
+  - Chris Morgan <macromorgan@hotmail.com>
+  - Xu Shengfei <xsf@rock-chips.com>
+
+properties:
+  compatible:
+    const: sgmicro,sgm41542
+
+  input-current-limit-microamp:
+    description:
+      Optional value to clamp the maximum input current limit to for
+      the device. If omitted, the default value for the hardware will
+      be used (2400000).
+    minimum: 100000
+    maximum: 3800000
+
+  input-voltage-limit-microvolt:
+    description:
+      Optional value to clamp the maximum input voltage limit to for
+      the device. If omitted, the default value for the hardware will
+      be used (4500000).
+    minimum: 3900000
+    maximum: 12000000
+
+  interrupts:
+    maxItems: 1
+
+  monitored-battery:
+    description: |
+        A phandle to a monitored battery node. Values for the following
+        are used by the driver and if not present will result in default
+        values being applied:
+        constant-charge-current-max-microamp
+        constant-charge-voltage-max-microvolt
+        charge-term-current-microamp
+        precharge-current-microamp
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    properties:
+      otg-vbus:
+        type: object
+        description: OTG boost regulator
+        $ref: /schemas/regulator/regulator.yaml
+        unevaluatedProperties: false
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    battery: battery {
+      compatible = "simple-battery";
+      constant-charge-current-max-microamp = <10000000>;
+      constant-charge-voltage-max-microvolt = <4350000>;
+      precharge-current-microamp = <180000>;
+      charge-term-current-microamp = <300000>;
+    };
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@3b {
+        compatible = "sgmicro,sgm41542";
+        reg = <0x3b>;
+        input-current-limit-microamp = <3000000>;
+        input-voltage-limit-microvolt = <4500000>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+        monitored-battery = <&battery>;
+
+        regulators {
+          otg-vbus {
+            regulator-max-microvolt = <5000000>;
+            regulator-min-microvolt = <5000000>;
+          };
+        };
+      };
+    };
-- 
2.43.0

