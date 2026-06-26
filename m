Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AA3AB29D;
	Fri, 26 Jun 2026 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782461556; cv=none; b=Ne0gwcR/iMp1OB2nkjbGcc/rjX2fq3B3YWvMb4MmwZAGUACbaMZeEWKbjGyzxfTxK507cHZPgyDlpu1CkCpkyKOlOMnCiHcvDTMMnW1yJriD/3ohiHkLzp0gLVMWLUpxK6ZG5RzYT8HMB+IYYvN2ssj3ujismR3EZtbO+wXhvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782461556; c=relaxed/simple;
	bh=24kQqyCQI8GpNsMl85YvfO3JvPz6Ler6LRig8dyCuIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pASzEh2OjaEq3UR4vUIGDo1ano0h7vUjtYAhAZ1inOshjtix6mweJ43V/yLFmJ8iTAhOv3G4uTozG8wtmF8ozcc6rrVp14z6QGtxgn0msWWkY9B0Y6yOLABM3k1CoEj+m51eaXq6JsLaXtpEfF7bIPDoSu+1iN45oChiow6bNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eZfN77Ky; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sMmEYJFw; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eZfN77Ky";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sMmEYJFw"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gmpLn1Cmfz9tjB;
	Fri, 26 Jun 2026 10:12:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782461553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nVugsGa9zWngmQtmGL/zlq0zV/IdO94ruEW1ZTfl7g=;
	b=eZfN77KylBPsRrndmsLRrCvA4RPLB4kY5tD6rSMifp3vClqes2TbubV/+pfKhIDIi7c0pX
	DlI6INAHqJTjjwakIKYkaBob8FalJxCQ2075uesBMYnxBx3Etlh1nWDeDSPLs+pq/BdTET
	wfzm1EuzOtX4A+7Pd3sMusivkLYtD11PW4x8i48t17NjvXghSRoMkaUC2MC9+XtByzPZyb
	4hzf5NZLN/vuIqirlDLAlHYUL8QWoETz1TD53iNvZhgGwQPjQ9zotJO3f7bbacDaDFGvl/
	O0JVCTgH6gqm7K4AuJHEe+lRZ+v7YvJLtQCd1svenKV2VK+NuoS9VSJLqgcRAA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=sMmEYJFw;
	spf=pass (outgoing_mbo_mout: domain of shuwei.wu@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=shuwei.wu@mailbox.org
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782461552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nVugsGa9zWngmQtmGL/zlq0zV/IdO94ruEW1ZTfl7g=;
	b=sMmEYJFwSXbm4yG90IeHCTS9a00wYrht1uc2x/+Qs8yk6XWlKUK5l7nNbO9pK5taqAQipp
	88NdBKyFmwT31AhgJPVwU6uB8k09AJRl1jMRJuSAJERosq8O5TUCTC6y7PureK72oSetOV
	wxKb7vPD/kgcp8sFwu/Of8/KscsQ1jDrCeurAaRAw6WbmDmewSfBIaPxObJevSfLud8O5U
	ykgIUemfRSRCEMIIL9MxfyLxg2Fn27cKObKkQhfGq5qH9kgpPUyt8bbhUxK0R0qyYNXJhB
	gx3o2UJPYC+ba7jEAx44ee83deh26Y0gitYzpv3hcGi33/BF7ODtnE8xs/fRlg==
Date: Fri, 26 Jun 2026 16:10:24 +0800
Subject: [PATCH v4 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-shadow-deps-v4-2-bba9831f2f1d@mailbox.org>
References: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
In-Reply-To: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782461515; l=8417;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=24kQqyCQI8GpNsMl85YvfO3JvPz6Ler6LRig8dyCuIE=;
 b=Pt0AZLBFdH+b+8aDfYOOy8RKshOi7kag2eex7/t4bLQF0NSpf5U8HLzqFNtzsBgmJb3cvw9ki
 GG3uGLINtHdD0MPu/icBfnzgNLa94yyff5KzZQowVRwoZ8iyip96ldh
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-ID: 46e67d3906907dae3fd
X-MBO-RS-META: ipmf4g4fardkawcstbtisa4ohijfyh1t
X-Rspamd-Queue-Id: 4gmpLn1Cmfz9tjB

Add CPU clock properties and OPP tables for the two CPU clusters in the
SpacemiT K1 SoC. The OPP entries use voltage ranges because the CPU
supply is shared by both clusters.

Enable CPU DVFS on Banana Pi BPI-F3 by including the OPP tables and
wiring the CPU nodes to the CPU regulator supply.

Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
---
Changes in v4:
- Use separate OPP tables for the two CPU clock clusters
- Use voltage ranges for the shared CPU supply

Changes in v3:
- Use one shared CPU OPP table for all CPUs

Changes in v2:
- Add k1-opp.dtsi with OPP tables for both CPU clusters
- Assign CPU supplies and include OPP table for Banana Pi BPI-F3
---
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  35 +++++++-
 arch/riscv/boot/dts/spacemit/k1-opp.dtsi        | 105 ++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            |   8 ++
 3 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 444c3b1e6f44..487179f7b9b9 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -4,6 +4,7 @@
  */
 
 #include "k1.dtsi"
+#include "k1-opp.dtsi"
 #include "k1-pinctrl.dtsi"
 
 / {
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
index 000000000000..4cebfcd87485
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
+			opp-microvolt = <950000 950000 1050000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-819000000 {
+			opp-hz = /bits/ 64 <819000000>;
+			opp-microvolt = <950000 950000 1050000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <950000 950000 1050000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-microvolt = <950000 950000 1050000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1050000 1050000 1050000>;
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
+			opp-microvolt = <950000 950000 1050000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-819000000 {
+			opp-hz = /bits/ 64 <819000000>;
+			opp-microvolt = <950000 950000 1050000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <950000 950000 1050000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-microvolt = <950000 950000 1050000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1050000 1050000 1050000>;
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

