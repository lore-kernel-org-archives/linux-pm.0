Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795188;
	b=oH89UEnCo5/a7S9dTNhGWC0VtVVQ8LORcGjYG4yo6nmcLNmF0Ywqxv84aM8hj6G+8Zb9
	 HN4YXCkunRRG95x94M346ecqTLNC7BwBtn4JFopa9Yxevst11MNzDP1q9KVhrmd5cjR/c
	 BXhQjGX9SS+qo+JsXSyeLNs/AzdY/dPBuws77AwkImDcWo2xmEQYvmHiXxlagkeuEYqrh
	 XR/ebCOEPjZNx4jDq4z/vzZpcTSrCkO1p84YLr3ZXYHk5H4AzrZ//iD7JTAl66kSP8DaU
	 UFR4RHi3QtpJnrCxDv+va7HXSW82x0AUk4wCY2QjnNwhbkYGmF0nP+HczPD1N3vieqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
	b=1YfsfLp0qqM/DMnubVcxaoL4oLUhundMGd1PY919jG6A75b+nYCB9/wIJBb2khWWznaG
	 7k4p8Dddjn2LXhQvANDFvSsmOqhwXHFFzum0fWlhpRTSLyftV8Yo4d8jbPgEtg1P1Rw+/
	 n1yJ6u9sLxxbwjtUjjLr/wTNU1gIn9Ty5J0MHV0SkYl64BZeXHQ06kRy6et5DpnuvNiFv
	 t9JGGTAjD6ydRQPIPA5mcS5ulnNNLTdgvsdUrBzwKTxY8B6Gw5PbHAo0VB4pFmdTd7fEL
	 GoMAim/BSSscRxTdQ05bTvbyzL0xE2Uxc3u4VjZm7LxcTigZW+7IH7hc3gEWmF0/CiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zqxTgXZC;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3A606D80A
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 12:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA3A606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zqxTgXZC
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so4419075e9.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 04:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793795186; x=1794399986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=zqxTgXZCedl88xAPuNpOKy5fkDuI/WY5HEZHcMrLocsOyvu65KxpiKziAlKb5ah9B1
         yCl288vMVkvMdiPl5/3Vui4txDSN1utH1vfyc20VNcH/IWtCoFQIjxg/mozXyD4ZhAUs
         Ac8bgLWYI9wAwDxNzSLAtJjWYxxRByaEWfNF/23IFcyXQ2pCnNy/N6B2dE0A4Q8Fa89C
         hBSxJY/4RN5a22kyLdZf4HkmUM9EfC9uu4b9PdkPZ7o0EIvsezP3JiDCy3ccXu6pqYG7
         qCXsNU5nf2+jLQP4XxE8fNz4dp3tGW8L+d+0qRj4W/3AT/+tHGAZOz72gv0JUCErPrqA
         Ehkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795186; x=1794399986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=I1PNfUxW7lWBblqaGIuXAMY+/rewSL/ivOZQjGUaO5dIJjkgtg1k6VZs2qa/VMnl2D
         eeEmt6OkzTq9efgi50RU7rl9IrLIxzCVTKTEb7dzzViLpqdmIJZCn4oVFBPAOQtb+CBY
         iTPlWxRIR8WT90t6jTB5SKjgRwiUC53h55jXgA5+/VlM4WBCHS1gMrMHViPoOASwPolg
         ohlSoc3PF1XG/oqGqu+IDXgSxOabTGNVwtb0kwfFyZ/moGfrWTLt0JSCAbDFWsYqoYBo
         6x61cBtV/r4WCYhtlDsFx2BO6PODbR/gs5QoYFb8qfMQwOnSd/8vh79SBZiofvIRKHJo
         igQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuNgWVLWq/C6f0v/sbgrLpLayL5QShvUsmhIOeaQ2wMbMeaAtQjZvJOd48ciB6uIbcHxs4Hl/83A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8RfGB7j7QrQ4nhuFlRWfU8aO2QJqVHDu+AAZF9s7dD0UdDP7oA
	pBfLq+LU0MFnCEmmvpGrYJmgQdzyilhrqZIo5mhvISquRyclvmogdZjM
X-Gm-Gg: AYBFou3AQUOQukzY57KNmHUuZPX1PBcyAPnaNaUXP2GSA+atgb+fLdumTFHLuOQ8YeC
	PPea6EUsRYfZRkZ+/vjGripuDmgKDWwZk7TLO9I8m/fHnfaieRlvtJo+c/H+6I9DfdnMvBZJHNi
	ba0V9LcmzkjD5GjalJKHZDQc71Djsn4nzk48uYSg/qmDqRrxb2d2jT/0xgw+vTA4/k0ake/6ErD
	+WoHPOWFd4JAop8TH4tfbfHRgRZ98zTqEpva8MnEgJZ5RpQs2x3NHMdfoh0ayB7uJFpF584LEK0
	JgGanrzP7OkgKESj1X7xDG2ozWOowcsRCFGrYApi57xrQ+tUVIhkwQZ2ALdqcHiUnrinJINtV71
	el0xgWtWeSlkCxxEk7pIsg01MUKYea28I4GRDvkDz/OZgnPRikQrm07TVR5NkCYjyrkCSq5Wo+v
	EORBiHooEeJRUxbRIAPX67f/8HklGFU0OhmAIY97K7zRlBhCfYE1kSnsZARRG2oCG3vDDCTd3tG
	KwcIdlLTbe5H7/NnNjmG6sNvCA53oA6AGcrAiYHnoW0yt6wN4P1tztoosJkbaRBCnUIwSuaaEd8
	FCluRBcD/I3/sZkASpXNAvdQ1sYBOIis449uxG3TANHHfDedZQ==
X-Received: by 2002:a05:600c:698d:b0:4a1:d97e:cd60 with SMTP id 5b1f17b1804b1-4ac185bd1e2mr362326075e9.16.1793795186366;
        Wed, 04 Nov 2026 04:26:26 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43da9825bsm50492415e9.15.2026.11.04.04.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:26:25 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v13 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Wed,  4 Nov 2026 14:26:00 +0200
Message-ID: <20261104122606.215629-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104122606.215629-1-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
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

Document embedded controller used in ASUS Transformer device series.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../asus,tf201-ec-pad.yaml                    | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
new file mode 100644
index 0000000000000..60b6375864aaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/embedded-controller/asus,tf201-ec-pad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASUS Transformer's Embedded Controller
+
+description:
+  Several Nuvoton based Embedded Controllers attached to an I2C bus,
+  running a custom ASUS firmware, specific to the ASUS Transformer
+  device series.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    description:
+      The 'pad' suffix is used for the controller within the tablet, while
+      the 'dock' suffix refers to the controller in the mobile dock keyboard.
+    oneOf:
+      - enum:
+          - asus,sl101-ec-dock
+          - asus,tf101-ec-dock
+          - asus,tf201-ec-pad
+          - asus,tf600t-ec-dock
+          - asus,tf600t-ec-pad
+
+      - items:
+          - enum:
+              - asus,tf101g-ec-dock
+              - asus,tf201-ec-dock
+              - asus,tf300t-ec-dock
+              - asus,tf300tg-ec-dock
+              - asus,tf300tl-ec-dock
+              - asus,tf700t-ec-dock
+          - const: asus,tf101-ec-dock
+
+      - items:
+          - enum:
+              - asus,tf300t-ec-pad
+              - asus,tf300tg-ec-pad
+              - asus,tf300tl-ec-pad
+              - asus,tf700t-ec-pad
+          - const: asus,tf201-ec-pad
+
+      - items:
+          - enum:
+              - asus,tf701t-ec-dock
+          - const: asus,tf600t-ec-dock
+
+      - items:
+          - enum:
+              - asus,p1801-t-ec-pad
+              - asus,tf701t-ec-pad
+          - const: asus,tf600t-ec-pad
+
+  reg:
+    description:
+      The ASUS Transformer EC has a main I2C address and an associated
+      DockRAM device, which provides power-related functions for the
+      embedded controller. Both addresses are required for operation.
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: ec
+      - const: dockram
+
+  interrupts:
+    maxItems: 1
+
+  request-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: asus,tf600t-ec-dock
+    then:
+      required:
+        - interrupts
+        - request-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      embedded-controller@19 {
+        compatible = "asus,tf201-ec-dock", "asus,tf101-ec-dock";
+        reg = <0x19>, <0x1b>;
+        reg-names = "ec", "dockram";
+
+        interrupt-parent = <&gpio>;
+        interrupts = <151 IRQ_TYPE_LEVEL_LOW>;
+
+        request-gpios = <&gpio 134 GPIO_ACTIVE_LOW>;
+
+        monitored-battery = <&dock_battery>;
+      };
+    };
+...
-- 
2.53.0

