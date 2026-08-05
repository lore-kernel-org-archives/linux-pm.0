Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28765478859;
	Wed,  5 Aug 2026 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943274; cv=none; b=WRHujBs9xgfEt0gk9Op0hXNRx0xodLqxnVSaK8WCuOTwpnUzpT+EPVP6HXlxmPqmIMQ7aWEgUkwVLjFebc4/y0tqzXiaBSeraEBAjM0i48YqNB15swBOtzV8E46hhdbLySdGHB54dG2suaPJdN1Nb/geZHNRuY2H/5znscQGCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943274; c=relaxed/simple;
	bh=TivlnZRdkebeAmAjJjT4n7r5quvXruztK8/+iVvyBLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4FUVZnsSz8feOrI/qNNXTtbE85PAPz1hr1A4W6kvjVNq9RpOuSgW3g/eTMWzZZyUxwCM7QGQctm7WeI/6SddzQkNbUKPQFnO+r5Kbx9c3bZq73LvQ/rMV06bjJg9sgDsQ62IrA8D1euaYx2EbR3peu/czt22F7WO5Q7C6LWis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB2A1F000E9;
	Wed,  5 Aug 2026 15:21:09 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/6] dt-bindings: power: Document Renesas R-Car X5H Module Controller
Date: Wed,  5 Aug 2026 17:20:50 +0200
Message-ID: <1173a3a32e818befa8d2ede0edda7aa1da82e549.1785941595.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785941595.git.geert+renesas@glider.be>
References: <cover.1785941595.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Renesas R-Car X5H Module Controllers, and add
binding definitions for power domains not backed by registers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v3:
  - Add Reviewed-by, Acked-by,

v2:
  - Clarify the meaning of the two power domain cells and the reset
    cell,
  - Drop R8A78000_MDLC_PD_CMN, as CMN is backed by MDPG bits,
  - Expand MDLC acronym,
  - Add a comment stating that all R8A78000_MDLC_PD_* definitions are
    for always-on power domains,
  - Drop firmware property.
---
 .../bindings/power/renesas,r8a78000-mdlc.yaml | 61 +++++++++++++++++++
 .../dt-bindings/power/renesas,r8a78000-mdlc.h | 15 +++++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
 create mode 100644 include/dt-bindings/power/renesas,r8a78000-mdlc.h

diff --git a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
new file mode 100644
index 0000000000000000..1dba1e1b1c5b52d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/renesas,r8a78000-mdlc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car X5H Module Controller
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+description:
+  Each instance of the R-Car X5H Module Controller (MODULE CONTROL) provides
+  Power Gating for up to 64 Power Domains, and Module Standby and Reset for up
+  to 256 modules in the Power Domain of each Module hierarchy.
+
+properties:
+  compatible:
+    const: renesas,r8a78000-mdlc
+
+  reg:
+    maxItems: 1
+
+  '#power-domain-cells':
+    description: |
+      - The first power domain specifier cell is the power domain part, and
+        must be either the Module Power Domain Gating (MPDG) register index
+        (0x00-0x3f) from the datasheet, for power domains which are backed by
+        MPDG bits and which can be controlled in that manner,  or a Power
+        Domain number, as defined in
+        <dt-bindings/power/renesas,r8a78000-mdlc.h>, for power domains which
+        are always on, and for which there are no MPDG bits to control them.
+
+      - The second power domain specifier cell is the module standby part, and
+        must be the module number (0x00-0xff), composed of the Module System
+        Reset (MSRES) register index in the high nibble, and the Module Reset
+        Destination bitfield index in the low nibble.
+    const: 2
+
+  '#reset-cells':
+    description:
+      The single reset specifier cell must be the module number (0x00-0xff),
+      and thus identical to the second power domain specifier cell.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#power-domain-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    system-controller@c3060000 {
+            compatible = "renesas,r8a78000-mdlc";
+            reg = <0xc3060000 0x1000>;
+            #power-domain-cells = <2>;
+            #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/power/renesas,r8a78000-mdlc.h b/include/dt-bindings/power/renesas,r8a78000-mdlc.h
new file mode 100644
index 0000000000000000..6f3d1ae23648e55b
--- /dev/null
+++ b/include/dt-bindings/power/renesas,r8a78000-mdlc.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026 Glider bv
+ */
+#ifndef __DT_BINDINGS_POWER_RENESAS_R8A78000_MDLC_H__
+#define __DT_BINDINGS_POWER_RENESAS_R8A78000_MDLC_H__
+
+/* R-Car X5H Module Controller Always-On Power Domains */
+
+#define R8A78000_MDLC_PD_AON			0x40
+#define R8A78000_MDLC_PD_SCP			0x41
+#define R8A78000_MDLC_PD_APL			0x42
+#define R8A78000_MDLC_PD_ACL			0x43
+
+#endif /* __DT_BINDINGS_POWER_RENESAS_R8A78000_MDLC_H__ */
-- 
2.43.0

