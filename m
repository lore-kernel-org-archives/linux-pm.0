Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343793CA4AE;
	Mon, 30 Mar 2026 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872105; cv=fail; b=Y0TLpReSF/ukYUM6lv4u5bteK8xUjVX09ngfdHYISARa/+xqHEBYBwS5mxBRFXVZoAAsu04vcyO1IQM6QxL/IzIi7gX57wykrZF6DKVJulDkD7IiRR12G5Jmuy2+NkKfhNdpTQLIW0F1EC21u8I73Gv3zLldcnW2rYgTL437gxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872105; c=relaxed/simple;
	bh=3zA84vPKf/InH9f6Pa1tIm5zn/54v5wJ+NyIBLHjAXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKD1FtO3RB0DbcXktKjXo0mwMHpcL3pWks6Ie6Pg3SPOwVHAceRUkW87efbvIYg8dYCdkY1sLCnRggNHv9X+zxB0mhBQ6T5ikAF/MwmuSGfG2B6hWm1s0gxVBiZVSDLnyd9bkDJK3LzAnIWfdwFE2QtVPcmEH/F5Nj58seUQ3o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SNiDxM+5; arc=fail smtp.client-ip=40.93.194.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SNiDxM+5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGHnQ0kMiNFHIQIfD6VQ9TXhXFlsxP/jv5LPddB/dYbhjA75Qun51NTXDBI3YgVEyQh0vKd0htuJLQUsObNA39j7xx6JvCK0lT1D+iINOtT5fBeDBsRw9T2AUJW1il9qk2X4vg+jgzukeIhqy850HArORahHj+eW/EZJcU8o9MBZqVYsTx4eW1NRoB1U+4qNIixROf66NskIPDLX5QcpJu17vszHyQDZPRRn29IWfA3dv1ubkFjM5+aKC79fAGT40EpoKOw8GxSokRJEo9tyjOH1ly3cU6BbQwaWQ7K8trs+3YZu8mKQrU916O7rOPic9dtO2crabuh/eNitHXsyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU298OAIE11ocQTjhKba/yP+OoZH3h1N6NJC0Fscw3o=;
 b=PJ7lde+G143Uw9Yw/nihQFgAxhUNyNTQD3QnOXfX0Odvn1s4lFum/vJ4VY/WJHaBSaoqbFKt3RrSS/UKYr9VUfe/oFu+3QlWvYPy8ZnrIWDh/yZQJ2KXj7YG9LaGQfkEOVikp/zKkuV+4p7B1MN6gbnamBRRWmwTMLbZhwLoarq6d9qgssBBxS1/y/TcRvphmfn/F2ALKIqXd3lcJU9cshjcAPjgKAldNT4H6BIzbRonFfpBcqGOLQKe9Ku6AdZCOTlGjnUNbGCHHgAJPbhEdXYJQM8A7IqxzL9hWXY0Z1lp74QNVW3MFqAhM6wTS2jveYhFCX0+gfk+BPrYHIPoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU298OAIE11ocQTjhKba/yP+OoZH3h1N6NJC0Fscw3o=;
 b=SNiDxM+5f1Jn5wUaGZv3CT1lsIGfrC7jeOVzpM880sUulj1JXCBKgfQIopoH/sBbFKecvWq8dJP0Nf/41os2wb9c8VsxMk07+ZDwdA5d1bXkyoVFWdqoZ62v4px4TwwvjQeAB7BY+4JKkxvowSg5+bvP5nlym+/cxle5kWKt1Ic=
Received: from SJ0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:33a::24)
 by SA2PR10MB4731.namprd10.prod.outlook.com (2603:10b6:806:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:01:42 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::69) by SJ0PR03CA0019.outlook.office365.com
 (2603:10b6:a03:33a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.27 via Frontend Transport; Mon,
 30 Mar 2026 12:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 12:01:41 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:01:38 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:01:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:01:37 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62UC18tG242506;
	Mon, 30 Mar 2026 07:01:33 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, <d-gole@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH 4/5] arm64: dts: ti: k3-am62p5: Add ti,soc-info to OPP table
Date: Mon, 30 Mar 2026 17:31:04 +0530
Message-ID: <20260330120105.2985200-5-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330120105.2985200-1-a-kaur@ti.com>
References: <20260330120105.2985200-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SA2PR10MB4731:EE_
X-MS-Office365-Filtering-Correlation-Id: e1147562-cc17-4287-cdd9-08de8e541b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IQnFT/zbTiDg49GkClGOmpPkA6p3NqW8DbkWPRWROL5GPlBumo/gG92u/AZ0RCoBYWMY/TusAZlO/luvNIVVWATcRpz3dDrlBefAdvSTBzs/lpiU4re+1J152DyQ3FrK1mx6Wh+zFnuq7c4OE+cYFFpCMSb8l2ARHEP+T1HFUIF30/nSoyRPVT5noDyX7E2cnzrnsRPZxqoxJmWCHYJnunw0yPv/YTJGpHHTrz9KezVee2PIgFwG1SXBYzxr9bAiL1MYujWEdXuVp2rQYVp9uVe8V3dla0fNFLugL6V9QZYBv8xywTDnKvAN6hJ/tSpdAoA75fsaAAeyQ5YEfqUSwsUaZfx+sthKRz+KbybtTDDM5iNtXbLs0BWiRzSOZT/zOYVgUlurK4gf/aBf6Q84S3d12ntZSx+PA7PcpRsFoaxDveNy6vxe+MsVqL0hn6NBUHnXAPc6KSyRG1tJjbEK1GCTRz2zmt1BB1UzcxPbi2U83MQJ1LcamkumYXJUBvVy+AVv0dKw6bHC8TLj/6ouRuQJsCeEsaX7AWRQYCBr2TUP+eveUTOqSJCJasr4TYDQQJX0YPOMoOD8wdo/p8n7n1TVUql4EI5qCp8lUG8GH4puibDQQs+jZxKPv+SWJn3rGpwm76XG8O4mop8qe+TaDaUnnv1LbdnQFLhq9FbDALs1iCeis2Chr21klHAGDidykD2zx9fBZbFGckbUHBuAe15WXeG8tveRXAjbcHSGRKxDrszVnhCG61GQN1ZynYP6vQKy4V5PIGPUoRmuWt+OFs7wV7XHWMamG2WM2xL8o3t9q5UiIHzENEA1UfZkFGj2
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y4nZFHz/igBsxeMOfRwzpvTgijq+eeeBw1wpE90O6635/Q5+KIcJB5nwqPdEUiiDvBGUcfwgIktUDbymsqMGPxdj/hS/V5179U360PznTEd5TJRt3YutsjpzkIy60cuy3/5FBsvXKfLEotmjduj7iSpOGmuke6Dl/jN3Xpn7v011yvO70mZNOc97i9D6bQCzocw/y0Ea5TVo2OviFpCF5n53ConEDEGvqM1KXJFR3MVVzvlI2HmqIhRrABuG3xkxe4Cqo62LHzeaaw+HF13/kbYLoJxqRHBPArZpYXlxC0FowQmzzDL+3OoBa2avoM7ZX8nPtiLru5HH04ZWuzdywbZUXtDulT6/B5hxlvniH9qtyIAt+fDZoZSA0+l/dJSoIq/KOFGqsC9yIk6QruL85FCHpY9ykA9LvRxsdl+DQq4sI80KfGWbHqvZ25tOJPJM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:01:41.6232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1147562-cc17-4287-cdd9-08de8e541b2d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4731

Link CPU OPP table to k3-socinfo driver for dependency tracking.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
index 8982a7b9f1a6..1a498c5eb3d1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
@@ -108,6 +108,7 @@ a53_opp_table: opp-table {
 		compatible = "operating-points-v2-ti-cpu";
 		opp-shared;
 		syscon = <&opp_efuse_table>;
+		ti,soc-info = <&chipid>;
 
 		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
-- 
2.34.1

