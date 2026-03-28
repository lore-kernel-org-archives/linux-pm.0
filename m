Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306C10E3
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774702042; cv=none; b=cMS2K3t31TzrwKnWDcn5clWtiKGAH4jejTf7Jy3w9KYzKCRX/3+jxjKiRhNegwF03Rd9x/UpjM/W85C/6rDWlcd3QYcbWfdkeV9STqOrYEnlYQJJZiS2nWl8/aC8eErnT/+2cA6ms8aA5tYQkYlg4njy3uAjO61Jt9U+VCCRbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774702042; c=relaxed/simple;
	bh=AAsVd0O+nkIadn0i0qyJWkXqJrVuhhqichmsUjfNbhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOKkrO3YbHpXl7kWm/1Ks3hB01MmPXrbBM3RNC4pwZV5HValJNEu5DDH4q62aZnY/QPCUboW5vEtRzt9spiQh0c1JiTyPYE2gjAM+s1KunVDJrihQ3NdSrRUnI5jMiR9+R2gV3GCoCC/WMsgfMi0cPdODlAfdDpidbq2g+41MIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXbpedSx; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXbpedSx"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so1098805a12.2
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 05:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774702039; x=1775306839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJkALNXvsl5c9zyK75EzpLXhf7ZTMskMbSq5Dp4tlEg=;
        b=DXbpedSx0Fqfy8sIWubDUymLaakggJ29EBPkdb87bYjZWPqxHOeaTlgwVANRmw76Az
         Gz5RHq7W8rJ3HCozcmeD0aD5C6QmUYZiwhZSWPqEo2yo0K6qSRBz603zvDe/d7QEd8hQ
         8Ps5CGIrjUOLjWRB+xa4jc3piMCwWqwz78J3wNNziWH8WZ0g0ljfnpaYt8PWNnKxRKDu
         JTWi1yzX9WcIVHD2E+8YveFAi2eAVcIqDobKGtU0Y4Hb6IQ3AjZfnycsfvQqQC9EMPfT
         9nRtxktXBa/Y1egS2txJh96/VxczUyaXyw2s97xlYk1ILOfCnYBQarz1ka4IPj2dCi0o
         Uhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774702039; x=1775306839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJkALNXvsl5c9zyK75EzpLXhf7ZTMskMbSq5Dp4tlEg=;
        b=F2DUTjpt0ywaLuvhYKSx5ZhE1jRGAx2NDi6A8Xx8fqcuRSJs7Pffmwv4CkIpotqWCm
         mXmuSZJI3F9zPfsiRd0rUZNfTp7ybU/od37P79ZBXiO8tQpMAMeCH/y9YkKE/KIneBPF
         HMtfMBeSWTVhHmHd2SLOiAKMvU+7qYe5baqjaEup7PIOriAyO5rhxmcxf/BerGugfIUu
         kbUmuXK2EyFe53DTPayaNFFckZ4/MiW8hvthdCh66VuLQ5MyHWwFiN0U0tiX1pYsEbx1
         oX76PvavM/kV/u/9EdCYuPXRi4CRYZseBBaBvosM/bf2wtKe1eefz6MSGIU/pjenaXfg
         raxw==
X-Forwarded-Encrypted: i=1; AJvYcCXJR817BBJkaaNTGigeNOyxa+BcL0aWbaY/IMN3qQSL+cm2+CjHQoBhniCbB0xUXGD/EZfjIMXJjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvWLiwNWqwsr5/P6Q1k9pqVSrj/kQxIheECEloKgFqIUj/4lM
	yzcyseleXa/AE70iiCgT6+ya1uLLDxYzZStz9suo7Bg3d3vC1vXJZVWj
X-Gm-Gg: ATEYQzyNRIW15692tpCWZGnf87zlVl0H5GbJGvV7lom//C4nRiLgzja45TYnsFgXZCp
	VKDi6se+p9PUTspTOx4F7WQql2MYnmYqb3JCPbDP4QYpa2XDYLUCtVce8hq78nDUG/CfhSIiWHq
	utFD6FJ7rVWfz2KfNt2Jck0IbDqBLhi2dxmcd+ej1asIg7kp4uliMHx2zjdlstf5Ab8T4XimfiN
	TFEb8jMRMPvFDMmQNpXBSvi33MhpXvGh5ZoPDJdAmOAZ5Y2RhGaFQL5jldSyBI+juLdBfQigCGS
	oBYQWSlUz5JyzPTn411YrgryJ0y1teZ1pWnU2lJ9nDrHw167GKVC9i2R2jZvv8vvxL3Bx03Nxkf
	3cFW7Kl8XujgKFYwnxenytloJy7IWj17ANYdsa0lsaYjN25n4S5upn9ia5awq5VP9mcBviVmImE
	rMAaiksmuw32JmyxskHFdbdlSr5Hyi
X-Received: by 2002:a17:902:ea08:b0:2b0:ba14:fc70 with SMTP id d9443c01a7336-2b0cdd91799mr68182835ad.42.1774702038938;
        Sat, 28 Mar 2026 05:47:18 -0700 (PDT)
Received: from snowman ([2401:4900:614d:8d5a:ad19:1381:7561:e82f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c769179e30dsm1791970a12.20.2026.03.28.05.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 05:47:18 -0700 (PDT)
From: Khushal Chitturi <khushalchitturi@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <khushalchitturi@gmail.com>
Subject: [PATCH] dt-bindings: power: reset: cortina,gemini-power-controller: convert to DT schema
Date: Sat, 28 Mar 2026 18:17:07 +0530
Message-ID: <20260328124707.141209-1-khushalchitturi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Cortina Systems Gemini Poweroff Controller bindings to
DT schema.

Signed-off-by: Khushal Chitturi <khushalchitturi@gmail.com>
---
Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 .../cortina,gemini-power-controller.yaml      | 42 +++++++++++++++++++
 .../bindings/power/reset/gemini-poweroff.txt  | 17 --------
 2 files changed, 42 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml b/Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
new file mode 100644
index 000000000000..1f9af7f34004
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/cortina,gemini-power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems Gemini Poweroff Controller
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+
+description: |
+  The Gemini power controller is a dedicated IP block in the Cortina Gemini SoC that
+  controls system power-down operations.
+
+properties:
+  compatible:
+    const: cortina,gemini-power-controller
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    power-controller@4b000000 {
+      compatible = "cortina,gemini-power-controller";
+      reg = <0x4b000000 0x100>;
+      interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt
deleted file mode 100644
index 7fec3e100214..000000000000
--- a/Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* Device-Tree bindings for Cortina Systems Gemini Poweroff
-
-This is a special IP block in the Cortina Gemini SoC that only
-deals with different ways to power the system down.
-
-Required properties:
-- compatible: should be "cortina,gemini-power-controller"
-- reg: should contain the physical memory base and size
-- interrupts: should contain the power management interrupt
-
-Example:
-
-power-controller@4b000000 {
-	compatible = "cortina,gemini-power-controller";
-	reg = <0x4b000000 0x100>;
-	interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
-};
-- 
2.53.0

