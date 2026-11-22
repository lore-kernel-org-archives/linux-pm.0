Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795306717;
	b=EGBS72y3/mmqIUgNKu95YIzXw8TMth07OJHyEYkUh8lLXUksE6ZjsMmmS7/n1zNnYSuJ
	 2XERQtL2pyBZo8AQe0ezqtmMi44T0N5/tT81cG4T+1z2BUDvw+yT1zXZrzN/eWw+XuMPO
	 PJnXYiBPFsIXdWN91yFOv80lUwz786jwJUC8YJ4kNxI+oxcQ2Z0oV6e3vCoaufyfOF9+e
	 XLdAaF67qNaRgiCJy3yaxjr6v4cA0q0lc/v/dYJDEP3whisfXBVkRh9NRAkYj3nC19s2l
	 rJXyTAI7n4q7JeQlQGLed0f8vnvi6AC0IFL4MWXWhcIzoJ1rdxj6Oo0G7xssN/HrrIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306717;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=J1ZGJnZQtQZbAjjyMmOw/z71RiFaPkMYBq3NUKY8jPc=;
	b=SlbVMdc/aJVO4/GyK1omiVZnT7fGzOhBFaDJNvXDERYElhhVx2WEuZcdgTNDSr4rzIGX
	 dufu+CLKLi/+XoU26p5O/qeQo6+B6NOTy3ilNMe7R5hyeeu69C4t4ux87om4T84UUn0nR
	 5G0vFycbL+sq5/MekD+0LtfeKslGjjpslm7S1rZ/0BlQuvV994r7RMXb4OhXhYvGLt6pj
	 6g4mlwdGGG9HjB2xyY4q3VvuVOiEG8a2Uxb3jNEF7XWztbFrBN9re4/dFJzxYNYFR1R0g
	 8Dmwrn9w+bosyriim4X1He+YRB5hwhexOcc5KauNJgad0kbqZttWycEXsr6aFTJXt1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJJiHnZ7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FEE606A339;
	Sun, 22 Nov 2026 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJJiHnZ7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795306717;
	b=tKll0OJrXGYv+xfu7b5xCiOhiSlU6HeOPGvf1fZfJftOJEmAeBziYXMbRdw8QW07HYlu
	 IScHnfe/x+vKaCmOX02B2HahCm6SV4JDMGRh3pGjLxMCKu6EPH3icrdkuWRHueHtODIGh
	 h3C4afc5yggrFP3mbUjrIKMKwHze2vIXbTKabHpBcmyrVaVPtunQJrQfVknF5dXZ6DNVP
	 JHJbe14Tvb80NlMYikBO9QdVK+7uKzKT0IeFRQJrp00uHId+n1Q/viLJQwyAkrJPOvCF+
	 ST4lH7J0XSq8SqLHFMa5gIUUPgTas4FzyluLm9LozKLPzjqdm6liJafuAuegR5igpaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795306717;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=J1ZGJnZQtQZbAjjyMmOw/z71RiFaPkMYBq3NUKY8jPc=;
	b=w0VdUknpyxmFNjFIp+aUwpHikxxj28WBsYRgsY6XnuzJ4j0NB25ARqO7nwk4D6vA3YPM
	 A5/BztHA6K0m4KmulF+MDVfgN1OJE32lOGs4bH9hqlUwOs6MfTRGj2q/1wmEOwR82Td/W
	 TwwX95u9aZhQla38YkJr/S6I4EWjqC/LomyV4gz/NfDOTA6IikwIdsxDp+p185AdqK0HL
	 1mXMlVQc7Zwees7Fz5w857mrxJOltXsJzprqpRyltmYSNiauFgiYZZKyqnHVfNg4BDHRJ
	 h8CV5A/6WWCQDR/wYZAlVKBO7lPikW3ycyIALuasJ5Jpr+fqDrhrpDrGWvoZ8SCG2jw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C16361F000D1;
	Sun, 22 Nov 2026 00:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306717;
	bh=J1ZGJnZQtQZbAjjyMmOw/z71RiFaPkMYBq3NUKY8jPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AJJiHnZ7EVp2XkZo3i/YAemvbaGfspPvFd4IEBmQ1ORop0xmlpqwOwDtqdUGUcOYa
	 6H8PJt4GQq1kgum+OVwSSSDdsBQhw8yvDn8rZzZat+6YeogboFFcShFGGG0vKONYQJ
	 9i9v4QknzzCQlt24LXQXds5YBHEE34ZKZ/13mc9GGQ9EU5mO62g4k3wrL0lK5LR5nm
	 mnrSRviVflJ/wnDa4A1sD99frxSj8X6qLd2xF9wTXQN7EFoYDok3ELI5R1mhwi11+m
	 O5md8UaNSvOvv/IWmPWI6xZEKklJKlhK9op4+BRthuut8g9jX433TgSjx3MHTu/qCi
	 JGRp0eC8tunZg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7D3774BE96;
	Sun, 22 Nov 2026 00:18:34 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:18:26 +0000
Subject: [PATCH v2 5/5] arm64: dts: apple: t6032: Add CPU frequency scaling
 and OPPs
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-m3-cpufreq-opp-v2-5-3c19963f55ee@gmail.com>
References: <20261122-m3-cpufreq-opp-v2-0-3c19963f55ee@gmail.com>
In-Reply-To: <20261122-m3-cpufreq-opp-v2-0-3c19963f55ee@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795306712; l=7260;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=RP3Tl98EGSTZRq8axcgQ4fI3CuPhgZyAKwc+j8gARmE=;
 b=svqXsQ9xqKQ2cDML9fwZcFlM4sEp5BZ7n1lI8uJa5YfcewBelutV99aoPDkUvqFXERil2zByZ
 pN47QATtRGlA3AdBsj4IwqFCodmEtcTHZ9Jqkbzmi8p6oZ+fMlMO1Gr
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com
Content-Transfer-Encoding: 7bit

From: Michael Reeves <michael.reeves077@gmail.com>

Add operating performance point references, performance domain bindings,
and CPU capacity values for the second die's Sawtooth efficiency and
Everest performance clusters on Apple T6032 (M3 Ultra).

The die1 cores use the same OPP tables and capacity-dmips-mhz values as
die0 (inherited from T6031), paired with the die1 cluster cpufreq
controller nodes instantiated via t6031-dieX.dtsi.

Suggested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 arch/arm64/boot/dts/apple/t6032.dtsi | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6032.dtsi b/arch/arm64/boot/dts/apple/t6032.dtsi
index 6115ab8db5ef..b5ddaa00a7e0 100644
--- a/arch/arm64/boot/dts/apple/t6032.dtsi
+++ b/arch/arm64/boot/dts/apple/t6032.dtsi
@@ -107,9 +107,12 @@ cpu_e10: cpu@800 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <870>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_3>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e_die1>;
 		};
 
 		cpu_e11: cpu@801 {
@@ -119,9 +122,12 @@ cpu_e11: cpu@801 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <870>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_3>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e_die1>;
 		};
 
 		cpu_e12: cpu@802 {
@@ -131,9 +137,12 @@ cpu_e12: cpu@802 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <870>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_3>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e_die1>;
 		};
 
 		cpu_e13: cpu@803 {
@@ -143,9 +152,12 @@ cpu_e13: cpu@803 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <870>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_3>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e_die1>;
 		};
 
 		cpu_p20: cpu@10900 {
@@ -155,9 +167,12 @@ cpu_p20: cpu@10900 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_4>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0_die1>;
 		};
 
 		cpu_p21: cpu@10901 {
@@ -167,9 +182,12 @@ cpu_p21: cpu@10901 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_4>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0_die1>;
 		};
 
 		cpu_p22: cpu@10902 {
@@ -179,9 +197,12 @@ cpu_p22: cpu@10902 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_4>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0_die1>;
 		};
 
 		cpu_p23: cpu@10903 {
@@ -191,9 +212,12 @@ cpu_p23: cpu@10903 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_4>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0_die1>;
 		};
 
 		cpu_p24: cpu@10904 {
@@ -203,9 +227,12 @@ cpu_p24: cpu@10904 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_4>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0_die1>;
 		};
 
 		cpu_p25: cpu@10905 {
@@ -215,9 +242,12 @@ cpu_p25: cpu@10905 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_4>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0_die1>;
 		};
 
 		cpu_p30: cpu@10a00 {
@@ -227,9 +257,12 @@ cpu_p30: cpu@10a00 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_5>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1_die1>;
 		};
 
 		cpu_p31: cpu@10a01 {
@@ -239,9 +272,12 @@ cpu_p31: cpu@10a01 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_5>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1_die1>;
 		};
 
 		cpu_p32: cpu@10a02 {
@@ -251,9 +287,12 @@ cpu_p32: cpu@10a02 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_5>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1_die1>;
 		};
 
 		cpu_p33: cpu@10a03 {
@@ -263,9 +302,12 @@ cpu_p33: cpu@10a03 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_5>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1_die1>;
 		};
 
 		cpu_p34: cpu@10a04 {
@@ -275,9 +317,12 @@ cpu_p34: cpu@10a04 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_5>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1_die1>;
 		};
 
 		cpu_p35: cpu@10a05 {
@@ -287,9 +332,12 @@ cpu_p35: cpu@10a05 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_5>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1_die1>;
 		};
 
 		l2_cache_3: l2-cache-3 {

-- 
2.56.0


