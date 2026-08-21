Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011048.outbound.protection.outlook.com [40.107.74.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C83546D2;
	Fri, 21 Aug 2026 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324721; cv=fail; b=IJMHIPZSLoAK9CfsShyhGrYyQhVlKxjnPmKjUV1KoiAoB/42HkC8UQSQL2aYf/qY4TTGRUp1gjgEGkWscKs36o9AJoYR4oGEaeJEr0uJ9HIIijt/b5TRDvVuraRgiJLmYsi4vB3tRKlEx9F1rdU8BN8sfiJCgL9/Ks4oiYhelxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324721; c=relaxed/simple;
	bh=kvtTmu1veJDqrjW9RbyZrsa2REAU5teRW/jQPNaM7go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGrw0umVbRcQd4pwiqsUM1wZVGnvrhx9lCDloTOqe+c0Xx3XuklJ0YEz7dtuF7DychDKsN4C3B/WdixvJxEKoV6iVS7THLMm/h9CSV19o95cSVhQZIJHD6BJH2h4qHq320zEMKR098X/ZJ6C83Aerrt8brSbB3W2f7TyQyAyjJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=jK7xiJPl; arc=fail smtp.client-ip=40.107.74.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="jK7xiJPl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6z2ySQqP3EqkZaJCLVfgN7Vvq4a4LDKXi06y0RgUHHYMWtxv+KwrHEvMGEP0YI6eFrodPsv4gIDBrwbrY7JTbjkXdsIb64kkO7vuJgKrpvIFi1qiDqMwXHSM9o2L4ZQL8i1ik/zKYWQ5gOym9x2tXKNq1trEmTT7250CHVQxsovNCgXDouosmIIqmeaaXpgE3rycPjfooRdqoMr0Z1ovNZli6kwuF4R0niq0ix/C3ptdEHwgYjlGfnfr4BJ0s/cl2TjkaHqxPPI1brMeE0kLLGfPT0m6w2o8OCVaske2EFuFjaTuCVOami8C1uZ8i78XIK3t8K28VI1epOEPKARWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y2nEdai6XAnOTrD7A7Z9/SHuYvgCybMO5Sug4AC5PE=;
 b=f+8X+Rofe98ruYmxWhJFBVDfPHg/npIIiWs9AIaSvxmyPGAe08o3tNsID/8vD5ZFvI8aQdB4Rtz9HIzTom4k00e2eZwZceqfZQkiwhIetXbiaGu9eiIzLHsTjOoLSs+QJ+ei4nxXh00wx+ZYXsNIIjEQYMwHnj6I5AGic2+w47lOwzhnIK/ErcudrpREdmestyUVRnZlC9Mk4690snb7dvrDbjCwUPZHtdCFi8MQc2NupyLoJ1vudLADOvZddzTjFfm1Njpkzwtd37civ+xVFFkM/nhNJNgBMoW0wkDK2rW0W+9xTlktNNLZRdpIj4tdIL8ZfD5Lk+HIqh0mzpkxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y2nEdai6XAnOTrD7A7Z9/SHuYvgCybMO5Sug4AC5PE=;
 b=jK7xiJPlKEhU+SGebXubuEE4lzlpPe8JX0OmG3+yWx07hwPaaHamYhVaC3fRxlEMKAVfnuYLztiOZjh818kmAM6R4VVzQf/WQ1Rfe3wBq1MNYsOWZctymK20uZ0Gy/50fREBApD6vDJJyeDEoWqxwyx3kkKx775tJVSf4BlwXo0=
Received: from TYCPR01CA0194.jpnprd01.prod.outlook.com (2603:1096:400:2b0::18)
 by OSZPR01MB7699.jpnprd01.prod.outlook.com (2603:1096:604:1b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 15:05:12 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b0:cafe::3d) by TYCPR01CA0194.outlook.office365.com
 (2603:1096:400:2b0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:05:12 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 62DE030002AF;
	Sat, 22 Aug 2026 00:05:07 +0900 (JST)
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
Subject: [PATCH 01/10] soc: renesas: Identify RZ/G2M v3.0 SoC
Date: Fri, 21 Aug 2026 15:03:26 +0000
Message-ID: <20260821150408.73829-2-ayman.chaudhry.kc@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|OSZPR01MB7699:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 96d7e7b6-7096-4399-50b5-08deff9599ac
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|36860700016|376014|82310400026|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0YaFcW4hDhrakm+sgj2oO0mOS2SggS+zKT4o8vo84RdIN4f/ANOIwmvOiyhuHOeuiaRu0oPqu2yrzU2lFRYpzpN80C+tVF6kc1l1vL22usxoBvPWaNnsHxj3lPTI4kOjbMW+006zWEQvq6iqZNV4Wqmx/NwxVoda9anK+qEN6G2pnwB69W5cNLuE0njsHMb0GSsL5x48fNdVc7oNepFwRq2pbJTqvhGqHvka6ldUnmr2B2yj8g600MMB9Kln4WcpsSlUTNSErLVF7u8oTAo5N5iwj2R4heo8rd4c/wpfHhHh45nFv20ImaskQLeaLdgOBahyFgtelK4FpS3vRMbaObW+F1JEzSRp8EM5yLpNNhA2h/EpL4jZlKcsWnaT820N/PIOpck8GnQsyk/wqjUiN04cW5ri+CjJ1Y+5eeH1NEehQ0+5ZmeQBH+KHcblOjqO3EH56L4P/DpLPnSPNaDIRlK41OeZBfiiuIzXx06XtLUt1xAbf5KO8m7SO3r6jvlaU2dL9w9cLezIKL7E5KzxKfdQcm5KKYcim5xHGxQqawjURbhk88VWe1AZShi9hqDlIAj6ZKE7oGLsc+OS5xNwpnJMyJPTkXDWzD7tJWD5D/73f4srcZGkMVJ/aBwvvwlAQShJlh1UdMKhcjw0vQ0tIDONXyOvZ3KsnTvvMXzt5SF1WzXDTece64WO+Sg0dH6f4l5wLjGeDJF4pr074T/+kQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KypuP7UZ+ZrZ6kFVAVtZ7AebfWsgH5x01iRM7G1aEbD3UMtU/DWhZC1qaswn4RQVP1Fnrlp4idXJs4GW6qnhQkSdOS7Nd90Fc5bMqTk/84LtdW6T4+YFUiNPudDSvh2p5mwcA8XclqlKmS9ySagn/oh3z+olV7d6X96fqaB0IIEDTv3xAtlG2guhKTdt58/1ijVOnBHROMSlFezi8Kcg0zAnBsCPthhIRVAl8A4ayaQ3zlELCFoEwNfB+BRUuXbvKL+3D7ns45mvEXysy6ueLYbvXhGI687MvElKNayIbYV4YK82dKIsh2+cIEi91V0wyO95dqU5/o4Diy0AmfO2zqflsNlBPEuXe1poENEpApH/GiwDVvOTyJ/UpyEuYzvWWp61iisw4RAqbhEO9fBiVHmW/owY1Up9z913CCeBK5uVd46RDoXpoEYhXwX9BT99
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:05:12.6103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d7e7b6-7096-4399-50b5-08deff9599ac
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7699

Add support to identify the Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC.
The RZ/G2M v3.0 is assigned the same Product ID Number in the Product
Register as the Renesas RZ/G2M v1.3 (a.k.a. R8A774A1), so use the same
SoC data.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
 drivers/soc/renesas/Kconfig       | 7 +++++++
 drivers/soc/renesas/renesas-soc.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index eb8ac0d47d9d..35479c2330f3 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -227,6 +227,13 @@ config ARCH_R8A774A1
 	help
 	  This enables support for the Renesas RZ/G2M SoC.
 
+config ARCH_R8A774A3
+	bool "ARM64 Platform support for R8A774A3 (RZ/G2M v3.0)"
+	default y if ARCH_RENESAS
+	select ARCH_RCAR_GEN3
+	help
+	  This enables support for the Renesas RZ/G2M SoC (version 3.0).
+
 config ARCH_R8A774B1
 	bool "ARM64 Platform support for R8A774B1 (RZ/G2N)"
 	default y if ARCH_RENESAS
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 18acca73064c..5a5d05013eb7 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -312,6 +312,9 @@ static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
 #ifdef CONFIG_ARCH_R8A774A1
 	{ .compatible = "renesas,r8a774a1",	.data = &soc_rz_g2m },
 #endif
+#ifdef CONFIG_ARCH_R8A774A3
+	{ .compatible = "renesas,r8a774a3",	.data = &soc_rz_g2m },
+#endif
 #ifdef CONFIG_ARCH_R8A774B1
 	{ .compatible = "renesas,r8a774b1",	.data = &soc_rz_g2n },
 #endif
-- 
2.34.1

