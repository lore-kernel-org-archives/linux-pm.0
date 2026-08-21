Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010036.outbound.protection.outlook.com [52.101.229.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7954D2ED9;
	Fri, 21 Aug 2026 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324768; cv=fail; b=Rbx8kY5xYgRbL0dLZu2o8PDyDkv36HBqCusn7z/W85dUq4sTSHf3POaDAq7RYHwz9lJYxJOCt1WBibLInInY8SIZWEIaUB+6dkAOFEMNXCySE2VFW950+NYNqVgjyVdrJpf0VH/OotJd8V2uxXmUUkeR2mTbmuaQZZb0fbnlt/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324768; c=relaxed/simple;
	bh=5Bk7ltC/ntxPfaUK0i1VEhPrEy8iijYALj6illRAsx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiMDkuEYfCbeZkP0NnK0tbsa0SCnJazvHbQSWsmlSLmftkgBbAQzrHyRNRsICqi2vzyQe1bi6yx/tTcHjDmnGZZAKdFV5lU+FGJ8j1F+aK5b5R6OGA1T0EXjmyA2rDyBUfd1hMLvx4PVc0jSk/1ETaywEDTPvTwO3G+5OI4C+8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=bMQSyt+r; arc=fail smtp.client-ip=52.101.229.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="bMQSyt+r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ31QrqJc0ywgAMJakVhccBucPp8kdXaKKOaYMbsYh4qIHp+U/k3n+tu31BnEbS4dmRDxv/gfhap+IvE6BU7NC+KO2OqkgZlDJspN/LLE1L02wGjGK7333iLumHAVYLCyjXjAzLuhS9W0I7LkCExHCjkk1SGKt9pEkRyg26uLBToQLmS/T1IP/Gx2ETS0dkOKv/kSBMdh2xcYSTly6mfO+NiiOJE0BvruyWDmbeWuaWQIRWzUUsMm2BM1AzTKdpkeJqxdwqrnmD0en1pQnX7ZHRixi/qlupSvVkgkxr00TeE9jFMKW56haBEF4Noi6oSjLeQwdc7+F3DA/ZGIJHoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFbG9eQcK1uMXbs7elrFvAbAiI+H3ZcnUwKdTZLs1Qc=;
 b=xzeEJJLEgjrH7O83N5ZNjOPRjmZ9Kcl2BKOurFmD2XEKtHhV1J1wgNWwMABRLsTF3m7dr7cSP9BZYURp2GY3ULoo2beiuep+A96oEBQVmeVebpudzvRvD5MMkNuOzT/xcnfJhs3aWlb7AFW8qQsdFT4AqbxAlfCo6BuHYoBt0XsIRw5XTlLQEakyzvcPFUsmPaokoAjTeoTg92dggYgncB2rgOnTZyHrEA871NaldQc9WaOM3ZJEevw/qrC4HYVA6eEH/F6V7anTsA1Qjsl2ZNNaXYjca15vheuSdM+Z191PGET8ry6lx/N9+fH4JbTvxz4yZNmbSTdnk4k3mb4YkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFbG9eQcK1uMXbs7elrFvAbAiI+H3ZcnUwKdTZLs1Qc=;
 b=bMQSyt+r/v6K3y0F7XKP3exlK9zGuDtrpSIFovU6J7xb+L85ZDksO2/S2K59s6NG4IMXhggwaJ6O3j/Niiez8KQy+DrK0dTe0qtbSpO0k2OKYmEUUOf1riXC5O9B2mntTqDPQXaoKEFoSNivUKFoetEylGGmAdxIpG28aCGNG94=
Received: from OS7PR01CA0251.jpnprd01.prod.outlook.com (2603:1096:604:24b::8)
 by TYRPR01MB16205.jpnprd01.prod.outlook.com (2603:1096:405:2e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:06:02 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24b:cafe::47) by OS7PR01CA0251.outlook.office365.com
 (2603:1096:604:24b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:06:02 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 7409930002AF;
	Sat, 22 Aug 2026 00:05:57 +0900 (JST)
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
Subject: [PATCH 10/10] arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC sub board support
Date: Fri, 21 Aug 2026 15:03:35 +0000
Message-ID: <20260821150408.73829-11-ayman.chaudhry.kc@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYRPR01MB16205:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 79c4c0b0-7154-4507-aab1-08deff95b77f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3BkzGnK8X1P+Y9ovZlTLdrKh5jB0aB/Q9t2Zx8ELxT00uE+hA476ySg08CzhYuGVvNE1AGo5DMpKipl1FKg1El/ROCE932S/gHRu7cGqQ9ybtB/lZKX9zjAZ2kWl82Ry4cXJVqq0va0Hhi1xXek4bYRl9Kwc4tipRtvdgI51WxAQqJBbpLXpwRxGwm2DkiUyfDV6DFUXEUxeeUwF4NwjZrKHpv8cWuWEMt1d4dnXZmVOR1DeiV5pvEYFYxbbKAj1Zm31SfWErzwpWnOlOTRPZ/5Tf7l1HSOZvx/LSoXb2NKDM9geAtLIFD/ssTJpAmYNkBVVcU9AICFmgj0WVucaKlUqUaaOsAHbnivYLGi51WepEeLLmJAOeYYcRQg89doN+s7OogUitiERpNP1EKK1cnsjjN3cuQvIBNX+rTgKVt4p7MAUEvSP/8ABf9bTzzxRgnH46W+6Ab+gzMEeUyfGkTtYlQK/v/sHFX2nxK98s3s59ojlYJ2bLo5DLV1slzLeBoeePU3VyspxP+cdx8XLHMwOpa8xlGmocSFg+4K6d0IAfM1FNnsGZn9NFdTY2dzcBK2LaCjZV6QxxvpGFpAkLL5UUQHJHzKgBJrQmgiXwcLKpb53ofRbaVfoDRfoFH/n/5NElsz0HPBZAD/Aq6W+bWyXIeOg3UjhbQTDR6GhMFvErj46LA5idzQSJJmiBIE4nxzEEXLJGFbCvjvHjg/5qg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZARLA8bpk93l5uO01V+3S0IbX4OZH4O39E1rs0olMtHSli2MQ6y4JWBRCuCRTBdprkFMIUhQE1XI5ESPCO6bUBJ8TWsZFPBqFhTivVfh7qnKBgRebVoYPRa/F39E1+YtgO1rfEOsdyQKhCAbViliFkxGAXEIPxodYmLyYQ/kpvQZaOA37zfMIetGNqad0MpJ0V39WywNF2WA3+dcZw1bTjAgKzTcYbC5mdakw7Z0DhSwLOC2MBTpNvCVx0WVGPoi1/N3/b5xVzrEECJJ9F/oY1G2tcQkzxjTIBeYCfk7nfQaIwggBpBg9sEHvenzEsdC27NuQ2s/Np0Q7AbA543Onym75alrjN7b96ILYIv2a8ovkp80UCl7CIuY3FvQikxvydDXYpNhhoDDl2ZGD78nXK+CJ7OVIUkH4G9IWIO2cb/qCY+szxkfqbGN68+L0TIk
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:06:02.6366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c4c0b0-7154-4507-aab1-08deff95b77f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16205

The HiHope RZ/G2M sub board sits below the HiHope RZ/G2M v3.0
(a.k.a. R8A774A3) SoC main board.

The RZ/G2M v3.0 SoC sub board is similar to the RZ/G2M v1.3 SoC sub
board, so there are already DTSI files available in the kernel. These
DTSI files will be included once additional support (e.g. CAN, PCIe
and ethernet) is added for the RZ/G2M v3.0 SoC.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile               |  1 +
 .../boot/dts/renesas/r8a774a3-hihope-rzg2m-ex.dts  | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m-ex.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 6ae96027664d..346670b10ada 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
 
 dtb-$(CONFIG_ARCH_R8A774A3) += r8a774a3-hihope-rzg2m.dtb
+dtb-$(CONFIG_ARCH_R8A774A3) += r8a774a3-hihope-rzg2m-ex.dtb
 
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-beacon-rzg2n-kit.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m-ex.dts b/arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m-ex.dts
new file mode 100644
index 000000000000..fc46ce321d59
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m-ex.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2M v3.0 SoC sub board
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+#include "r8a774a3-hihope-rzg2m.dts"
+
+/ {
+       model = "HopeRun HiHope RZ/G2M v3.0 with sub board";
+       compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2m",
+                    "renesas,r8a774a3";
+};
-- 
2.34.1

