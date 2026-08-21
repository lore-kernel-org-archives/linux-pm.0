Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011019.outbound.protection.outlook.com [40.107.74.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFE4D2EC3;
	Fri, 21 Aug 2026 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324762; cv=fail; b=FZ8LgRYbHUtrV5i8ibdbuqQh26OMjulWC56ieMbZV/KI3K0s9XJilvLj+GtETN6Q/G5BOeb/0UJiDucc4OrMtXQwj2hPFomJj/Qzfvgo+l5gv1tNM+ZR8skNzFj77CpPewwndztkINUBNwxWhyoLsVNJunzzQURKnxZUwG0XB9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324762; c=relaxed/simple;
	bh=5EZmGBG6H82pdI2Ovypvr1dvmcYTdUttAVGGrdrZ4SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pn1xFRJS3eIR7pAxt2tWSxuSYamsdnMfRHaf7zaLJomXdGXhU1jJT+lx319oi29URqrCf7apQpA/L1PXY0aOCTVGtq6AkBRV29x3xF80zv4aORhjQRVSMthTlCqXNnaM65pH2SlhuF2oeG6Uw979DpjdZy5Xb89EUxRq5JN9Efc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=N9/G7zX/; arc=fail smtp.client-ip=40.107.74.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="N9/G7zX/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvDRX9y5aY3tmqnPavW1OZVIBYrNkKKBaTwrAbdJd3SDgqpE5rI0OV0nEN0tlIYVhuLKTwmaheMTVdKgqXeaJCDBMD4X3xtbxC8myS3rPoiHDanebtgZnNC8R818ry/pvnf2Eid2c8J33cxrpnLUR2ed7paDHInaHc6JjW9Q5N7/OblmCuQJR4Tr1MlbLy4Z7WLQA6TnXqyiSlSmolZpV8XULng5D8cgpTPUcDuFUW0PE1r2fpNDHty7j83GfMAYUy0bwfIYOWgjIQ6rbab/ASMVpQBUDpC1uaIvjB9hHDeNt/8D3Ux/4zxxP/CUVmNRhMDUpy9rO9eSxzWgSX562Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biuvVm5hToSuzS5ZmEGMEpPkgo7kA3wNh+8PaUNPAR8=;
 b=bAvK1cN+bk1MBGP8f3wcWau1FShPw4lz3+mh24FsI0OatLnop3vz8e1Ikx2cgNAx36e5/DDIWSrm4zcaFsBPnJwbZupUd1JbtgTHrhFj4bMyAd8Mtx0dL4qqVx+iWLi//5FTUE90ioG4NVMNwr1+Qmlv3LXSuOiMK1BbefQb/zfIpcwTTC2kuoVSb6vb9Vbp4KQRPj8q0EMEcgvdCDz7t+I6nbZADtMIlLr06vGqGh10YhyROb2y1nm2lEEWY6JjLdne0UJrGEwFJtgq0VkOaEVBylrhS8S9gXMo9csLZ99kAtBhTzoSDfgimq5nKh5yxxC4UjBa6Fi1bAqcVbaM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biuvVm5hToSuzS5ZmEGMEpPkgo7kA3wNh+8PaUNPAR8=;
 b=N9/G7zX/32xKuAURj8a0WMiQ5XqPM8HcoR9eIvg/VolNmc2fmmhH8Ujo/sag+OM8CHvEbk0fpyG40BI8aLQQsKS3m3dq+BOKMysCa3MK59Y9Y+X2gy/ex3sICFWdS9W6Moodje9Ulv99l1Pnq/3nyhf+Z0/K6Irjkx8wC4V2RKc=
Received: from TYCPR01CA0194.jpnprd01.prod.outlook.com (2603:1096:400:2b0::18)
 by TYCPR01MB8191.jpnprd01.prod.outlook.com (2603:1096:400:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 15:05:57 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b0:cafe::6) by TYCPR01CA0194.outlook.office365.com
 (2603:1096:400:2b0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:05:57 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id E97AA30002AE;
	Sat, 22 Aug 2026 00:05:51 +0900 (JST)
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 09/10] arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC main board support
Date: Fri, 21 Aug 2026 15:03:34 +0000
Message-ID: <20260821150408.73829-10-ayman.chaudhry.kc@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|TYCPR01MB8191:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cb2aff7e-0fb5-4d60-329a-08deff95b42f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|23010399003|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	B68XmjFyGJFwfKw2JgdzYhO5FqGbEbfTeiPExGjOZBRW8ByVuzIYMlXhx3RmjlSJ9golAKqyIlSfayBoFEGhh7gyBAP+PZm/uAkRV0RfLwBsjLvYJBFaIuzbwqcrV3pzaUqiHArMzjZaD6twyJX+CdjfZToeYhIcJYIrthYHElhTTdL3tQ67mlmdxdqZJWSUdpOp9jSNMlfE/7muTcaGn+2B9+a143ZR/+BVB4yGU0dSu+MDR7KSzPqwuiyiH2CvOIfwLz+uvHPw+o4aO6CKNK4sqv/qNOoifEQWD0uoOwOjR5vS0pEk4rETRXbCfcVp3ZzqQOxwElzsVKU1iYtJ4U6dn338FU+I7vQuKK3G9hLpdeEtS9sdZetbCZbAT71I1ICeGSU9C6dfsWIu3JBcosZLpVQPzOgr3A6tpb3c4mqSckJvjgPErSqkwfKIhjEwqE7VSzs5cIswC9NUpPx/Qg41D+AW9SEws42x6EKdPGGDRsjhfzzl4O3hSqcsz+zvc/II0D5shtYFIvUrIGClmkYrdtp7H9EXcVCpDsy27GUxb8Ev7T4xAKdq4KZLmXp6odANL2vyzqLgo9UBw+XoQnyhGGPN5BCvChGT4yHwU0t08WX3LBl7kQspzJ5i93YXMt896FRvh0/+GIZLY16H9ahfi91H+Y0aenPBBlTabJJV9bVTVNd98N++CBEfpfNlEtF+CFBa6EDsXaSec36rTw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AxtPIxJnQa4odALUAx/Lyjv04y/Gv1VrR2fnWvRcP/MeLF+WKpTbNem58hFCfIyrp2wb53OiyoH7DHFTunRpS4LiJPeooWYNFiJ9GeqdZtsCkWqNO4C8SvY5jgF78ljto8W5I/TmOVEXL8Me52pSPzozuk93rbJmDi/9mm/kHZUSjnBd1jRlYgamxeA/1qa8MMh6NEgR+v9MwtXlyEG85PTFXgLA6hPrf81i8q1spS6dqSPhYAKbB+7FnLbW8ta7T90txSCM9CHF5UiZUNSVz9AGnk1ef8xP8Q4XkGHl5cde4EGv0I+NgzML8ialP/bpQbP0KQKgTomg9fmay70prK8smy3YyKtPybSv8SFjlYyMlHIBX+cjRIUaYJT3BCqgKO8lY5ql574zpkIA6posot4cnlSBmwacSagkw16cd0IFDhbvdJAQcCN0MifkUSwY
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:05:57.0880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2aff7e-0fb5-4d60-329a-08deff95b42f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8191

Add support for the HiHope RZ/G2M v3.0 (a.k.a. R8A774A3) SoC main
board.

The RZ/G2M v3.0 SoC main board is similar to the RZ/G2M v1.3 SoC main
board, so there are already DTSI files available in the kernel. These
DTSI files will be included once additional support (e.g. I2C, GPIO
and sound) is added for the RZ/G2M v3.0 SoC.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 +
 .../dts/renesas/r8a774a3-hihope-rzg2m.dts     | 50 +++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 8bf155badd11..6ae96027664d 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
 
+dtb-$(CONFIG_ARCH_R8A774A3) += r8a774a3-hihope-rzg2m.dtb
+
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-beacon-rzg2n-kit.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m.dts b/arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m.dts
new file mode 100644
index 000000000000..f51ba4fd602e
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2M v3.0 SoC main board
+ *
+ *Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a774a3.dtsi"
+
+/ {
+	model = "HopeRun HiHope RZ/G2M v3.0 main board based on r8a774a3";
+	compatible = "hoperun,hihope-rzg2m", "renesas,r8a774a3";
+
+	memory@48000000 {
+		device_type = "memory";
+		/* First 128MiB is reserved for secure area */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+
+	memory@600000000 {
+		device_type = "memory";
+		reg = <0x6 0x00000000 0x0 0x80000000>;
+	};
+
+	aliases {
+		serial0 = &scif2;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
+&extalr_clk {
+	clock-frequency = <32768>;
+};
+
+&scif2 {
+	status = "okay";
+};
+
+&scif_clk {
+	clock-frequency = <14745600>;
+};
-- 
2.34.1

