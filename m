Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CE360ED2;
	Thu, 28 May 2026 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959158; cv=fail; b=ISIKoq8v4u+Z8P5zSW4mbE8+1IUxsYbdvy02Q4szBKXmB+0htiFqmwK+o/UDEmRBcItPWdwd40pc+G8c/xDRZ1KJcIs2RWLDiUXjkrAx02hCgCp4vfgjULKX7vZP5sOULmvol2W4bxnsDWjqLyjLpSEWoWXCD+LfTVWGu6MxAww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959158; c=relaxed/simple;
	bh=TmisErIBICvRnHWGtIsa5koEUgt4Cs1hDKrXFSFF2Gk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e+w43c8E6HT71Hl3WeuKVRPUdNbG+KwG4SKHMtyI71MhaAUAqz+dpEQG/CH3ktOuZJH/hRDhCXMK9s0L9mvNOxxBxju8zKkWnMBeI4Fw9E7vv4XlJqQod3gmNrC/D/ysDb7IINpU3P2Tas8dypc2pSJ4CShLriF3YeuBkFRPaS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TQ4wu4N3; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TQ4wu4N3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwbKNv8RIuHQVHTqm7yX3lv8vrqDH96EBKLZKdqXF7hWaWGkzqCzgifR4v1L0FdQtScbtJbMB8g2sAau1SIUMRlzMPIl8KbvccdLvelz8uCzYd1tZa53FWwunvOz4YRZWttFpTaTx3Hl80+/8VeKJhT5BB+YpqD+jtliETcgv0w/Wn0inS2qwligihH3e1YzpIBi36VVVogC6pP8RASniPQw8ITuCsZLWRLlGQOWNFUUrOkdVDoirtscxmMxbN6G2mRRZ8iedFbM6fxg6dV7Cp/OG8gHduR3AKCK1dblMPao9wNNQIEvhrF0ld9IJSIkHaOWR81usDnvep79MhZ5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2XvIIU5kw+U5H6glNppE9mB0D1cdBl2THtOJ3qjW+c=;
 b=Ix368i9zt66NlBHg9gjuvV6WfAOPJniVGbiGSw73WnLXVO9eh2ExBDPYPHXf29RB28AioZqshXoDekS3GKHKUnrLksNpzOQ3cBeSMigEeL4sSkklhljWV5jkXZrDxMhEPmiO6Sgrz0E/ZXAbFpltzunrfZDNuspZvbDBpCO1uItA19xyHpQFZCGPH3Zx866hGWmaN0XZNBPOh7jpQ71EAfRVlGF2UlNMlmFrxIIpQmCQmKwg4tJOtS3wLi3m990eIW4Jz8HUS5xb5wt9Y127paWgMA/3iezX+sQyY6d6tW1frFpZkZ3aM8k0lyCwao5roXit+9RPKF3Dv5BZ2lmE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2XvIIU5kw+U5H6glNppE9mB0D1cdBl2THtOJ3qjW+c=;
 b=TQ4wu4N3DacCbbC4zsPsAFF7lWxk6x4N3TsJESq7KzwKDJZZkqpCplaeSzqb8O8DI+73KsyJ9tC3uixwDQHWmEYoiSmGoS3rlP9BoGJQl+HzycljwlaaZRF0Wj5d2NGZxZ+ymFUnbeWj+KlESeEm+9a4dDQvDZIlLv99BbC65Qs=
Received: from BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21)
 by SJ5PPFCAF322559.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 09:05:53 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::2a) by BL1PR13CA0106.outlook.office365.com
 (2603:10b6:208:2b9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 09:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 09:05:51 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 04:05:17 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 04:05:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 28 May 2026 04:05:16 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.72.113])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64S95C5U1741887;
	Thu, 28 May 2026 04:05:13 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <zhongqiu.han@oss.qualcomm.com>, <praneeth@ti.com>, <nm@ti.com>,
	<vigneshr@ti.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v4 0/1] cpufreq: ti: Fix probe ordering with k3-socinfo
Date: Thu, 28 May 2026 14:35:09 +0530
Message-ID: <20260528090510.829513-1-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SJ5PPFCAF322559:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b5fc8b-f6bb-4566-4707-08debc98517a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	u5acnRffzim5CG+bgqVkCsi77Zkybu99YmzMVHlOuBml6NlR+2YMpUAysWAGrgq/+H73ezYrn2QlYhrLDrV12kUbvf8iruKSNI/MlSZNdm9cNTj2mMQkd9bdYIv6I0zWpeFsvw3HGdXZE1fJyHwo8DwDEtBKS/xKrhcaAFzr+soQk1F/Tn97w+mnGoOOV009+sPNzt9Syv9KRI2hNoEZf7CCsQO+7fdF46sMFyJsCHI27k7eXTYl8iHzxY6IIdKNjgKFx339EHtn1kimpN2AT9IgDDjf+aWnPz6gvseJG46C3pwqvf3MbwdJpg2R9uQJuvZ4YOrlI7JdWsOcSM+XtbQCrO/4d0KWcSktkZ4QxmoJVcjNvA+2UtcvlJq/F6nDLwyfMX00BYML0RtSrohl8R+gR5RpfZ+k7ArsabpPcFcmWW94tQ4G2Tni9uSh++ydN1IFPLQbovMxDmfgMbhfGR6Biodo0kCZmYSCeKNyAWpPsY3uuwSp72r3LRTuHYL+3UY+CcekUmFkXxNXnn4rHn8end8JwRVCa4RqVyLE6bjcS4JdiSp8qjFVrWAVpsGasesSRDwVxWUhIPIlOiYm592espXWaQpRWbEEQjIR40bfnSO1Fl9iY/YNqb9vtzBWhujnBva97NAjmocmMN3QsR1OlbKQQ0WAC6jamwRiyZ7iIWvLH7DpjLckR5/Gy0DtEnFnkHRdktgEe8clOuUv9ZKRZrkg1G151q1kgMYxa5w=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zz7i8xsAdX8IUlWRQcKmcrvYVS+NPQJrJLviuvWDBAGlsL4GeNZzgdxN2VlXQaolujkChZuYU0AONNsjZ6Ab73YcgCSXT4RKzW9lqFD3HyrDk5KRfsAlbEMj+kUmit0uRDt1Fw1VZKNPZnMRQLSo9pA2xfacHEE2KASgkADZm+cesWurQ7bhfYJoI3ALFEgivYYU6+O7/4UKoFmc90jTLdWbMLNfddHi1RJvx9bvI1JqUb+XjaJ5NmODTvWbEzTGzARoRgmE+m/htUuFH9rmQXtUsNkihCFDanc0Us2y/4GyLBoIwOWYDwDhchYZvolhZroY58kqqMZ8gnwW5bbnKoyoRClvB0FRreQnj1PNxzUoeGZ83oMTcGbMM5JaN0MiZqcyJYPKR3gD+OlaPv9IBya358ns7BKA6iDiM6XuDk09XUUmwvEBy33j3DgrBcG7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:05:51.9994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b5fc8b-f6bb-4566-4707-08debc98517a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCAF322559

For K3 SoCs, ti-cpufreq depends on k3-socinfo to provide SoC revision
information via soc_device_match(). If ti-cpufreq probes before
k3-socinfo, soc_device_match() returns NULL, causing incorrect 
revision detection and OPP table initialization failures.

Add a needs_k3_socinfo flag to ti_cpufreq_soc_data to properly handle
probe deferral when k3-socinfo hasn't registered the SoC device yet.
This follows the existing multi_regulator pattern in the driver.

Changes in v4
- Use needs_k3_socinfo flag in soc_data 
- Link to v3: https://lore.kernel.org/all/20260527062534.1808422-1-a-kaur@ti.com/

Changes in v3
- Simplified to single patch (EPROBE_DEFER only)
- Changed the logic to detect whether the probe is for am62 family SoCs
- Dropped device link patch after analysis as revision information is 
  cached after successful probe. Module reload also works as k3-socinfo 
  stays bound during normal operation
- Link to v2: https://lore.kernel.org/all/20260401105404.1194717-1-a-kaur@ti.com/

Changes in v2
- Added DT bindings documentation for ti,soc-info property
- Reordered patches: bindings first, then driver changes, then DTS
- Link to v1: https://lore.kernel.org/all/20260330120105.2985200-1-a-kaur@ti.com/

Testing
- Verified correct probe ordering on AM625, AM62A7, AM62P5 platforms

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---

Akashdeep Kaur (1):
  cpufreq: ti: Add EPROBE_DEFER for K3 SoCs

 drivers/cpufreq/ti-cpufreq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.34.1

