Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7D1ACED5;
	Wed,  5 Aug 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943270; cv=none; b=TGFdMQ3fojdO6vSHqZ+ulDBh+hO4pWVtSQaJf+aDg0Z1J3alS87lqU3yMoPzwnKu2oueBEKsHSFGltFps6RaGKoQszg81FX5mtT60QYfEHi608zv/QQl1WHSW49rlr/Rofd8ixfNY9nIKsl7UQUgvFuu5YQ+zazeJb9advgt498=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943270; c=relaxed/simple;
	bh=b/ioUMqrpQtpju97vaf3OSPM0DlD2QUKdDEN7m06sbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHc28DvscIOv6GMFqq/pd+MBXRbvkskdrH3ivyZD18UQKo8XE7UnbH6nD/RH1ep+yG7OqaNN9/CBffF91v4EWhn/u1YKPllH7RFSpVob90kiWBbXxoplaTDgZytLoWg4AOjvmYfPkNLxIxXXGBrbOHn2retllhfSg8d+iC0TMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1D41F00A3A;
	Wed,  5 Aug 2026 15:21:04 +0000 (UTC)
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
Subject: [PATCH v3 1/6] dt-bindings: clock: Document Renesas R-Car X5H Clock Pulse Generator
Date: Wed,  5 Aug 2026 17:20:49 +0200
Message-ID: <7a33c99816c850faeec5c17532811faf78959a1d.1785941595.git.geert+renesas@glider.be>
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

Document support for the Renesas R-Car X5H Clock Pulse Generator, and
add binding definitions for a limited initial set of clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v3:
  - Add Acked-by,

v2:
  - Add Reviewed-by, Tested-by,
  - Drop preliminary,
  - Expand CPG acronym,
  - Drop R8A78000_CPG_MSOCK_PERW_BUS,
  - Add R8A78000_CPG_SGASYNCD8_PERW_BUS, to avoid holes in the
    SGASYNCDn_PERW_BUS sequence,
  - Drop firmware property.
---
 .../bindings/clock/renesas,r8a78000-cpg.yaml  | 55 +++++++++++++++++++
 .../dt-bindings/clock/renesas,r8a78000-cpg.h  | 14 +++++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
 create mode 100644 include/dt-bindings/clock/renesas,r8a78000-cpg.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
new file mode 100644
index 0000000000000000..4e23bba334382346
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,r8a78000-cpg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car X5H Clock Pulse Generator
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+description:
+  The R-Car X5H Clock Pulse Generator (CLK CONTROL) consists of oscillators,
+  PLL circuits, clock dividers and clock control circuits.  It provides various
+  clocks for other modules.
+
+properties:
+  compatible:
+    const: renesas,r8a78000-cpg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: extal
+      - const: extalr
+
+  '#clock-cells':
+    description:
+      The single clock specifier cell must be the clock number, as defined in
+      <dt-bindings/clock/renesas,r8a78000-cpg.h>.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@c1320000 {
+            compatible = "renesas,r8a78000-cpg";
+            reg = <0xc1320000 0x10000>;
+            clocks = <&extal_clk>, <&extalr_clk>;
+            clock-names = "extal", "extalr";
+            #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/renesas,r8a78000-cpg.h b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
new file mode 100644
index 0000000000000000..7fd09a3fb353d952
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026 Glider bv
+ */
+#ifndef __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__
+#define __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__
+
+/* R-Car X5H Clock Pulse Generator Clocks */
+
+#define R8A78000_CPG_SGASYNCD4_PERW_BUS		0
+#define R8A78000_CPG_SGASYNCD8_PERW_BUS		1
+#define R8A78000_CPG_SGASYNCD16_PERW_BUS	2
+
+#endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__ */
-- 
2.43.0

