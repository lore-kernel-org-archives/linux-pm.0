Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DC3D16E2
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443999; cv=none; b=eBDn7gr+pGhm51QJCfO8aj7ksRNJqqd3LgN9WgpSwP/9AOMWRsJFDJKSvACC1LPUxwq8mFHwpDN5poyG0knkvMUSv3YFlJDVVfvZ7NzuoNJ/j+zCuCPRBjy2wqxPNLIexcsDzp/38NrWDxrH2xdZ1awbeVxvvibrsNKnaNcGSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443999; c=relaxed/simple;
	bh=DCs64t6ILvp1G2L1GiCl9DEexyP+6/3Iz6bAhpmkNTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLDudb3DVzd0R3f542U3EIDiZ6khOv5SqcQl3ejfTqOqTnfyoGUiukbjl4sda3uWNiBgc6WVe2PMutHS0yu8kQ9rHV3eu4k7aOrH4mPOIX0CssQ1CE6DYeuJmUxSRgdT09G4u395evW8N6XKXS4CfE+qtJVPMpfd7mX+9iAiyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOy4y46a; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOy4y46a"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad9516a653so12514175ad.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774443997; x=1775048797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2a6VH5mySpW506GVneDmVFhcW10r6kZBilzxo1xGBaY=;
        b=DOy4y46auRf2pARfIaX1XeCOy0cQ/jpoVHCgWOVH8NxJZTBxS0InfgEtM3jjX+HFh0
         G/Y8+to/dBzHqxepuRm8iTA/SyWIHYd1V0pj+bydZ+j52yecRA09ewSIO9Gps98MGwX+
         PboiHv5fw7wdoRubhm3I8EA2/SkJ6Ppf2u077zkh1V9fRvIJ0TBxoFhpbfuWFo4bnHdH
         PANIdg2T6ysrPJM6uaEKOl3TTItiQl22u6L2i83+CYKPxYlL4GvXbncFOZmFjko+wAaq
         +5bKn7C7SriWkNlAX8rn+rB7C5gGiTjebfbcaRBr5g7CYc254e/0DYkdBOuUfm/8SaaB
         4ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774443997; x=1775048797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a6VH5mySpW506GVneDmVFhcW10r6kZBilzxo1xGBaY=;
        b=ec6Pv+2c1LoGqiarnz530eFZZ4DdqUax4lf3xs+CGYG5rvx2PFucxdv+jL5fTmibC9
         Hx1R6Y877Y1wAliYUGMp32WNKepQ+rymrkRESDzvN+2X6qs81cPxST+z2y7EcNoyZ4dy
         pElQELa7nEr3N1vOnUY9fEEyGbOQ4kRm2AOA6PsHvkzarU42DJVAk3HkN9OFpaRigm4t
         FhCHp+9ozUwNT9GYE4EwLpfJ4LFlBUMGiugKYy+mIg/FsXsY+IdFoN8/oA4DVGgP8XsT
         R2fnzl1X6oeJcp/Hj6+cfOAvvilCzQPUt89yQgM219jHT36qgAQjbubx6P7v3aYyfuDu
         YTAw==
X-Forwarded-Encrypted: i=1; AJvYcCUSMfBhW0EewCxXqUUhuDfvxWFVOzQQXu7ARe3lgXx8I6d1LfhZ4cWG/NWm1bYjBpxbF0rgzrP30g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHKH8v2QXFXTYPvTSaRya+CWdaa4+oggmN74RuEDzIs5Bio+8
	Oi01rUesmFLySKUm1VCopvaQBMlXgATeCV9T3SLIQCofBFudcxL4x7Xu
X-Gm-Gg: ATEYQzwuag6qAEHvFpC/2dOYLJuigSXUy/IEk1FrIeOCVsOZ06KAxBJb0TKoCuYMYgz
	Mt9IEFSNVhLpNP/asOEbdx9H2zTuUm0E4aXaa8uOrBdbCwx8sN1QfKBHbHBqoaEtSNVuotItwHZ
	a8gFf1BJYIbLx+dIM5Wp22EscS+XVFjIhm51v6zZcPqfamlKrduJflkvRlxXXrNSjYQLVmF1cTH
	Bhaon+Qa1T0g20SsZdsxeH7oIwmhGJNfz0nUnbBU/McqO6ONEzbuqR24mDc7SMhhIqo5rUS6pzj
	zxM25gVdcjx0JwtyqRSpy1ivfrQJ4AQMatclt753pIKX0+nIaNmfkj0n3ke94dcnJ7TQdEhX2La
	trToVwZ0iCmdV9Zton+gOSH+Oi0VxW35IEJ3oJ0d6l2Mc4/RB6FKznLuvFSLy9Avq/rlnH5j6g5
	Iul1zD9LoYsroohMf/rSurwAoUuKnAvmCKGycqKRT2GVOglq5CZuNVMvSJx8hzFTRCu94OoiJ72
	bA=
X-Received: by 2002:a17:903:1aa5:b0:2ae:8253:1452 with SMTP id d9443c01a7336-2b0b098902dmr38868845ad.11.1774443997437;
        Wed, 25 Mar 2026 06:06:37 -0700 (PDT)
Received: from toolbx.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08369617dsm234356445ad.71.2026.03.25.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:06:35 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	lee@kernel.org,
	conor+dt@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: reset: st: convert to dtschema
Date: Wed, 25 Mar 2026 18:36:21 +0530
Message-ID: <20260325130623.36710-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the STiH4xx reset controller bindings to DT schema.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changes since v1:
- Changed unevaluatedProperties to additionalProperties
- Removed the Suggested-by tags

Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 .../power/reset/st,stih407-restart.yaml       | 31 +++++++++++++++++++
 .../bindings/power/reset/st-reset.txt         | 11 -------
 2 files changed, 31 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/st-reset.txt

diff --git a/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml b/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
new file mode 100644
index 000000000000..0dd7f5e98157
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/st,stih407-restart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST SW reset controller
+
+maintainers:
+  - Lee Jones <lee@kernel.org>
+
+properties:
+  compatible:
+    const: st,stih407-restart
+
+  st,syscfg:
+    description: phandle of the syscfg node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - st,syscfg
+
+additionalProperties: false
+
+examples:
+  - |
+    reset {
+      compatible = "st,stih407-restart";
+      st,syscfg = <&syscfg_sbc_reg>;
+    };
diff --git a/Documentation/devicetree/bindings/power/reset/st-reset.txt b/Documentation/devicetree/bindings/power/reset/st-reset.txt
deleted file mode 100644
index b63948737d80..000000000000
--- a/Documentation/devicetree/bindings/power/reset/st-reset.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-*Device-Tree bindings for ST SW reset functionality
-
-Required properties:
-- compatible: should be "stih407-restart".
-- st,syscfg: should be a phandle of the syscfg node.
-
-Example node:
-	restart {
-		compatible = "st,stih407-restart";
-		st,syscfg = <&syscfg_sbc_reg>;
-	};
-- 
2.52.0

