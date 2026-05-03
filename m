Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431B372EF5
	for <linux-pm@vger.kernel.org>; Sun,  3 May 2026 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827410; cv=none; b=ujy6dsOixdMQtpQOsg2g1G+orMbjZtRu71wgwwmGxSm8bWMVTO9ZTtLMYMFn3vrrHk0P8PcUbeBCOpj+bvmUgw1XjvyK5cxj7Cm6aT9o24Ao7+yakZNp6h66ykrhd/tj6YWEiBQI+y6j2buBerB12j2qv4mzpr2sgqKyu+DZ0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827410; c=relaxed/simple;
	bh=+gXx26kToc5Qsn+X5xpx5KaXlfJuV83OpMJgOHZcMo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVzaixFWY/dUeXN835ASp0+fzjhvR3UcyYr3g+8nCqZts8JeEjDEzUhRheaXaOo3DPyVCOOoU6Nuq9QxUBA9NZsLmeoQAF56UNApLiIox5D+/6vD5Sbp5ppnt9Zzx0QUNjWr+Ux1D/87bI8c5S0ktYtPhHh+XpOxpLj00gOhj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9DgrVZm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9DgrVZm"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso3592549a12.2
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777827407; x=1778432207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFgTexS82Aes4S2KA8waYF2yU7gR1eiSJ6BQPR26m30=;
        b=q9DgrVZmybj2oRjUyU/JHYTQQmlcwp5G5MAk5cXWeS3DGHHhA1jOu5+BLMf2SVf9r0
         zNNYY+Yy3nuAN9PxQQ5UF9evxs/mXO9XXInw/51MZ/JpbNsn3XIVvCQXfe172mbs1bca
         I1mLrhZiWMg0w0rN/n5fHa1bvuuYIxST+Z34WJy/NPZ/KovTC9mv9c92uHBQBChDcXnO
         chAMG1hkDobbRuyGkePHt6w2R1Y1nqY9RfAPsaIqte5z/qFZwWnrEGBrArfsh5+ExWcK
         CrgA8ZCX4YjhKTYirHgFbYCmOBvi8i3e1uskp8CeErvcWcIQlWIkvkoLUqd2B7W0t33I
         5ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827407; x=1778432207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFgTexS82Aes4S2KA8waYF2yU7gR1eiSJ6BQPR26m30=;
        b=U+5Gb1GPv0InVw4immB0OvDjBLz+JFzB73BS/P8dXAyJZGvr5Bc4+PNnM/z9vsbHh8
         RYzI8qF4G7Ukq18RTGk3W3OoYtRj9aJiQlCYWZZi7IstgOdJSrm0EJiaBpVOvtWlXrLR
         Sj8ip6HUc7+xrsniel6tMhct199Q1rkaM/gl2tdKAJzzSykW3rUhSVDzRCNahv/gO160
         9zP1ravebw4OMgE3GbMBn/Hk4g7bhnmMcrmP9Dncf4Zh+qFBvdFWQrSXTmfJh9BbzvoJ
         wUqXgV4Hn6LzOBRhCwV7FqmE00jeRhuJSBK2wZx+T0ig8NLt1bCfjQ3nhGK/P38ZFzLE
         ytLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9U52s9/aJo4qxSfJ/id3ZXGOjF1ry3P20ubJAshW5aCONrTQpvtH4dkG1YgWkWfRd0JRBFH/s19A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyteUB31wo/Yxb4v2n1PKyaEawL0U32Q6JOZs3iqwGGZymKE+Cd
	OTDpwapsd6xzb5xa8tqd40LQ2CBMlhG1/+kY3RbZ6teST51pa4cZJItm
X-Gm-Gg: AeBDievsMCTQ5Y78Ho4i36iSGwevSHhNKHO2fpOfDmY9cBipVfJ+xWjsg74idXL1EyO
	UG+DdbW/Wk0So6av0nCYYJePa9pe25JhqAkfxIWFxTVcnWndGgC4ZYVir+IojycGE8oM92ceGDv
	ZkzCltGCCx8NoYGLwetMt6fCDvdkeNa4FYDpOKm8bFVV1AtrzCfS21OdjiMpxKpNLEBCAFWzeBC
	ddXUzaY6OlmuN0x18gSNhl7wUa624DP++gVmBEQdIbCRWtNWau04TLJU/oqBCMcpmblPC+dh1Xf
	vFnISBixUwt5A6DvuTlnd6sp9hK5+wVzu3Fl76Ld5QG2Li7Kpq+or4C3KHOdAJqSamWKQ3hMhq0
	+BtzuuMG1p4DE9OgQZz2WCEfghk6raqpUocTG1VKC1KMsrMLsVV7fnRlR+lCDpNqzmhjUIuwy76
	mf/i7hlDIUcb2CqGDy9l+FTf0=
X-Received: by 2002:a05:6402:2b98:b0:676:d8df:f8c1 with SMTP id 4fb4d7f45d1cf-67c1b2a2c9emr2670164a12.22.1777827406947;
        Sun, 03 May 2026 09:56:46 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b8579891fsm2713649a12.0.2026.05.03.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:56:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: embedded-controller: Document Surface RT EC
Date: Sun,  3 May 2026 19:56:33 +0300
Message-ID: <20260503165636.216257-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503165636.216257-1-clamor95@gmail.com>
References: <20260503165636.216257-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document Embedded Controller used in Microsoft Surface RT tablets for
monitoring battery properties and charger status.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../microsoft,surface-rt-ec.yaml              | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml
new file mode 100644
index 000000000000..0fee574a3015
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/embedded-controller/microsoft,surface-rt-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsoft Surface RT fuel gauge and charger EC
+
+maintainers:
+  - Jonas Schwöbel <jonasschwoebel@yahoo.de>
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  An Embedded Controller used in Microsoft Surface RT for monitoring
+  battery properties and charger status.
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml#
+
+properties:
+  compatible:
+    const: microsoft,surface-rt-ec
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+
+  monitored-battery: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - enable-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@a {
+            compatible = "microsoft,surface-rt-ec";
+            reg = <0x0a>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <74 IRQ_TYPE_EDGE_RISING>;
+
+            enable-gpios = <&gpio 88 GPIO_ACTIVE_HIGH>;
+            monitored-battery = <&battery>;
+        };
+    };
+...
-- 
2.51.0

