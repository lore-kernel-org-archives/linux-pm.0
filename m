Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778028;
	b=SAVtXsPOdrJ9BSPr9ssz6w4lJKZlFi79LZq5UCrwInJaHzNxUY8lWufjRuWW6osEafHI
	 +DnopzKkJgCY11karH12MvLMTI1xg0umfSSXAzVDloBX0rinE3xwyKp6+m7AR/ir9u5/O
	 2RYTZE6OkKoQ8zjzrL8ekaOryf8nYd1NdDfBonPhOJdN4eKWTTqXaixZZukigiH9dAcoB
	 TjLrdYBThE10Gv6TSfTA4Rnv1b62Qe4ifFgQq7HrL6mxqC48OHyQP1gBuuPppBc+9GKI+
	 ccP6LuzkQo5sOT/0kE2DY6MrewaX+LrVBajU4FfVawwsBy4R1UdiTuMwSDnJG+hOXaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778028;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=1muTcKBLuC7q1JD0nNZzHZd+pNV0OB32RDBryHwu9Mc=;
	b=i7ORzPhhImyp9kptN6ZKEvsRWx2pzx1xNVdefPYYKLNb8vA69PPuegIqHMxnub50jr4d
	 gtHbietNlZ3Ib930CoxJA61l6wjBp4NS/PqsCFZbCj5sM6PsdPWI4d0OKaNCGt7bGuNkL
	 N4/VaqVL9zRGd44pmslw210iN95UcY8NO0BHe+Q5hhHkNGlocFlzo5PVMxx32N58zFqyD
	 CAfpRx7x3t8PKomM8EWAsr0qyDRVSv+fLKaL/9Oxns+IrdNOjBjBHioQhpE4zBW8RX140
	 lSaMWNYKwjV5VNiP6oi6goZvKnW8EQVg17YuVCdisvABZk+KAtsE5M7MU+K/rAN6pSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A43606A31A;
	Fri, 23 Oct 2026 17:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6461F031E0;
	Fri, 23 Oct 2026 17:53:06 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/7] arm64: dts: renesas: r8a78000: Add GPIO controller nodes
Date: Fri, 23 Oct 2026 19:50:41 +0200
Message-ID: <f9de8214043ad4c8748fadce7fd2cc2fa95b1291.1792776697.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792776697.git.geert+renesas@glider.be>
References: <cover.1792776697.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Add device nodes for the General-Purpose Input/Output Ports (GPIO) on
the Renesas R-Car X5H (R8A78000) SoC.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Co-developed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes compared to Marek's original:
  - Use hardware clocks/power-domains/resets instead of direct SCMI
    references,
  - Drop gpio-ranges properties for now, as upstream lacks Pin Function
    Controller (PFC) support.
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 155 ++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 66eec0907b34fa58..36a4fa1e032ee703 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -1263,6 +1263,161 @@ pfc: pinctrl@c1080000 {
 			bootph-all;
 		};
 
+		gpio0: gpio@c1080110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc1080110 0 0xc0>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SCPBUSD16_SCP_MAIN>;
+			power-domains = <&mdlc_aon R8A78000_MDLC_PD_AON 0x20>;
+			resets = <&mdlc_aon 0x20>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio1: gpio@c1080910 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc1080910 0 0xc0>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SCPBUSD16_SCP_MAIN>;
+			power-domains = <&mdlc_aon R8A78000_MDLC_PD_AON 0x20>;
+			resets = <&mdlc_aon 0x20>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio2: gpio@c1081110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc1081110 0 0xc0>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SCPBUSD16_SCP_MAIN>;
+			power-domains = <&mdlc_aon R8A78000_MDLC_PD_AON 0x20>;
+			resets = <&mdlc_aon 0x20>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio3: gpio@c0800110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0800110 0 0xc0>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_S0D24_PERE_MAIN>;
+			power-domains = <&mdlc_pere R8A78000_MDLC_PD_APL 0x30>;
+			resets = <&mdlc_pere 0x30>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio4: gpio@c0800910 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0800910 0 0xc0>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_S0D24_PERE_MAIN>;
+			power-domains = <&mdlc_pere R8A78000_MDLC_PD_APL 0x30>;
+			resets = <&mdlc_pere 0x30>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio5: gpio@c0400110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0400110 0 0xc0>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD32_PERW_BUS>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x30>;
+			resets = <&mdlc_perw 0x30>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio6: gpio@c0400910 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0400910 0 0xc0>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD32_PERW_BUS>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x30>;
+			resets = <&mdlc_perw 0x30>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio7: gpio@c0401110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0401110 0 0xc0>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD32_PERW_BUS>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x30>;
+			resets = <&mdlc_perw 0x30>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio8: gpio@c0401910 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0401910 0 0xc0>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD32_PERW_BUS>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x30>;
+			resets = <&mdlc_perw 0x30>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-reserved-ranges = <16 10>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio9: gpio@c9b00110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc9b00110 0 0xc0>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_S0D24_HSCN_OTHER>;
+			power-domains = <&mdlc_hscn R8A78000_MDLC_PD_APL 0x50>;
+			resets = <&mdlc_hscn 0x50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio10: gpio@c9b00910 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc9b00910 0 0xc0>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_S0D24_HSCN_OTHER>;
+			power-domains = <&mdlc_hscn R8A78000_MDLC_PD_APL 0x50>;
+			resets = <&mdlc_hscn 0x50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
 		cpg: clock-controller@c1320000 {
 			compatible = "renesas,r8a78000-cpg";
 			reg = <0 0xc1320000 0 0x10000>;
-- 
2.43.0

