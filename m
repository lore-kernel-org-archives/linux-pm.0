Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE83B2FFF;
	Mon, 30 Mar 2026 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872092; cv=fail; b=pbCpwlopOqOjrU1HTRMID0EkV6oxL6v+L1yDb4xicvLC6+2W8SrmUZvjvaNwL2Kqqt/sarE/W+tElFK9svU4LHeJ/xwn7ajHERE/M5wERRBHP2u5BJocXo3xBsYjcNF+eIU6kVkJa1y1QGEIYzEO0wZorH5S6QZyEUJBP9G35sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872092; c=relaxed/simple;
	bh=MZXk88hvaLHz9TsIYqUNVEfkkJHVtIgPTJE3F+2qxE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVH9bfRXqazHmY1+q41Kz+8HDMFa8qPr9oped51pNkQfeMJL6lFKagG2fg1qftReRjhtpn0TOZzq7xy4CKlOKWlh8fUHD3BP5c8fRe14Eyu3KQjJWhaz7vrD9zuJKofCuH+eHn0I4k7aaYxnYxchoeoyzg5Pyj4tbjUt2+epkE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VQASYPSa; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VQASYPSa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T80YIan10lGXPAr0TSsct6v3PFWpwXWIs92amD173OcvMXfhfedE7DbkWIS7YMpnZWdyZ7r1JUlpQhJDdHunOszAPbSe50WIbMYaTOEWqGh6BEWo3iEOoUPwmr2l73U/u9/wIQZsYC55+8QPKu1crPZQo4/ay2AGsBMg6JHHX3/EIYxElFGhxbhFSPw4oei0oigkOziaCK1PD/UqFIdHnXViV8JvRNJjtmsOhQVcf4tthwrw55i5ealBFh4g8e4XVoJgs5NTBRH99+5s9pzmsLti7fCg42Q5b6FjA1MKOT7zqa/b+dAP/ZezdWYeWtCkD2JjZq5ugCb8NLtE2vlwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wz6XwalJokhYcVR1f6lT3VamIddG/z2OGHjGFwc9qTE=;
 b=peN8Pb9XzA+dGXk8OAM21ja4RsnL6xKh17XaK6W0bwX2QFF0LawHbuKmxL/YupSZadgpO3tsH65d3iVoFlKj5QGsYhOJTMOIAerM5z0jHnWOwMlThMzGxR0NP98KxlSJ00tDMIZWmjchmW6f1JkIxLghP0bmGlqyIjUqQLTle6xpPLPmhFxAFyaM+AK/XpqNH7hHyYvm12WbOkCmjwOcARkDE4+py5vfiTsA9RpGQDSvxF+umQa2/qovM209aavDjqZ9+0BcRhEugidzpc+KtcsN7Y7ZSRCz8zg3ug6L1WM3RnQOaT6LP0zVCcw94T6cAcStgKIYLbeBos/6OkdBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz6XwalJokhYcVR1f6lT3VamIddG/z2OGHjGFwc9qTE=;
 b=VQASYPSaX59n3w/SAQ0bHJUcrZlDsrdnB3KkqqC5/tY9RTaLp6TYktL4IMCipT+/DZ4J92Jkn7OFL35Dpcm6FGrEdIaMMQ9dAqfl0Osahi5nax1zgYew2jfTNLAwAu4kRP74AkOKhcFQwEHgLhMuitgNwq7xw3Rg8u080rYVbMo=
Received: from SN6PR05CA0012.namprd05.prod.outlook.com (2603:10b6:805:de::25)
 by SJ2PR10MB6991.namprd10.prod.outlook.com (2603:10b6:a03:4ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.27; Mon, 30 Mar
 2026 12:01:28 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::45) by SN6PR05CA0012.outlook.office365.com
 (2603:10b6:805:de::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 12:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 12:01:26 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:01:26 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:01:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:01:25 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62UC18tE242506;
	Mon, 30 Mar 2026 07:01:21 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, <d-gole@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH 2/5] arm64: dts: ti: k3-am625: Add ti,soc-info to OPP table
Date: Mon, 30 Mar 2026 17:31:02 +0530
Message-ID: <20260330120105.2985200-3-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ2PR10MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fecfd5-3737-4a75-f36b-08de8e54121f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Qrb5d3AoKL7iOvu1tSm0i8Ntki/cOalqdQGKabzDG2CdUfuZVgXZq4chZiD+mXEaWmoAnGyrdT7jPic76yWAQpINbxR4B3KaYHH5U29hSrST+AT0TiihPUZR4ReIDwcCobmeYfcFHhu/lodQ7yYc7HvV/mOl9jJzGe66GwYSALnLB4QZdcTgGb8gV0YC6cxBDF7BcnoW2zh9QA48mB+jTz+wdHYO1NvFRQ1Ukk9ZOrtTOqGmnFx0A6d43JLlM+s9c+CjO4pghnRMahtaIwSRe/g28jgR9g+JrQ8Vdc3+km7GZqiMomYwXq+ez0oL1ZCBIODj+3Q5NCQo0QI+6nd9iMf8lZggYLDx2TLnvhZ3EaqfvnDz+sco1adKgW51E/hEHwB2mYhG0ufI3HyuOvZIKuFm/1YmZ3wD7cg1+iGiVFqfB8Z+p2koAmaIw/H2B3II1oMgTKAlYD4o1nh9mueSAqXodRC7hqepb8Hf9w9N6Em+XFitPOTJCoKPYQs2uqv3+8Hi7SvS0DWTXnIjvpL1Qk656RN0j/coU2u2HjBcnkb+BdIOZ86dxlJcmM8MzrSO/I3O7CVmoP0VXVGkFP3fDY50CbriKKS7gjEO3MmahYVDyeKXoms9rt0qMtMuipBjGQeUT0bj7997zEHu1gGOhOigAnaTW1+yVheDwpcRP0Q3xdIPYL7cjbtdFXlEeorp6rTfW1lDFxz9T1oL4jNBmX2KJIGGCmd593Cz8zHtlxVeyjI+hKRp5oU3oc16sXKylkM1VOmd7gQrMp6N72Xw7h+Jb60OxtIdw/kHHiNuBzPw2rm5eDvwqN9R1B8xwFwi
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BSBp5GnbXPFx9e/kTxy4bYkk8ryJatGBBON2lnsMqyXgUIuqIcZv039RCmURFk2pmazGXMSXl6TzE9m6hH9qnCdmD/xwWTPPiT7rVE7rTGA6mBvyfKDsyYDBAhi4o2XCCrkcMMOFgxr7XooZRHYqLJnxhq9vNTmwhkPD0qcPGzLxeXOIt2iTmQnb5O7MA8lJ9Agc8iJo27dK1J2P0SYhFMT9dTv8CXDy2KbuzzKJjAinsqPuV+Kn/yF990WKXGxoSQGPLUJ9xZuywylERbjN/4qae9wg7NjCnlKVO/PqZQxjHKWGA52Sv0iJi0X6LZfNidO3v39ZgVS9RTt0dQjJnCGuU9rI3e7YLJGiN3Av9NY6hrOHo2mrbwJyEWR3KBTO4HAykYAcFO4YkWfbvquhSwynAqTif4VjmGY+JfnmUIGSvUEwuGb7Yisayux0Flln
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:01:26.4949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fecfd5-3737-4a75-f36b-08de8e54121f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6991

Link CPU OPP table to k3-socinfo driver for dependency tracking.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
index c249883a8a8d..b0020e667882 100644
--- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
@@ -109,6 +109,7 @@ a53_opp_table: opp-table {
 		compatible = "operating-points-v2-ti-cpu";
 		opp-shared;
 		syscon = <&opp_efuse_table>;
+		ti,soc-info = <&chipid>;
 
 		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
-- 
2.34.1

