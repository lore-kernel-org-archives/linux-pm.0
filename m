Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787754A689A
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404263; cv=none; b=WfG/RUZNYv4ntdAitaUauNLE0+UAMq356KWjQJGa/stQ60FCIx6KSM8w9ZbN00i8eJz0OERvvLCUA2qwdYBOQa9BQ3dUN0/sOtIHRNUQGQ9fGxE7eslhdIWvRCt+HWBAurApPnd5tqdWeBLls9Hd2D+aEs2xqJSzoOz+v+amV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404263; c=relaxed/simple;
	bh=0ir6EEm9FNQCLp9OUbkjQzJH24SRp6mnaINdn/CT2yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABu64CoXiBNPPm0ypFjbwM+l1mMojdOSkyu8r3Ta1i/4DQGjLJ3q9qxtf/Z74zDebMrbVeuXiKwA5J/VDKFmp+X3+Xf022cMEd7QlZsJHW23l3mqgvyUV0e/OeO3X8RYr9aJrW7HEg2uV4JBrnvaJVN4gRxoV+g3SlzzdCnFrMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rABZifdL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rABZifdL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so20726735e9.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792404260; x=1793009060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=rABZifdLa7+QGoQG+sPcmcgRrz5Gg5wUX8ktsRm6gpsNYz6j8d+pDrtoIn1AbCBPMj
         bbTDYf8T3zki1HlGBViNsZiOQ8aabJf6cPuQLhfCIy2sWD8e8acRVh/HB2tA1eOpBSOT
         46WYGlVqKyZ2Zhsdr44+RrUY0x3eua+s13bLdZzm3FLZaGBl+vKIBgd9sDfyLpqwt5lY
         sf864dVMyJu5/mByQyFTtclmtTwOW/tR9DJ53ioEvGAVO2nopYubZU87T6QrCSBVkkHu
         wwFLJss/tCxIqn4Teq4kFtAUTu9O+X+WlPuqG6Efungf9wIwPpJ63Okjyih09dojf9Gl
         SGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792404260; x=1793009060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=MI0kkUEtU0mrwAdNrKDUpJvTECURA3B2HCxSHznx9MNdpL31ywCXkj9BRCp0R1IVe7
         WbvNWmuTqe2+poKypJyqMrq4xi1rdVombCLkt9d19UhMg5oJ2jd+yMdz5/8XFQN8/+HE
         OKcTjp2Mi+SVYdHi5gsg9LmhfQJbllPTb+63Y7jd3AMMzi4y8+IcX/10+r5/s0igtyBK
         VwFF+6p0icGf3Ry5H7EA/SHRAYvF+53urSYyQYRUffZ/zYpVC2mVjW8r4FhagG+YNQT/
         cjrU+RQ3TQantPask700Kuacf+pIMB4IL9JRJAaRxmXIor4zIL2VxJRSd4fcuQWlTzuV
         VEnA==
X-Forwarded-Encrypted: i=1; AKwUvBwMGyE81uuMJ8Tt27DP4gVgEHJsLSpPNt82a3JFIthqoA7n11u3NBP2+Wb+h89448EvQqndb6vLUg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKpCB7KpV3CJ49hf8MxoMfLnQLP5/SpWRRzhJFJXitem7Crd7UZ
	4JBKiHwX050Q7RvS2fz3/yHI5Ogp+C2ZD26yP2yMmHjheCG6LqcguU3e
X-Gm-Gg: AYBFou31PdOhVPWLVXEjohDxwwdxb16D/jdC1riJXv1h7aBXfHU+m93yacNPAhJBd1D
	/xQ7J7yJW6sF3n704zYbEabk7ZK9tTEGYbue3HOzbC1e7xIBQZOMTHACPx2O9pWQlNVvwUOGgMb
	m2gUsrsV1kF4FvbSpnXPq7Erjz8CFBgFswjD1p1X2vK7tD1E4CTNmhiWrN5BT6R/fdvjK+vTZ0s
	wfO9LC514Tq2PDSHcVvI8bChgBouD3wUR0UTlEBqJ3KwunDZVW4lnzKNewAUdYFTxWWzUOsIdI+
	6mnu37J//6/FesSyM5eXT+rvMiV5fjQl+ogW3xxxTNjXVm6U2MK2yH6PSirC6e2YLTd4KzM2uvq
	CejvdYD7LOvZvHxV02ErvdFTwz47YrP8PpqpaLvInjZZo4jp5ez9mZTMHqqsncnv7k1+hKmpKow
	qc2G0/pmZ0euO87InbaMd0FcEKpQG6J1gzpnKtcAERMwaBmdDOHVA2/OXmwuXfnFpn/A9Zr16rw
	3TP67vt6DY8ieQp1pI=
X-Received: by 2002:a05:600c:8b28:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a1d7634d5dmr157311995e9.28.1792404259520;
        Mon, 19 Oct 2026 03:04:19 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1df164777sm177811485e9.5.2026.10.19.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:04:18 -0700 (PDT)
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
Subject: [PATCH v12 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Mon, 19 Oct 2026 13:04:00 +0300
Message-ID: <20261019100406.103687-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019100406.103687-1-clamor95@gmail.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
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

