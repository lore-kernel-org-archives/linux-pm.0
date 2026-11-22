Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795306717;
	b=QQcQT8KaPcMY0h+J3jZnDY5n42eE8+xo+LaSrW5rVpiRDHnJf6CUrKzImIWeKafxFzv+
	 4IMuPp9S3BG21Vbcoa9cLXLd6MeWSYKuWjMvqz+D+6+qbVXPZ1m9gylVUxNEsostoEVFh
	 qX8xTZ11NtGrcB2OQFAeHIzFmxEGkBXCSsoRmiGVWiA8hLd+ugCEGm+qw4KYdlxtc/grZ
	 pYnGj+dNlHDDpZYLjophKhj09vw1i/7rfnTXq7Uhg+eM1q3PJyBoYGukujMUUoeVuNDva
	 3M5ZNJmctaulEQg3GVFhscIfhW2TSEM3EL3uAUWDQBknbO+6lbw+5S89w3VEoJ7PthA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306717;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=AYQ3h0rtIc/x4AHSlisRZpq0fWYnG7U/RHa57ZiYz8g=;
	b=kR/8a5BBBIT/UOK+aW5WQ600WcOA+G6vA2kV2JZPjHP0UK8bOUFipGt/YHmv78MOqC4F
	 6KcmLEMn5rnbwJ6HLobzU7/7fn8HVOiSrOK3dzm6QIODFt6vKtdheTYJ7TPg9RFF0t7MC
	 Cy5NLyMaubkA75Kl/kVM5ZN57R04SH9xGXshoy0hi2voU6/sOdCKtdpVYYNyje2cRD5ty
	 gf8HBUFpeyesDFV4Sa+sD8cBh3Sb8n77wLWTmr/+sOMED2NJfJsy7fv0EO/bE/pJxzyKB
	 LCzd4zx9p+t+szYc5Cus+mJVGGd6733+IwF6PmbHSERaDCEegJnpxewaNRDb949FwRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtws4cVd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F169606A334;
	Sun, 22 Nov 2026 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtws4cVd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795306717;
	b=Uyo+M2XpJbKHzNz93nScphX38Up82okjX4sVz5whcoPnj/gLZZ7R9/LlSzwR/L+kfI3D
	 250sVLVh7/IURpP5mlcb3pD1MMF/Mq8pLMwoQvhlDaWV6QoYiup2HvEJXXJJJH3zlNywp
	 2F4KhLxUUICh4bYEryygokwF3FEuoQBjjMfDKmgR8eQHoBkARYk+bRa0Yh80kc5wNLP/R
	 09aXZsw/fXthyX0C+GFz9oUa3Z2KPiaHIDEg71Ip3ZqY+mxY8ZHnjziX+efTZsaYHcvWZ
	 H4XmEss24vq2tBGYlWPbgvlKRfTBzFakBICTyabndq7g+EBJ8quvZewEUOoqqYB47Fw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795306717;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=AYQ3h0rtIc/x4AHSlisRZpq0fWYnG7U/RHa57ZiYz8g=;
	b=UF92B+avYHZsNpcHjFvTkIrU62dn4S/Pv7su3992pqE76cIfp5VR8P4KnIgmCgpzg0wK
	 tiZxpMB+2ci9/zWRwT0P5B2BQ0zOnl0iMYeRbqD4uDgp5FQ4dvx4TsuHHzM+PxkfuattT
	 8B7Jq814wFf8LARBrmbakPbs37AkK6jEexNzoJoFEYJoa7paCt23bAzPj5xHj2Scd3RCm
	 4w24P3cU5M4cd7iH9pampFQ5H0TMZYJIxdXhFMRSXJ189CMgNZ+XPUkHbApyGyoQh53eJ
	 XdHRdluRFofDxzi7D2ep2IoRUTuZGb8bhXAyoGdphTLT+BSN9PjN4QVPnu+CZrs0MYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D66CE1F000CF;
	Sun, 22 Nov 2026 00:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306717;
	bh=AYQ3h0rtIc/x4AHSlisRZpq0fWYnG7U/RHa57ZiYz8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dtws4cVdTv0mbL8sJPpdG4ftdr6WCBWTo+ikwad8DLWZWKsRFukpM7k7AljwgCmr/
	 hANG4MXPkKcATxIw+FM2ay+T7UtYt1tkwDxCjUf/1PdP6qVSlIsxY8aMP5vxqHXB83
	 ZvwpNCImAXCWSG3CepzoomHBQoKYSA1qx/xGFz/OEGIZPEcwTzCespFa4C6P4M3tSM
	 e2H33zkf39fvfG9/CWIP1VdBkj3B6QQmMh+xcoWmA6JAj6bfUpyw7nLdoMBnaKcjDY
	 3ntQEgxC9aQlhe5fY4jsUGhHW0UTwO7bWJv/FQups0855zRSwLiutUQxwvEHchRqg2
	 1HCvC0GfWOF/g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 637404BE92;
	Sun, 22 Nov 2026 00:18:34 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:18:25 +0000
Subject: [PATCH v2 4/5] arm64: dts: apple: t6031: Add CPU frequency scaling
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-m3-cpufreq-opp-v2-4-3c19963f55ee@gmail.com>
References: <20261122-m3-cpufreq-opp-v2-0-3c19963f55ee@gmail.com>
In-Reply-To: <20261122-m3-cpufreq-opp-v2-0-3c19963f55ee@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Reeves <michael.reeves077@gmail.com>, 
 Yureka Lilian <yureka@cyberchaos.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795306712; l=11794;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=YkEdJfg3jJmfUnmIG05lwn+Vi7HZhvhrxExzaxeo/fs=;
 b=Cuw1itj9lk6F51NPgB3tAtdRDCi0rnDR5xK6N0CGvfMZtGWBf6M0K7LJ0QUtIK61yRCSiJBIk
 DO1WtUweVpzAeTbSe/NQoy1smJlNzoQ2OD9okTGONORVjAFrfevfsM+
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Yureka Lilian <yureka@cyberchaos.dev>

Add the cluster cpufreq controller nodes, operating performance point
tables, and CPU capacity values for the Apple T6031/T6034 (M3 Max)
Sawtooth efficiency and Everest performance clusters.

The capacity-dmips-mhz values were determined by measuring single-core
CoreMark [1] Iterations/Sec/MHz at fixed frequencies under the
performance governor.

[1] https://github.com/eembc/coremark

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 arch/arm64/boot/dts/apple/t6031-base.dtsi | 215 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031-dieX.dtsi |  21 +++
 2 files changed, 236 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6031-base.dtsi b/arch/arm64/boot/dts/apple/t6031-base.dtsi
index f62ce0690182..eda83b526e1a 100644
--- a/arch/arm64/boot/dts/apple/t6031-base.dtsi
+++ b/arch/arm64/boot/dts/apple/t6031-base.dtsi
@@ -101,9 +101,12 @@ cpu_e00: cpu@0 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <870>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e01: cpu@1 {
@@ -113,9 +116,12 @@ cpu_e01: cpu@1 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <870>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e02: cpu@2 {
@@ -125,9 +131,12 @@ cpu_e02: cpu@2 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <870>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e03: cpu@3 {
@@ -137,9 +146,12 @@ cpu_e03: cpu@3 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <870>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_p00: cpu@10100 {
@@ -149,9 +161,12 @@ cpu_p00: cpu@10100 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0>;
 		};
 
 		cpu_p01: cpu@10101 {
@@ -161,9 +176,12 @@ cpu_p01: cpu@10101 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0>;
 		};
 
 		cpu_p02: cpu@10102 {
@@ -173,9 +191,12 @@ cpu_p02: cpu@10102 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0>;
 		};
 
 		cpu_p03: cpu@10103 {
@@ -185,9 +206,12 @@ cpu_p03: cpu@10103 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0>;
 		};
 
 		cpu_p04: cpu@10104 {
@@ -197,9 +221,12 @@ cpu_p04: cpu@10104 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0>;
 		};
 
 		cpu_p05: cpu@10105 {
@@ -209,9 +236,12 @@ cpu_p05: cpu@10105 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p0>;
 		};
 
 		cpu_p10: cpu@10200 {
@@ -221,9 +251,12 @@ cpu_p10: cpu@10200 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_2>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		cpu_p11: cpu@10201 {
@@ -233,9 +266,12 @@ cpu_p11: cpu@10201 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_2>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		cpu_p12: cpu@10202 {
@@ -245,9 +281,12 @@ cpu_p12: cpu@10202 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_2>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		cpu_p13: cpu@10203 {
@@ -257,9 +296,12 @@ cpu_p13: cpu@10203 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_2>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		cpu_p14: cpu@10204 {
@@ -269,9 +311,12 @@ cpu_p14: cpu@10204 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_2>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		cpu_p15: cpu@10205 {
@@ -281,9 +326,12 @@ cpu_p15: cpu@10205 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_2>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		l2_cache_0: l2-cache-0 {
@@ -308,6 +356,173 @@ l2_cache_2: l2-cache-2 {
 		};
 	};
 
+	sawtooth_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp01 {
+			opp-hz = /bits/ 64 <1020000000>;
+			opp-level = <1>;
+			clock-latency-ns = <7200>;
+		};
+
+		opp02 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-level = <2>;
+			clock-latency-ns = <22000>;
+		};
+
+		opp03 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-level = <3>;
+			clock-latency-ns = <28000>;
+		};
+
+		opp04 {
+			opp-hz = /bits/ 64 <2088000000>;
+			opp-level = <4>;
+			clock-latency-ns = <38000>;
+		};
+
+		opp05 {
+			opp-hz = /bits/ 64 <2484000000>;
+			opp-level = <5>;
+			clock-latency-ns = <46000>;
+		};
+
+		opp06 {
+			opp-hz = /bits/ 64 <2568000000>;
+			opp-level = <6>;
+			clock-latency-ns = <46000>;
+		};
+	};
+
+	everest_opp: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		/* pstate #1 is a dummy clone of #2 */
+		opp02 {
+			opp-hz = /bits/ 64 <1092000000>;
+			opp-level = <2>;
+			clock-latency-ns = <7200>;
+		};
+
+		opp03 {
+			opp-hz = /bits/ 64 <1356000000>;
+			opp-level = <3>;
+			clock-latency-ns = <19000>;
+		};
+
+		opp04 {
+			opp-hz = /bits/ 64 <1596000000>;
+			opp-level = <4>;
+			clock-latency-ns = <20000>;
+		};
+
+		opp05 {
+			opp-hz = /bits/ 64 <1884000000>;
+			opp-level = <5>;
+			clock-latency-ns = <22000>;
+		};
+
+		opp06 {
+			opp-hz = /bits/ 64 <2172000000>;
+			opp-level = <6>;
+			clock-latency-ns = <30000>;
+		};
+
+		opp07 {
+			opp-hz = /bits/ 64 <2424000000>;
+			opp-level = <7>;
+			clock-latency-ns = <34000>;
+		};
+
+		opp08 {
+			opp-hz = /bits/ 64 <2616000000>;
+			opp-level = <8>;
+			clock-latency-ns = <37000>;
+		};
+
+		opp09 {
+			opp-hz = /bits/ 64 <2808000000>;
+			opp-level = <9>;
+			clock-latency-ns = <38000>;
+		};
+
+		opp10 {
+			opp-hz = /bits/ 64 <2988000000>;
+			opp-level = <10>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp11 {
+			opp-hz = /bits/ 64 <3144000000>;
+			opp-level = <11>;
+			clock-latency-ns = <41000>;
+		};
+
+		opp12 {
+			opp-hz = /bits/ 64 <3288000000>;
+			opp-level = <12>;
+			clock-latency-ns = <43000>;
+		};
+
+		opp13 {
+			opp-hz = /bits/ 64 <3420000000>;
+			opp-level = <13>;
+			clock-latency-ns = <44000>;
+		};
+
+		opp14 {
+			opp-hz = /bits/ 64 <3516000000>;
+			opp-level = <14>;
+			clock-latency-ns = <46000>;
+		};
+
+		opp15 {
+			opp-hz = /bits/ 64 <3576000000>;
+			opp-level = <15>;
+			clock-latency-ns = <46000>;
+		};
+
+		opp16 {
+			opp-hz = /bits/ 64 <3624000000>;
+			opp-level = <16>;
+			clock-latency-ns = <46000>;
+		};
+
+		opp17 {
+			opp-hz = /bits/ 64 <3708000000>;
+			opp-level = <17>;
+			clock-latency-ns = <46000>;
+		};
+
+		opp18 {
+			opp-hz = /bits/ 64 <3780000000>;
+			opp-level = <18>;
+			clock-latency-ns = <45000>;
+		};
+
+		opp19 {
+			opp-hz = /bits/ 64 <3864000000>;
+			opp-level = <19>;
+			clock-latency-ns = <45000>;
+		};
+
+		opp20 {
+			opp-hz = /bits/ 64 <3960000000>;
+			opp-level = <20>;
+			clock-latency-ns = <54000>;
+		};
+
+		opp21 {
+			opp-hz = /bits/ 64 <4056000000>;
+			opp-level = <21>;
+			clock-latency-ns = <54000>;
+		};
+	};
+
 	reserved-memory {
 		ranges;
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/apple/t6031-dieX.dtsi b/arch/arm64/boot/dts/apple/t6031-dieX.dtsi
index 1624651c1d92..bce4d677ae4c 100644
--- a/arch/arm64/boot/dts/apple/t6031-dieX.dtsi
+++ b/arch/arm64/boot/dts/apple/t6031-dieX.dtsi
@@ -7,6 +7,27 @@
  */
 
 &SOC_NODE {
+	DIE_NODE(cpufreq_e): performance-controller@210e20000 {
+		compatible = "apple,t6031-cluster-cpufreq",
+			     "apple,t8112-cluster-cpufreq";
+		reg = <0x2 0x10e20000 0x0 0x1000>;
+		#performance-domain-cells = <0>;
+	};
+
+	DIE_NODE(cpufreq_p0): performance-controller@211e20000 {
+		compatible = "apple,t6031-cluster-cpufreq",
+			     "apple,t8112-cluster-cpufreq";
+		reg = <0x2 0x11e20000 0x0 0x1000>;
+		#performance-domain-cells = <0>;
+	};
+
+	DIE_NODE(cpufreq_p1): performance-controller@212e20000 {
+		compatible = "apple,t6031-cluster-cpufreq",
+			     "apple,t8112-cluster-cpufreq";
+		reg = <0x2 0x12e20000 0x0 0x1000>;
+		#performance-domain-cells = <0>;
+	};
+
 	DIE_NODE(pmgr): power-management@292280000 {
 		compatible = "apple,t6031-pmgr", "apple,t8103-pmgr",
 			     "syscon", "simple-mfd";

-- 
2.56.0


