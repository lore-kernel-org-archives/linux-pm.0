Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF53A75A6;
	Fri, 10 Apr 2026 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808000; cv=none; b=XL7w3lz4Zi+AftQ1TTMKY/+w4kADcZrkXmqfpAcELCVxflgnkregUWDYLLsM9+OG3WiMAT/oaF6yBofYRf/AHM/vm3cG/HdP/Ya25kHxpbXhBKCtpJEamSEw/FJ8+kd2NkWV5L4nfRXiAPuZ2cnYUFyUtby7m7ZfNFdxdd3dnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808000; c=relaxed/simple;
	bh=0VUX7RdGqDoXNiMwU2EZr3QON0J9hCZx8fbGCBgiJcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBRnGjVGpbW5eddbMjtwjszVaFVgbE5DqlJBdcv77BCAqZRHsxFBa7e1i2vjhKnPEzp7pfwW+gfeByByIMJQQ0qGQIVZJWz3KwuLDDcL7HhM2AsdDREu0kixwwfv/6QCD7WRRRDZZ64uvxAuqfO1h5XmDjF5bzJnG8uyyEORV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rPjx/5mu; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kTvbSN4Q; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rPjx/5mu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kTvbSN4Q"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fsTjf1fNtz9tnV;
	Fri, 10 Apr 2026 09:59:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775807990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C119NIzcOGxwxwzIdJOwlvrD0/jfXj7l51z91Pjq1S8=;
	b=rPjx/5muFQBLOxM3vdadLL8JZjnkbBY2dZKheizcEhT559SrwDrMSoQd0GKXmf4mOI/GI4
	FE78OHWj4iRKq0YbJTyMcM2sWE1K1r4fHZhTW94dWE9YyeCD6uFRaTqF8GByV4SAI4qvcx
	d5k8nn8UWJaCRBhyP9TBYCSCvQLJ1a6f4Tf6yJoHFZgcCJGksw9KbpwoueR8OZje2LmLAb
	ag/Xh4PIXTXcZ4dM45RAzNqtscNzNRPmJQYwK73G0akvBtXktNuORQWuMtkQHVTOKDn6XX
	p+lsh9hBpdui/50yFGfQWgrOS6q5Y0AmD795WGQG5ltxvId3EIeJW7eE4bPojQ==
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775807988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C119NIzcOGxwxwzIdJOwlvrD0/jfXj7l51z91Pjq1S8=;
	b=kTvbSN4QFgbF9q6zd/+MBOE0VeBlitVZ8nhDfTQVzMRTpSI+aVvgZplEaXnpCa3PkO3Rf4
	ZXgRVPVkcvo9gk6hNRcNciT4En8sw4UFry7INyPjZUZu7tr9MTjKyVCErOJ9kqnbn8itut
	pwBwYN1SGfELGmM8B0zaDblk/yOyefscDmhu4OF7lEyDft9fQ0G+iqr9FQyqiR2Fve3v88
	fg2pPmhdL7qxxiE5MFq5314a5Ql8i3qQmXuyIz+w5Kmu097RfBPYg6TqYjrjik9SlU3eGU
	m/1MiAbETmmlJqfz7d+Oz7FLb72pUtFSwkXrBYVsyA9xf9wZNU5MUQZVZiGF6Q==
Date: Fri, 10 Apr 2026 15:58:23 +0800
Subject: [PATCH v2 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-shadow-deps-v2-2-4e16b8c0f60e@mailbox.org>
References: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
In-Reply-To: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
 Yixun Lan <dlan@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 devicetree@vger.kernel.org, Shuwei Wu <shuwei.wu@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775807959; l=8034;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=0VUX7RdGqDoXNiMwU2EZr3QON0J9hCZx8fbGCBgiJcs=;
 b=3tq5OGveOn8/5bf+tMiV4unxU6gVl3E8eKnwcx6TihxWp0vNd9WfvilcqiQO3ihts5bDqO+GG
 a5dNX7PNi/BCyPQ6MymUTD+tm+hj/K8VkVCQyEJCzOo9vCMOogmHl0q
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-META: 9jff3fkmqxjiun45qgappn1fu8s6jp3q
X-MBO-RS-ID: 14cc6a5e871f3b5b420

Add Operating Performance Points (OPP) tables and CPU clock properties
for the two clusters in the SpacemiT K1 SoC.

Also assign the CPU power supply (cpu-supply) for the Banana Pi BPI-F3
board to fully enable CPU DVFS.

Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>

---
Changes in v2:
- Add k1-opp.dtsi with OPP tables for both CPU clusters
- Assign CPU supplies and include OPP table for Banana Pi BPI-F3
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  35 +++++++-
 arch/riscv/boot/dts/spacemit/k1-opp.dtsi        | 105 ++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            |   8 ++
 3 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 444c3b1e6f44..3780593f610d 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -5,6 +5,7 @@
 
 #include "k1.dtsi"
 #include "k1-pinctrl.dtsi"
+#include "k1-opp.dtsi"
 
 / {
 	model = "Banana Pi BPI-F3";
@@ -86,6 +87,38 @@ &combo_phy {
 	status = "okay";
 };
 
+&cpu_0 {
+	cpu-supply = <&buck1_3v45>;
+};
+
+&cpu_1 {
+	cpu-supply = <&buck1_3v45>;
+};
+
+&cpu_2 {
+	cpu-supply = <&buck1_3v45>;
+};
+
+&cpu_3 {
+	cpu-supply = <&buck1_3v45>;
+};
+
+&cpu_4 {
+	cpu-supply = <&buck1_3v45>;
+};
+
+&cpu_5 {
+	cpu-supply = <&buck1_3v45>;
+};
+
+&cpu_6 {
+	cpu-supply = <&buck1_3v45>;
+};
+
+&cpu_7 {
+	cpu-supply = <&buck1_3v45>;
+};
+
 &emmc {
 	bus-width = <8>;
 	mmc-hs400-1_8v;
@@ -201,7 +234,7 @@ pmic@41 {
 		dldoin2-supply = <&buck5>;
 
 		regulators {
-			buck1 {
+			buck1_3v45: buck1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3450000>;
 				regulator-ramp-delay = <5000>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-opp.dtsi b/arch/riscv/boot/dts/spacemit/k1-opp.dtsi
new file mode 100644
index 000000000000..768ae390686d
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-opp.dtsi
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/ {
+	cluster0_opp_table: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-614400000 {
+			opp-hz = /bits/ 64 <614400000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-819000000 {
+			opp-hz = /bits/ 64 <819000000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1050000>;
+			clock-latency-ns = <200000>;
+		};
+	};
+
+	cluster1_opp_table: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-614400000 {
+			opp-hz = /bits/ 64 <614400000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-819000000 {
+			opp-hz = /bits/ 64 <819000000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1050000>;
+			clock-latency-ns = <200000>;
+		};
+	};
+};
+
+&cpu_0 {
+	operating-points-v2 = <&cluster0_opp_table>;
+};
+
+&cpu_1 {
+	operating-points-v2 = <&cluster0_opp_table>;
+};
+
+&cpu_2 {
+	operating-points-v2 = <&cluster0_opp_table>;
+};
+
+&cpu_3 {
+	operating-points-v2 = <&cluster0_opp_table>;
+};
+
+&cpu_4 {
+	operating-points-v2 = <&cluster1_opp_table>;
+};
+
+&cpu_5 {
+	operating-points-v2 = <&cluster1_opp_table>;
+};
+
+&cpu_6 {
+	operating-points-v2 = <&cluster1_opp_table>;
+};
+
+&cpu_7 {
+	operating-points-v2 = <&cluster1_opp_table>;
+};
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 529ec68e9c23..bdd109b81730 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -54,6 +54,7 @@ cpu_0: cpu@0 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
 			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
@@ -84,6 +85,7 @@ cpu_1: cpu@1 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
 			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
@@ -114,6 +116,7 @@ cpu_2: cpu@2 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
 			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
@@ -144,6 +147,7 @@ cpu_3: cpu@3 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
 			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
@@ -174,6 +178,7 @@ cpu_4: cpu@4 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <4>;
+			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
 			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
@@ -204,6 +209,7 @@ cpu_5: cpu@5 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <5>;
+			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
 			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
@@ -234,6 +240,7 @@ cpu_6: cpu@6 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <6>;
+			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
 			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
@@ -264,6 +271,7 @@ cpu_7: cpu@7 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <7>;
+			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
 			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",

-- 
2.53.0

