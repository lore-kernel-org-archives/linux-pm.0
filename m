Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F4420475;
	Wed,  5 Aug 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943290; cv=none; b=sAZypnFIltG1vItDnnrAuFCRaM7geeo4hqIaBpkYVOX4hJ1yh7fOgGsZ1ONV9cOB9wlNr6R7QL31Py1qvf22WvUX44IEBIdS5AST8qaOBbKOn4wXIM7hHR0IA9tVk7SIJlVbXrrEMiBFDbC1nKehC1QNN2FUoLr3G3JvAnothOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943290; c=relaxed/simple;
	bh=I0J+MWKiWSED1BqPpMHg3NeQTQNNwiOeUyWs5x1YkOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBoipKSnzz+HvSkMTh5BygrGU/58MfxdmoZKtCtCVYRxTeA+bfUaYZ04CfqGoKnVUmxPAQwTdzGmv2OMinhwlkhJZA61os786J9i5aEPID2JMUemHbOp+cdrCnp7Tj45mt31BjgL6ixUvT1i5rulxllDOhX4MMHp+BRCZdLBwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2B11F00A3D;
	Wed,  5 Aug 2026 15:21:25 +0000 (UTC)
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
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 6/6] arm64: dts: renesas: r8a78000: Add MDLC nodes
Date: Wed,  5 Aug 2026 17:20:54 +0200
Message-ID: <9b7f96352ef5fe08e7003169710a9af874fccb68.1785941595.git.geert+renesas@glider.be>
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

Add device nodes for the Module Control (MDLC) blocks on the R-Car X5H
(R8A78000) SoC.

Complete hardware desciption of all (H)SCIF serial ports, by linking
them to an MDLC for power domains and resets.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v3:
  - Add Reviewed-by,
  - Sort MDLC nodes (alphabetically, by label),

v2:
  - Split in separate CPG and MDLC patches.
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 241 ++++++++++++++++++++++
 1 file changed, 241 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 1fe078c7822c01a5..9a07753b221541ed 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
+#include <dt-bindings/power/renesas,r8a78000-mdlc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -870,6 +871,8 @@ scif0: serial@c0700000 {
 				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x40>;
+			resets = <&mdlc_perw 0x40>;
 			status = "disabled";
 		};
 
@@ -882,6 +885,8 @@ scif1: serial@c0704000 {
 				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x41>;
+			resets = <&mdlc_perw 0x41>;
 			status = "disabled";
 		};
 
@@ -894,6 +899,8 @@ scif3: serial@c0708000 {
 				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x42>;
+			resets = <&mdlc_perw 0x42>;
 			status = "disabled";
 		};
 
@@ -906,6 +913,8 @@ scif4: serial@c070c000 {
 				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x43>;
+			resets = <&mdlc_perw 0x43>;
 			status = "disabled";
 		};
 
@@ -918,6 +927,8 @@ hscif0: serial@c0710000 {
 				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x54>;
+			resets = <&mdlc_perw 0x54>;
 			status = "disabled";
 		};
 
@@ -930,6 +941,8 @@ hscif1: serial@c0714000 {
 				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x55>;
+			resets = <&mdlc_perw 0x55>;
 			status = "disabled";
 		};
 
@@ -942,6 +955,8 @@ hscif2: serial@c0718000 {
 				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x56>;
+			resets = <&mdlc_perw 0x56>;
 			status = "disabled";
 		};
 
@@ -954,6 +969,8 @@ hscif3: serial@c071c000 {
 				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x57>;
+			resets = <&mdlc_perw 0x57>;
 			status = "disabled";
 		};
 
@@ -974,6 +991,230 @@ cpg: clock-controller@c1320000 {
 			#clock-cells = <1>;
 			bootph-all;
 		};
+
+		mdlc_aon: system-controller@c1338000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc1338000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_cmnn: system-controller@ca410000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xca410000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_cmns: system-controller@ca510000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xca510000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_ddr0: system-controller@e8000000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xe8000000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_ddr1: system-controller@e8080000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xe8080000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_ddr2: system-controller@e8100000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xe8100000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_ddr3: system-controller@e8180000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xe8180000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_ddr4: system-controller@e8200000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xe8200000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_ddr5: system-controller@e8280000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xe8280000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_ddr6: system-controller@e8300000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xe8300000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_ddr7: system-controller@e8380000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xe8380000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_dsp: system-controller@cbe90000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xcbe90000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_gpc: system-controller@cb510000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xcb510000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_hscn: system-controller@c9c90000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc9c90000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_hscs: system-controller@de200000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xde200000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_imn: system-controller@c1990000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc1990000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_ims: system-controller@c1d90000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc1d90000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_mm: system-controller@e9980000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xe9980000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_npu0: system-controller@d2c30000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xd2c30000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_npu1: system-controller@d6c30000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xd6c30000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_pere: system-controller@c08f0000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc08f0000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_perw: system-controller@c05d0000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc05d0000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_rt: system-controller@19440000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0x19440000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_scp: system-controller@c1330000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc1330000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_top: system-controller@c6480000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc6480000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_vio: system-controller@c5000000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc5000000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_vipn: system-controller@c3060000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc3060000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		mdlc_vips: system-controller@c3460000 {
+			compatible = "renesas,r8a78000-mdlc";
+			reg = <0 0xc3460000 0 0x1000>;
+			#power-domain-cells = <2>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
 	};
 
 	timer {
-- 
2.43.0

