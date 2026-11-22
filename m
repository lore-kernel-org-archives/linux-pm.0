Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795306717;
	b=yF1tfNKCoI/e4zgrZTnm/LQpNnAdZoaenGUQr1PvutySXmhn8AJdrUC3Cpf0KuNTc1y1
	 sqd/1Xcrq2ST9tc/G31pVj8UjPcfpsbLnay9wd9Ax8KgJb0ckRJoSfOmpwy0WciHweLRv
	 I3HDehUcVpsiQ7/ou3EugRDVzTbj6ekgQ7saPtayRZwraDQveoOavfI5YQFhV+SoME2dN
	 tIN7iCWv5LNAGHgupGy/lyCspaoTSfrdZyybe2pbhxGu9c1HB86OnWZgQXk3S5PCS+BlM
	 FF9JHiThKNh/Tm4K2yskBwmOh2bqI9GunP3pAnhCXYyjbfltjHZRvWJH1V9Fa/FCMEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306717;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=XHk0qq4OewpWXy/p1sboykGoZ4d8guL0nkEJcam1UF0=;
	b=rvwy9uKgFD6XlUfRuFgL5nBtLSt8z+6JcgAs1b54dNFV9lIwuwtrm3B96SBrtjwWwwx0
	 fUo1dySK8hjXRmbpqG3N9qQ9BEgs65qddnoO0sL/4DGyVFD6MYwM0CiI9SbT5Uu3QOsnk
	 J0899u1q6ekPJrd9qSTCeIOLStxClF/zaQ/h9YBlpkkbVXwQIyG+AOT5w8Pwep2Ei/5jN
	 Gavd+9tjtnCGrfR5MzteOZGUt/+1bQrFWTXXNJYGzWBHsy8tu0cKHFSGtfMMcyIAxZ1nr
	 PjWxusjDV37ZBO7X+n/aTwF+Mq3FcxXwW/AjqKJIh2DnN+ehKQE/pl7+HLUodkIHGBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ug+++Lkp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C1606A32C;
	Sun, 22 Nov 2026 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ug+++Lkp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795306716;
	b=WdoP7jeiEyW1lEhWxC7rUgJ3kTxxTSSrHez+yeiEQf7aOHY8dA7PiKc4wxkTsFU+b3kI
	 nhXiHOYWoT7kYejYpXGA7hnywvvGlBef6wfyXpuH7uupHLSxvsBN5K7gm5Dihy9vu0okp
	 EdJ7UorZMGHlYHjnVElgiaKAQ+1vQuX5bWbrcjhn5qandZZq+58N0o2dpUNW+7ukJzC0O
	 g5iAdwIDGDZqEQreru5ok78ZDQ5/yHScLh9dsFvtUmCxaxzt9vBPr7xa5dk8UpT3NcoKx
	 N+J3p95eAL2qid2C7dAB/G4NIClBp8fSORgfPOE6l/jz4FP3x32DLrGP3Ocqhk+P0NA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795306716;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=XHk0qq4OewpWXy/p1sboykGoZ4d8guL0nkEJcam1UF0=;
	b=xCn3QvfFcriatJD0Gl6noRuj5uR1XpHeEHBT6ySCvWDiCzrQa4or2ZxcYlMYd9YFkDsQ
	 2WmZbW9waq3pgRcFik7+AB3er6MAFMqxjBCVyG7b2iNmzbVD25BXdBAAZukKel4+a2ioe
	 FjXZ9djuNGIciltOjspbQCZkMyyYQuxSYjPMExPbNQ5zWCdC+45aa8u3oLKetquAorn1W
	 c8VUqLOBTqNmSpXiQiATQvaH51tv8uk5xnA9Ld/gssQp7nfthfOM3Q9dn+QHeUvUcRtjV
	 U94OOYmSxfwLFqQmeEgMmVyKgKoGeZeww96dPEybUuPIMqL5YzxRB90WGKdABwuk9LQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BB7C51F000CA;
	Sun, 22 Nov 2026 00:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306716;
	bh=XHk0qq4OewpWXy/p1sboykGoZ4d8guL0nkEJcam1UF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ug+++LkpphNbcSVhOGiFVC1NSqco3umZnfQBhtVFYRm7yf+Fxy50v5rdGrKzAzldj
	 GXg1jXJX1AsUV5+K8pNA9H2HMUXJfWaJBrBQir3i4daakUElKF+AcTeb/W6BV4OMVK
	 SrJObZ3tlVFIA7nhDe6kCnphH2ck+XxAzUZpEAnth+bglhXeeVsNssskTTClV7/w3R
	 F7xP8z2UYc+H9U3alCqRbSMLi7F7Zj7uqYKbDHdsDZoPpcbsmF0UoOZ6frgST0BjNj
	 wopHV2UAgK3Db8DQZeAmD6J0ZcPtO0dLKC8v/YwttxtJ+YYLBva/SXrsJNOavrzTBc
	 KXuyXL8ilS7fw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 48C894BE8E;
	Sun, 22 Nov 2026 00:18:34 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:18:24 +0000
Subject: [PATCH v2 3/5] arm64: dts: apple: t6030: Add CPU frequency scaling
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
Message-Id: <20261122-m3-cpufreq-opp-v2-3-3c19963f55ee@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795306712; l=9815;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=QgVq5aXsZJKMzLs2agAzkYFjmXr3mEm56FOcA4htlbg=;
 b=fqylQrWHSFZRl9SR/umzm9GDag6oourzl3YgpzfccjtTUTR2Si1OdyjV3yASJHtPlpmjLQUZ9
 1dLOOkWIFGxDO1240ucwIqRJa9W/xSS6iRQ1DcXzHeozt8AYw18ozEF
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Janne Grunau <j@jannau.net>

Add the cluster cpufreq controller nodes, operating performance point
tables, and CPU capacity values for the Apple T6030 (M3 Pro) Sawtooth
efficiency and Everest performance clusters.

The capacity-dmips-mhz values were determined by measuring single-core
CoreMark [1] Iterations/Sec/MHz at fixed frequencies under the
performance governor.

[1] https://github.com/eembc/coremark

Signed-off-by: Janne Grunau <j@jannau.net>
Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 arch/arm64/boot/dts/apple/t6030.dtsi | 228 +++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/apple/t6030.dtsi
index 85a16d03e22f..a5c2fadae6cc 100644
--- a/arch/arm64/boot/dts/apple/t6030.dtsi
+++ b/arch/arm64/boot/dts/apple/t6030.dtsi
@@ -87,9 +87,12 @@ cpu_e00: cpu@0 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <851>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e01: cpu@1 {
@@ -99,9 +102,12 @@ cpu_e01: cpu@1 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <851>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e02: cpu@2 {
@@ -111,9 +117,12 @@ cpu_e02: cpu@2 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <851>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e03: cpu@3 {
@@ -123,9 +132,12 @@ cpu_e03: cpu@3 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <851>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e04: cpu@4 {
@@ -135,9 +147,12 @@ cpu_e04: cpu@4 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <851>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e05: cpu@5 {
@@ -147,9 +162,12 @@ cpu_e05: cpu@5 {
 			cpu-release-addr = <0 0>; /* to be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <851>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_p00: cpu@10100 {
@@ -159,9 +177,12 @@ cpu_p00: cpu@10100 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p>;
 		};
 
 		cpu_p01: cpu@10101 {
@@ -171,9 +192,12 @@ cpu_p01: cpu@10101 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p>;
 		};
 
 		cpu_p02: cpu@10102 {
@@ -183,9 +207,12 @@ cpu_p02: cpu@10102 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p>;
 		};
 
 		cpu_p03: cpu@10103 {
@@ -195,9 +222,12 @@ cpu_p03: cpu@10103 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p>;
 		};
 
 		cpu_p04: cpu@10104 {
@@ -207,9 +237,12 @@ cpu_p04: cpu@10104 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p>;
 		};
 
 		cpu_p05: cpu@10105 {
@@ -219,9 +252,12 @@ cpu_p05: cpu@10105 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p>;
 		};
 
 		l2_cache_0: l2-cache-0 {
@@ -239,6 +275,184 @@ l2_cache_1: l2-cache-1 {
 		};
 	};
 
+	sawtooth_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp01 {
+			opp-hz = /bits/ 64 <744000000>;
+			opp-level = <1>;
+			clock-latency-ns = <7700>;
+		};
+
+		opp02 {
+			opp-hz = /bits/ 64 <1044000000>;
+			opp-level = <2>;
+			clock-latency-ns = <21200>;
+		};
+
+		opp03 {
+			opp-hz = /bits/ 64 <1476000000>;
+			opp-level = <3>;
+			clock-latency-ns = <26400>;
+		};
+
+		opp04 {
+			opp-hz = /bits/ 64 <2004000000>;
+			opp-level = <4>;
+			clock-latency-ns = <40500>;
+		};
+
+		opp05 {
+			opp-hz = /bits/ 64 <2268000000>;
+			opp-level = <5>;
+			clock-latency-ns = <44400>;
+		};
+
+		opp06 {
+			opp-hz = /bits/ 64 <2448000000>;
+			opp-level = <6>;
+			clock-latency-ns = <47200>;
+		};
+
+		opp07 {
+			opp-hz = /bits/ 64 <2640000000>;
+			opp-level = <7>;
+			clock-latency-ns = <52000>;
+		};
+
+		opp08 {
+			opp-hz = /bits/ 64 <2748000000>;
+			opp-level = <8>;
+			clock-latency-ns = <52000>;
+		};
+	};
+
+	everest_opp: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp01 {
+			opp-hz = /bits/ 64 <696000000>;
+			opp-level = <1>;
+			clock-latency-ns = <8600>;
+		};
+
+		opp02 {
+			opp-hz = /bits/ 64 <1092000000>;
+			opp-level = <2>;
+			clock-latency-ns = <18700>;
+		};
+
+		opp03 {
+			opp-hz = /bits/ 64 <1356000000>;
+			opp-level = <3>;
+			clock-latency-ns = <20700>;
+		};
+
+		opp04 {
+			opp-hz = /bits/ 64 <1596000000>;
+			opp-level = <4>;
+			clock-latency-ns = <24800>;
+		};
+
+		opp05 {
+			opp-hz = /bits/ 64 <1884000000>;
+			opp-level = <5>;
+			clock-latency-ns = <30700>;
+		};
+
+		opp06 {
+			opp-hz = /bits/ 64 <2172000000>;
+			opp-level = <6>;
+			clock-latency-ns = <34400>;
+		};
+
+		opp07 {
+			opp-hz = /bits/ 64 <2424000000>;
+			opp-level = <7>;
+			clock-latency-ns = <39600>;
+		};
+
+		opp08 {
+			opp-hz = /bits/ 64 <2616000000>;
+			opp-level = <8>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp09 {
+			opp-hz = /bits/ 64 <2808000000>;
+			opp-level = <9>;
+			clock-latency-ns = <41800>;
+		};
+
+		opp10 {
+			opp-hz = /bits/ 64 <2988000000>;
+			opp-level = <10>;
+			clock-latency-ns = <45300>;
+		};
+
+		opp11 {
+			opp-hz = /bits/ 64 <3144000000>;
+			opp-level = <11>;
+			clock-latency-ns = <46700>;
+		};
+
+		opp12 {
+			opp-hz = /bits/ 64 <3288000000>;
+			opp-level = <12>;
+			clock-latency-ns = <49200>;
+		};
+
+		opp13 {
+			opp-hz = /bits/ 64 <3420000000>;
+			opp-level = <13>;
+			clock-latency-ns = <53900>;
+		};
+
+		opp14 {
+			opp-hz = /bits/ 64 <3576000000>;
+			opp-level = <14>;
+			clock-latency-ns = <53700>;
+		};
+
+		opp15 {
+			opp-hz = /bits/ 64 <3624000000>;
+			opp-level = <15>;
+			clock-latency-ns = <54000>;
+		};
+
+		opp16 {
+			opp-hz = /bits/ 64 <3708000000>;
+			opp-level = <16>;
+			clock-latency-ns = <54000>;
+		};
+
+		opp17 {
+			opp-hz = /bits/ 64 <3780000000>;
+			opp-level = <17>;
+			clock-latency-ns = <54100>;
+		};
+
+		opp18 {
+			opp-hz = /bits/ 64 <3864000000>;
+			opp-level = <18>;
+			clock-latency-ns = <54300>;
+		};
+
+		opp19 {
+			opp-hz = /bits/ 64 <3960000000>;
+			opp-level = <19>;
+			clock-latency-ns = <58400>;
+		};
+
+		opp20 {
+			opp-hz = /bits/ 64 <4056000000>;
+			opp-level = <20>;
+			clock-latency-ns = <58700>;
+		};
+	};
+
 	reserved-memory {
 		ranges;
 		#address-cells = <2>;
@@ -254,6 +468,20 @@ soc: soc {
 		nonposted-mmio;
 		#size-cells = <2>;
 
+		cpufreq_e: performance-controller@210e20000 {
+			compatible = "apple,t6030-cluster-cpufreq",
+				     "apple,t8112-cluster-cpufreq";
+			reg = <0x2 0x10e20000 0x0 0x1000>;
+			#performance-domain-cells = <0>;
+		};
+
+		cpufreq_p: performance-controller@211e20000 {
+			compatible = "apple,t6030-cluster-cpufreq",
+				     "apple,t8112-cluster-cpufreq";
+			reg = <0x2 0x11e20000 0x0 0x1000>;
+			#performance-domain-cells = <0>;
+		};
+
 		i2c1: i2c@289014000 {
 			compatible = "apple,t6030-i2c", "apple,t8103-i2c";
 			reg = <0x2 0x89014000 0x0 0x4000>;

-- 
2.56.0


