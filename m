Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F13E025E
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098382; cv=none; b=XASighUemJLKl/fSXP14TlVgyUA1iOyfVJjRSoV08DoXnoUfGdNPvXR9KI0/bg+707Qncx/t6POLTh3xwtvOovYiZ0hbHqRjC6rt4DMjOH9JbJnEFzhMezugMWE3Y8N+IR0mPB6flzJ6xofm13o2UqtSFkG1p5a69cZbw9Xpo8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098382; c=relaxed/simple;
	bh=or+EJ07SOsHtoyrRm94X5M8kiBqJd626zfaT/m/MjG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCkYqHoRUo+CDmrg7b8ZY1P+UWZssZjHewzT++oIe2zbeIqMcjrT99aEEtAZSaDXgcFfSmQLcmJDVRAKsHqdO6p+gOp3bLOahxvEMrlnN0DODtwI/Eh4Oxi5mutSMV/MacJQTkcVXXXOVnqEx6QwR1hWE26fOJDVe6yFCdcwGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhHlK+PN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhHlK+PN"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45562c41ec7so1129937f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779098375; x=1779703175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuxBA1Jnwii0AQo0AYAcpS9dZCQZKs+YbA2PPOQhDTM=;
        b=MhHlK+PNKlu/c34xaAOmHYeAhOebNMkpHJQtL2f4SKgGigePk/5RE/Qvhzjs7lRJZi
         VMecwnoXqipnrp7G5nKmNz5lWksaYfqybUWvLUBThrkwAgjxUkZCf9eewGLRciqnw7RO
         1DgJ63ygH4zpTpHpzgTuhZC35LzhCqzqVBxcystfJuyBPzUuDVUsa5KllFvX9SFtjyyy
         mjCOZ7VnTfFlvKZf7Atj+gfkhsx75GztCoVozOyfNY4dCXhDJ/yTNLNPk9eBGX2x7jlh
         DlQh8nOrnYVscQwMfuSlbAuyjMrPEB3w5VrSVtZu6gTn04ieUw59sD3XblsvoFPaguSL
         53gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098375; x=1779703175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CuxBA1Jnwii0AQo0AYAcpS9dZCQZKs+YbA2PPOQhDTM=;
        b=OPipzvFi3JPOWuR35FQsL+PXmSjKelYL66FV/5hILoMGDrlAhKDVdXrbJGu7TNdjXM
         GAxWgWbRdYG4Y88aGkHsTun4NrFnr8NN/6/3mo3hbBj0tYpxWTAAfrz9iIWA/3ybuutS
         PzQ4BQ1nlow/gEDwx67CsQufcI2AfGsWlTqXYgE0VyrqZJdzpNZxwCBXKZ7+Tgh6tjuD
         QWdSktw/0MKWtzhnThvq8+4gNpB98QRl0lEgC/AvNFYnLc0rYy3A3v/OIKlbt9kx/NaK
         nDki8wUay9OtI/Vs4wWfLBAcEgPyu45a58EwSbp0hRNP1b4o7juW6isrSJqB6WfDMG6h
         BnSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/lGOdfdwW6eq5BXYS/kKODEeKFg8VN/Kt+egUQko2JRIj+wpGV55KneDq6Lwaqho0EyUiodKNaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZuxYl2YpDy8ZcHefLmNqbJQCWvGqvzcHc7NtcGriH+ukOejD
	/j1/skwu9UgI3embqqvkHlObW4xiLYiarZAvpF6UUoetE1jxt+w6O/6o3dSe1g==
X-Gm-Gg: Acq92OETsoHjOLseAJgOSSwIZ3A0ay1pWXmOHZ1bg3YdT/u2tmlTRKUlYka7Mx04lCA
	NTrM83NlrOGaZuGGXjWbFaKf0Z7Ov7qorE0Yq8PD+8L1itUVHBPEK75z+FF927zGd+jJTXoZDZS
	o1uNVk67Srh6WCrEW/5XrWcJa3zJchz1tD2puLTOpIvM5Tld7m4bI5eTPZdSRuhq9O8R8OOt1hv
	x2uA078gd9XZtOZZqq2dicTIVhpQOI/PDcVTLcMQJWq3sENAj7BE33f2uCHclLJQLUlgkL6dTCU
	jrBZTu6/G41bQr8yLvdtytjQvNi4FWxvjBy/tRNTRmveWat13kWXodAtYb2+2NG3qBbP09F8p8G
	OCdeHrdxJUHPZub+2mxRPN2WaGvooenGmB3HyNGm2ZnWLY3BaEJLSDTLMcumv6Q1HGCUllvkoAp
	23dRtufPnAaos9plcLO/00o5E=
X-Received: by 2002:a05:600c:630a:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-48fe632663emr252629925e9.18.1779098374859;
        Mon, 18 May 2026 02:59:34 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm102995005e9.7.2026.05.18.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:59:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v7 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Mon, 18 May 2026 12:59:01 +0300
Message-ID: <20260518095907.36158-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260518095907.36158-1-clamor95@gmail.com>
References: <20260518095907.36158-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
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
index 000000000000..60b6375864aa
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
2.51.0

