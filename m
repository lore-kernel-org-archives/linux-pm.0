Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF493FDBE8;
	Thu, 11 Jun 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182983; cv=none; b=bkQ4veuTmy/MgdiLQuNDh/Hhh6DPCt+1m6GCwm5BZW39/NwBzwiNRPCASUGUcyurFL4DU0zRDRH629sfg5jGSNepzsNPDdXUeKbGBHHOg0BA4zPg0kNkquckcgXP0QoCqWboPXBDBtwbylKgLppJVsjUX0PsvyvEH1shUinufi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182983; c=relaxed/simple;
	bh=Dz/XeYwHL7OCjZlQZP43UoZPLeZG7Dn2a4gxL8e39U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGmS2skWOD/w7lmDy6oSv8fX2GFlx1Oafa5SEynzmmL1eMeTbN81O/4ZbICnEhUuUVS02y/njZs8ULpEVFcKpEcbm93bHh8RP/rezOG4MZQWr198sUwsjwKnp6FnmG+LpvSQKNlCxWILExPqLRncJ9vRNmJVBxtmQ9wN6D6d/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178C01F00899;
	Thu, 11 Jun 2026 13:02:56 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 9/9] arm64: dts: renesas: ironhide: Switch to pure SCMI
Date: Thu, 11 Jun 2026 15:02:13 +0200
Message-ID: <0940352910d97e24410c5fffd815a8dded3db070.1781171706.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781171705.git.geert+renesas@glider.be>
References: <cover.1781171705.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from CPG/MDLC remapping to pure SCMI:
  - Add SCMI IDs for selected devices, supporting SCP FW SDK v4.28,
    v4.31, and v4.32,
  - Enable SCMI clock domain support,
  - Replace clocks, power-domains, and resets properties by pure SCMI
    references.

Note that the user must uncomment the line that defines
R_CAR_X5H_SCP_FW_SDK_VERSION to the SCP FW SDK version being used.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This patch is included as a PoC.
This fails to apply, as the SCMI protocol subnodes are not added in this
series.
---
 .../boot/dts/renesas/r8a78000-ironhide.dts    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
index 00b5a010b7247722..f4093c359b21379e 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
+++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
@@ -9,6 +9,45 @@
 #include <dt-bindings/soc/renesas,r8a78000-mfis.h>
 #include "r8a78000.dtsi"
 
+#define V4_28	4028
+#define V4_31	4031	// Supports v4.31 and v4.32
+
+//#define R_CAR_X5H_SCP_FW_SDK_VERSION	V4_28
+#define R_CAR_X5H_SCP_FW_SDK_VERSION	V4_31
+
+#if R_CAR_X5H_SCP_FW_SDK_VERSION == V4_28
+
+#define CLK_SGD4_PERW_BUS	1661
+#define MDLC_HSCIF0		228
+#define MDLC_HSCIF1		229
+#define MDLC_SCIF0		209
+#define MDLC_SCIF1		210
+#define MDLC_UFS1		203
+#define RESET_HSCIF0		228
+#define RESET_HSCIF1		229
+#define RESET_SCIF0		209
+#define RESET_SCIF1		210
+#define RESET_UFS1		203
+
+#elif R_CAR_X5H_SCP_FW_SDK_VERSION == V4_31
+
+#define CLK_SGD4_PERW_BUS	1657
+#define MDLC_HSCIF0		224
+#define MDLC_HSCIF1		225
+#define MDLC_SCIF0		205
+#define MDLC_SCIF1		206
+#define MDLC_UFS1		199
+#define RESET_HSCIF0		224
+#define RESET_HSCIF1		225
+#define RESET_SCIF0		205
+#define RESET_SCIF1		206
+#define RESET_UFS1		199
+
+#endif
+
+#define PD_APL			257
+#define PD_UFS1			13
+
 / {
 	model = "Renesas Ironhide board based on r8a78000";
 	compatible = "renesas,ironhide", "renesas,r8a78000";
@@ -35,6 +74,7 @@ scmi: scmi {
 			scmi_devpd: protocol@11 {
 				reg = <0x11>;
 				#power-domain-cells = <1>;
+				arm,clock-domain = <&scmi_clk>;
 			};
 
 			scmi_sys: protocol@12 {
@@ -138,6 +178,10 @@ &extalr_clk {
 };
 
 &hscif0 {
+	clocks = <&scmi_clk MDLC_HSCIF0>, <&scmi_clk CLK_SGD4_PERW_BUS>,
+		 <&scif_clk>;
+	power-domains = <&scmi_devpd PD_APL>;
+	resets = <&scmi_reset RESET_HSCIF0>;
 	uart-has-rtscts;
 	status = "okay";
 };
-- 
2.43.0

