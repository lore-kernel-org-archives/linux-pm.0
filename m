Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816163;
	b=GbKgylAw+G38sl43X3pzOgR1q+mA5Kambik9UuiNhNOUgEAK7iSn60jCJT7zxHU7akW5
	 euHZhn1mdD+jlCmv5tAjPmRKVWtpXX24+BnAhmJjSm+MAeFxX5C/Lt36Yt5GW2hT/Bxy2
	 nPUlrHi4c3K4W3t4QfgEl/JqV3EiMElZQOn4FYwQLWn6vo41wREaoD0MNTMtiZZix4hYl
	 tEDCEqxPyTS3bPzGiaHuhrLfhP7GqndS4A4DziCjvTL4TbFB3NGlluzH4A3oEzYy/XXCA
	 NBtCBrrekYqA6iSD80vEUJrxluykBMnWaIWKh7OcH2cUY4SJmCqunBEfaNgcfqBaTHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816163;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JSIAW2eebUX0rCyKK822idMZTB+cMpcya6VCP1mncoM=;
	b=ZvsF51wQBxScLvnf7+1JktLsTKnRS9wIVQpoZK81TOmiL5UxoxeMhKYWbzhSApOLRgSX
	 QASVdRcTTTnhR440mvA4K4n6NU9wKqzLJ5Lh3TsLv4GmoBas8eZA68v/N4FBOy6ZBcU03
	 1wLAc3wmxzVv5hbPFL+nCCN1vvzeXZSp8PXchAx2CaOJFeuJ9KZaVSBkHMBMyRXY3vZHT
	 8aDjm+b4YICDChIR9IenjPLU/envrjiy95cm+rqKWqNq6T8YBchNu/4hw2Efr+fqRjpCP
	 OGnUhqstnYpgoQ7Y+694/s3kVGMMkdo9N3ttik46ZwMPqUWoUGwsUsDEeuDr697W8+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uAQ9caUn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.20
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261E606D810;
	Wed,  4 Nov 2026 18:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5261E606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uAQ9caUn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+8rqDSPgcS+UJf/9kv/MhXv4w5UT9UV1WsluTv7502HW4+OFijpO5rOeiQPMxuXpVuLS/3VnZ4ESm189SnNj5Wadn2/HhMfRMSO0PVJY9naapk6WEUGJTMmhFPZ4Q1P9XglTs3Huqj3TtTa2rq5O7nEMZwYJ8KAUf9+ti+B83r/WRj4PjVIg+1ZSmgsY246a+otUhYvlVztsE6nAtbDUN+cpX+9pF4pUHhD9BY6UICOsd2CjUlg+170jNaEKhp+IuSNlFwarJkkEv3yxqF39QNEtSs5hXe4aixPTpoC3K5UprbDcIQQcbZHbkAYlpVvSqPncdtv2G921tEnf8HqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSIAW2eebUX0rCyKK822idMZTB+cMpcya6VCP1mncoM=;
 b=MWx+lKc4qXDl8xuqkvPVBzupljEE3doPSSedHp4XoKUC0vZPu/ERfY040TkpywY0Iq6FJAm0o7K3cnYPM+Qg+5W+qZi5lWCQphk6uGRirxdoP2sK2Y7j7AuhaZpSmG6GCuaCnlc3qRmagsyKFeLJi9Hg6dzG+WCiBuEMAbXA4ZJGiykb4j2AY91mfbRjgYrC/ECkQVUxIeALEvYkrOSjnOXOU337Zsh0BRwj7gM2IPv4JSXt8RMn/nTEfI/BEVYbgtGswrJfSNCSNop7SGZ3RdaP7nViJvSySBNxYwI1+N6OIpXYRXkWFWI6tBOFdb2g5hHKqiS53n0JRwzpyAmXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSIAW2eebUX0rCyKK822idMZTB+cMpcya6VCP1mncoM=;
 b=uAQ9caUnfWTRFuIljTstYMK0GmraMK+PYIGQGuj0eLEq4AIEeJflJeSjlzNXaHyIFZE7oft95oc+PRPg46bWTBEYbpn8h5s/Vj3c5Uj6W8VrVM0wthyTxHq+VdGXTiaPArZnSLZgDZ7JTz8QxVvF417Xd2jCyPPkTBmahLiVCzhiYd87LgGirzKkav+NVRoFcFJN7iTk0V8oF5B/6QOHhLeFFxU592wYFh31gWA+fVLLQlvUOBUnU5xqvbkmjIfzDxKkbrezQ/Pq1XoMvNSTxxfsulyltw1uBpcVKoqEvRBnMUHYVGJD1TSMTtCmT1exsWwtvAbrt0YQHE42vtdrvw==
Received: from PH0PR07CA0051.namprd07.prod.outlook.com (2603:10b6:510:e::26)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 18:15:55 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::79) by PH0PR07CA0051.outlook.office365.com
 (2603:10b6:510:e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 18:15:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:15:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 10:15:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:15:27 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 10:15:23 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH 0/9] cpufreq: tegra194: add Tegra264 support
Date: Wed, 4 Nov 2026 23:45:12 +0530
Message-ID: <20261104181521.3003578-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc13288-a30d-4129-df02-08df3a9faa8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|261102123227099003|18002099003|921020|11063799006|261021123027099003|261022075727099003|261026121527099003|261022105027099003|261009221227099003|56012099006|261028144727099003|261009223027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	faJrfbWCC6wUV9+yln+/GrKx5vQqQZVn4d/oA6oU5E6KVRzZE0jfKEP5MVA2J1VdEv3lo699IAiyKdEa3dcjnaSVC7hKZh4il1k27hjOGc/T32/G+p1MU3nJg0jSPxjnkXkSzopewUGZ6XMp5J2R5ZVKMTMZF4YCoegCT+l9/ElLqN6h8XDbMFK9nNDFP5pJGFdcJSjjgbC41MHjx6oeYB+yjH4prkVk91Q+3lVaCtnYZxF+aCA0CtoFNXHE84wkti5842KT0NGOY9jvPIyjrQ52Y3gESZqPTX8MVOXL/nOsIV5l+Aq8gR+MLs9sURBb1VyqjQJ0lgLmBEN1hwnEu1RCA4fxc4J2hPlH7C2eDQTk6GoqjDZVRPWYZXCkNqOkxI2HvjQfWZvyRNrYCU+sVVDkvhMwohD99aHMOM/oZsw+Cz/t7q8+cuRdihDW6ufEQCGJtPIOxyQmo3HjsRWi5PYUB/ElWY/WLvw96/xDmc1XzZW1HH9AN03nclHv3uWR3cG2YCG2m0JCCwuPyj752EWEu+AwT0KEBUd/vjWMaM/jUVL7/aPFedR7DqHZk+Z9ZJeVbXnY9lwkZNSiZkK7zhKhvFsGs9HocTyPUO/KjBLkoFcoyYgFXSe8V0zYROBVz0ygRV4qxsIlFcUDgMkJGJC4Fr8HBQKuVJDtANshWe4FnK0zCPHHblbi4oAxDXPH0mimaBcsA36jjW0GDWtXCy34h/v6K+mLFUEmJJF5oGbqcYSonRYQcoCT7A+aAVnl
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(261102123227099003)(18002099003)(921020)(11063799006)(261021123027099003)(261022075727099003)(261026121527099003)(261022105027099003)(261009221227099003)(56012099006)(261028144727099003)(261009223027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mHgQewP1gkzl7Auzm9mk7otRAsges9AW4kh/6AFsniGYU/bm5xdaQlCRatacDp5jkwizzN1PuAtoVE5tvlcUjSIXoScsMsTB+vDBndaqO9CQj1mQaGzutenBUAK5B/LVjjTp/qal1vj+OYXR1CoPIQwEvf6nqsfXckqD5M0u0D/4B1FB6E/xGxVdz6JLyJeK2OwGsyTihw00uMIybJlMiZ9JKUHnmNQNQ1y55jtz+2Rl3Xmui5QMpJWKZrh2biRUpn5SvTEPwTEWaqvR1Z66aCfPwzEDC/UfwfR+Zu6eth+Qwq1aBPQtV8Yo/clTwQKdBXFdnr/25uWXduxKoIa6z4iKduilP4ORo+kDvpodQu8Sah8hI5RlbU7nJ3jQFtQjHiNB7Y6HDb4r4AXp/WcXpPy3IpsZht863HuW7paZBFSchNs6F9KDIOOiXpauScZ+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:15:54.5055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc13288-a30d-4129-df02-08df3a9faa8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876

This series adds cpufreq support for Tegra264, which joins the SoCs
already supported by the tegra194-cpufreq driver.

Tegra264 keeps the existing model, where BPMP provides the NDIV limits.
The driver derives the current frequency from the core clock and
reference counters.

The main differences are:
 - Frequency read: through system registers, as on Tegra194, but from
   the 64-bit architected AMU counters. The reference counter ticks at
   the system counter rate (CNTFRQ).

 - Frequency request: through MMIO, as on Tegra234. The driver writes
   NDIV to a core_freq_req register in the CCPLEX register space. Each
   register controls a cluster-clock unit shared by two single-CPU
   clusters, so both CPUs form one cpufreq policy.

The patches fall into four groups:
 - Fix (patch 1): read each CPU's MPIDR from a CPU-hotplug callback
   instead of at probe. A CPU that is offline at probe then also gets
   valid cluster and core IDs.

 - Preparation (patches 2 to 5): cleanups, mostly of the counter code,
   to make room for a 64-bit counter and for an MMIO mapping without
   ACTMON counters.

 - Improvement (patches 6 and 7): group CPUs by the generic
   "performance-domains" property, which cluster-based grouping cannot
   express on Tegra264. Device trees without it keep the existing
   grouping.

 - Tegra264 support (patches 8 and 9): the driver support, followed by
   the device tree changes it relies on.

Patch 9 depends on "arm64: tegra: Fix address translation on Tegra264"
from Thierry's series [1]. Without it, the ccplex@30000000 node does not
translate to the CCPLEX registers.


Sumit Gupta (9):
  cpufreq: tegra194: move MPIDR read to CPU hotplug callback
  cpufreq: tegra194: remove duplicate counter sampling loops
  cpufreq: tegra194: add tegra_counter_delta helper
  cpufreq: tegra194: add per-SoC counter mask
  cpufreq: tegra194: split MMIO mapping from ACTMON offset
  dt-bindings: arm: nvidia: Document the Tegra264 CCPLEX cluster
  cpufreq: tegra194: derive frequency domain from device tree
  cpufreq: tegra194: Add support for Tegra264
  arm64: tegra: Add CCPLEX cluster node for Tegra264

 .../tegra/nvidia,tegra-ccplex-cluster.yaml    |  27 +-
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      |  21 +
 drivers/cpufreq/Kconfig.arm                   |   4 +-
 drivers/cpufreq/tegra194-cpufreq.c            | 422 +++++++++++++-----
 4 files changed, 357 insertions(+), 117 deletions(-)

[1] https://lore.kernel.org/linux-tegra/20261030141101.845044-1-thierry.reding@kernel.org/

-- 
2.34.1

