Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795261480;
	b=y3Bf18Dv7EDYuDfkdxwL9rzpdeS0x5vsgIQdYYzaUkTtSL8Z7oSRRjBmOW8ucY6TZB9f
	 XMNJImd9OkVSIr8Bfoyr1Sh+aMzm7lz6eHIjbVUB4sLjjvZfC+DET34KQYVsGubbXft78
	 UY3TJoDUa2W04PqLbAR/z/WybCordwAhnHRxx6VZHltSIItq5GOsbEr6W9mWiQksWaJDk
	 BvztjFlbigDPnAQMkIXzm6WvELaUz6EX1sr7z59Mw+Jy34jnRYdnJ5uyAWEHQEwad7Mht
	 Yhpv5T3j9GoS8+AAcJ/qAdy4WZb5b5F/fkokU5rGTL7+OB6s/s36xgy/Yd01CY5CJbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261480;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=atNCITj4VwYEN2ifZbi+GZkuid5vipP6wFxYeAeVWnA=;
	b=jzI72f+4qVWCBhYO2Cf/QOqZ0qBs5StV6HW7622vmud9awsZLbMLfenbEOnUZflBIadH
	 mPGOImtZcJDgJ5HU+tc0O0AlcQCWaC6FFXYnycTgNNXUCir2vlVL3VzqLB07DJoYlOLtX
	 v36yGr6y2FuTPpjcwYaCRuwLIdFSw+abnXWi5GcKHhsKGCWDMTIVi7bu2lTyUGh/TkiWH
	 kI7n+855KFB8E2Et5EwzJwe3/S/CnkU4c75UHMnX5t41wz8ZWrdwx7J5vsTTcyAoON0KG
	 xJhFSeET0hZxWGu0H91z+9OqSN3gH1nm9XzhNZOJuDUVe3luoybDp8OIMXtMmcXpfVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLNiLLLu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C8606A689;
	Sat, 21 Nov 2026 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLNiLLLu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795261480;
	b=ZkqF786K6JHBHdGcZf94vYN70+1CWMlmAnhJ8si0/Dz3M8kdRrylHKe+qejLn33bjD6O
	 WqVQHJc1FFubTDyaGOc42u9WFYZ4U86XWqxxWzUyks2gOklxoTbhbUD1PHeovSSYKjX6C
	 HjJjHjkMh8U5HahYDZF82CvyUF2Zp2QE/WCE/b2AjcNratq6biSERckEuMR8VymAamqxr
	 FSRmCBr+s6nZUlUe63pDInWO0EE4F2iI4E3pZCC8KmtpJwCh0YQs1QalyB6WHaAZgzZPZ
	 Z655cCCpMEDN5TUPBKg4WzoG7LeKj2mRBghE3XrgMRimpuFLBD7cyhazBwwsRNZ2fww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795261480;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=atNCITj4VwYEN2ifZbi+GZkuid5vipP6wFxYeAeVWnA=;
	b=3cvg3eMzCzxTEmc5/lzJa0vODOGyne3RH21uB1yzXbHwxcbw0idYkXUXmSwdAaJN32mB
	 fBc9nUKpKhN3IZU/5cfAeGSg5vBFQzr6lD1999ZCzOgwJjWU7Xb7BLmlvhMOJSwh4ggW8
	 bMmMpEmYyCekSv+NXLG5ESCLg0tv06NTgPe+hs8JcrsbP4NvJ2+K2Z2kHf3fvP9Q6HeuQ
	 EAX09JzCP5A920dewyevCr1yju39m6TeSG4a2J+lNi4WQ4Vcl4C/5i4xDdR4USDeHKLAh
	 fMwVb/eqlBa3o/ZiaZBA/sgQ0a1fhkWpQ1MmJkNsZlirpiEnkkzGf7O0DwXeSfGh3BQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5F8B21F000C4;
	Sat, 21 Nov 2026 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795261480;
	bh=atNCITj4VwYEN2ifZbi+GZkuid5vipP6wFxYeAeVWnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JLNiLLLu0h7JtBPyD9yUkXV/FMRAvSBhchLaUIYzoQLfKvuPeaFWn7NANinQP8pWL
	 NM4ygVC+NQ+BRwjhGZzZFSVnZHdbQ+wwk5Cq/Z4WjrNIjN4u3A/TFU5jliyfvM0vYW
	 BlVpPKPpMZHUaZeqkPq+b+DMrq1U/JugFCCtaYz9sLn0l0qIg8BFsxrMw5vyrcuAXI
	 mLp81eJO4bUYA8+k4SKjvJhw3xCM1rF3qsS3kj4zpqwzv+dAeKVN4MoeagQrvEGnFx
	 4EvLhuUqldCFQ5cU74pud0pQ8270YpPv0G639OqJjrTPLZoR1xyvGqddobD9O5GbAb
	 I9cQGdlrb9n7Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DFBA14BC20;
	Sat, 21 Nov 2026 11:44:37 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 11:42:49 +0000
Subject: [PATCH 4/4] arm64: dts: apple: t6031: Add CPU frequency scaling
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
Message-Id: <20261121-m3-cpufreq-opp-v1-4-42a0c07c48a4@gmail.com>
References: <20261121-m3-cpufreq-opp-v1-0-42a0c07c48a4@gmail.com>
In-Reply-To: <20261121-m3-cpufreq-opp-v1-0-42a0c07c48a4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795261476; l=11528;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=Gq8iF/bi9mfoajslHI1AmzrsOvZ7XFTGXui2PLFTZaE=;
 b=7FpCxCzsRYi1SakzqmEs6DlJDLHepr8OpOi4+WvRNxVQAPzL0RtJg7PQ1RlZpwy4/rtQN6Ucv
 ++n9bHehQePBJ6JOPIt7jLRJA9Ny8YD3LqjmUxUMwQWf4cZySjtE1Is
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
 arch/arm64/boot/dts/apple/t6031-base.dtsi | 213 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031-dieX.dtsi |  21 +++
 2 files changed, 234 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6031-base.dtsi b/arch/arm64/boot/dts/apple/t6031-base.dtsi
index f62ce0690182..772af1ea37b6 100644
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
@@ -272,6 +314,8 @@ cpu_p14: cpu@10204 {
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_2>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		cpu_p15: cpu@10205 {
@@ -284,6 +328,8 @@ cpu_p15: cpu@10205 {
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_2>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		l2_cache_0: l2-cache-0 {
@@ -308,6 +354,173 @@ l2_cache_2: l2-cache-2 {
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


