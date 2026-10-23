Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778125;
	b=rU/toiPO9TVq5REjCqP3ET8T8f5OPAalI1c6FRhNPiwBhjS6iLRjZUdVI3V+mX5x3T2U
	 GBnvsD/Fj8PfsSziR0MKHjRxZV0/y2GTO9th/dzPDxcQ/wPdZenTlB+6filFw38iCGiS8
	 Bpn3juEFQM3YL83tITLrQKWzxROtn0UTsSmfCxrKzTmmxTA+QvklP6YkVq5o9L5zWk1XD
	 qi6QC266QSxp7fVoRHpSiG4nf6v5mbcSLkrAX2Qcyx3vHNg8X8C0VU1rtZizfL2dRL6Z4
	 mngBKUuLHFDm7K2jIh9VU2zA181bZcF3tihflwXCwPeCzJwGco2zKAM84MxbAQSkxJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778125;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=u1NMUq+jqXQwc0QHEPQZUDhJH1xGVhYW8LwKRkp9xfA=;
	b=fuV6y9sIC/kXyFLj/y1evQymwYtzo40tuBJED+jz1abeIA3xsxQxqJcJ2rLJY/RyzXSn
	 jYjZ4YDcXILRE43yHbFZRx116sb4T3ZfwFtRumRw9mTDKjVjY9iQ55O1ZUa8xHko5B4OH
	 cmckA2og4IvPmcCC0bWKVq2zNlC1vt9I90V/4t+KJ/lQdmLPm0fVLgfxeoL0qJCwWGf+W
	 tKhP/iLjMsJYfQkQrmoWRd3OB65ScPhqEoWBWEJ6W/GMaZI4J1TXykOadWwGxMkboIJcY
	 DKoDBgcf3qEeexNdzvMPIANygQZh45noUmbrDT2ZUInMO7HLzd5ORbWdDB1KBzhY8zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B6606A31A;
	Fri, 23 Oct 2026 17:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC541F031E1;
	Fri, 23 Oct 2026 17:55:01 +0000 (UTC)
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
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/DNI 7/7] arm64: dts: renesas: r8a78000: Add gpio-ranges
Date: Fri, 23 Oct 2026 19:50:45 +0200
Message-ID: <cae27d2d9dd17c081dcea27e3b223a8fb8653796.1792776697.git.geert+renesas@glider.be>
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

Link all GPIO controllers to the Pin Function Controller using
"gpio-ranges" properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on out-of-tree pin control support.
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 36a4fa1e032ee703..946dce6ab38b619d 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -1273,6 +1273,7 @@ gpio0: gpio@c1080110 {
 			resets = <&mdlc_aon 0x20>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 0 28>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
@@ -1287,6 +1288,7 @@ gpio1: gpio@c1080910 {
 			resets = <&mdlc_aon 0x20>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 32 22>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
@@ -1301,6 +1303,7 @@ gpio2: gpio@c1081110 {
 			resets = <&mdlc_aon 0x20>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 64 29>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
@@ -1315,6 +1318,7 @@ gpio3: gpio@c0800110 {
 			resets = <&mdlc_pere 0x30>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 96 17>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
@@ -1329,6 +1333,7 @@ gpio4: gpio@c0800910 {
 			resets = <&mdlc_pere 0x30>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 128 16>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
@@ -1343,6 +1348,7 @@ gpio5: gpio@c0400110 {
 			resets = <&mdlc_perw 0x30>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 160 23>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
@@ -1357,6 +1363,7 @@ gpio6: gpio@c0400910 {
 			resets = <&mdlc_perw 0x30>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 192 31>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
@@ -1371,6 +1378,7 @@ gpio7: gpio@c0401110 {
 			resets = <&mdlc_perw 0x30>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 224 31>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
@@ -1385,6 +1393,7 @@ gpio8: gpio@c0401910 {
 			resets = <&mdlc_perw 0x30>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 256 32>;
 			gpio-reserved-ranges = <16 10>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
@@ -1400,6 +1409,7 @@ gpio9: gpio@c9b00110 {
 			resets = <&mdlc_hscn 0x50>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 288 17>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
@@ -1414,6 +1424,7 @@ gpio10: gpio@c9b00910 {
 			resets = <&mdlc_hscn 0x50>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 320 14>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
-- 
2.43.0

