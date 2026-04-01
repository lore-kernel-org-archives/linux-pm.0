Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E93DDDAE;
	Wed,  1 Apr 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040864; cv=fail; b=kPeBelc2VN+TTjlNswzlTZf2oP+j6T8KatCYw+rGhLuD5xn7rt/oryuc+q7ZeSjZCROcJ+d8RJT1b2fu0wdlbRS9TZ5IbPFZE+RrLf45cdEH/+H6CkD4hL26PSAiw1GCh0rqTq+ie2VGh+P4Z0oLTx7ma1AB7Mk6WtyEQMHw6vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040864; c=relaxed/simple;
	bh=MQ/BSqjg4xN3ExhO4CcwkvKDHFaLcBJRM92Gt83UC8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMR7W8stVY1cJEoFLBKvGeO0tr5PbxzAuj2UDT1KyplvtugNSuJ0F1lfUb31g/pa5lEnzOWsubH5kH+OdtmSBSJJfrdQaijlV2YyPCH/oWDEhgMe+OQGdpwBDPSeUe8bgpJ6D7NTL53Uoddy5EFi04v+ZWH9fsBvk2N0mufwsr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wDRilfH9; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wDRilfH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaq+NHtDcgh7BK8uQrEDBe5iNTMuR6fh9viZvCrpSOXupOpdrQn3YwBwrw9GeZS0zSm3V0S1dSURrBIMtJ9YpTElJFZZneQvRt6c+ziACGiP6Kf9KCkPn3Xjvjk5NBT5twllVjR+Dd3o+QBcIZfEOhZlHpzHS2fFaPLOZAJKoB/1FL1Bw21bTNdKGRsPRg5Q70bnZwHXCzcCqJOY0E8MJac7X+tjkRcHl+JIoyFu2s9jlhK1jSTmmNMxqUfJhqpPq2f7FRYlJxz+KJD9Vs2sZPdwk02mKBjNyn0bLx14+yWCf+J4ZYPqhscwJb9XPc4sRxqbHIK5Ek4nm6NLAEujZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98WxTkibNx2XjSK+a9yGkPg+4DzgWf74Kod9CtRK6Mk=;
 b=o5GqMTZIuTV045Mv0V9WZstk3UaXRBf12dOiCpjOeyapPYox1c+/hPwWo02CRwbRJTXTY5xnQ17QRfGMO1HxlxrZ4aozoAAPDzOm2dI0ZAu+zW1pEcaZluWE33IKU/OUV9LHnc6RZXmpmjXWd0PNY7JetYMZwUFpFQHJQR1tliQsKDjr3qJHfVrpNDZ320ppYB15mA7jWzyvIMnF8iFuce/QTRqo3oz3Z3l3CqsWcqyqnWN1sAPrkobsrr4fSWDNaHZ/9Nfv4t267YL/FX8ZDpIgrVVT6sTSugP8IUGTPmwwEnLmsPTvUF0zYQ2kmFDeD1i6D5mRyFLu6oKTV4ykRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98WxTkibNx2XjSK+a9yGkPg+4DzgWf74Kod9CtRK6Mk=;
 b=wDRilfH91VOSOGDYxVCZe2BVxj8GImW+fObGBQdAs9DaJAiJtc13jffpphr3wgQfdZb32w4TkUfGwE4xPVwjxDilD+adYrd18jUdveOR5uBaWgPTMKUPQRC/VPeW5tPhiL0rCxBPJRyMVOBg9Qq60zp4Tx07HlQ6qZ4Pbd8g5xE=
Received: from SN1PR12CA0049.namprd12.prod.outlook.com (2603:10b6:802:20::20)
 by MN2PR10MB4224.namprd10.prod.outlook.com (2603:10b6:208:1d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 10:54:20 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::c) by SN1PR12CA0049.outlook.office365.com
 (2603:10b6:802:20::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 10:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:54:19 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:54:19 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:54:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:54:18 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631As6KN4132409;
	Wed, 1 Apr 2026 05:54:14 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <krzk@kernel.org>, <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, <d-gole@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v2 1/6] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
Date: Wed, 1 Apr 2026 16:23:59 +0530
Message-ID: <20260401105404.1194717-2-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MN2PR10MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 45734874-3c2d-4c26-688a-08de8fdd06b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	fvWYrgpcVPZAe0s50/7aS0mSXVK8bCuw78pAt185DMrg3hqzph6QBsjWqeVUnDcQztk015vdhT0n5n4A5Dzu0FmOUkz4YvUfXAKWhDvWm2APBFZW/6V5g8MqvvUGkTvHQjvn87FoWaBN5+OVcNUHwTl5QqNVe1zfMV9QmRrdWEPTGjweGHWlgSycaffpfxQipF0ojTZ/n9vhWgPk6+pMIm4mQXMxBP64TYd4ou+BxdUK/Hmkp1u8Da2hLvaiMvYjLzN0TMI2Q+IMCZTGBtsy6R2x1eKHytXVYhRmx4qc//ObJ7K5Vj85IVvqKJSEd0YqynOZN6BzVl791TvPG2ZOu1R+YxK0yXBOyWMavVsLWH5iNTm6fDEYl6osXMAlku1wJMm9Pm4ncb7RQLRZ6pcfCTrjT41++wjtMXg9ULlymJU9KXUXzNP19zgK86emxHx1JaRPH5tgm4XxzjsPjLRM1AqnKGEm+Sk6sVKVQnAvDmJylryGZ3/XpqBdS6ermJNdLUUtRgzpnW3TycURbGMQg7pT7QM99B1efHpadC/tDP2eR/cnenSch6CrcAPE2TSzCQu/Q5p9xsgSEA3/IbhovocuTxIxNDbViYMsbi4+kYcLWg4muTXTAJhzZ5HC4Gn+6Zw+LZvjKZV/HW9s4C59bKl/Qw5niPTrS2vbv2qCa553xYSTtNUwUqN6m3Aem6sAQLel+haBmNo7jOyf0toyE12MrEFJqhU1iz70Hf9h0FuJnWU8wGJ/LcvSRnYPMxoMYeVm1UUPFweFIVanOJBh+94DBEOq2hKWFvaS9dkenqfDtaJAhJp58/XZJGkeN4HZ
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NME2SvWSoFXV4W1JT4fF7ZB10Xl6P8YkundeFByDJSaHHtbMl3ZV96Q0PWAbLqM53Fc4cNgbmy6AQp8A+RBnDxowqjJo9lkw2KMJ7YBBmQR0/1gXhDmMZFCJ5/0azklyD4zTOy18v3iWsopNio7RCZKXvo0QJHabPdbYNRfqhbUmDlUKOHPsjxGANWYay+R3zLagDSUdrHpV0MrWP5R1X2Zg7d2a+33P2mrliURu3pg23PZ6qkXHzYWsSnK911P28wj+4FDjqlKu54xooZ3Jry2Y1xH2HXfjVomrspY53/OXD/gYXX50m9Em4X9OfqANu4LsnUbok3WE3WU4a6MyTyWIom+CuvZwdN8ASlqMRgRew9SJ5aaPkXD//F/KoLfEAmjywAsZiWscb9rw3vgxswVXlpbkAyN81YWT5RsRqSQAkSIO1ZHzRaMcRRrMa3az
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:54:19.5312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45734874-3c2d-4c26-688a-08de8fdd06b1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4224

Defer probe when k3-socinfo hasn't registered the SoC device yet.
Fixes incorrect revision detection when ti-cpufreq probes first.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 3d1129aeed02..88f7912ef6a8 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -441,6 +441,15 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
 		 */
 		*revision_value = 0x1;
 		goto done;
+	} else if (opp_data->soc_data == &am625_soc_data ||
+		   opp_data->soc_data == &am62a7_soc_data ||
+		   opp_data->soc_data == &am62l3_soc_data ||
+		   opp_data->soc_data == &am62p5_soc_data) {
+		/*
+		 * For K3 SoCs, if soc_device_match fails, socinfo hasn't
+		 * probed yet. Defer probe to wait for it.
+		 */
+		return -EPROBE_DEFER;
 	}
 
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
-- 
2.34.1

