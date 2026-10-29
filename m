Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279516;
	b=yEpdWhDN8s5ojOAN/VZ2jDaRkfWDtbvgX2avVEsYk+5fT7sh9Bo+HAdNWuD3tdkfvPrP
	 an6jqzg1E53chhkCVeyKUY09GPMnLnpnOVsHIFTlV74p7FujdpJw9k9EXE2SntsoZFNsw
	 FaZcWncKzgjn4JHe8Q3CWYLwsUgupsDsUM7JEFw7RFF6bfe/eLDgEcknd0XFD09W0+W8L
	 NoW2HH6WhMpbXaAp15XkN3TWcTSD4NOjvxzoGVksFV7Vc5LIXfkcfeHH2B0dQH8rQTMLc
	 NBFPvKTwZY6tJBddbMREURZsm183yyIZcbanv7euelAu78wBnsCqHl4xC95xhLZ75XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279516;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=5pCrvx2wO9rxz/SVIPupq/LgqP91MpNSt9foXvKiLGM=;
	b=XlRVy5Z9Ax+CD9bcpYp0wVkk1CSdIJnIOA3Li0kHvXvXGcKv79RV6Ze6hSLz32DmLmPF
	 kQN2N6nY139xc/X8nSZxhai6Ol8np3hYO/Pm85FKupoK2kbBWJ1j/xiP/AStMwNY71WX4
	 d9F5/ZffaS1gkR88IvsPAmSc78zbD5LE1loZ4HJQB6Q1Z2l5HnP6nhwcc3Mu6tRXH0eCD
	 EQv/hryGQ74rIMcKN2E0TTxS/T06lp18+2GkWXzftBFy0q4HEG2eXlwQbPT8Wlko/6/O/
	 gS6MLnneeZutem8HeC7/J/JXcOBvhnD1VATmCzY9Jc4h1YFnRJReFD/t6gXm2PmVcxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D41606A31D;
	Thu, 29 Oct 2026 13:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1531F031E1;
	Thu, 29 Oct 2026 13:11:52 +0000 (UTC)
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
Subject: [PATCH/DNI 9/9] arm64: dts: renesas: ironhide: Enable CAN-FD
Date: Thu, 29 Oct 2026 14:11:10 +0100
Message-ID: <66a35ed04f5d3f14a4bc60b4646917e1dc25b2f6.1793278754.git.geert+renesas@glider.be>
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

CAN-FD channels 1 to 6 and 12 to 15 are wired to CAN connectors CN7B to
CN12, CN18, CN19, and CN55 to CN58.

Channel 0 on CAN connector CN7A is not added, as its transceiver is
controlled by the System Control Processor (SCP).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on out-of-tree pin control support.
---
 .../boot/dts/renesas/r8a78000-ironhide.dts    | 117 +++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
index c2d814da9fd97802..63dd4fa2d737a729 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
+++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
@@ -171,6 +171,66 @@ ecc@1ecccc0000 {
 	};
 };
 
+&can_clk {
+	clock-frequency = <40000000>;
+};
+
+&canfd0 {
+	pinctrl-0 = <&canfd1_pins>,  <&canfd2_pins>, <&canfd3_pins>,
+		    <&canfd4_pins>, <&canfd5_pins>, <&canfd6_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	channel1 {
+		status = "okay";
+	};
+
+	channel2 {
+		status = "okay";
+	};
+
+	channel3 {
+		status = "okay";
+	};
+
+	channel4 {
+		status = "okay";
+	};
+
+	channel5 {
+		status = "okay";
+	};
+
+	channel6 {
+		status = "okay";
+	};
+};
+
+&canfd1 {
+	pinctrl-0 = <&canfd12_pins>, <&canfd13_pins>,  <&canfd14_pins>,
+		    <&canfd15_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	channel4 {
+		status = "okay";
+	};
+
+	channel5 {
+		status = "okay";
+	};
+
+	channel6 {
+		status = "okay";
+	};
+
+	channel7 {
+		status = "okay";
+	};
+};
+
 &extal_clk {
 	clock-frequency = <16666600>;
 };
@@ -214,9 +274,64 @@ &msiof6 {
 };
 
 &pfc {
-	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-0 = <&can_clk_pins>, <&scif_clk_pins>;
 	pinctrl-names = "default";
 
+	can_clk_pins: can-clk {
+		groups = "can_clk";
+		function = "can_clk";
+	};
+
+	canfd1_pins: canfd1 {
+		groups = "canfd1_data";
+		function = "canfd1";
+	};
+
+	canfd2_pins: canfd2 {
+		groups = "canfd2_data";
+		function = "canfd2";
+	};
+
+	canfd3_pins: canfd3 {
+		groups = "canfd3_data";
+		function = "canfd3";
+	};
+
+	canfd4_pins: canfd4 {
+		groups = "canfd4_data";
+		function = "canfd4";
+	};
+
+	canfd5_pins: canfd5 {
+		groups = "canfd5_data";
+		function = "canfd5";
+	};
+
+	canfd6_pins: canfd6 {
+		groups = "canfd6_data";
+		function = "canfd6";
+	};
+
+	canfd12_pins: canfd12 {
+		groups = "canfd12_data_b";
+		function = "canfd12";
+	};
+
+	canfd13_pins: canfd13 {
+		groups = "canfd13_data_b";
+		function = "canfd13";
+	};
+
+	canfd14_pins: canfd14 {
+		groups = "canfd14_data_b";
+		function = "canfd14";
+	};
+
+	canfd15_pins: canfd15 {
+		groups = "canfd15_data_b";
+		function = "canfd15";
+	};
+
 	hscif0_pins: hscif0 {
 		groups = "hscif0_data", "hscif0_ctrl";
 		function = "hscif0";
-- 
2.43.0

