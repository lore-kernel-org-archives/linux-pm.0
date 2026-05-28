Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7A318EDA
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946353; cv=none; b=i37Eoc1xS0rzp2RUK2ZXlhpnOLnZyonwkKsJkE08XC8wGD9U8CPa4o0zJ72t27hoqhlZqji7+MzrD876iOLsFqXeX5EZd6zlVpcJDBkMr26c5g5/km55V9dmB2mLtiwp/AufwMfG152acSqr/9WREQtx+BqToLasM+7RGm5Fhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946353; c=relaxed/simple;
	bh=or+EJ07SOsHtoyrRm94X5M8kiBqJd626zfaT/m/MjG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyVpwnHYXFDxxrg7s0KbRBwiz7epB5Dgr0Xyxz6HeXjFPboG5n0OSSRyF37zT1ufV0HLXMJ/O/m2Olcs3j0VsbPsjutNnCaBhYtKPTiio51ZQE/T28dDg8FcGQ2m7rR0CKRyPQmeEljh/FYQbDzgaMacVYS/QbgzDhrVlddJHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuQN5ltW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuQN5ltW"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd8f9725b30so1411852566b.3
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 22:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779946350; x=1780551150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuxBA1Jnwii0AQo0AYAcpS9dZCQZKs+YbA2PPOQhDTM=;
        b=VuQN5ltWkC3k9ikvHRMRn5mkhcc434VY8Oel+BDUNoYr7CMaqMWu/GlU/MWWZUrlH8
         5DUPIc2xQ2+khJIWyXS+p3Xma8S1uZ0dbiO8BYNh0RGr9uuO7uVPgZFbMiZfpLvTURxV
         m3uZImWMUQiZBJ+FTvqI8IkSpXUHaFC7xxP2KO5NxngeJGsPkSvHuqtepwUIt3vDXXjl
         qqGo8bAMsJBscsjObnKv/uulevFqotmRz6Xxrge9ZuU5E8ai7A0DU77H0p+96XJKd69f
         8dc32hl/4AiJdtZmCZyoJ+zklnMIipZGv1CviB+2b4du5/G3i/hJwgaAVT+j803+iHoX
         DANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946350; x=1780551150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CuxBA1Jnwii0AQo0AYAcpS9dZCQZKs+YbA2PPOQhDTM=;
        b=HNsrdcx/WcLE2hwj2n9wBE3PdZsGG5FzTlKLo0p0KCky3q9Nev1FwcJmZdYv7fNljk
         DE/hN/R8gwzBfrxcIEVDsfnwag+POHmyuTIbZ+msr/4QLbXGj6dGy8YzbABE+G0QlQSN
         TKCsgjT7ntqqa8ychR22spBSUEdWw2r+lg3CJ9K/XDVl71rYSiEjhgIN3dFeL/kg8oQ0
         Gu/bS506OzsUNDEj7uu63kDoVlOWh7nG6mjZa0IXHaM3Um5cmvfnsLlQ935S7kNfmltg
         xfy1mr046oaPdnzS2jmoRXvWNbgmWl2WRLL7j+U97HhGJQ9chYsSmwxt0TeKd484lsbi
         Kpvg==
X-Forwarded-Encrypted: i=1; AFNElJ+/OXSvWPYpS9PPaGmvRSChXQHdfxi+mMVup29+HoHjoDSa6AuQHrlEOLEAXHB6skmS1zoWfyyfwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pvaB1M0gumr3vEvE9/ygug4I1m/9+UsCzqZRDdNPgSpgbt8k
	uJF+oIlJm6x+3x1t+9HRdsfwlZ1pRSlK3dK7LzcB6K4lslw2bwAPgJCs
X-Gm-Gg: Acq92OH9IEHIc97YOTeL8LIeOHR/f6dOslYz6APeeMgb3b1RkmKTTkxRLFvm3Kxn8Ig
	KBGyqaCS6yn2jULneGTs6r2r0CqKBGPxMO9PISCuBAgi9YJ5uKP/bPlzwPrXQ8PRa/QKt54OmSC
	7sc31y4tS4unPOb5QOa7/vPsts8nCtsw/t8ZpSdWJLxe6yfmqMitcnVgzBYk3IccaDYlMzDnRjT
	VlIFTCiCwp+F4gfNXTTb3+Xn0IafRur9EqrHTXhv7eI4rQLjkEFsh88CiAJ7/wmBF2xeOW2lZ7i
	veIRNwdFf1OTJPrlCqonu7srJ4oDPMNR9/mxGkStm0giSx/TyC/SV51xpjxudpIfIQU8qLZoKdY
	Db9rk7FRIQSRoaITv3C0YJD7hD6wDO5Rbthh85DYYBiTjbW5cVUgiu0wpeg8SmE+nQ781vkNa9e
	LMCnxP3DbjejwmqHyva23kRiM=
X-Received: by 2002:a17:907:c003:b0:bd5:7a3:a593 with SMTP id a640c23a62f3a-bdd2b0d6a45mr1714780166b.46.1779946349814;
        Wed, 27 May 2026 22:32:29 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5eca616sm693427966b.30.2026.05.27.22.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:32:29 -0700 (PDT)
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
Subject: [PATCH v8 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Thu, 28 May 2026 08:31:57 +0300
Message-ID: <20260528053203.9339-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528053203.9339-1-clamor95@gmail.com>
References: <20260528053203.9339-1-clamor95@gmail.com>
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

