Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795306716;
	b=WHDx1W+5FlIk+3gGI3znJQH0Cymd80pHR+BwM2VBjp+wf+8e9/w5WT6PyDGvzp/ssf/v
	 KlCPZlLOgSpK8FbejCS5LhXo9krVq0p9zU+om/vXcc06KGYyu3AumkcTX+n1FeR9b9MUN
	 oVNswQjdxz3SeLyNuRZSaSa7rWDs7A+hGKvl8oJ8rZ5XXqBYD8iVWjO+rrlWhNnWVtjqK
	 TI7jb8PjhjWeCaA47DqkmBn3S4RlGjVt/VpIvFW5qVoT62cixOAb63QKMIby+W7I4ymzO
	 wFCrWSASWTzbZUV3wEOWvuSFUe46vg2iEnvwbYSh7VsCIEy+kTul5xzRs/N7alnhZCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306716;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=BgRa25c2yeRWcTsSfy5rWDhEKsR4WN0Hp2Qr9mr0vew=;
	b=zOrOcRfs+L3fCIW+KGk6brFVnHO1WNxiLgAROzxBP/fPperU7MLaYERiB/FZOPISdVQd
	 jXDo5FBU2lUfTyTbVI/BCaG71j+SooRWtO8My5ybozvRVzg1u0NouxYHylMrAk+vzzg8Q
	 M/mNatIbEsia/GDFWYkGtWFNHBHmTx9LO5rldELFPlHd5/9x8Oiq25CDXf/89aXqzNyJO
	 z6GehUrleCCbP66FruRvURW0NrodobQPBzN34dmh3hBkKcjr73S52j836EobuTmchxnBu
	 8awW2WBIvNsJvA5htb/FgNDRc66ubEFOiZxbuo7TyFXNTLVe3ZUPGCM25B4knKXTA6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJbEUIqH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF30606A681;
	Sun, 22 Nov 2026 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJbEUIqH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795306716;
	b=EXlNzcF6EmWiYY9ff2JEvuJSXvYmapubEKYAwW8ieL+QJ7C3t4ECI7x6Alp+aUSlCkPx
	 o1p1MiJiY+0YWPSre6ZfoMeX60EXm8L1OAZ1VoIdThpMyKNcwML3M1hLvO1xd+riTCOo3
	 /wklfTsbc3Z7XR4T8w0XtK9veHo07YaRYSqsvIAz+gjyl1S7hUI9xmvGdtTXO+SLZvWOC
	 12KMEFfYLScTOg67l+jvFnIA/xYWqM2YCF1GCn6BlztdQ2XG7nzDhA/eQYvzn38AGXnDo
	 MUyfeju6RME43J9yI5QHP3kYDqESN7MKULLu8pDcHOqQd+ux3DF84hV6LwGJQxXCP2Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795306716;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=BgRa25c2yeRWcTsSfy5rWDhEKsR4WN0Hp2Qr9mr0vew=;
	b=UlJy+jLcTYUnsMAi4iOw1k2AR5KobjELHmxETATdMXtKE13EhKU3O1weUYGYZh5So2x9
	 Wd9iDuUv1PxuYFTTlqMCR7YFCKU3MN63FbvgwYFjeKb3kZNQ2AB5+wF7Z9nzS5QhBpRcx
	 Vor6xNrrnkV4LLOJBvA8gDrB0CDEU+zqa+elzmUv1VhQ3LGsCaE0i36poi0hKgCWvToiu
	 l0izVorRKkRiWvofXwx5q9sAmvsbWEzXRnwn4O/s/jL7O7WxEbeDuhIGIIRnkaUXjSWjJ
	 z9rOSit/qTm7Y7npdZ7Qq5N9c8FpJp211XnNdH6x2tr5ej14ED9o3sfkWLxqcZzuvDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A1C661F000C6;
	Sun, 22 Nov 2026 00:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306716;
	bh=BgRa25c2yeRWcTsSfy5rWDhEKsR4WN0Hp2Qr9mr0vew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZJbEUIqHsxaWtfI5mJ1e1XDECr5SqINnlMSttuTGFD60E6H1uC0n0ST1vmwSbMM6a
	 4VKgLLfivjX1o3E8aumXJJWq9zo8XQwLmqmoSRLYuj/H6QOCbEW6N0G4EVvyGcnf06
	 SUKhXQiqwYfrhuBH/J6wQArNJzbWwRnWeMikQV+D9Uq19M0aLUonpCI/q46NyKQgM0
	 eCvUc9jolrfh0Sf9NE7Co/4yvCXZCBqYMEV5gaY4zsvS8HPUh+LLQmKesQLF3Jdp9s
	 i/ezq0NbamyNzAyBUGVp6d6xhELNaoTOzngr1gpBEcBTNPqDJp3lSKsKJHWfiPoEqR
	 dfLaXEIXihHTg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2EA324BE8A;
	Sun, 22 Nov 2026 00:18:34 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:18:23 +0000
Subject: [PATCH v2 2/5] arm64: dts: apple: t8122: Add CPU frequency scaling
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
Message-Id: <20261122-m3-cpufreq-opp-v2-2-3c19963f55ee@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795306712; l=8104;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=7RgM/pZr6piF1+dFtELmpZINHsFgJk4k3LRIKe7+/VE=;
 b=+d6qvnPQXAZ8lcNxUtaiD8oVewSWnjM5XEtEC39AQ2RKBo7Y08+grz1bvUlV9d6N3I+WvVv9U
 kUuRPVJyBJwBlkJ1OATej5D/VA686aU7eXuF39XSgFtlMwQhsiyznCW
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Janne Grunau <j@jannau.net>

Add the cluster cpufreq controller nodes, operating performance point
tables, and CPU capacity values for the Apple T8122 (M3) Sawtooth
efficiency and Everest performance clusters.

The capacity-dmips-mhz values were determined by measuring single-core
CoreMark [1] Iterations/Sec/MHz at fixed frequencies under the
performance governor.

[1] https://github.com/eembc/coremark

Signed-off-by: Janne Grunau <j@jannau.net>
Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 arch/arm64/boot/dts/apple/t8122.dtsi | 210 +++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8122.dtsi b/arch/arm64/boot/dts/apple/t8122.dtsi
index 959ddf36efa1..3d41d32331a8 100644
--- a/arch/arm64/boot/dts/apple/t8122.dtsi
+++ b/arch/arm64/boot/dts/apple/t8122.dtsi
@@ -76,9 +76,12 @@ cpu_e0: cpu@0 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <804>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e1: cpu@1 {
@@ -88,9 +91,12 @@ cpu_e1: cpu@1 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <804>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e2: cpu@2 {
@@ -100,9 +106,12 @@ cpu_e2: cpu@2 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <804>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e3: cpu@3 {
@@ -112,9 +121,12 @@ cpu_e3: cpu@3 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <804>;
 			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
+			operating-points-v2 = <&sawtooth_opp>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_p0: cpu@10100 {
@@ -124,9 +136,12 @@ cpu_p0: cpu@10100 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p>;
 		};
 
 		cpu_p1: cpu@10101 {
@@ -136,9 +151,12 @@ cpu_p1: cpu@10101 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p>;
 		};
 
 		cpu_p2: cpu@10102 {
@@ -148,9 +166,12 @@ cpu_p2: cpu@10102 {
 			cpu-release-addr = <0 0>; /* To be filled by loader */
 			enable-method = "spin-table";
 
+			capacity-dmips-mhz = <1024>;
 			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
+			operating-points-v2 = <&everest_opp>;
+			performance-domains = <&cpufreq_p>;
 		};
 
 		cpu_p3: cpu@10103 {
@@ -160,9 +181,12 @@ cpu_p3: cpu@10103 {
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
@@ -180,6 +204,178 @@ l2_cache_1: l2-cache-1 {
 		};
 	};
 
+	sawtooth_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp01 {
+			opp-hz = /bits/ 64 <744000000>;
+			opp-level = <1>;
+			clock-latency-ns = <7800>;
+		};
+
+		opp02 {
+			opp-hz = /bits/ 64 <1044000000>;
+			opp-level = <2>;
+			clock-latency-ns = <19400>;
+		};
+
+		opp03 {
+			opp-hz = /bits/ 64 <1476000000>;
+			opp-level = <3>;
+			clock-latency-ns = <24800>;
+		};
+
+		opp04 {
+			opp-hz = /bits/ 64 <2004000000>;
+			opp-level = <4>;
+			clock-latency-ns = <43600>;
+		};
+
+		opp05 {
+			opp-hz = /bits/ 64 <2268000000>;
+			opp-level = <5>;
+			clock-latency-ns = <49200>;
+		};
+
+		opp06 {
+			opp-hz = /bits/ 64 <2556000000>;
+			opp-level = <6>;
+			clock-latency-ns = <53400>;
+		};
+
+		opp07 {
+			opp-hz = /bits/ 64 <2748000000>;
+			opp-level = <7>;
+			clock-latency-ns = <56800>;
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
+			clock-latency-ns = <9400>;
+		};
+
+		opp02 {
+			opp-hz = /bits/ 64 <1092000000>;
+			opp-level = <2>;
+			clock-latency-ns = <19800>;
+		};
+
+		opp03 {
+			opp-hz = /bits/ 64 <1356000000>;
+			opp-level = <3>;
+			clock-latency-ns = <23700>;
+		};
+
+		opp04 {
+			opp-hz = /bits/ 64 <1596000000>;
+			opp-level = <4>;
+			clock-latency-ns = <25000>;
+		};
+
+		opp05 {
+			opp-hz = /bits/ 64 <1884000000>;
+			opp-level = <5>;
+			clock-latency-ns = <28200>;
+		};
+
+		opp06 {
+			opp-hz = /bits/ 64 <2172000000>;
+			opp-level = <6>;
+			clock-latency-ns = <32300>;
+		};
+
+		opp07 {
+			opp-hz = /bits/ 64 <2424000000>;
+			opp-level = <7>;
+			clock-latency-ns = <35600>;
+		};
+
+		opp08 {
+			opp-hz = /bits/ 64 <2616000000>;
+			opp-level = <8>;
+			clock-latency-ns = <38200>;
+		};
+
+		opp09 {
+			opp-hz = /bits/ 64 <2808000000>;
+			opp-level = <9>;
+			clock-latency-ns = <39700>;
+		};
+
+		opp10 {
+			opp-hz = /bits/ 64 <2988000000>;
+			opp-level = <10>;
+			clock-latency-ns = <41700>;
+		};
+
+		opp11 {
+			opp-hz = /bits/ 64 <3144000000>;
+			opp-level = <11>;
+			clock-latency-ns = <43700>;
+		};
+
+		opp12 {
+			opp-hz = /bits/ 64 <3288000000>;
+			opp-level = <12>;
+			clock-latency-ns = <45000>;
+		};
+
+		opp13 {
+			opp-hz = /bits/ 64 <3420000000>;
+			opp-level = <13>;
+			clock-latency-ns = <48700>;
+		};
+
+		opp14 {
+			opp-hz = /bits/ 64 <3540000000>;
+			opp-level = <14>;
+			clock-latency-ns = <55700>;
+		};
+
+		opp15 {
+			opp-hz = /bits/ 64 <3636000000>;
+			opp-level = <15>;
+			clock-latency-ns = <55900>;
+		};
+
+		opp16 {
+			opp-hz = /bits/ 64 <3720000000>;
+			opp-level = <16>;
+			clock-latency-ns = <55900>;
+		};
+
+		opp17 {
+			opp-hz = /bits/ 64 <3780000000>;
+			opp-level = <17>;
+			clock-latency-ns = <56000>;
+		};
+
+		opp18 {
+			opp-hz = /bits/ 64 <3864000000>;
+			opp-level = <18>;
+			clock-latency-ns = <56000>;
+		};
+
+		opp19 {
+			opp-hz = /bits/ 64 <3960000000>;
+			opp-level = <19>;
+			clock-latency-ns = <61800>;
+		};
+
+		opp20 {
+			opp-hz = /bits/ 64 <4056000000>;
+			opp-level = <20>;
+			clock-latency-ns = <61900>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;
@@ -190,6 +386,20 @@ soc {
 		nonposted-mmio;
 		#size-cells = <2>;
 
+		cpufreq_e: performance-controller@210e20000 {
+			compatible = "apple,t8122-cluster-cpufreq",
+				     "apple,t8112-cluster-cpufreq";
+			reg = <0x2 0x10e20000 0x0 0x1000>;
+			#performance-domain-cells = <0>;
+		};
+
+		cpufreq_p: performance-controller@211e20000 {
+			compatible = "apple,t8122-cluster-cpufreq",
+				     "apple,t8112-cluster-cpufreq";
+			reg = <0x2 0x11e20000 0x0 0x1000>;
+			#performance-domain-cells = <0>;
+		};
+
 		i2c0: i2c@2a1010000 {
 			compatible = "apple,t8122-i2c", "apple,t8103-i2c";
 			reg = <0x2 0xa1010000 0x0 0x4000>;

-- 
2.56.0


