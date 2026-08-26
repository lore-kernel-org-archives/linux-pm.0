Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011037.outbound.protection.outlook.com [40.107.74.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A623645D;
	Wed, 26 Aug 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739225; cv=fail; b=rwGiMx/ajI+/Y3tHU3+Pd7Bkovhh13GRtrE7IvAdjxPPXgMF1EIaO2kd7KEScvisem8PxERTt3I+ndk1Azrq3vQeJmeEwdahA7ZVoWdBj/touDYAHfHrjMohUeITjBGW0C/VHMj+FMCsTTGJETAPWOyC0Wh7RriXizm9JrqcNRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739225; c=relaxed/simple;
	bh=GVCP8IBj/9YghN8pWrXy6nAQPe6kQhgGm68mRTsj+jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b0KpzAsZL+rP5RxRvJDHfEPGE6eAwL/5Vyp1R3WBNmElpe0gw5vg9uqle8lUoFd1DW8UPuwZ7Flv70KXrineyEkVziuuHBysjidoKH4M2jp7OwFdo5+H2pHRsS+G2FcuTyRK5qAmCK0OZ/6FY6m6UE0cOEdYmWHq/6WZss2+cZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=oZw8JArp; arc=fail smtp.client-ip=40.107.74.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="oZw8JArp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=si/RbBEzfzbyMq3obFrRN2diauHwEqcg6NZ2wyf6qNLMp6aLpNokWxBvahTYp8cx3RIhx0Rp99Vh6UHGqsA1yWc1303767D0eO3qy6JTKFYcjkvYFM7vcBPI2AWYBUtf3QYv9rr7ORFkiy9zAK77lmwwoljVlpFcErMB0RT2HRsMKy9q0sCrDofmyBD096NJlj5B4VcaixQUKiLfAPCH8voEMbM0CAVBZDciAfu72D2cDNUukqmxd9W2MXE82AHrlEctYYRC9h7PPmxGCMcNnGFSkKJkCsL9lEcnvxMgDtTGBDZzYLIDiPgagm3B1dF6szWKnKlFUyJsKRHiBqCCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxGx5zoeH2wrPVFePziZn7lpyQ8BeWM4ga9XxTmbYw8=;
 b=NXG1FNv1iOzIQ5C3On2q2lZsR/LJyLPb9pLtoCt/VRD3LspV3FmQX2rdmT+sGNrPC8myIMHMsnrFEAfQmi1fKbXZPuGCNgWR4paw4RRR2MxiHrsC7mSZFZ8ezjAXz3U3c+EOSAGwMG/hlzFM+4ZopqrDemeG4+BgBHwQZI0vaNstcNwQENwXssP7X00qe8iEbhhDVRsa4J28rYviXdYg6mIRnGJLoSN/RbHpPXs4FQhYeqYE1PrMRC00Mx54B4lkTUkKI8LekyBPyDsNL4zH4YDIwEZYj4homcHwoKI4bxbpmy5IAXX9ZkPDHm8aCk9W6bJownyVFRmLsB1qy4N00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxGx5zoeH2wrPVFePziZn7lpyQ8BeWM4ga9XxTmbYw8=;
 b=oZw8JArpk+6x3lGmGQZp8/oA7aZ1ftNQCMRI32kXPJ06zsVkQqeBBAoDBK4JhxvPT93scyw0c+Z6BJx9hVWOpn/MWvR5+uEfzzte7FW1lMiwkxSymZdwBuwpDj4JdKYz9Rrh0rarDTpnSt6N9U7H2CoXRG3F35oIJx21D8h12iI=
Received: from OS3P286CA0111.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a4::13)
 by TYWPR01MB10288.jpnprd01.prod.outlook.com (2603:1096:400:1e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 10:13:34 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a4:cafe::30) by OS3P286CA0111.outlook.office365.com
 (2603:1096:604:1a4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 10:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Wed, 26 Aug 2026 10:13:34 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id E2E273000265;
	Wed, 26 Aug 2026 19:13:30 +0900 (JST)
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/1] pmdomain: renesas: rcar-sysc: Update description of chan_offs, chan_bit, isr_bit
Date: Wed, 26 Aug 2026 10:13:12 +0000
Message-ID: <20260826101316.22193-1-ayman.chaudhry.kc@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYWPR01MB10288:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 63ff4077-0277-4d19-5f47-08df035aafd1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	I5YfDTp93AN0SFAh1cQdtO4Mbh2uCVACjdk7NuXUuBS50s/aN31H8w3oM3sV2qCeIR7rUbOv49+An/PKJrlRt3BK9FqnkEs+GhZLz37O+K0nfpN24MDF/DcrpnP6SptR453Np/R9DUmCJDRe11Jri40hw0CzYxqyPbLWa3Ej6D0/hgRTz8AXN7SNBn2PlF2C0U7EMluYJlXAvPvLKbRM6l2XZ0Atm/QUJ+3fp4RJzYCT3SpIzcDvegb6jTKO5acpNzNYH4tBUCCU8n3nA1IKuD1Sb0B4jYd6iGPzrkfEuxWp9/gQD5p/qy4rulBcnP8MalQdwD3L/EJ9SH+sy4iaPviX4dnwhLuRXHIRXp7BNMxdRRnkp9jRMbpcApt1uXxBmJSwqZXB6yy2JRuiJ6b0CeDrheTM0tyN0xJR7VHoYnYI7tC0QZ0Aip/+efLfIKRKgTUivGaZ/jpzRWDPW1uT2fKNXfakvkxXtzFRLFp190OeEVQyi8BaL+S+Flq8bGXycmzm98yhYU1bWSMSDtp6r1M8mDId2XTpiz5PVwywmy2QbbieAm96jK43UOtaV59Ks+F3itC5HzFWFWncjFfttnK1VeH+D3EHJm2ZU+jJrOAbJ1lJgJNiPoJRSnlTNvsWy07ppbGqgNuz9liWIDNNnmlI3vCVxnRB9gHeaXdGPFuOOu0Q49Tgwvfp+GWkgRrsYie+Yf/9GpHHSd26QvEQZg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WJGhcq9bVyMwo5cQSmmnpp56pWO0dHdBrv1MssDjeBI/pK94Zvl/7d4+eqsiVGgmps8U9d28gPyU4ctHK8Q0+efhwmPzK7/s59YonptG4IliJphD5Zp+NHuUfyNbHukuLzU7CUes2+i5tbELSlbu2heETSymqSj/c5REvss+mqUzvqoW+610twuU/GWjbM79V00u+c3n5AAK40LpJPigsJ5StT2xXuE9uDyNm5hIhJXSGLKZnNAtPBAe2hpBrBOb9UB/7P6qbDJE/P2ffJMcPAGnt1rmSvAh0zfEyCXuiWRFEFzv9dyB/h3WRCvONc3SsMxRWKh7yG8aCa6+F0jFClKtx1pH8l0l2u83VZrTsDhOsXGuKyOkFqLDtSccNPMYGIPGx4laA2fceJ0VBE9F9u32kjDHJPboEwFkHPv9hx3iV9B5VttySUl0+JyY+4kX
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 10:13:34.0960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ff4077-0277-4d19-5f47-08df035aafd1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10288

The descriptions of `rcar_sysc_area.chan_offs`,
`rcar_sysc_area.chan_bits`, and `rcar_sysc_area.isr_bit` do not clearly
document how these fields are used.

When `rcar_sysc_area.flags` is set to `PD_ALWAYS_ON` (i.e. `PD_NO_CR`),
these fields are ignored, therefore improve the description of
`rcar_sysc_area.chan_offs`, `rcar_sysc_area.chan_bit`, and
`rcar_sysc_area.isr_bit` to make it clear that the field is set to 0 if
power is always on.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
v1->v2:
- Updated commit title and message
- Changed the description of `rcar_sysc_area.chan_bit` and
  `rcar_sysc_area.isr_bit`

 drivers/pmdomain/renesas/rcar-sysc.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.h b/drivers/pmdomain/renesas/rcar-sysc.h
index 9e93a1f98f68..b264e727883b 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.h
+++ b/drivers/pmdomain/renesas/rcar-sysc.h
@@ -29,9 +29,15 @@
 
 struct rcar_sysc_area {
 	const char *name;
-	u16 chan_offs;		/* Offset of PWRSR register for this area */
-	u8 chan_bit;		/* Bit in PWR* (except for PWRUP in PWRSR) */
-	u8 isr_bit;		/* Bit in SYSCI*R */
+	u16 chan_offs;		/*
+				 * PWRSR register offset; or 0 if area is
+				 * always on
+				 */
+	u8 chan_bit;		/*
+				 * Bit in PWR* (except for PWRUP in PWRSR);
+				 * 0 if area is always on
+				 */
+	u8 isr_bit;		/* Bit in SYSCI*R; 0 if area is always on */
 	s8 parent;		/* -1 if none */
 	u8 flags;		/* See PD_* */
 };
-- 
2.34.1

