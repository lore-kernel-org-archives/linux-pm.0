Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011039.outbound.protection.outlook.com [40.107.74.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5543C7B9;
	Fri, 21 Aug 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324737; cv=fail; b=rgTazD2TaSOqjW8DrsIc4A2Zz8qHUoi47OG4xW2lQoV1nrMb+xGzwuZBSP6cbj0ODLDNlizBj+SVddN0RD4NsgUtGKbp2r1SZ9AplapS+wY01Hl5ENm3T1vqUJWhk02dcXwXveATw+/ZIEBhQGH6mxIjdktID/Dw9SgjV9cshC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324737; c=relaxed/simple;
	bh=QW2u399G+LLoiIZuE4sJ6rQYxU+wYr/Me/xQJbSzVjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FANxAdmQiWryJn0hgyNAmzx8CugaFK7lzxgY7ELk2paVIklsnG2vFOmaH2yY1r786+1b4e514b9oGHBVC0XqtH64IaMMaTNG5ulYyF0F83x1mMuP3wRT5rZgd/DwOKR8QQASbLJPrt787rp8a1H15kQT1mEN21v9WWM/N2JKc2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=SguiAMmJ; arc=fail smtp.client-ip=40.107.74.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="SguiAMmJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxsYWD2CHdSIXbPS0zGvkMWQ5tTKhmMOQCGGKshfS7whv+KZc9ZFrJnZxeKKRWvwJzZHMcbBKvIAMEmi3uCl5D1deNhnRsBEk3obZ+226mhcMj+fow+ZgC5/aUlKIcCEMAkkf/W9V9aKj1kNPabgO64gc2hchJXJESYSVh0n6svP1C2vKVW+WzT6wK27DTDKupS282vp+x/4QqvqckPdoREtdvBBqdA+vvVWGCsXMrdHPySDcAuZmQu8Dk7Rxzcg4IXUlQhKA7bhfY5DiL2nO8+Uz7y6bSU2EPELlE7p6ln8VKRI/7S36TOhuio0NuPub9Sms9AzWQvW6EOMXAePOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+/GBrf3mFOKTKbUHqdXTknd0ewPqqJkISc+393gW8o=;
 b=vvK/NHgRb+w6fAb82w/mu32Ra6uKavj+u3hwo13AaF6ihJEbu2xrDDFB5I1p3dBCSqhPtAYaMpfea64t+7x5t4zg0AiWom1+YxIJ+I9pnUJ+0Da1jIwNPeUMAHF/VBWYbCwSO33/U6T0qx+p44usiixAsEuCMcswXDp0Aye6MJaWKwlroDNvC1+JZk8sCebFvMUzwqqOJM+4xd+++AUBaVtnKywghCrEdXI6kCwjYGvD64O9XyQsPjyqpX8owuYWmFsls3378nEtLQ602km9JDB0I+HHh+c3Cjfm+VTOwy0zEWDM7qOUK0NtPQ5zslGOTGQQaL+8TQsDWeD571CupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+/GBrf3mFOKTKbUHqdXTknd0ewPqqJkISc+393gW8o=;
 b=SguiAMmJJP/GME90R+7O4jdYeDuvAyNn+2rN178KCFnwJkpbJyYRNzyhl2+bpZXzZL5x+MjTvNdDOqnUWovu8jKTz/yXnCsUjfkms9ZFDLigU61Q6ZY98AG+DnvucTTsyfvbw0pSdN1tuLZivSWRqu5uxai/C3tOKP83nz26hSw=
Received: from TY4P286CA0011.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:26d::11)
 by TYCPR01MB8517.jpnprd01.prod.outlook.com (2603:1096:400:155::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:05:29 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d:cafe::aa) by TY4P286CA0011.outlook.office365.com
 (2603:1096:405:26d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:05:29 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 1338730001F7;
	Sat, 22 Aug 2026 00:05:23 +0900 (JST)
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
Subject: [PATCH 04/10] soc: renesas: Enable SYSC driver for r8a774a3
Date: Fri, 21 Aug 2026 15:03:29 +0000
Message-ID: <20260821150408.73829-5-ayman.chaudhry.kc@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TYCPR01MB8517:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: efa6bb87-1f2d-47ed-8ef3-08deff95a390
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|7416014|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	lPWz5krZ7oULxUGpecwT2S/9rOGIOQw9sJ889o6W9iEz1vdePDajNyc6cdERaM4+vlFU+pwZLSR+gpx9goAn3pxZXzIz7fbavmvbxFXkmG7Whjiw2MjuxSPjb39wFxVmOk70I+Mv61RiqJjK7ZuY1wYyrnLXwQ2f8xAVVI2+/nxFMOE0NzUlNKrrnr2eZEizQUAY1SJie9WWm1x8f5MnxsCpfhIeP6L75NIvF7czUFoblG4qQT9pr/Kwx1N/YuLXOCNpa7yNlqz/Ks3Mmcs4OM7DjonEn+SA+tCxR+8gvSlkpTAoZkxO+RvwKCjgAIQdqiKfZP36wVfg3uIO/yguCG6dmzh7Wgk1EoLczybTwQI21MsgVLRbs+vGaCfqJanSGfRlj/yw7rAwvTszaKTyMnq2F8UOrAq9zgKuJW+pX8CG7kD9dhqgqID+GrgUfXC4s+Nge7yUvGpliQQ6X8pJLwPIfhBnYROkH+XncrLC1zvB9onsGM3fHsXCnyt6kP+hiXAwh/RJ9xWJ0EKBmJGg6gvDjdhaxX9lFX2bAyR65qIMpfS8IoY6oXZt+bO/lRD3qDlYVi9fQL1mXU9PebEeAFs5fcnDhF5LibDNhhLFq4aY7DdZxLYxOIRjjNEiG5SlG2gdxP/dTD93HH4YCvFh1RiGHMmsY30TSm+x1V1D0iPVcfarFnk9CKaqf55KIxS6E/+6W/TMdhd8p9/OJgnGTA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(7416014)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZBV9QmlDMUw1yW4PTWhTzvhGaUrvM5t6RotihUHbbsFqPNcPUf7wZq8wXtppO1VX0pgK8meYTllM2gNHMqZvl5vQxBAT/QeJP+9uNBHQvYKz9VExmQNvxq2aWvV4AtRNOi1NIBkPxbPEKkdBWZyWub+nVfc3qxS54myJ6GxO46ZBr8HKY7HT64i5USLLB7ydAGEiuphK+ONiqMUHJRiPM6CKmewTrsYX/CcIwsR2sRpsAOg2YxK6sZOuGHUF798JGN+cx4APNyuR+MjvcVQVgtqRfYMyEEIfpR4EipxeazdwvdvXKBxeFPIh+30QG+GSnbRgLpB68HUJ8950KXTNRh5mLS+6SRkhMoC87O8j6DCr8S7OaGEhkySwT7RGCEL9y+EaouwNegVGY3Op8MrG9Z3ZUN3xEmOCZd96geXn0NABFsxcBDmCviqv24dF0pYs
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:05:29.2051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa6bb87-1f2d-47ed-8ef3-08deff95a390
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8517

Select SYSC_R8A774A3 config option if ARCH_R8A774A3 is enabled
so that System Controller driver is enabled on Renesas RZ/G2M v3.0 SoC.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
 drivers/soc/renesas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 35479c2330f3..cfc56276cb0c 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -231,6 +231,7 @@ config ARCH_R8A774A3
 	bool "ARM64 Platform support for R8A774A3 (RZ/G2M v3.0)"
 	default y if ARCH_RENESAS
 	select ARCH_RCAR_GEN3
+	select SYSC_R8A774A3
 	help
 	  This enables support for the Renesas RZ/G2M SoC (version 3.0).
 
-- 
2.34.1

