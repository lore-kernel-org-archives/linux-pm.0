Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026568;
	b=Ap2juyoL47ieQk4WZ/w7IzN9NyQ7Soo1/XG2d9Rc6+ydNq1irjkHdw0K5/Ue9ELRVh85
	 lSwMOHSqCQmBecQJJWXtWTMrDWt4We8yGp3e5+aiKw68KRhcsOqOPXkOJcfsbVd8PfAhp
	 LdL713hQNbci7kJVvx7e6ZDpHqL+zKmMaFH3+vb0IZtI+PQWQC9NbWk1gFYVlHhN7X2sh
	 qrQV5Z5SECt7hSlGhRjFN5vyfF6aw1gCWXw/dkas6QqOiSJy4UXhHR0sY1A2IaSdmquVZ
	 i/bLopXcWSgiFmcaYbyYIOlrCm2hUgHiNKmlP3yEsJoJR0wahFTT3h/ZPiGpB0r928w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026568;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=6j5fPmNl4JXPUL19Fwb3C5vWLLpOlOJYPelcoa3tW+0=;
	b=NpscZqaj5qylgbWJaKpJy2tAGkRgpbo/vQNmvGrvdazTvBG89Kp3JZ10vs2SDpKaLCSE
	 Pco68AWKX9lIqUNqYCQBkg4CxWrwx8QsiqzADt75YqM/+zO6+6VU/saKm9/Q0xG7wi/l3
	 R43QrKiQqJqPodR1H6vUj7NpXi5+l5OShSUyTBXU6V7iCU/KWa99X2DEV8mOoNKR0aUab
	 QT6oA5ZKwKVKqJdk9J1tbHkOesF5eTEY/PG4IzC46wt6Xz0hZ0OPpi21NnCM69bNHf/+c
	 3Az6v54VgmoGwyOUEJWIKtsY+6fyss2SvheXlpxffidsG+l1ToDinMBJf1bTphwl5oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D9606A322;
	Mon, 26 Oct 2026 14:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A231F01829;
	Mon, 26 Oct 2026 14:56:04 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 08/11] arm64: dts: renesas: r8a78000: Add PWM nodes
Date: Mon, 26 Oct 2026 15:55:24 +0100
Message-ID: <8912d1d4e99b95fc7e9f0d1cf3c596689c470e09.1793026273.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793026273.git.geert+renesas@glider.be>
References: <cover.1793026273.git.geert+renesas@glider.be>
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

Add device nodes for the Pulse Width Modulation (PWM) modules and the
16-Bit Timer Pulse Unit (TPU) on the Renesas R-Car X5H (R8A78000) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 121 ++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 946dce6ab38b619d..c5e48eac4c3712d8 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -1243,6 +1243,127 @@ hscif3: serial@c071c000 {
 			status = "disabled";
 		};
 
+		tpu: pwm@c0720000 {
+			compatible = "renesas,tpu-r8a78000", "renesas,tpu";
+			reg = <0 0xc0720000 0 0x200>;
+			interrupts = <GIC_ESPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD16_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x76>;
+			resets = <&mdlc_perw 0x76>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm0: pwm@c0740000 {
+			compatible = "renesas,pwm-r8a78000",
+				     "renesas,rcar-gen5-pwm";
+			reg = <0 0xc0740000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD16_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x70>;
+			resets = <&mdlc_perw 0x70>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@c0741000 {
+			compatible = "renesas,pwm-r8a78000",
+				     "renesas,rcar-gen5-pwm";
+			reg = <0 0xc0741000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD16_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x70>;
+			resets = <&mdlc_perw 0x70>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@c0742000 {
+			compatible = "renesas,pwm-r8a78000",
+				     "renesas,rcar-gen5-pwm";
+			reg = <0 0xc0742000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD16_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x70>;
+			resets = <&mdlc_perw 0x70>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@c0743000 {
+			compatible = "renesas,pwm-r8a78000",
+				     "renesas,rcar-gen5-pwm";
+			reg = <0 0xc0743000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD16_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x70>;
+			resets = <&mdlc_perw 0x70>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@c0780000 {
+			compatible = "renesas,pwm-r8a78000",
+				     "renesas,rcar-gen5-pwm";
+			reg = <0 0xc0780000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg R8A78000_CPG_S0ASYNCD8_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x70>;
+			resets = <&mdlc_perw 0x70>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@c0781000 {
+			compatible = "renesas,pwm-r8a78000",
+				     "renesas,rcar-gen5-pwm";
+			reg = <0 0xc0781000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg R8A78000_CPG_S0ASYNCD8_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x70>;
+			resets = <&mdlc_perw 0x70>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@c0782000 {
+			compatible = "renesas,pwm-r8a78000",
+				     "renesas,rcar-gen5-pwm";
+			reg = <0 0xc0782000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg R8A78000_CPG_S0ASYNCD8_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x70>;
+			resets = <&mdlc_perw 0x70>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@c0783000 {
+			compatible = "renesas,pwm-r8a78000",
+				     "renesas,rcar-gen5-pwm";
+			reg = <0 0xc0783000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg R8A78000_CPG_S0ASYNCD8_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x70>;
+			resets = <&mdlc_perw 0x70>;
+			status = "disabled";
+		};
+
+		pwm8: pwm@c0784000 {
+			compatible = "renesas,pwm-r8a78000",
+				     "renesas,rcar-gen5-pwm";
+			reg = <0 0xc0784000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg R8A78000_CPG_S0ASYNCD8_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x70>;
+			resets = <&mdlc_perw 0x70>;
+			status = "disabled";
+		};
+
+		pwm9: pwm@c0785000 {
+			compatible = "renesas,pwm-r8a78000",
+				     "renesas,rcar-gen5-pwm";
+			reg = <0 0xc0785000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg R8A78000_CPG_S0ASYNCD8_PERW_MAIN>;
+			power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x70>;
+			resets = <&mdlc_perw 0x70>;
+			status = "disabled";
+		};
+
 		stcm_transport: sram@c1060000 {
 			compatible = "mmio-sram";
 			reg = <0x0 0xc1060000 0x0 0x1c00>;
-- 
2.43.0

