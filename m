Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279504;
	b=MvcNDu7hV3d4mKy1CPjzUVupe91F17dWXTLJ3adBnr+M0OCtwN3M4foz2yxvrnRQpjgq
	 O+sQFNEXzlUFqCPitxWEcp9hyl6bFjtGLjCZA+7/Mm2r86I7UdSEpSlU6vf1Ij1IINKAQ
	 uJ7RXJt7ArzSdkkDddHxE6TuKlS72nmYTzTvP/i/DhW/6ZL6XsI9Qn6SDomx8m93kfYdX
	 LLb9ND+4Eakph1ENVK2g8BxmRD/jI7yQMWGzt5enY/6eoCOhXU9reCtgz0tsaqJmbldT4
	 aa34pvMhlJ6F86glK1l34EG16vET5VrnsLUZrjGnDxnQE4Nx58E0Zfp2+cpF6G6YHhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279504;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=xCaU8OgKweL0hH8jd16muVJhjSF82fs6FeZyCWrYC5o=;
	b=kQMBOp/csd18ProTmfnFFv070Bo/Ke3PIEGy88MJg/T0RWZi7S604xy0Tzc/jnoezvRH
	 9cC7x7Sc8mt4gLKm1wrTI3Xb0ZleKohjVlZiA8+99/M4NZdD6hCaKUu5iCSIdc0tHrW7u
	 GNw4Pkwl4ifn1fm85MqZQLgRBDgDCvFhdsA4iIiUPSSjGxFWGpWgd37SEFUTK+5uk1LDK
	 zGnBeDNYDZQtdJNqL+ZUYkiGYxh2GbkcEsIlcxD6hhiZqwO9H54dhmN3mNkRRq0B2c46g
	 8ofjNTjLzA6xD4EoUj9MYz1ev0oFalTOtPaNps7/0dg9dsqabFUoesNy7W3a0yzam+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB80606A31E;
	Thu, 29 Oct 2026 13:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26AD1F031E1;
	Thu, 29 Oct 2026 13:11:40 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Biju Das <biju.das.au@gmail.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 6/9] arm64: dts: renesas: r8a78000: Add CAN-FD nodes
Date: Thu, 29 Oct 2026 14:11:07 +0100
Message-ID: <258c1bf126f5f350dcb998b8392b74f7aa642864.1793278754.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793278754.git.geert+renesas@glider.be>
References: <cover.1793278754.git.geert+renesas@glider.be>
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

Add device nodes for the two Controller Area Network Flexible Data Rate
(CAN-FD) interfaces and the related external CAN clock on the Renesas
R-Car X5H (R8A78000) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
RFC, as the DT bindings update is marked RFC.
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 235 ++++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index c5e48eac4c3712d8..437e49c58ff299a0 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -15,6 +15,13 @@ / {
 	#size-cells = <2>;
 	interrupt-parent = <&gic>;
 
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -1783,6 +1790,234 @@ mdlc_vips: system-controller@c3460000 {
 			bootph-all;
 		};
 
+		canfd0: can@c1420000 {
+			compatible = "renesas,r8a78000-canfd",
+				     "renesas,rcar-gen5-canfd";
+			reg = <0 0xc1420000 0 0x8500>;
+			interrupts = <GIC_ESPI 610 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 611 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 612 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 613 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 614 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 615 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 616 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 617 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 618 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 619 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 620 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 621 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 622 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 623 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 624 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 625 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 626 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 627 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 628 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 629 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 630 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 631 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 632 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 633 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 634 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 635 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 636 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 637 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 638 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 639 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 640 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 641 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 642 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 643 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 644 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 645 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 646 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 647 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 648 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 649 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 650 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 651 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 652 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 653 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 654 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 655 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 656 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 657 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 658 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 659 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "g_err", "g_recc",
+					  "ch0_err", "ch0_rec", "ch0_trx",
+					  "ch1_err", "ch1_rec", "ch1_trx",
+					  "ch2_err", "ch2_rec", "ch2_trx",
+					  "ch3_err", "ch3_rec", "ch3_trx",
+					  "ch4_err", "ch4_rec", "ch4_trx",
+					  "ch5_err", "ch5_rec", "ch5_trx",
+					  "ch6_err", "ch6_rec", "ch6_trx",
+					  "ch7_err", "ch7_rec", "ch7_trx",
+					  "vm0_tx", "vm0_rx", "vm0_err",
+					  "vm1_tx", "vm1_rx", "vm1_err",
+					  "vm2_tx", "vm2_rx", "vm2_err",
+					  "vm3_tx", "vm3_rx", "vm3_err",
+					  "vm4_tx", "vm4_rx", "vm4_err",
+					  "vm5_tx", "vm5_rx", "vm5_err",
+					  "vm6_tx", "vm6_rx", "vm6_err",
+					  "vm7_tx", "vm7_rx", "vm7_err";
+			clocks = <&cpg R8A78000_CPG_SCPBUSD4_SCP_MAIN>,
+				 <&cpg R8A78000_CPG_CANFD_SCP_MAIN>,
+				 <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg R8A78000_CPG_CANFD_SCP_MAIN>;
+			assigned-clock-rates = <80000000>;
+			power-domains = <&mdlc_scp R8A78000_MDLC_PD_SCP 0x72>;
+			resets = <&mdlc_scp 0x72>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
+
+			channel2 {
+				status = "disabled";
+			};
+
+			channel3 {
+				status = "disabled";
+			};
+
+			channel4 {
+				status = "disabled";
+			};
+
+			channel5 {
+				status = "disabled";
+			};
+
+			channel6 {
+				status = "disabled";
+			};
+
+			channel7 {
+				status = "disabled";
+			};
+		};
+
+		canfd1: can@c1520000 {
+			compatible = "renesas,r8a78000-canfd",
+				     "renesas,rcar-gen5-canfd";
+			reg = <0 0xc1520000 0 0x8500>;
+			interrupts = <GIC_ESPI 660 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 661 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 662 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 663 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 664 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 667 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 668 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 670 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 671 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 672 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 673 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 675 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 676 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 677 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 678 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 679 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 680 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 687 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 688 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 689 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 690 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 691 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 692 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 693 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 694 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 696 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 697 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 698 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 699 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 700 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 701 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 702 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 703 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 704 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 705 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 706 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 707 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 708 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 709 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "g_err", "g_recc",
+					  "ch0_err", "ch0_rec", "ch0_trx",
+					  "ch1_err", "ch1_rec", "ch1_trx",
+					  "ch2_err", "ch2_rec", "ch2_trx",
+					  "ch3_err", "ch3_rec", "ch3_trx",
+					  "ch4_err", "ch4_rec", "ch4_trx",
+					  "ch5_err", "ch5_rec", "ch5_trx",
+					  "ch6_err", "ch6_rec", "ch6_trx",
+					  "ch7_err", "ch7_rec", "ch7_trx",
+					  "vm0_tx", "vm0_rx", "vm0_err",
+					  "vm1_tx", "vm1_rx", "vm1_err",
+					  "vm2_tx", "vm2_rx", "vm2_err",
+					  "vm3_tx", "vm3_rx", "vm3_err",
+					  "vm4_tx", "vm4_rx", "vm4_err",
+					  "vm5_tx", "vm5_rx", "vm5_err",
+					  "vm6_tx", "vm6_rx", "vm6_err",
+					  "vm7_tx", "vm7_rx", "vm7_err";
+			clocks = <&cpg R8A78000_CPG_SCPBUSD4_SCP_MAIN>,
+				 <&cpg R8A78000_CPG_CANFD_SCP_MAIN>,
+				 <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg R8A78000_CPG_CANFD_SCP_MAIN>;
+			assigned-clock-rates = <80000000>;
+			power-domains = <&mdlc_scp R8A78000_MDLC_PD_SCP 0x73>;
+			resets = <&mdlc_scp 0x73>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
+
+			channel2 {
+				status = "disabled";
+			};
+
+			channel3 {
+				status = "disabled";
+			};
+
+			channel4 {
+				status = "disabled";
+			};
+
+			channel5 {
+				status = "disabled";
+			};
+
+			channel6 {
+				status = "disabled";
+			};
+
+			channel7 {
+				status = "disabled";
+			};
+		};
+
 		msiof0: spi@c1700000 {
 			compatible = "renesas,msiof-r8a78000",
 				     "renesas,rcar-gen5-msiof";
-- 
2.43.0

