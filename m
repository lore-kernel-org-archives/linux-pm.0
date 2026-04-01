Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8343F6615;
	Wed,  1 Apr 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040865; cv=fail; b=mJfigSC4tGWueD3zJSxC6RFHV7mFhmtM2sGWrz++6j1yQLHM9QgazGWFwYDxH+bcT9XOds6mZMWxfxcKUNVF77s0Z0oqqRJ5ACbKVEM/c9dbrMv1qF9Ve1yrnCZ8xcM3dlCELE7uy3iw/87HWfRi/Ci9pt5DdyqxHyYWoV8+HpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040865; c=relaxed/simple;
	bh=KiDgz0/EC/DxbQWgtiXCCSsOiI2eHThU8dgz0tqKGK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=koNdKTkZFoZ2VeunBb9uGWnTlembPmBW2HvsCbPxICmqI63uX36sjbd646CZRbY94VdHdHiAvEahbkFTtaM/4UcoAsP5//GuRtoD6GS/3Pqv72MwfCq8iTWGNDCstb/t2i4gNyusted/sw0AKcCNLFNls+VqgpdzokTdkcauktg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MoH8NQTp; arc=fail smtp.client-ip=52.101.57.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MoH8NQTp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExMz/nzYaeFRO79kOLzhEgPKx024mASz9WX1Y2bKTY6/qsTjd4hvX656KizS5bIKLixT9Zz6Odme20TLy4MH3VVpK8WOESLF+fvI/iVRl52LyiwdSEewtg5EhMA5ynNpx2tXfUBdCW+7o1w6koK4ZtIr1EPHNR2zcNqi+lhnmQ7TIkw6sHySIwR3W+iLuUbXTL4UlVNI5MICfKUQU24/xQz2nhjMAKa1hr1FkVzgV4UfZj62BVD560mKTNlVdFjEI4yMLCzZTUS4Xn3CfgNixPEAaBsDqTzbqHt4MnpIeREXzWQgMwl6T50U1Ov+NZin8a+Hw7aZKIQ59QwVIArdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cyp9t+I+iZP9Ken9zxyKEtXE/mIgfaUn78mxBPVu7Fs=;
 b=YOy5n/3St7G23egjmTfDZETpTp+Cw2lH+9npdUrKsQ3LoIZzjwUqN+Mb8UARIV5VWRpD2Cmp5hGWieDyZCSfWYJXbI0so7IcAwgN+KcRQjG5xyHVpwP2arMmgIxJ5Z8pih8PCrteAwJi4L7inJBURCIvFXPJE6DMOEbCse0cdSkuu5xHI4Wj1RcZO5KaooSEG+Xzcj+r8Uf7rtLXyWoLg7sNhwwJZEr0eTRU8ZMiP+jrU7zJwYLnv8L0c5T+YeumE3QQfX1+xmK358KRfrxNKw46CIw6B2ldtZtpgPfpnKgeyP4lZ0dAF+2hlyTHwBqAtZCHjnSy/S8F0oWr2VIOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyp9t+I+iZP9Ken9zxyKEtXE/mIgfaUn78mxBPVu7Fs=;
 b=MoH8NQTpTC+J+sMQCBCRhsndchprZHhoEvZmWs3sDzop9zK69cw4YLSc00iOzN6iv9figWXLsw3D+ZeqbNgxQrkmUXuhS+N7kBLOHz9JxTziWh9NE6EuInvYj8UUabeU0G1VufSIdYUZPwgEntjv4xAPYquiydo7SBbE29AmPXA=
Received: from MN2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:236::7)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 10:54:14 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::5b) by MN2PR05CA0038.outlook.office365.com
 (2603:10b6:208:236::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via Frontend Transport; Wed,
 1 Apr 2026 10:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:54:12 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:54:12 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:54:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:54:12 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631As6KM4132409;
	Wed, 1 Apr 2026 05:54:07 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <krzk@kernel.org>, <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, <d-gole@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v2 0/6] cpufreq: ti: Fix probe ordering and add device link support for K3 SoCs
Date: Wed, 1 Apr 2026 16:23:58 +0530
Message-ID: <20260401105404.1194717-1-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c53380-d7f4-4d9c-0d32-08de8fdd02b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|376014|1800799024|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1WOyh568CyCSwlH4TOVlV/ZmanZo14aOZ9BGsQNI54zaie8T3wZg9+v+T/kyt05gP7pNpdqLzsBO4/k0CzPM2Tos4Z0pDwtu2TVcJ+hI9LgSqEP8e5hVZOVFUv7wNaal448162oCW9ko8sNH/5LYN/Gxtu4mGn/nPo+CV9fp8PQz5N01cOVoYnW0zTxCu74hY5Q7EFctm2vE1s6MU0LufP7ZYuTsn4XtO0+j6XcEN/uXeiZ9fGq5wTMo6YlhPQBhGzw9Lr2dzExUIqQU1h2TjtY3jqHIUq97+AOfQavI8lLs++r0Wq79F7SpzyvUkVtS5rPjlDCkyWuz6VrajesUIlN8wM6NYnB1lyrcXAC112MzzXKaL/wiOEZVkOnqYpINMm8qFzPvmmyqKM5gb+fSCdVaZgtvrzZdRPpjsCHS56DauF452LqSrCJjRVYION98G9q87g2xqa+ikzIck6npe+LR5Q0+zRSDpDtfgBkXgVQcHAgASa/A0nkrc+rpzv692Rp9Qggf1baWWn3GsZPclH+kI3ZlQbv4AyH/CJXfZPspQCSlGunJQDyqdJkYgMfSQ1VQBvFeC5PEevPtA9YThaNz8wDqK+ZyIm0cfjRd44GAXyVGgUviszHcHu0FbiPbaHqBuJ+rXIdCFUYskBG1FvWdWcgmdRPrG519qvfXDoev5DNkfz2RtiOHfqHnvnsbkzCxqYXpanqjDMraN+CwTI4VoYrenHHWHg6+wf//oJ8vmS8iQ+hHlm5lpBuBlo2GyBieoPV3bSogz767KpCx+54EuvRNYZPx6TnrDS4x8fZuC2+GqYD1l51DUnXuGH8b
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(1800799024)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tLBbv+LE5MZjsrkQG4x8Ws6+zLdpo+vxSOx8SCmy/kyqQqO4xi1VA8W4K2gzc2Z4XTE2I6Nb2AKVIu4sRP287MR1frzQ3E8CG0hgKKUC4tnSv9O49+iQze0YX2C3XYFAwel7RQZ8gjcxtOOMpe+VizSaOxHe3yfWCzLbEpG2PAsBdGeoa0vmKGvZVXku3ShSuS+2FlKlNgMQpqzVdNf7fWnJ78NEagzLxx6U3Cp3XFXACAKuB+Mqjw/p6Ml6BAkTz9sO5/zmQP6KSvmxdqst1VqZcEIoWDWh57sx6v3pyRPKT8nmeeYv6afO5+nYwW6lx3AqQjXCmzgOflWKlGuDTLLijgLefkUD/DOj/Q8MvCre4P1LINBnrXs+ZY9x5cjNiZtAfRvGMnrndyxUI+ptDqy25ZnnkQYHgbqGksGyDXi/ay9vA1nC5YVLkJ0jueip
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:54:12.7901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c53380-d7f4-4d9c-0d32-08de8fdd02b4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744

For K3 SoCs, ti-cpufreq depends on k3-socinfo to provide SoC revision
information via soc_device_match(). If ti-cpufreq probes before
k3-socinfo, soc_device_match() returns NULL, causing incorrect 
revision detection and OPP table initialization failures.

Add EPROBE_DEFER handling in ti-cpufreq when soc_device_match() fails
for K3 SoCs, ensuring k3-socinfo probes first.

Add device link support via a new DT property "ti,soc-info" in CPU
OPP tables. Device links prevent unbinding k3-socinfo while
ti-cpufreq is using it.

EPROBE_DEFER handles first-boot probe ordering, while device links
provide runtime dependency management.

For backward compatibility, the DT property is optional.

Changes in v2
- Added DT bindings documentation for ti,soc-info property
- Reordered patches: bindings first, then driver changes, then DTS
- Link to v1: https://lore.kernel.org/all/20260330120105.2985200-1-a-kaur@ti.com/

Testing
- Verified correct probe ordering on AM625, AM62A7, AM62P5 platforms

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---

Akashdeep Kaur (6):
  cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
  dt-bindings: opp: ti-cpu: Add ti,soc-info property
  cpufreq: ti: Add device link to k3-socinfo
  arm64: dts: ti: k3-am625: Add ti,soc-info to OPP table
  arm64: dts: ti: k3-am62a7: Add ti,soc-info to OPP table
  arm64: dts: ti: k3-am62p5: Add ti,soc-info to OPP table

 .../opp/operating-points-v2-ti-cpu.yaml       | 11 ++++
 arch/arm64/boot/dts/ti/k3-am625.dtsi          |  1 +
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi         |  1 +
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi         |  1 +
 drivers/cpufreq/ti-cpufreq.c                  | 61 +++++++++++++++++++
 5 files changed, 75 insertions(+)

-- 
2.34.1

