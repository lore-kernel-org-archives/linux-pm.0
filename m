Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521748F008
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912934; cv=none; b=Grw49ZWlvoYrQAbQ3o3H6R8ZlXxlAUC97+2VrCfohd6Z8C3l3SPdpgM3EDn5ac5S4kBaiNQaSkTiMTQzvcduu8FdxLHekALoUEtL3qsuoPqIYlVCJZbKgdi3hhJjhg3ez+Qg5UFYwS0U9awMUNIYmCO8VYbO/vVrMGpdODBQOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912934; c=relaxed/simple;
	bh=0ir6EEm9FNQCLp9OUbkjQzJH24SRp6mnaINdn/CT2yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeZjKHpiI9BOtAzO5z4PAcNc6sOofKh0wznTbE5ywbFHCAJsMOztP5bHWji6K0gVaR9g2q/BJ/oF+sFis23qu++DrTKhTAGbR4UtaKXFP6gKwZjXNpmqnApzd/YFtR99D/aPvGWTnM+Y3XhCbA/ZjZ6F6Bo8saWySBe78TkBfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVt2NfHt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVt2NfHt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso23227815e9.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912931; x=1792517731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=aVt2NfHtP6jHB+WKrB7b+cZ/rrzgNrGpYjHqoGs1BQdg+0mXKgJRpf2ACXyyN7JJwh
         kvYeG6XV+LGF7LcVFJOKLcGzhyHLPd2kSt5CDFD0g/s2IFv6kwuffltnZxln9wHPo+jf
         x75omabmofoH9f/bkENX4SnegJE76RWNkbZiksRtMWV8OJQy8Q2gzkMkyja7MbQvKu3/
         HHrjRbFQKhRcm7ilBZz9vptGa5+6Bd7VWDx6PzIJe1/aLZQpyIUWAcHm2/ib8VEpElI0
         ozbZXnZ2rzWjDJSiCWttNmyGw8R1+SC+0hDj/wNe1EklyBjZsQkrucWR84Z4RS3kmQBj
         roiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912931; x=1792517731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=uInnWw149HRDXgpGudq+RrU0zgg04JqD+DHMMR3bV6AdBO3kJtGU4qOXaDp+YmcR5b
         mWY/n87GxQs8qvUyunASpgo8Ohz1A8Yti77lpTEYguUZFssxlWmadzGQxtkqx50TXli8
         UMxqQm22HTCPm5JWAefSSks59GijFYCimSlRL+t+Ir9dVQpoLLUobVMmTVVBf5h78Fbd
         rH4zJlXY55jbNEAHw5rgVxEkku1mrjSSZAKinJWi2o6zsRqhvnX5+V9sDtUu1Hu3xa7U
         budEQW1Kh+bR1skyFuvV8KozHDZDqFeCQy5IGaCnza2Pat4dcaycHMDaUoZg/7ppJZz/
         uGAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiBu9GwWoXHxBtWM2Bn8LOUSL7L0beyHfhFANd/DjUQvJDP41lweDT8RtjBGwnzV/9RuP4SgFRAA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIvVwwdSuCT887KY+LPSB35N3nGG0GOMHk/FN2iqCADU45YxEYZ
	/qO+/tEwbEbQMSAnzoEjiBtdKkq341OBQAysoUMCRwuVy11YQ/ZafKKe
X-Gm-Gg: AYBFou2RgJ2O9xCCsmIHCUSP1QNOiO4Sy1GjbpbdfjSSV2UZ2ndSr58rtiV2oXgGxv/
	c6XtdlDRZD93+uBJvDT/kxS6/LWFRS3NgpPKtSmge4jU2YNBNPcO9az+v2BAWty+t7B6fhPDVwP
	Cw9rR0V6wRUzGjCh8QKgloRZKmCfpltYrpcpNdsvSTdxtQjWLKFuZwrOGKBNuol8BAlR7meTMTZ
	KQjh/SGft+oyaIevdNYd197vNTrELQpOMC7oCKfa4KrS6X06oDXlMqf546ZKfD01LzO9yHC88B1
	6JQ9eNUMoXKsBFjXZP80oiHoxp5PVRAI+YD5lq5+qdroyLtB0CQpHhbz4TwjHFBbqBUtpwRsdGh
	aVQ6Ltj81ZEPUflTnOL2zsLkx+poAXKRgLLaTGfkOOvF1vGfu+Fma4RkdTMOAnyRVwBqD6wphBX
	9VsRxvK6ufzfV90O2ugMqngKq4aKWP0qSQNoddEKNTpXI9J8TwaH19ea6rF/pa4x9m9kGGmbLzD
	joMKtXlhixEEj+//6dML7u7QBmBkg==
X-Received: by 2002:a05:600c:64c8:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-4a18e4c41b0mr240687655e9.21.1791912930626;
        Tue, 13 Oct 2026 10:35:30 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ca51465sm284127195e9.4.2026.10.13.10.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:35:30 -0700 (PDT)
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
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Tue, 13 Oct 2026 20:34:57 +0300
Message-ID: <20261013173504.451391-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013173504.451391-1-clamor95@gmail.com>
References: <20261013173504.451391-1-clamor95@gmail.com>
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

