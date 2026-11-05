Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793853663;
	b=ZjJDy63qsyKkEGAREUaEzYtI9lelyefVdPEpqfiFxueBnLF0hRWhTvypPtV+u2of/aPS
	 QVwtPtQ3j2vHGUwtf6SoaxgxeqPfq4J07PrSbrT54XkUeAyba2NcGY//BlWzk1Vyo3gzW
	 gDMcDOKbL1oB3o1x5xXwLiY87xw0LLvdyzfl7YhqDaA3wSPbiSRGL69J03mkgfFqt00iB
	 d/PTETjaHvXdAwPmevE4GOecbpNhzL+SiTMzhNYWpeJSf032OBItAHM9Fnkz3q9ZfEH1n
	 KmyVQ44mscTtgXJMI/CLMwFBS+QRoJP5vid0dasK8Yw7Ay2Fo2aanXOIMuR62+RrCWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853663;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=920Az6115sPvj8iCYtHdqq70ag0r2QjzUhDTYwWKYHQ=;
	b=jkYp8rw4IzB3B7i6NIkTdj2fSqzmhfcB82tpiVJOf6L0qYm+zo4dY/u3DhV5/l5L8V/L
	 qFoqKq4HYDh8/Ixw/jQuF58XxnfDXLK5WjU3mg8bLu0fUFYXWENlEbYJQY7GenD4BuyBB
	 xM1a3A67WFQj655j5haZkk525Q1rppibK/23G9rP0uV0Go8mbtdywbABwkJTuslS752l/
	 nb7KUKl7qUxQ/qwQ3+1rcI3z/o1Cpp34N7laDxkxZX0xDp+3xINK3sbVLa0wtfJwoj0LZ
	 UsofbtAPGnXBvh4la7ld8Lwzthwl5ZthhgF6lJaatBQ3O8Bv4UFkpjlqUTZbdqcfm9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSxrDkkJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1C606D832;
	Thu,  5 Nov 2026 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSxrDkkJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793853663;
	b=ajQvyPTQcp448DKn1jhDqMtG3k5LAKscWuwzCpG51c8uN9ZXrU5Wb849wjFswvr/4UJP
	 CMS1uITXaMGOzmQImKV0W2+ZIBdPngsvXH/if4naI7Tw4jfCqeH5sMoZVX3tVURw0RkP/
	 P02WLqtioMI5Dgudp9/rczvu/ekXYS2mWN4dMhuER6ZrmMQ68HBmT74TOCJTGcfsVncSn
	 djoAW/LRuTqZQaXC6XQOg/j6rNPcwMRK/8p0cRGUkM6jbhwjF+EvI/EJsc4ICaCdJPjwz
	 VYkkAJ1BzKhYTvNtzupYp7qqGrfmdj/5WDd5qrD2vvRus34QiWuaeY1gNMuIkTBHS+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793853663;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=920Az6115sPvj8iCYtHdqq70ag0r2QjzUhDTYwWKYHQ=;
	b=xQUH763GTW7/kgEkuezTWG1LU0YopAjDqlYRNKhnYo65s2M7vX+3JhGyxn0xIRCXCa5a
	 ntjsslZ5qX84x/stNpfznMf+7vxyL/VFfFZj1ZpGtakJRfLJj2JjErz2z8lBez2jDy/mM
	 id75UXEvZgTAzWELKfornjjnNY88xzN4RCOVjbmuTGHt3wAz/6ySmZlAmqDS9nKC2uU5m
	 zHhntm1XwhEn3B+vhaJ57s+SEtpZL9BSqWdsUuz2GGscxCVYNXF3suSyKQZkajzDRz2/T
	 BXBBQcTcoVjnf+Bo8bzxxfFUFEg20/yej0sngZ9niNRzLjDJNVF7R9WObpULb+B7ZXA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 02E6F1F00A25;
	Thu,  5 Nov 2026 04:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793853663;
	bh=920Az6115sPvj8iCYtHdqq70ag0r2QjzUhDTYwWKYHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lSxrDkkJCesKK6EWUVMkjdYkn6CMizI6bMc0QVqrYakL7QBfRj5eObY2PO7U8xnaG
	 VeE2Zm0AQr8ftPw00H+bKfE9tLo070i/ZMRcJqbMtADm3lOQUDUvbq41MNN3A/pAkK
	 GXlb0EyGJdI8EnIapmBwOZrqcxUfgxDtn5kXZW9169r8df2ZxwusEZTRk1eV3cir82
	 kFMZENEV3KGCDBOshSBN+gjQ9vdHPRle8v10q7X7jG5V45dZp5MfgKg0+vZMe4t+pG
	 JvRo4HiX94Z5iVCu3j1ZGnu8aJYkadplnZjFR3MWZGATQm9I1+IB+euc8PjPP4V2AZ
	 /OMaW92g6Y3BQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 15491470A7;
	Thu,  5 Nov 2026 04:40:58 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Date: Wed, 04 Nov 2026 22:41:00 -0600
Subject: [PATCH 5/6] arm64: dts: allwinner: a133: Add CPU OPP table
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
Message-Id: <20261104-a133-series-v1-5-58217cb33a87@gmail.com>
References: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
In-Reply-To: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Cody Eksal <masterr3c0rd@epochal.quest>, 
 Alexander Sverdlin <alex@sverdlin.org>, 
 Rajan Yadav <rajanyadav0307@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793853656; l=7301;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=JbNG9D9/O5ZOJlOhkb4ozcx9RZQgrX1IN7mhejW6aCw=;
 b=RvjeWHdaV2+h/JLh7ZnjSDBuutmp4IiUmurCSLwsqq83XzykZvJ6qO7bCKhqmXSznDMS3Dfw9
 DEBvWo7FFFwAlrSBByIbkH8zP8Fb4efN41WuxUO7u5x5HlUtXLDV35s
X-Developer-Key: i=rajanyadav0307@gmail.com; a=ed25519;
 pk=4ZPeiP5qrv2b44q/Obxi2koUS70Q6npbttJnpUoTlgg=
X-Endpoint-Received: by B4 Relay for rajanyadav0307@gmail.com/20261103 with
 auth_id=1391
X-Original-From: Rajan Yadav <rajanyadav0307@gmail.com>
Reply-To: rajanyadav0307@gmail.com
Content-Transfer-Encoding: 7bit

From: Rajan Yadav <rajanyadav0307@gmail.com>

Add the A133 CPU OPPs from the vendor BSP (sun50iw10p1.dtsi). There
are ten voltage sets, speed0-5 for the a0-a5/a6 grades and speed6-9
for the "high speed" b0-b3 grades. opp-supported-hw selects the
frequencies of each grade:

- 1464 MHz only for the a grades
- 1416 and 1512 MHz only for the b grades
- 408-1320 MHz for all

The highest voltage is 1.18 V, inside the 0.81-1.2 V recommended
operating range of VDD_CPU in the A133 datasheet (V1.5, table 5-2).

The BSP uses 1008 MHz where the A100 table uses 1080 MHz, at the same
voltages for a0-a2. U-Boot starts the CPU at 1008 MHz, which mainline
now reports as an unlisted initial frequency. This table follows the
BSP. The BSP table stops at 1512 MHz, so there is no 1608 MHz OPP,
although some datasheet versions list 1.6 GHz for the A133. A newer
factory kernel adds 1608 MHz for b0 and b1 only; that is left for a
follow-up.

The table has the A100 compatible as a fallback and the speed bin cell
first, so a kernel without A133 support selects speed0-2 from the speed
bin and gets the voltages of the A100 table, with 1008 instead of
1080 MHz. It needs the efuse cells added to sun50i-a100.dtsi in the
previous patch.

A script compared every voltage and the frequency set of every grade
with the BSP file and found no difference.

Claude Code (Anthropic) drafted this table and its message from the
vendor BSP device tree (numbers only) and wrote the comparison script;
I reviewed it and tested it on a KickPi K5C.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>
---
 .../boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi    | 172 +++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi
new file mode 100644
index 00000000000..12b6612a920
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2026 Rajan Yadav <rajanyadav0307@gmail.com>
+/*
+ * A133 CPU OPPs. The voltages and grade selection follow the Allwinner
+ * vendor BSP (sun50iw10p1.dtsi). Index 0-5 are the vendor's a0-a5 grades
+ * (a6 uses the a5 values), index 6-9 are the "high speed" b0-b3 grades.
+ * This needs the efuse cells from sun50i-a100.dtsi.
+ */
+
+/ {
+	cpu_opp_table: opp-table-cpu {
+		compatible = "allwinner,sun50i-a133-operating-points",
+			     "allwinner,sun50i-a100-operating-points";
+		nvmem-cells = <&cpu_speed_grade>, <&chip_marking>,
+			      <&cpu_pcpu>, <&cpu_bin_ext>;
+		nvmem-cell-names = "bin", "marking", "pcpu", "bin-ext";
+		opp-shared;
+
+		opp-408000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <408000000>;
+
+			opp-microvolt-speed0 = <900000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed2 = <900000>;
+			opp-microvolt-speed3 = <940000>;
+			opp-microvolt-speed4 = <940000>;
+			opp-microvolt-speed5 = <920000>;
+			opp-microvolt-speed6 = <900000>;
+			opp-microvolt-speed7 = <900000>;
+			opp-microvolt-speed8 = <940000>;
+			opp-microvolt-speed9 = <920000>;
+			opp-supported-hw = <0x3ff>;
+		};
+
+		opp-600000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <600000000>;
+
+			opp-microvolt-speed0 = <900000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed2 = <900000>;
+			opp-microvolt-speed3 = <940000>;
+			opp-microvolt-speed4 = <940000>;
+			opp-microvolt-speed5 = <920000>;
+			opp-microvolt-speed6 = <900000>;
+			opp-microvolt-speed7 = <900000>;
+			opp-microvolt-speed8 = <940000>;
+			opp-microvolt-speed9 = <920000>;
+			opp-supported-hw = <0x3ff>;
+		};
+
+		opp-816000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <816000000>;
+
+			opp-microvolt-speed0 = <940000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed2 = <900000>;
+			opp-microvolt-speed3 = <940000>;
+			opp-microvolt-speed4 = <940000>;
+			opp-microvolt-speed5 = <920000>;
+			opp-microvolt-speed6 = <900000>;
+			opp-microvolt-speed7 = <900000>;
+			opp-microvolt-speed8 = <940000>;
+			opp-microvolt-speed9 = <920000>;
+			opp-supported-hw = <0x3ff>;
+		};
+
+		opp-1008000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1008000000>;
+
+			opp-microvolt-speed0 = <1020000>;
+			opp-microvolt-speed1 = <980000>;
+			opp-microvolt-speed2 = <950000>;
+			opp-microvolt-speed3 = <1020000>;
+			opp-microvolt-speed4 = <960000>;
+			opp-microvolt-speed5 = <940000>;
+			opp-microvolt-speed6 = <980000>;
+			opp-microvolt-speed7 = <950000>;
+			opp-microvolt-speed8 = <960000>;
+			opp-microvolt-speed9 = <940000>;
+			opp-supported-hw = <0x3ff>;
+		};
+
+		opp-1200000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1200000000>;
+
+			opp-microvolt-speed0 = <1100000>;
+			opp-microvolt-speed1 = <1020000>;
+			opp-microvolt-speed2 = <1000000>;
+			opp-microvolt-speed3 = <1100000>;
+			opp-microvolt-speed4 = <980000>;
+			opp-microvolt-speed5 = <960000>;
+			opp-microvolt-speed6 = <1020000>;
+			opp-microvolt-speed7 = <1000000>;
+			opp-microvolt-speed8 = <980000>;
+			opp-microvolt-speed9 = <960000>;
+			opp-supported-hw = <0x3ff>;
+		};
+
+		opp-1320000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1320000000>;
+
+			opp-microvolt-speed0 = <1160000>;
+			opp-microvolt-speed1 = <1060000>;
+			opp-microvolt-speed2 = <1030000>;
+			opp-microvolt-speed3 = <1160000>;
+			opp-microvolt-speed4 = <1020000>;
+			opp-microvolt-speed5 = <1000000>;
+			opp-microvolt-speed6 = <1060000>;
+			opp-microvolt-speed7 = <1030000>;
+			opp-microvolt-speed8 = <1020000>;
+			opp-microvolt-speed9 = <1000000>;
+			opp-supported-hw = <0x3ff>;
+		};
+
+		opp-1416000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1416000000>;
+
+			opp-microvolt-speed6 = <1100000>;
+			opp-microvolt-speed7 = <1070000>;
+			opp-microvolt-speed8 = <1060000>;
+			opp-microvolt-speed9 = <1040000>;
+			opp-supported-hw = <0x3c0>;
+		};
+
+		opp-1464000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1464000000>;
+
+			opp-microvolt-speed0 = <1180000>;
+			opp-microvolt-speed1 = <1180000>;
+			opp-microvolt-speed2 = <1130000>;
+			opp-microvolt-speed3 = <1180000>;
+			opp-microvolt-speed4 = <1100000>;
+			opp-microvolt-speed5 = <1080000>;
+			opp-supported-hw = <0x3f>;
+		};
+
+		opp-1512000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1512000000>;
+
+			opp-microvolt-speed6 = <1180000>;
+			opp-microvolt-speed7 = <1130000 1130000 1140000>;
+			opp-microvolt-speed8 = <1100000>;
+			opp-microvolt-speed9 = <1080000>;
+			opp-supported-hw = <0x3c0>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opp_table>;
+};

-- 
2.34.1


