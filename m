Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E6379ED6
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774817542; cv=none; b=tbGWyLEs2djrMJt1iQ316D6xr0mKDzrihXSpmgEPpwgT4Sj8LHHpRXKR2yZIa15RUwH2LJ8s5YkjCSFnnrInlaWSHyXRl4cC9cE2sSf/CiuWiVesZz42mnma1KDCNRnhrpP9jiJdtjEFzV9aIoUw3/IVNAr6Bx36PM/L6Od0kb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774817542; c=relaxed/simple;
	bh=5wB2jRWrDf34Wq2yXZveYEIfG5TX6LXKr04QZfDaEM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdylEGTS+fch72jYn9LU0oOpzeq+Jc7/NAbmSJsWZdu++J9a2V9vlLLVz5Ynr4Sx0e33XeHAngmyDAKPIaVRnqw/9PrzN0Oksk74i8nAo3YCCOWYOPEZBuEDciPkPSuwheqkQ9Cva1o+9tzPoYcJArOv6vlli62jWnr5pZUZp80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkVcj4tf; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkVcj4tf"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so629225a91.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774817540; x=1775422340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4Cow+KHFKRG5kiCnQkhdbidV9anmjbpMjKgFHIwing=;
        b=CkVcj4tfDurUray//vbYq5QklNe6tQseVqX+BPTMLzCkSg1pwh0fJErDkw4Nsigx4G
         MNAeXvvDOoEQFlaoR41EI0VM2Qp0AeX1ZPC4u8OTvi4FjkwfsmqkRfw2v3ov9Y6q06F3
         9h55t3FgTh9EfpBsWWXafLjcmn2dsgAlzsFc5KSchAsICDeJ1mfbMS148VUlVwbXeZtP
         +4Y9lIIOAcwiUSefvWWKk4XZNEiqDeJ77R7Ro+kqk3qZay7lwyD0fBmottvNtfMnocz8
         Kb8jaAI3bSyefU3n0PXzZDWxek36D5NGz2FxaXDfdsxipi6HlQL+sS+u3/LZCT7E1cgb
         SSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774817540; x=1775422340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M4Cow+KHFKRG5kiCnQkhdbidV9anmjbpMjKgFHIwing=;
        b=L2Hi4kbkrnN8B5zsjLs56Ielx4hk2uBkBmdOmQbzxwNWPDlavWGewpajq8LKJduQ2k
         sYAuvx5nIEJsWEpbOfm7xYg3TIbF8hLTGrGFjT0APsr6tc0dAzD3nL8ikw2il2HeIDE8
         2lv0MZ1Ew0z0loKpA4aqvdC9DKh1wXctBZkRMA3CwyNqnbt3OJ46gSrqhXVRMiK4Atjq
         GPcCPF5ZvwN8sZ6s1/qMJjeoAbcQogFyrGyf7GX2tcE2Eofa/TqmFkA8JackvYBsbXAW
         7HYiwXK5ddapuVPH3og1bIEFKJrGeoqOJN3BqiLOwNvyi1G+c3k3erjosCjzTk5BDJd/
         44Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVS2P4fh3qFSQic63lNgFncjyRRGWGOhsG6Mu85D3aTqf1AI55WL0KTIG1FXzZEXkSW6hUUcRRGpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaigkrK+R3OboBzMLKe9ibKP37pIRB4gsPeMQuMoPfWa1AU7O
	RuNYCxhJdn8XsFxa1sFMlfJVhCx2LYaHjObwdXCHSWT+5D8sp2HdZETCFJjrCQ==
X-Gm-Gg: ATEYQzyHYydZHen7HgheCcYOtYVYlXL1WWKHZn82d6RJS9FvDMbaqpmvq2bYnYH7lvO
	Wmnw9oOr/PfcIVXq+Z5BNzgUSmRL9AlrpGNFIJExeqvSSi8OvbEogeeT1arr3HdGs/G3FGEID5d
	SBLSYJV37FB9Cv2kaUJw1J1Osk5gZYgZ5ANea3maq1Fso3NJube5csvUv2ztMZkvMl1aQx/3/yl
	LxnZ7mjMCTh83C1f8hTDKZ0hUcHgYrQVDL9DG35zPgXeRVmY+VICMP7xXG4Ej95+Xexc86Nw7bm
	1jMvFI5LeosLO/k4W+QhXibVbaCTqDLqIYFl4ADl0bPlmGHD3FLx6tbXzyL4HmqnjGAqBOQSjLL
	/HOSaT77L+wjP6zVIheU5PQakk6J3id9gZ0nMDXQicNkXvxHHDORW1gkdtSzHw8XZwwG2Ul2jfG
	Jskw5nFJSpY6JF5QH1XlR+e48/pCIs
X-Received: by 2002:a17:90a:e7c1:b0:35d:a276:a87d with SMTP id 98e67ed59e1d1-35da276afa0mr2577266a91.27.1774817540473;
        Sun, 29 Mar 2026 13:52:20 -0700 (PDT)
Received: from snowman ([2401:4900:646d:9af6:7748:701:6c70:4173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22d8c500sm10423412a91.10.2026.03.29.13.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 13:52:19 -0700 (PDT)
From: Khushal Chitturi <khushalchitturi@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulli.kroll@googlemail.com,
	linusw@kernel.org
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <khushalchitturi@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: power: reset: cortina,gemini-power-controller: convert to DT schema
Date: Mon, 30 Mar 2026 02:21:50 +0530
Message-ID: <20260329205151.15161-2-khushalchitturi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329205151.15161-1-khushalchitturi@gmail.com>
References: <20260329205151.15161-1-khushalchitturi@gmail.com>
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
Changelog:
v1 -> v2:
- Renamed the node from power-controller to gemini-poweroff to resolve dtschema warnings.

Note:
* This patch series is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 .../cortina,gemini-power-controller.yaml      | 42 +++++++++++++++++++
 .../bindings/power/reset/gemini-poweroff.txt  | 17 --------
 2 files changed, 42 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml b/Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
new file mode 100644
index 000000000000..8fbe7e952b25
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
+    gemini-poweroff@4b000000 {
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

