Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC113FADE2
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161583; cv=none; b=sEvJJF92NOhlQeHCc/tUh+oAn1eqQcAl3By761KnFrxAtAI997uL8kHZT3KCk+kTMSZupg5o9ZrLaybc80duMutN/hhrPyOQmuBfkwUJAA5OzK0Z0oHuwIaVdQg3kaYxQG2gFWmPc/fsqObl+/kwbD7onB1WyW0ecCdUXFNF8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161583; c=relaxed/simple;
	bh=+gXx26kToc5Qsn+X5xpx5KaXlfJuV83OpMJgOHZcMo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSoibWMAtfquDkKZVZR6CT/rBLbbyVWbqRt00hSFBuXxlg0yAF6o2WzzC/FFFKDx6qA6dnlNyh+FGuql+Wau2AY4280b0QdivAEt+OLRzcUBI3Be3nDw58FcHMjcGFzF7rDvyRVsZVnRkc8ZddniNyTUnNmmHH/zf8f5oZD9I0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkgDFTUS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkgDFTUS"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44a5174670eso574604f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161580; x=1778766380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFgTexS82Aes4S2KA8waYF2yU7gR1eiSJ6BQPR26m30=;
        b=FkgDFTUS4VAHCzCXwoib/O1Ujqwk8hb+6wWrorAgdpGuo5UWKX8UPOMIXkH+ZxkweB
         0DeyIPbEZeyiJtTGtHf2GUWIjan7Y7BLIntjZbwDCy4div7L6cDfeV2W4FI0yqxlDSrF
         dz0UmWufE4R6+Zduz2pSgYfjZT1I7PHu2Om6NJyaYHS6h1NIob+F1wt6JOhjMZDJZvXQ
         zVyD6xVAG2ehMU6Lw1te/8tMOqbDBO6nREtN8rmdlaGWpYd8CYRDzjDqszPiMpT25+nZ
         F2RIvu0xDnUkoelxBEMLWhtQUFQ+QU4VqmPRaga8fEuaf8QBdyYlBtsTmDWynzm7yF6g
         J0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161580; x=1778766380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFgTexS82Aes4S2KA8waYF2yU7gR1eiSJ6BQPR26m30=;
        b=Lnd2Z64Q4NyrkltBGyAQiot/Sl5Wp0GocaVNExoMAdh1NEaztG82x29EvYve/bCnuN
         1XJtF3CDIG5PPSm78pyIij1rkJm0/5UJOcFXVauqE1Ah8s9KZjqLRNF9gLa+PMonttHh
         S39d3u1WBqU9jEVgtpgdihjO4w3930ZATpDJRmuILUTEMQewagsGoUt614N7BVfsdWov
         1CzaFZJvTugfen0PJlMPRlkflcWzMz8dlczQTT9myhFa8GpivsOf+4XXsR/6o0rH71IH
         vMpJUUVL65QzG+T6iwh4Tcu4BioyYtBb8VIEOe7k9Tp/OPLJ5DgP9TogKtxxm+ibiIeW
         eF+w==
X-Forwarded-Encrypted: i=1; AFNElJ+mXJ8AXcn2OXvxgXzagTjJmRXoXKc6sfA2IumYfjZCsWI6pkZFgev3//R/R6CnivWEuDvkNVzPIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLVwzFo+JnlBEgnJulqXaFVGL9Li3dDUOtPYv7Q30xZx0KwEL
	/yAWgavzqdjtKn2U5eimp6PWyF2Vr3SrQKu+V/aCQwUYsXDqVlh/reV3gU2ZbA==
X-Gm-Gg: AeBDieuPtVRfWo7kHva5ZV2IfJzzUZYfV/r8v5Posv2ROi24FPuN1zZKfvDrTrZrnIL
	5OCTFwWO+PJ3A42NsvX6CsMx95Ma9G8SVENNh+kc0GnJY+8or89L+2dWyxc/Tmfzhjw9tXaeR9v
	HHHXcWqUw+lVvOFzZZry94q/x/2/0YYGMeoHvxcV5kvrp8SQMW2zJxmMkqnk9plkzZUwZWH/8hx
	ypbZR6Vdkom3Tg1e/gEztOvEiVEJEOTfLhjcjeGmzgUS9tiGciX+RYPmVjgFmIEQY7R8n5wgn32
	aKd79TmelhWihwebQTZ6wVOl4yjb3uSDb6lyln2u0aTnAaQ+jzTnXyZovZayFNtHvTirYjlDrns
	V79lGF/ao+4LzWZtJm4zIpagxiDZRmznvStsSTXaxGtk9u5BVJjtZ30sYUwbmszgwTEQg6YcVlx
	tOAFG1q3rt0rexTOXNrCt55OY=
X-Received: by 2002:a5d:54c9:0:b0:43d:73d4:b34 with SMTP id ffacd0b85a97d-4515b525080mr9703117f8f.16.1778161579065;
        Thu, 07 May 2026 06:46:19 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524833e1sm20701615f8f.2.2026.05.07.06.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:46:18 -0700 (PDT)
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
Subject: [PATCH v4 1/2] dt-bindings: embedded-controller: Document Surface RT EC
Date: Thu,  7 May 2026 16:46:06 +0300
Message-ID: <20260507134608.76222-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507134608.76222-1-clamor95@gmail.com>
References: <20260507134608.76222-1-clamor95@gmail.com>
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

