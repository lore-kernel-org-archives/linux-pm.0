Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026581;
	b=PClr+78bALRoyZ57VyEXQr/LZBsQgZyd12/Ou4Uz4aJqRVYAeQodHU1QbVI973X/FaKH
	 n3hiXKW32y3y7NGMbJdPpBgKe4VjFXk1vkg/dN/zmQUNLsiXy2bVXNLSW325Ew95C3y9+
	 Yhm68QDqN+D1wVKk9h5EyuCghuyqk9qSX59IlA1zQ1l/03sgfXR1ilsuunzF6tqaB4Qa/
	 mpeWzdd2ZRdJB6kqTgbz4/Xaj/DF5HXeH2YNjj0x1qfK51YRGq07M7U24AAT/5gXOWo/z
	 FMmivI2mqdc3vTE2GnERGTaJ/USkJWvQyMBqoHUgEKvRPuiKQ5dZhzvVWbBV905xhYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026581;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Su/NSRv3Sw/2MP6PmrgJEPefQQ31VIPrx3FkQ3Apx24=;
	b=rGjl4HmACQmbVVBN4ivHaZnyJwNbhGV9xyLwS/8rUgbZRPNFGWVZJpYJmoz8lX9uEHfF
	 C4s6o3hcYIBGSZvK7kF+hcRazapMMDCHXm0k/SkOL5uagJQ1PZqUnYm9ixmd/sYDqGW1M
	 F3wDrLJcVV9X83VQ+Defg9VbFWLh/ORNhIHmphKA49uUvPuTHGwrMyCLZuJ3On6WjQhYF
	 1tjSHlRKYbKzNiOkltntFhcUNNkVUfoCWkRvZsIuuPJ79UKbw9RYN3SuBWeG5SJV9mXk6
	 1uBhc633avUrg2iM/mky9eIPJqHT268sId1WwukOESqe4IDgMXfNDg6slqnF+hj2QQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE33606A31D;
	Mon, 26 Oct 2026 14:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFEF1F031E0;
	Mon, 26 Oct 2026 14:56:16 +0000 (UTC)
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
Subject: [PATCH/DNI 11/11] arm64: dts: renesas: ironhide: Enable PWM
Date: Mon, 26 Oct 2026 15:55:27 +0100
Message-ID: <d28846258918d12122704debc70b7c9bf9553053.1793026273.git.geert+renesas@glider.be>
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

Pulse Width Modulation (PWM) instances 0 to 5 and 16-Bit Timer Pulse
Unit (TPU) channels 0 and 1 are wired to PWM CN (CN48).

Note that TPU channels 0 and 1 are mutually-exclusive with PWM instances
4 and 5.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on out-of-tree pin control support.
---
 .../boot/dts/renesas/r8a78000-ironhide.dts    | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
index 5d919953efe4970e..c2d814da9fd97802 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
+++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
@@ -242,10 +242,87 @@ msiof6_pins: msiof6 {
 
 	};
 
+	pwm0_pins: pwm0 {
+		groups = "pwm0_a";
+		function = "pwm0";
+	};
+
+	pwm1_pins: pwm1 {
+		groups = "pwm1";
+		function = "pwm1";
+	};
+
+	pwm2_pins: pwm2 {
+		groups = "pwm2";
+		function = "pwm2";
+	};
+
+	pwm3_pins: pwm3 {
+		groups = "pwm3";
+		function = "pwm3";
+	};
+
+	pwm4_pins: pwm4 {
+		groups = "pwm4";
+		function = "pwm4";
+	};
+
+	pwm5_pins: pwm5 {
+		groups = "pwm5";
+		function = "pwm5";
+	};
+
 	scif_clk_pins: scif-clk {
 		groups = "scif_clk";
 		function = "scif_clk";
 	};
+
+	tpu_pins: tpu {
+		groups = "tpu_to0", "tpu_to1";
+		function = "tpu";
+	};
+};
+
+&pwm0 {
+	pinctrl-0 = <&pwm0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-0 = <&pwm1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-0 = <&pwm2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-0 = <&pwm3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-0 = <&pwm4_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pwm5 {
+	pinctrl-0 = <&pwm5_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
 };
 
 &scif_clk {
@@ -263,3 +340,10 @@ scmi_rx_shmem: sram@1300 {
 		reg = <0x1300 0x100>;
 	};
 };
+
+&tpu {
+	pinctrl-0 = <&tpu_pins>;
+	pinctrl-names = "default";
+
+	//status = "okay";	// Mutually-exclusive with pwm4 and pwm5
+};
-- 
2.43.0

