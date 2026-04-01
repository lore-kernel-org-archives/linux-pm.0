Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03753F87F4;
	Wed,  1 Apr 2026 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040905; cv=fail; b=Mpo8AqSmrO66F0WtU2xn81JjeDK5M8ZvraxYzabefpLJrnCyY8wCQv3/jR8sjdZB5l5hvGvDaQjt6Q5o1VsAKTR+s7wuT6Lwm/BcEpXcKjiBHYQvwKr49vDYvUlE032jBcSmJwSrxJIqY7//qZzY5epMp+gpen0dUh68F0yMyxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040905; c=relaxed/simple;
	bh=3zA84vPKf/InH9f6Pa1tIm5zn/54v5wJ+NyIBLHjAXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrBtgaqGlmVfqv1SwjHtYP6CjLmzmVev6nZq0+KfD6dnWAfl3TBWt6rdbcvHJPr4Ve2sBICJB3xK0OXvwJQpWfELzaFxtiyFQlyM7ZV3eoyBLsg+8nDTgXNwkxgxhTqHiAdkVhHjegTjdZOMzS8/npVxHK0X5KaFh9jevmXL+XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qy1FcAZz; arc=fail smtp.client-ip=52.101.193.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qy1FcAZz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj39p7RPF8avdfIQkteSgd5H6QJ4PrP7gEprZLzSFn0k7xtjsyPhGAJS2J/1KFT+RRJ1vnY3zeKeUydaL2A8Sr+SiWPNHkH8gh/v69CICRutD4J6CIZvaTUVOsxSjNpfQJNe+tlLursP8zyW+W9pmZ+N8toELtNsZ6Kqgw9AnU/Z+6rmYwVH/iTo1XX4vNfXMe8coaRK8cTjyho04kBFyP80GtVlkKYQTef1O3liiowUyGlYA0BjPOkS39NmIuCgUY96SdRM1+QRJWYRLStezp7iYrd1DPzdLoVknqBAS6RQhkiCApnPbb0NlZVdVg3+IcaanS/jKXvGsERWHih8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU298OAIE11ocQTjhKba/yP+OoZH3h1N6NJC0Fscw3o=;
 b=kxipSFvPEqWoUOjkm/M9PwctnNFQxHGYWAtjbhrb44U9yEym5G9/qwqnN3K0rrIQYDb0yZ1RUmO+5ilXmUDAOw5pbq3SqMlmsLcfuT+aWDXTN4DWY/DCqonir5dXAishm4nX5L0Y9mE6RFTW+Y2xlLnIS6G6gCiacVlBZNH3PvrA3mYX+C0zfqQVZOouqwJ8iCLy/lW0TUGCiO2s0HgT1Rje1vQucf88fgaUM82QKSOOPD3ga/7qhW84k4ebV3CoLgOfnbIvMBgtu7W9vsKvkyJ7WHrx/YJ0xQg/8Ul0dnp0yKYSYxiLIBDCjBPy+oRCQuNiSB5CGrm2EdQ6IEVr2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU298OAIE11ocQTjhKba/yP+OoZH3h1N6NJC0Fscw3o=;
 b=qy1FcAZzL6UGx+H7ctW07P9FKlpNNYXTPQQxRCjyaT9f+00CXHYj86ZDxKpTitVeyJHQEEVNa2NDmYRQUBBflgAsMShKKq6tOWV2lOR5FZ3RdMYA8Zlq5JSiYce48QCsXiJqVWU38AYq3kXqMSAihAow1/B407LIqpsCdP2qkl8=
Received: from CH2PR14CA0053.namprd14.prod.outlook.com (2603:10b6:610:56::33)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:54:58 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::97) by CH2PR14CA0053.outlook.office365.com
 (2603:10b6:610:56::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 10:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:54:57 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:54:55 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:54:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:54:54 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631As6KS4132409;
	Wed, 1 Apr 2026 05:54:49 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <krzk@kernel.org>, <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, <d-gole@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v2 6/6] arm64: dts: ti: k3-am62p5: Add ti,soc-info to OPP table
Date: Wed, 1 Apr 2026 16:24:04 +0530
Message-ID: <20260401105404.1194717-7-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401105404.1194717-1-a-kaur@ti.com>
References: <20260401105404.1194717-1-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|CO1PR10MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc300d5-a18a-4549-a516-08de8fdd1d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GWjq4oqXVnnlNKSlhJGojanM2Ok0u5OeAMSM0j318BNmwt4VjS6CMjFv8/+9Z2mF9R+lEZUFUyEuaLsWd6xlW4OnYWOS2k2UlMDkWleGTW3+HEODjxG5Rom8c79A4HRXVJOQlhI6/i48GmLYSf1dtvBtzG61Y0FjFCyYxEyDLgoPiaEbT6yVwDcH43tWFH48kQfjKCDdWtGC/rIuWj88psW/dMS1RFHOJAgLpsTu+VShCuH1Ue0n/EShjeQoWgRabTJH7DB+3X1GAvQzzO6h6fNzexDGmxdpF/Xg6WE5JqJi/kIzrWSKmCiwoK8Ot6xpuxmvVbDPylu07JJ1IL3QEcT4rX4pWyPQxKuml2mvoEsaFWuD+JYGPzrO8LrfLUjOUNTn0ir4ytF8GHfx7M6nS79gyA+eTZkK7aRii+JTKkwMTr5txeeem6jXMDG7L7qAvNAE8rg86KLFdmY9NtDgG9R+KxrSueeT1Ywu5HIpp+9UqYlpDIWFf77vNdtfe5FFz6hjmccVYnOv/h7lzxvwds1JasE2MxNUFkut+SHprwz18DiYXivz+tgmM+3R/ZWP4zb3+JbCl1vrZBYlX1eDBHXB3qqS3Koyelev4GeejagMbkr/A0L0tMo0nIVmt3BLjRa/2QyusG6+D0+o1M4vU9vGoJamR0WEWiSSTwZd9njdE7Fr8I2uMTtLOMTGZvrMTW+yHzWz0XqZL2308Bl5bQMPVkkkhDRVGQ2+RXqCdahgqLw//UqFejpDBOuQHV3jOxhZu4xliBRLqPOM1fPSEDRtIYLgUpGzpYdi7WqaKP0qXVeCyojodHj06j90yubx
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VpU5nHyn8pcBhGi9lxt1uaNFEOGZ7UXsjZHquWZ7IoGULJ5TDR04rOk+0ELohX3BqOPpmYtD3a+PIuetK8QxBUbAngXUaxb5AGzVSzU7dw582voG751NlMnx+T48UKgBgfzGjk+4k/IfRwYZYUeHDXsmaT3zKmcErTHzKXOcRaMuEDbJLvcSojsbrapHWFvLgcEDFLBIMI/NUx1zCdgRXCE5uUUbjuEoFURURY1NLVP8IaCh4aZ6UK8bSvINMeiyHaDLF6Z++8iNLIJo1IrrewD5w5VUOP3clVwOLnxlOf4YuZP7pj+kkbC5aNh61XK71Gr+La3+BvspKl31H2eWfTt1iGpx132Xp10ukeRXgoTMLUk4tLuOf6xNe8jpORclv2NLEP+/yu3AGIIvwviebIAI5zo1MhNcSe5bCSodIhsXiFL5oJUHOykvhHk2rZuS
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:54:57.4170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc300d5-a18a-4549-a516-08de8fdd1d4a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786

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

