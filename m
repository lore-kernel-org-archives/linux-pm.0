Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA536C0CA
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787713; cv=none; b=TIF/lyTU43Cv+2ov9ENKhMbI6dDsWPd7PrzauD91BjCNFxFTNvb/R3uLuIymS10zFFji0k+gs22DjR35CHK54bGpT9AkTzwUxh4BKsiNsEXQJQkFVdt4S4X2/LGTTghC/umzVRImfxZV0UfUFgEE/JzUK8YvG6cIHmcEP2xVuz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787713; c=relaxed/simple;
	bh=Z3qCgdReWQ1prJb0XmYEgTOQ/bvofKyS6Un91gtBtJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFLL3H8ZKc7PPfwga6J0ZPegt2VUC+QcrqXy6uerXQP5zMu9O1uGwQ2vwRU6rzTKpE3qFP0gRtymBzpC3mFJI8chF9EJ0HCs5V1/C8U92ceKHd9yQ6aepuxy4CT7jVxoncrYevwy4fooFCrqqwTXTH/Cb7XrnyqrXL9Z3DRFqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXncDH9W; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXncDH9W"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1463056a12.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774787711; x=1775392511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tLsn8hpa4BdCwst8VwbSLWHz/M72CzfhEMC9Z3GeEs=;
        b=BXncDH9W3zj+WaCTqor75xZHyvDsNzpEiElUC+59+6FJlUjBgUboRLknZzBNFNJKGO
         5nn2O3fKxIgFmkdQSxJGW/48IO1x2n2k9RZbkhKRLWD8EhXFHVWsUDVXLIVB7x0ntwcL
         /v8tkPkHunMEaSZCvENjj9uW9iSm0IjBCwdSnZMymhxnz7ep5D7mp+g3zD/zuh8wJIkn
         7k/0O8RadGm3nr/vCH7Cn52+aKFRWDUq21EHgcawyEFIz/Vi9YKA2AUAnXLPVybJ24kh
         xRkE+Wnj1f0g7n38PWVBhHKOmVs6NPJ1XLfI/tF9/WZiASAe9P5fiJC9ZGS06vDJjpk+
         YpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774787711; x=1775392511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7tLsn8hpa4BdCwst8VwbSLWHz/M72CzfhEMC9Z3GeEs=;
        b=ZLkkFfKA6o79Pk9wrOLl867DpCQrRyiT+sRcKs1/nknUSUpYVbgW0Yle+Xty5XkCOe
         C7bYnAt5HjzcglumGH1vtBilW/vEkfW95oGVBtFvt8ZFfQM/rU7iYpBg5n0xXWYVuegE
         SQpykRvrDzAhy/8Y3vlGwbmIQdNuWHfWWtdxeuWPMN1vvE5BmNuRvGxD1tM4BRW4trwo
         fDjmqCiAA8ZTTI3RuWeZ3XxCPqiDo4Im6i3fDKfd62qD4n1AIiL7Zg/WF7ZWAJ+HJ8zH
         08ewDLPWYOTYBLpG52EfZZRU22Qt1+qfWssO2VpH/1c4lQguhW1jPudKDL6DstqHutL1
         gs9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcfhK4BuMRSAXt6l2PCoiluBzV56mKNwzTPlrV2mwYXFL+RqS/cNmAGP2+b7JfVbE68ulGyyCEiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFXgt9cqixDxYrIz/Nf/DSuMZuwvEhBsOXv0CXKw1GHF3/N8l
	MoKZfTiVgVioBuf7PouNT/mgAg9uat2ZYY6PZJM47zynbC4Ge5OTmj+e
X-Gm-Gg: ATEYQzwDvX8DdQLxyAZpVGzHxHoznLvItYJoP0tfGwj48sSxb1356WeaMx3X/pX5Z95
	h453ZDY6Vkj0KrexhUgh7pZiMsyd+4hYxp8JQSyykssJF3VrU5jivQEYl6XAgFR8qYUFru0Sfhe
	r2jVal9VBEGAClA+1kopFrmCTfaooFO0C6uFG+A0ioVQg0Q/HCBo6iUyR46n5ajY949DelPn3U9
	ViXYpS5qTvco1NT6adruAnwWSLaOiR+PLt/oQQxabWebtinJy+rtoCYjWA1SV2CSJtL7jMg6p/c
	uXunYy+leXSQxRPCm6cRWnqfLyoCFQJ5xBM5LF/epTcSUYJkowjTn/JaQs52VC5jgg0DuCy8zKC
	B2fD/TPB+VscU5dhRuHcMxNeJfJLPh1N1L0Gy54B9neX6Ub2937fGEY/u3c+V0OLq/fhwz2fcL/
	lmwVU50InBJ/zSHXYQ9YMf9GD7Oq+/XTTtbmKmSSfZLccLS2f3ThcB0Y/xDn42JZ63zQ7kwaKjG
	Qc=
X-Received: by 2002:a17:902:d588:b0:2b0:6e60:9582 with SMTP id d9443c01a7336-2b0cdc48fbfmr101671395ad.18.1774787711463;
        Sun, 29 Mar 2026 05:35:11 -0700 (PDT)
Received: from toolbx.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afbe0sm58709665ad.72.2026.03.29.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:35:10 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	vireshk@kernel.org,
	conor+dt@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	soc@lists.linux.dev,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
Date: Sun, 29 Mar 2026 18:04:43 +0530
Message-ID: <20260329123449.309814-2-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260329123449.309814-1-krishnagopi487@gmail.com>
References: <20260329123449.309814-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the SPEAr Thermal Sensor bindings to DT schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changes since v2:
- No changes
Changes since v1:
- Changed unevaluatedProperties to additionalProperties in the binding
- Reword the commit message and subject in the second patch

Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 .../bindings/thermal/spear-thermal.txt        | 14 --------
 .../thermal/st,thermal-spear1340.yaml         | 36 +++++++++++++++++++
 2 files changed, 36 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/spear-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml

diff --git a/Documentation/devicetree/bindings/thermal/spear-thermal.txt b/Documentation/devicetree/bindings/thermal/spear-thermal.txt
deleted file mode 100644
index 93e3b67c102d..000000000000
--- a/Documentation/devicetree/bindings/thermal/spear-thermal.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-* SPEAr Thermal
-
-Required properties:
-- compatible : "st,thermal-spear1340"
-- reg : Address range of the thermal registers
-- st,thermal-flags: flags used to enable thermal sensor
-
-Example:
-
-	thermal@fc000000 {
-		compatible = "st,thermal-spear1340";
-		reg = <0xfc000000 0x1000>;
-		st,thermal-flags = <0x7000>;
-	};
diff --git a/Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml b/Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml
new file mode 100644
index 000000000000..e3462a974691
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/st,thermal-spear1340.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPEAr Thermal Sensor
+
+maintainers:
+  - Viresh Kumar <vireshk@kernel.org>
+
+properties:
+  compatible:
+    const: st,thermal-spear1340
+
+  reg:
+    maxItems: 1
+
+  st,thermal-flags:
+    description: flags used to enable thermal sensor
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - st,thermal-flags
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal@fc000000 {
+      compatible = "st,thermal-spear1340";
+      reg = <0xfc000000 0x1000>;
+      st,thermal-flags = <0x7000>;
+    };
-- 
2.52.0

