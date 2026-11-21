Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795261481;
	b=JZi+oZQ7B88uYd2Yj6ahWLGQJgYH53M85bbmgtEBv+0Zc4P0Ar9ibQC26xMCyqmzY5ik
	 tBjolt3h+N5utgnqpKQVhJIwvenllf61ONwm6nCwLMHji2RzOiGTpSF+BRKmIGqNxrEVa
	 +vj+bNjqVF0tEivB+ZLnEofbJAqSvi3lGTQuCKlec0p0PcI3XpI4ZNFkJEjLLUoCJa/LK
	 ZQMj+NfJci+rpp3ySxKz0xc+AvLvb8M4aK8geha8drmrJ6T+Im0oVaNMvdSIhF3pZaNmW
	 T7uadMyhYQJ6p14lN1Am+0c11c3qkIX6c0ainmo/SkTEQUevNVDB/6y50GoE1V5BZXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261481;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=XHk0qq4OewpWXy/p1sboykGoZ4d8guL0nkEJcam1UF0=;
	b=QsiFJyPbJgs0tt3fpPFYmG8vcuO6DxpM1Wk1tH5HQqR1zyWejZW5pdSZVB+NwsUoPXC4
	 dvrZvWxPlXnI7vgBZFlZk7enODpNTJHa255wvBwgEHZFL8Jt5VNgRQmPkYZGpMsjpTO2p
	 Yr+5+vqIYZqMsikA/hyj/G0yYEBWBfAG0N3qvVZaPbiMmk53+zpliQeIPvabq8VhuKTjc
	 OBIJ0c+mgQR0LqFpwkbO3Ls4t16IMcypAZVxJMgWbrWKqUHSFt8KQXpuK6gWiKcDwOjwa
	 oTCma9qFZZjhmQVrOVedyM+PqPKDRk+9Bu3/K1q+QYNEQe+Nb+lcrOpUbc6t/FnDD+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYezfrOq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B56606A688;
	Sat, 21 Nov 2026 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYezfrOq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795261480;
	b=UiFcevvYxBiNBVAaBmh8TLW+w6pqTBbNSGOK6Pz8WTMNj5Qs8zZuMjxyxkLXioRqt34T
	 8COXYl9Sv3NtZQliHrq4qdAbAN2hd1/ai4AFrwXfcVHApfoDqP75ULhPT9K2TU2GxJnIW
	 nhezVhHyLXLQuEpBNRuDMMoDVGYyg2yCwB7ZL6Qk3tkIGr/tuShWFxnr/pk4HBajTiPTO
	 +kxzLCns6lXhXo2tEljIhNxQFA9TKNtQJsefeJoDajNuZ7gf1UvCe5x0QSJ2r2WTBzWDF
	 7Vpbvs1SwFXeRrSifealhZudLDaeaHWbnHtqm4N9olvRYBd51nNkk/ZFbDJ1hLK4IjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795261480;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=XHk0qq4OewpWXy/p1sboykGoZ4d8guL0nkEJcam1UF0=;
	b=BauJL7oFzzIsfTJTpbTMkRDmgBu58OdjlZkaBZe8/u92MLvCmybqEZCEi7vIogS8cQe+
	 imiylJmWz8vggY94rTHPvqpDua9Lby0NaKEw1T0x5vnjc7DGJmmSvtgTq4ajlOBdCOmKM
	 0iaSChpL9z9Q2TQeQmrhf65rBv/g1TAKj+Wkq/zWzIO4nsBLS4EKL/SZDhxwPZlUvW+WJ
	 R/J5JL3fTVFfvpTOR9LMDFla2jSVm8mrbg7GgVh/EPlNt4A2nn3H2/k+N4QNs+vZ3tEk7
	 jZjcc5VhK1LzITr1aAjlfWjgvlYlAO/3JF+WOCAPiEshRRocp5NCRyOEMxfFaSAM4dw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4195B1F000CF;
	Sat, 21 Nov 2026 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795261480;
	bh=XHk0qq4OewpWXy/p1sboykGoZ4d8guL0nkEJcam1UF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UYezfrOqFy9soyMnxRNTCIdftNWt++1AnhwisgJVelyaXueeF9xj2pBcciSCBvaOJ
	 N54jT1v62q+cE1B9ROtDDRwpUR2wEsctKST9fgs8UlJEvy1YLOqhKz1OW9XAP9eZPB
	 cm63Ash53SLI3PQH5WpcZ1kReqYbU2/SFBFphVa3oiK3jbCXO0ufatj/3nlLuEY644
	 J7wV80gHIO0Tzz3jFucUeHTldtTg2F1X9v/sDGwtqN97RLM6t4eXMSEaWEcrgyzs7+
	 MREq5eLTwT0HH0RGmgRvPf+ppEoaOsmlXaVjghXbO0LLRv2N9UySp3DP1U0OgvuNtW
	 9occsPzzi+s6Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C2FFF4BC1C;
	Sat, 21 Nov 2026 11:44:37 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 11:42:48 +0000
Subject: [PATCH 3/4] arm64: dts: apple: t6030: Add CPU frequency scaling
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
Message-Id: <20261121-m3-cpufreq-opp-v1-3-42a0c07c48a4@gmail.com>
References: <20261121-m3-cpufreq-opp-v1-0-42a0c07c48a4@gmail.com>
In-Reply-To: <20261121-m3-cpufreq-opp-v1-0-42a0c07c48a4@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795261476; l=9815;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=QgVq5aXsZJKMzLs2agAzkYFjmXr3mEm56FOcA4htlbg=;
 b=Nqgh2sUbMPY3wXyp+yzuM2WAqEtPhBzzvRKj0HAApz5ylD1TKD4UUtpmhwzAc5wf/MbYysAGp
 VLV937v/9ToAvREc89bC+EUgzVvH5v1Q9YNTz4KjoHkYJLv0g00unps
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


