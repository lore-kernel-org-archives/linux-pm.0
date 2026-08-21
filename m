Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010051.outbound.protection.outlook.com [52.101.228.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8D31E106;
	Fri, 21 Aug 2026 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324713; cv=fail; b=eaPnxunY6LiPgcOdaOp8Gyo4SX0wGtT7VOisuHEQMgGZvQAMHOnws98vdLK8cEXj+jZVR9HXfDCS/NMObsX9g4SstqOmkpm8lCZlwgmYym1e+FGJYCdIHciTHIAyI8qY9r4cPDU9eFJdmpUdUk3p7TpPIK2TrWPS+nKmzJwVLqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324713; c=relaxed/simple;
	bh=U424bggXv4J49Bpt1jdCGP5KBrJ7j2l/oVRDK2HibD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fxwJfDHUPdJq8t86Cp1R8t6jT+c3aH/rMn0L0G76KusneA28UTCpxyEkThCoUZzSw5AZVw/RQSFwY/YWLyPHN9CMH+7F3idztvtpmLSmSGkVXgWjMXWWID+WNqs6GEez6w6neTeEAOoxXD9X7hQIyEhL9NJN1D65AffCiuPf+VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mL/0i3lp; arc=fail smtp.client-ip=52.101.228.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mL/0i3lp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8oMX5NZ/Ypfu43ZYop44sCQH6s8WcihNhWdPen40Zw26R56016E9lRy0fAF49iFcSygvYRsahTeO3gAzKxTkGwRb8HDtDfthkSjsp4tByWcm643WVZAvk8C6gsdAYYkHCd999U7iOaARnnEaRTvzF19JNldGM2epW1ci5Ap5Pb+5EC4GzpCaHqsH5z5LO5jagKqtgUfMi1KXAjVYetgjCQ6JqBuTy0nMmBr/V6reZpWAmEm91haGtHW1mYk72m24CptO/CpxCYhvk8L6WYeoqYoK4n5lwxpmbSOv6bMPLVatqZFChStNzR0BNbP2lu5JKliCW6J+HV1mm+Ji4rAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTo0M33jzTL0Syk12pxkS9zNdevNk6BSJK34PWf0HW8=;
 b=nfeqtWnQG5fQ3qdnALMK/Rbe/TyRJ5n2UA0fJDirCZjSsySsZS/IXNFMF3xiFiOEowKzSDKR6YCjs01ALChm/nhBs45gkCoK7rKgkO9hTpe1w1OaaWK3QNr1nJpwufwwHCGwYi1HgM36af65kMY64kkoxopRwoQjZVhPuRtc1Rf7WpMCyyrB8iq4EzFZumUoAhLTQlRPPmc9VeQ9H9ojhZMSR0vpW3kZdAb1P4SilTDJVXD/oWl4zy8fEVUbqYz3y3XZDjwpWmuGrZlSxtkGdhkfWYj5Et+d0zqnDDEnnF4DUgVMD/nb1RTpmM6A1kwzObx4IC6o6CKN1ofotvNpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTo0M33jzTL0Syk12pxkS9zNdevNk6BSJK34PWf0HW8=;
 b=mL/0i3lpIfwmWUBdnAEO4gzFca7EjTdvJ9vfejNzMpLcQhtyep5pzkQMV4IEK48PqbVc82mEcYmW5B2mIKtuFXvy8J44/NluwrsQzqB8AviF42g6revWQweOzqG1QbfVPiDvky6TUt5/+LCx8mjeyhJhfdv2PUcxaQQSelxSNvE=
Received: from TY6P286CA0011.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b8::9)
 by TY3PR01MB11513.jpnprd01.prod.outlook.com (2603:1096:400:374::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:05:07 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8:cafe::91) by TY6P286CA0011.outlook.office365.com
 (2603:1096:405:3b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:05:06 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C0ADB30002AE;
	Sat, 22 Aug 2026 00:05:01 +0900 (JST)
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
Subject: [PATCH 00/10] Add support for Renesas RZ/G2M v3.0 (a.k.a R8A774A3) SoC
Date: Fri, 21 Aug 2026 15:03:25 +0000
Message-ID: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|TY3PR01MB11513:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aed30245-31d9-4ee3-1328-08deff959653
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b6i0Ahzx3aE5+EAM90jmq+q6sTeNnH8FlDocZgX8ZcW8zBJhp5VFmNANhm8AqdhB4IKTNr519+2eVpMzjdvPOoAmYRqCY7yFJACOeVh7ScyKrQnIeYEUoU0cnLhN8BpzoG59TA9KBXeGUFLqGfngUJWO3h71U5QOF4QF8w+hn63DG5zCbsExeURLetNVd6vmD89Pnz6cRdTHmqRmyHWp8/6KeTV6n+mywdhFJ35p1n9HQBeK9ProfPrXh9TUdrMCzrad8roINNt3d2WAFQkhi8BdE5tdM3y3vzp2hV4tArc34VeI8WdxIKXipsDvaDM5Q8DWQmyEzvJsiYnoAahhStfb2vnuG8yKOHPZ0WXpXmT9SdZe+1XVgLuXxoUDrgFpsaRzXLePoN0GN9sLVwvxHnT1DV3oGIjBhxwo24SvzEGt6p137bNZEaEQ8G7Inj31GjH3ZnwVql6DWeHUzh8EfSvAFrGF1qNW9M3q5Se8AcjerFPgc3kdCOp5UumZwtEV7vp56Mq9blk6CC6wGptViujO+pRyozubr6ylDZzlnrq0UijsiIwDBnUeNP8+t4AhJnpEFmWRltO3/S8MUw1fsjQEHFZvRn9XZm7szP2KsmEopmEk159JRWqs4ALx9DF5QDzGxDaxXnHoVP5vX1TNwQ/7f5lqjssuvOM7Va2anDWk/rm3LYb+LJ0yf2CEGZg6IGmtHIycBQGLPHsBzrGIkw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NmmpGT1Gl2o9cYLkJp4wmqLtg6wfYJQWGVa1YKcXfAOwYNmqpElhaf2h/5M8642sy9MzV+swc5hKobQLKSTxzg4K1vO+qTirxwXEXAKI53zJX+wMus+SiAVH05OU/Bi/YEC2SfZONlxgzJz+aSq9oD1dwEqH1D5EitIX47mcO3ZRQ4qEiZULIcqNnpMg5L1iCBkAYETU/VsdfCK023OFWG0hGmpdmvjPqLl0gyTPila1jLn2Mq1rGRPsYQ3d4Bo+2lFmn26BYXiflhE9ev5Q05R04QWbyLom66gah/9UwfRl5sUOrAQvhz6H3/uAHm/1pUBo8dyImgaCDrwWurU8pQoO2eDkllWJ0/1WufeN0YAAqRuwJcb1+bO+C147WyI4kbs6JolmDNWPtvxTD3ceL1EKYR+3n6Ku/sxB4I5tWhkm6GrzJqcGxvCqPjO9M2YO
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:05:06.9907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed30245-31d9-4ee3-1328-08deff959653
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11513

Hi All,

This patch series adds initial support for the Renesas RZ/G2M v3.0
(a.k.a. R8A774A3) SoC, which is similar to the Renesas RZ/G2M v1.3
(a.k.a. R8A774A1) SoC but does have hardware differences, for example
the System Controller lacks the A2VC0 power area, and CPG lacks modules
like FCPCI.

Thanks,
Ayman

Ayman Chaudhry (10):
  soc: renesas: Identify RZ/G2M v3.0 SoC
  dt-bindings: power: Add r8a774a3 SYSC power domain definitions
  pmdomain: renesas: rcar-sys: Add r8a774a3 support
  soc: renesas: Enable SYSC driver for r8a774a3
  soc: renesas: rcar-rst: Add support for RZ/G2M v3.0
  dt-bindings: clock: Add r8a774a3 CPG Core Clock definitions
  clk: renesas: Add support for RZ/G2M v3.0
  arm64: dts: renesas: Add initial SoC DTSI for RZ/G2M v3.0
  arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC main board support
  arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC sub board support

 arch/arm64/boot/dts/renesas/Makefile          |   3 +
 .../dts/renesas/r8a774a3-hihope-rzg2m-ex.dts  |  14 +
 .../dts/renesas/r8a774a3-hihope-rzg2m.dts     |  50 +++
 arch/arm64/boot/dts/renesas/r8a774a3.dtsi     | 302 ++++++++++++++++++
 drivers/clk/renesas/Kconfig                   |   5 +
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r8a774a3-cpg-mssr.c       | 168 ++++++++++
 drivers/clk/renesas/renesas-cpg-mssr.c        |   6 +
 drivers/clk/renesas/renesas-cpg-mssr.h        |   1 +
 drivers/pmdomain/renesas/Kconfig              |   4 +
 drivers/pmdomain/renesas/Makefile             |   1 +
 drivers/pmdomain/renesas/r8a774a3-sysc.c      |  45 +++
 drivers/pmdomain/renesas/rcar-sysc.c          |   3 +
 drivers/pmdomain/renesas/rcar-sysc.h          |   1 +
 drivers/soc/renesas/Kconfig                   |   8 +
 drivers/soc/renesas/rcar-rst.c                |   1 +
 drivers/soc/renesas/renesas-soc.c             |   3 +
 include/dt-bindings/clock/r8a774a3-cpg-mssr.h |  59 ++++
 include/dt-bindings/power/r8a774a3-sysc.h     |  30 ++
 19 files changed, 705 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m-ex.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a3.dtsi
 create mode 100644 drivers/clk/renesas/r8a774a3-cpg-mssr.c
 create mode 100644 drivers/pmdomain/renesas/r8a774a3-sysc.c
 create mode 100644 include/dt-bindings/clock/r8a774a3-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a774a3-sysc.h

-- 
2.34.1

