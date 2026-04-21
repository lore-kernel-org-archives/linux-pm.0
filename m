Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA30347BC6;
	Tue, 21 Apr 2026 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795163; cv=none; b=ab81uiH6v9P7xcCkrruwffknFz+pRPgw6I2yvjrQ8a/jcG/sL4r+sDFSAZhrIRNLMGDnGZsVidItmb5KBB5A79HXBunSRojZOD+zDPjfNifTohkJ0oIH1s86PkYvgv4WcXXBt50T29bbdUsU4oz10CXOrtzRwUNCShQwSQANBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795163; c=relaxed/simple;
	bh=CrSp/pZoa+rfAfIByGc+fsW1M4yQUQHnQztAQ+i9N9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqK3aiOxQxIUiiKKMtA8qhs50tTwZ4pyoyfiMZnqVd6MCREL2YhBOfVzjqY1aBEhMUrww1HhE1qG7ODXp1ggJc1sAbMHmzEwra07qbmUZI8vi+4i4xV9TqA9Ndg7NmMntaBYGdpBVywweSKJql73ROHe9vUc4oCGuDM68YDcOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC01C2BCB4;
	Tue, 21 Apr 2026 18:12:38 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 09/14] dt-bindings: clock: Document Renesas R-Car X5H Clock Pulse Generator
Date: Tue, 21 Apr 2026 20:11:42 +0200
Message-ID: <f8c98dbf6b32c0d467606d59b071e9c2bfc29dbc.1776793163.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776793163.git.geert+renesas@glider.be>
References: <cover.1776793163.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for the Renesas R-Car X5H Clock Pulse Generator,
and add definitions for a very limited and preliminary set of clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/clock/renesas,r8a78000-cpg.yaml  | 62 +++++++++++++++++++
 .../dt-bindings/clock/renesas,r8a78000-cpg.h  | 15 +++++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
 create mode 100644 include/dt-bindings/clock/renesas,r8a78000-cpg.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
new file mode 100644
index 0000000000000000..fc499e7cf52e4f0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
@@ -0,0 +1,62 @@
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
+  firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Reference to the SCMI firmware device node on systems where SCMI must be
+      used instead of direct hardware access.
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
+            firmware = <&scmi>;
+    };
diff --git a/include/dt-bindings/clock/renesas,r8a78000-cpg.h b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
new file mode 100644
index 0000000000000000..8c8bc4d1feac6d26
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026 Glider bv
+ */
+#ifndef __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__
+#define __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__
+
+/* R-Car X5H CPG Clocks */
+
+// FIXME Preliminary
+#define R8A78000_CPG_SGASYNCD4_PERW_BUS		0
+#define R8A78000_CPG_SGASYNCD16_PERW_BUS	1
+#define R8A78000_CPG_MSOCK_PERW_BUS		2
+
+#endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__ */
-- 
2.43.0

