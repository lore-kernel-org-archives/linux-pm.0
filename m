Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794999148;
	b=LV13a3kuDLeflhBE//Yf8gqsQ9XZoYxt+5F6cpwe0Xwm/XtILH/+K6y7JiuaIifKJgjl
	 hCzLtiLLi2HTCSLbwMrgK6rXAvFk6DKfkDYlqsiuIetEqgmeueNTFoAup2nXmGtyzuUOx
	 wlu4KJOakkuS/9xQepL46ekojMtq50lHojYBlSiFDQbMuhivJ/jeFkmEI7MKNMunYHzsy
	 VAdKb021W89H+q2jwYQNWc+mBC+qVnwS9eaJqqRo85xN47UgCa6gF8xNSZAhUMqKNXe5W
	 BKL1pGL7FbqwG4/6X7z3icaQ4ReWC30rhhsfUb9xTwI3pksFZuMwiPt4kzDcaVluEUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999148;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ekSWlwMFYCJb5CWNs9PahwiZ4lvhB0X9D5Up2UC4Rjo=;
	b=MzZ5a28bn/59chOD3ycXuIPVqRjN4vrU+NfiKXwG2+z4eqEs+Ps2uXKeHpzLFSDy7sZB
	 2miu+VR4OBWzpWohkL9hR52pNDbk5JQ7lhi3ZOrvOvLjSsmceMZBjlbT00+7KQog2UDQs
	 kTkQ3GlGdTKWIJiqdUEEeQD7a/hVDegq5o8P+BnP7O9WyanbjIzpb7zc4wng82z9FqJiw
	 iSRETUZLSWjQmWf7KpeTdY0wiWJzLAPPzA3L/jG5qoJSML7y8ZK4V+x4gy8dacOpDHRSL
	 HOsKdxMf+zqOmAzakUv84NYPVpUnvm5SKXFQjFw3qIco4mHpcdJi1GNxcH8Xis/W5Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T08J5mk/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742AB60A2626;
	Wed, 18 Nov 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T08J5mk/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794999148;
	b=VOTTUb8d3CKjguUjFo7lsae+fiQwaDYp726xJuW3/FpL4qWiIHXL1IxheP0oXMdvXs0i
	 y0kel/6tlVWjFiZnbkIQaKlF5oD0wkow8V4CkHkDHA11rOKlZNYFW93136m4gy6ed5XVa
	 Mp3XN0melYnqjY84WypwhV+1xtZPZzXu8cpbmT0gwF9E5voIFseezv0CxM+5y7lhArzxy
	 WHKcplzy0E18r04zJdRx8igP3tr8+dZYqrb5g/aaFhTEJDX7o/cddAa59zeEGCSt09qk2
	 CwySHSswf43IQefSFPiAESXZwjoYVOKySILvcL+ixjGcWp4y1hvifAsKvDMwedMJcdw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794999148;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ekSWlwMFYCJb5CWNs9PahwiZ4lvhB0X9D5Up2UC4Rjo=;
	b=QfjAlkXvjIf10KpP7nK+ZlVaZ0pzmyUtziH5mo4z3VlfmtmPKIWq32uv73Pd2LhZN0bY
	 hQ7xljUQ8fWBD4niogYKhFQbXfxnz7eIx06cUXhoDQpr/rnBYCVn0+kSM/911TIfmel/E
	 0ZRgUZUoPSsDnjnRbSJ723MIObN3RNzCn3qrheZjrvWVm30i3GEaP+4U1hI44GRYLYq+D
	 +dxhEJVgbL/mlFe6fU5uKc42+ueB/vXUSsydhJ1YaW4qbPBtXVmqIAkMLGliArgZ0rdEl
	 omb78gXpARoU6t0oUjGokKmUDzfQRVYtp77aMShBwSyzsvr6H5Db5MG5Yh+kRFdFdZw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3F1D71F000CF;
	Wed, 18 Nov 2026 10:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999148;
	bh=ekSWlwMFYCJb5CWNs9PahwiZ4lvhB0X9D5Up2UC4Rjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=T08J5mk/RX+6cdghSOFju2FhuuUou8N/LBUCqTfCa0UBoNFADH1c0K+WWAd5VX7q+
	 qQ9i1fmK3w/dGi9R8ZelK4hnt+aRYzdu5NocH0lCTxB+XvifWeP5tG5Xbkf3172m0T
	 QAGhnl4/MISUWXDLO6pnwWSbVPsXOsGAD+/OTaOSog++vtmQlW/7pHUEvChE84BUh5
	 YrdKeXodM9ip2r5An5YEzOmHJZDtx4kUaVbKd0Gb/INaNWQA+dvmuYnoNDgCForaxG
	 jF0QMbqWXfGILVyi+ZWKgjbkRucvanuiwjQf8+uxJKJsHSt8NrZZlsi63KvjyUjq+t
	 FGou5gFdsE31g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BE0884AD20;
	Wed, 18 Nov 2026 10:52:25 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 04:52:28 -0600
Subject: [PATCH v2 5/6] arm64: dts: allwinner: a133: Add CPU OPP table
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
Message-Id: <20261118-a133-series-v2-5-8bcec9c9aadf@gmail.com>
References: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
In-Reply-To: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
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
 linux-kernel@vger.kernel.org, Alexander Sverdlin <alex@sverdlin.org>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Rajan Yadav <rajanyadav0307@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794999144; l=8781;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=S+uzsmUxTcW+8l4ePq+AR9wIIhaHfO1sQ5kGjKEbYc8=;
 b=Z1W2EcEk0u4/zpyvz+58cjfxO4XScNr+ZSFY4Po66FZn9lAt7r2eIttql/Zm9+MB23ZWG8vF7
 lm5AEAE8SPxCHurWhhPwzl+ash1AglMpeWGOG9tRC4ODdhyx7C6x09g
X-Developer-Key: i=rajanyadav0307@gmail.com; a=ed25519;
 pk=4ZPeiP5qrv2b44q/Obxi2koUS70Q6npbttJnpUoTlgg=
X-Endpoint-Received: by B4 Relay for rajanyadav0307@gmail.com/20261103 with
 auth_id=1391
X-Original-From: Rajan Yadav <rajanyadav0307@gmail.com>
Reply-To: rajanyadav0307@gmail.com
Content-Transfer-Encoding: 7bit

From: Rajan Yadav <rajanyadav0307@gmail.com>

Add the A133 CPU OPPs from the vendor BSP (sun50iw10p1.dtsi), plus
1608 MHz for b0 and b1 from the vendor table in the factory firmware of
the KickPi K5C. There are ten voltage sets, speed0-5 for the a0-a5/a6
grades and speed6-9 for the "high speed" b0-b3 grades.
opp-supported-hw selects the frequencies of each grade:

- 1464 MHz only for the a grades
- 1416 and 1512 MHz only for the b grades
- 1608 MHz only for b0 and b1, the revision A-E "high speed" grades
- 408-1320 MHz for all

The highest voltage is 1.18 V, inside the 0.81-1.2 V recommended
operating range of VDD_CPU in the A133 datasheet (V1.5, table 5-2).

The BSP uses 1008 MHz where the A100 table uses 1080 MHz, at the same
voltages for a0-a2. U-Boot starts the CPU at 1008 MHz, which mainline
now reports as an unlisted initial frequency. This table follows the
BSP.

The BSP table stops at 1512 MHz, although some datasheet versions list
1.6 GHz for the A133. The factory firmware of the KickPi K5C (Linux
4.9.170, built January 2026) has the same table plus five OPPs:
1608 MHz for b0 (1.18 V) and b1 (1.13 V, at most 1.14 V), and 1416 MHz
for a0-a2. This patch takes the 1608 MHz OPP from it.

The K5C is a b2 part and never uses this OPP. With a test-only change
that forces the grade, the CPU PLL locked at 1608 MHz and the PMIC was
set to 1.18 V for b0 and 1.13 V for b1. Forced to b0, two 20-minute
runs of full load on the K5C without a heatsink reached the 90 C
passive trip after 10-13 minutes; from then on the temperature stayed
between 83.5 and 90.4 C.

The table has the A100 compatible as a fallback and the speed bin cell
first, so a kernel without A133 support selects speed0-2 from the speed
bin and gets the voltages of the A100 table, with 1008 instead of
1080 MHz. It needs the efuse cells added to sun50i-a100.dtsi in the
previous patch.

A script compared every voltage and the frequency set of every grade
with both vendor tables. It found no difference to the BSP file other
than the added 1608 MHz OPP, and no difference to the factory table
other than its 1416 MHz OPP for a0-a2.

Claude Code (Anthropic) drafted this table and its message from the
two vendor device trees (numbers only) and wrote the comparison script;
I reviewed it and tested it on a KickPi K5C.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>

---
Changes in v2:
- Add 1608 MHz for b0 and b1 from the factory firmware table, as Andre
  asked; the commit message describes the source and the K5C tests.
- Alexander's Reviewed-by and Tested-by for v1 are not carried over
  because of this change. Alexander, could you check whether they
  still apply to this version?
---
 .../boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi    | 182 +++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi
new file mode 100644
index 00000000000..dd5fdeea7ea
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2026 Rajan Yadav <rajanyadav0307@gmail.com>
+/*
+ * A133 CPU OPPs. The voltages and grade selection follow the Allwinner
+ * vendor BSP (sun50iw10p1.dtsi); 1608 MHz for b0 and b1 is from the vendor
+ * table in the factory firmware of the KickPi K5C. Index 0-5 are the
+ * vendor's a0-a5 grades (a6 uses the a5 values), index 6-9 are the "high
+ * speed" b0-b3 grades. This needs the efuse cells from sun50i-a100.dtsi.
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
+
+		opp-1608000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1608000000>;
+
+			opp-microvolt-speed6 = <1180000>;
+			opp-microvolt-speed7 = <1130000 1130000 1140000>;
+			opp-supported-hw = <0xc0>;
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


