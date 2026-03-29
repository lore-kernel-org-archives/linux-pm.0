Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3B2BE7AB
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774764949; cv=none; b=G1pmIb7lm27KY5egaq5DWF5eorZbrKUmGtN8TgP5qkxouT5VXe3uHKZmBoQZi730cUq3fysYWQuE+mVA/Omn+bmciqhT5PZYFrVk2JK12U1YC3UhZ90TvNetaUUG4pKWuh9Wd3JL4F660tnfo/7yEmE96FrnYePO3bgZuISXDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774764949; c=relaxed/simple;
	bh=2otHkcmCT9w8sLLXpwrGseCnidGp/GU8lh5rUN96wp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhmZCcevWdPT6Fco5f84NLcRDMHTNS9k9aFHBVbyyJVxFfGZlfqfomTXad74lJXT5pFslhxF2VslcUDNJ5eoV6d+qW42ea47QBjiYlsd5Xrt8MpiOW4il5GLh99jlhIQPWlsg96bdQoQKDqFLH9ESMb0vPAKQQII+maT7/HXgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt0EuAwl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt0EuAwl"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so1576105b3a.3
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774764947; x=1775369747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyUhv8dZe5OountEy6t4pKCcPVDlgAwS0iiOUhBetOM=;
        b=gt0EuAwl2QTwnnFrDZdN0XF+Fg/Gj3mNudO7d8wW7LU++uFc6JPWThIFiYlTPMuQjN
         XhIUW1Zg3zGx2S1R0IFPY6tEF7o6cTxYmFr8lfY8fzuMd1UgNNLvyh7YotWVmN7cdviE
         B04J0tEMoGAeQnVghLlJqa+E6CmFTeKlLjbqdgpvOBd6WcZFsEpE6mLfMBbozFJ+GG+o
         29EYcprqW1bQkV7hn516WfHSxACZ/bI28wuGwnKg0kLYuTK6IGZFf+R1cVVQ9erpfsny
         8W/dcZ28AVurzO92Ror/AfMkWIshe3pwisKPBwUmE0RA2jwv0DKHi1pmvVjDOOF1eB+V
         kDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774764947; x=1775369747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PyUhv8dZe5OountEy6t4pKCcPVDlgAwS0iiOUhBetOM=;
        b=OFrHqAP25JF3uOwC4wBBm+cl3XEDaIYCavgjUrNXF88umhRDgMotjvLt5v7JMDqzwN
         P0L0RSNu7+TZtRofDdStCsFgaHenS7a0O4Yrc7mB4A1RQgRblAK2JR6hwZcivO2GxuEO
         PnSait3YT0znbRZTN9zQ2lhx9eWMoMqCYYU92LxXncU4f3nhg+JYxXwW6Vftw5tIH8fm
         9kS4yyxFQKZs9Av12kVKSagNT8E9TwCJ8Ln8f/ShykHK9mCbkdVQphcbudcKCW/qvP1i
         p/zD4Me4XogfXdsXuiVnbVUWvRqebO3bxhjXGnIrElPADLG4Xd6+snSjFbtp64cqo2xd
         GIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkOSozjUjPOCK8p51gLufUF3/62OVMvXwNAHvseeKURTspefIXrephqYvuA1XGm64AOySxTGuOPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymoK/yJ927RE2HiVKCROc/w2fgEHMgAguuyZ2CSFTgr84jLlnj
	+KGoLs0Idzpw79W2zA2Xf/E3j2QrdFbaYBsN9dfylNig17Hfly2akkIa
X-Gm-Gg: ATEYQzwQfpAXFUZJNaNObxwEIp2s36uc7EA1OaSa6mgMXHvZiDBXoJaSjX4PFLD4rnz
	Lx0yexmKfC/ZXu6Ib6zth+wHQJgsWVQmLH9lLZNKgOaQtsmmLXsfDHSsRQbdN8qSijxOgUlTvSh
	nBoOB/UqI8BjiTUcduhbZxbnZixKVBbpwL9S6ICRjvSbed6Gr68jKVwR3aieX74zaPcpEyEd9EO
	LDkRB+fpwv0Hxyx9rPGQ5xCw7tTWTZ85R05hYeFN4sk0cgL/No3X6mfkn9X164vJakec/Z5lZ1o
	t6IWisU9x9GqKvn+G924Mx5eW71LZRyHB1/fa90vQonvNCz//54cyjlVDNfHrngC0hqplemd2sC
	QdLwEaM3WXUIsx/J23Fz/ngXRYu5pq+Tjmwhs9wAQKB+G1X2Flv3P6X87Qqde/9m4Rp0R2tLe/+
	MVCvAFbLCV7dc93kfLaVXeL55T49PuUbBRL3ms3mQ81kAynjSdgd4Oan/2+4THKo78YKd8db/pY
	T0=
X-Received: by 2002:a05:6a00:2d27:b0:82a:1337:493c with SMTP id d2e1a72fcca58-82c95e9559amr7945631b3a.14.1774764946822;
        Sat, 28 Mar 2026 23:15:46 -0700 (PDT)
Received: from toolbx.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8436f19sm3709731b3a.9.2026.03.28.23.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 23:15:46 -0700 (PDT)
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
	m-chawdhry@ti.com
Subject: [PATCH v2 1/2] dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
Date: Sun, 29 Mar 2026 11:45:19 +0530
Message-ID: <20260329061523.98346-2-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260329061523.98346-1-krishnagopi487@gmail.com>
References: <20260329061523.98346-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the SPEAr Thermal Sensor bindings to DT schema.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changes since v1:
- Changed unevaluatedProperties to additionalProperties

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

