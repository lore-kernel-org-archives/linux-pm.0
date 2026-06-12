Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467F3D649C;
	Fri, 12 Jun 2026 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257924; cv=none; b=TAuIl6rd+tG8pdlT5f++dKQeTuVtl2UV+x2nN2naQB51Io4SDgtDfFV1cttsa53rRtRX69TOWsQBaOS3/Ku8C/D3UMKWFIxVQUKTjcjsDvpE9pEHgj+3IvuAJDln4/WXhhIM2juEKnzMaXjcHRjk9r1sBYVSJHrX+PfMCmNe1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257924; c=relaxed/simple;
	bh=kMk70jSxtb3MD3cA34JzN4CJWO0HzPs0M08gJr1gSr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiXfKLvJUTCNLdctPnKMy6jqcZ6QUVVPS3ZTsQkR30rUlr6nwWRQ1NvmDxNMRgpKXAKLjMqYwbkr7+epuJB897eFTXBJY9U9p0SEJGFVKJ0WftSl/VfRIHBJMIXrfZjZSrZBs2oPAWnqYN+zAKlC3dgsqwv4NualKvxNOAmbgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tT7kVdOE; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jrcr2scJ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tT7kVdOE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jrcr2scJ"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gcFCw3RThz9tpN;
	Fri, 12 Jun 2026 11:51:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781257916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zfe/dJqFfrMrhmEzQiIVU+r4LtnZx/69uLFhmgVm3jQ=;
	b=tT7kVdOEYN0LqfPUDL413lWeNxqI+/6uJWUGW5KslSuMaNG7E3n1oZ5SDbjs1/hozJX5vT
	4A0NgftunkyhpJZPuH0HUyYShouOp/GSXFJaMmcV7X0sPXT1Z6A4Qo9WzB1bPfuZzspr64
	L7Ws1sF3N9pBr2jkrQCMQuDR6OBEA3y/edJQ/CwZ/BeCC8nkisyzQtp7jfdsiBrDbaeu0q
	Ol//wNue89IXNZXzGXrcYIXwrkgX88gubgdz3XSSB36/vAWQVUDYnAO1XaaQbiHQeUbbHk
	9+UO7O2K0N+iaI1Y6Yh34qJ196xXadi3SWYP4kdsMUf7iOCdVb80D4+qfNMWYQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jrcr2scJ;
	spf=pass (outgoing_mbo_mout: domain of shuwei.wu@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=shuwei.wu@mailbox.org
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781257914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zfe/dJqFfrMrhmEzQiIVU+r4LtnZx/69uLFhmgVm3jQ=;
	b=jrcr2scJwWan4crijrU3QtEOUNAKBSj15cGswWgFkGhHn2qsgEgvDoTKVw/vKuW4T4DFIb
	O70Xi8WJiiaXOnKShEueNLU5rydIcYGz2saxns0R/9mGVU311OZPL23XWLlBgspkShn5AF
	Y9Krr6nGqPCREasabZ7E8ZTXVwZ3JFi84Gyx4FaRLbEqUCbZqrnNc5aF6585PIajKzD4Y9
	/uALLUL/s+/QQX1+VFsrmNgrtBfO0NUAPJq1fcRLNPF2RrMKHfREk89hQmqp6WeayfWmVf
	S477EQuFsIkJTMzOP2cz9z9XE8L+DS0ULaJQJj1omNoxwsVGQF7a00ZdaK3+cA==
Date: Fri, 12 Jun 2026 17:51:02 +0800
Subject: [PATCH v3 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-shadow-deps-v3-2-2f3ba88611ff@mailbox.org>
References: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
In-Reply-To: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781257883; l=7264;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=kMk70jSxtb3MD3cA34JzN4CJWO0HzPs0M08gJr1gSr0=;
 b=R8lUg0Ck/5RNYU+5FwX9zIpHYKFMuRl28uMk31qF020V2HHOw5tMB/6X3/CDqkdrm7adyeLLH
 Lf4KOaLz98wBBs1pFM6Q8jVQFaNBidqxNl7UUcVvlrz6VfHdM42cQZP
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-META: pkdxdm4u4y1dubcmy3i5fjwcjecejtby
X-MBO-RS-ID: 372acceaeecb71d3147
X-Rspamd-Queue-Id: 4gcFCw3RThz9tpN

Use one shared CPU OPP table for all CPUs and add CPU clock properties
for the two CPU clock clusters.

Enable CPU DVFS on Banana Pi BPI-F3 by including the OPP table and
wiring the CPU nodes to the CPU regulator supply.

Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
---
Changes in v3:
- Use one shared CPU OPP table for all CPUs

Changes in v2:
- Add k1-opp.dtsi with OPP tables for both CPU clusters
- Assign CPU supplies and include OPP table for Banana Pi BPI-F3
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 35 ++++++++++++-
 arch/riscv/boot/dts/spacemit/k1-opp.dtsi        | 70 +++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            |  8 +++
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 444c3b1e6f44..81ab5f70176b 100644
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
+	cpu-supply = <&buck1_0v9>;
+};
+
+&cpu_1 {
+	cpu-supply = <&buck1_0v9>;
+};
+
+&cpu_2 {
+	cpu-supply = <&buck1_0v9>;
+};
+
+&cpu_3 {
+	cpu-supply = <&buck1_0v9>;
+};
+
+&cpu_4 {
+	cpu-supply = <&buck1_0v9>;
+};
+
+&cpu_5 {
+	cpu-supply = <&buck1_0v9>;
+};
+
+&cpu_6 {
+	cpu-supply = <&buck1_0v9>;
+};
+
+&cpu_7 {
+	cpu-supply = <&buck1_0v9>;
+};
+
 &emmc {
 	bus-width = <8>;
 	mmc-hs400-1_8v;
@@ -201,7 +234,7 @@ pmic@41 {
 		dldoin2-supply = <&buck5>;
 
 		regulators {
-			buck1 {
+			buck1_0v9: buck1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3450000>;
 				regulator-ramp-delay = <5000>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-opp.dtsi b/arch/riscv/boot/dts/spacemit/k1-opp.dtsi
new file mode 100644
index 000000000000..3627812e1344
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-opp.dtsi
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/ {
+	cpu_opp_table: opp-table-cpu {
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
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu_1 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu_2 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu_3 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu_4 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu_5 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu_6 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu_7 {
+	operating-points-v2 = <&cpu_opp_table>;
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

