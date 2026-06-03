Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C23FC5A4;
	Wed,  3 Jun 2026 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471511; cv=fail; b=eU9G/5O0FDiV2yzxOaxhw+HlQVpdQAkff29ts/iYPWQMiW60WYcNC6VsSAbkN34ra1D+Zy8FimvVNkZEEswckeKJOoY9SD4X+fTPa7qg4kLouRqvo91ySP5CNZl0jjxSr3fNUUwY2xDG3OmYXIx9kRZDvWK3eUmJm+nLlORtTvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471511; c=relaxed/simple;
	bh=3Cc4jvXmDDrIxYCVKU+HgxlIrqBPiDTGISgi0MqijgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A+HKzDTk7yNXkBBPKN79kdRN6gNP61uNsHb/OqeF0T7UcJSysZcsix9sQ6C8M1lLjUahuYc/vDYXweasMvNv8kfFybPnk3RJ5KDfDlUz+hOiGdudCPQ3CU5Lm1U1ZWXX/mHW5sJQOVD+lGpjDMTDpxuBl0lMWdSRnkfpJQbyxVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bjtmJeT4; arc=fail smtp.client-ip=40.93.196.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bjtmJeT4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjjTTar+xH+mvGoJQmPhM+GYyIKyAcxBWFy/jge9hX7RD8eotbvz8GeuicoSh/V+8dvdRQXY96T0UbyK5Z6PXG49v4svWuIBxgxkCQ+nJhmbB/BeQkEP2ciWXC8xlrijXuix1hdKZUvbprbiFJvDNWObF6qtT9G3tVVQBimHDdvGAgK+1VeR9ilp1XH53cE+WyDuNnQ7RIjMfhyYm66B7yghtWMVEUK5hfgPGqHWvniBIzx1YvsCnUS7aEd7CS1RscXs2j2bW50tjoqwzPUdmaZtpo/YbOfKjRpaVTamVa7VCvg9b+BMhxyXLB435rCs/Bp8+2rwaU8eNwqZkRYgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCHE0x8hg9AUIiEn6YeLR6SVdobu2nPmKup7UYSNiXQ=;
 b=IRDB/Rg6H4Ly9trsbtZiMVw/40KlzQK15hPUzs8T2QN45zosKk9Lr7NatfdRWN2j1FnPsWX7u/oe3QILIdn318AyuZqH6jnFquaqQqt15HYa1l4kLx3FSBlXgyZdACnkn+/tmFXFNhJFtJQu2FE3g1avxUvMAx2VFs1CWqTGK/N4q3kBhS4i6A6Vq6oW6DmU72u6/YD3qCwjBnz26AYkxRUwAV8bkqeyWPEoUZh5nc1vqEtvDmPHSaTK3HNEU2ht/3PNLO2I5QC7LkiiKpzthqLUNhw7NK8dbuqkVanoFtbSoY25vx61R6JMzQt0+1NoQ4LB6Z+YBPYew72rJwJTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCHE0x8hg9AUIiEn6YeLR6SVdobu2nPmKup7UYSNiXQ=;
 b=bjtmJeT4YO4BmOyMA34yx0iR+Pz+6pOlsCbE49lXgEyFwAShp8CxMu8QCG8iqUSwkbbyID8V8MPjNQlborc22p+A8JDAncUgeAbMMgJ90lWBwmYTWt6Y9rxnFJ1e2CvpB5w1gQ6/JFjn9mDzEA2IXLjqN1Bn1hN+A4pqv9ejQ+w=
Received: from MW4PR03CA0241.namprd03.prod.outlook.com (2603:10b6:303:b4::6)
 by IA3PR10MB8467.namprd10.prod.outlook.com (2603:10b6:208:582::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Wed, 3 Jun 2026
 07:25:07 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::97) by MW4PR03CA0241.outlook.office365.com
 (2603:10b6:303:b4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 07:24:45 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 02:24:45 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 02:24:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 3 Jun 2026 02:24:44 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.72.113])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6537OeDk730260;
	Wed, 3 Jun 2026 02:24:41 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <zhongqiu.han@oss.qualcomm.com>, <praneeth@ti.com>, <nm@ti.com>,
	<vigneshr@ti.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v5 0/1] cpufreq: ti: Fix probe ordering with k3-socinfo
Date: Wed, 3 Jun 2026 12:54:37 +0530
Message-ID: <20260603072438.1199527-1-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|IA3PR10MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: d076595a-88b2-4103-d1ff-08dec1412fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	YztePzogP5iNUFH6LogUBheO2y8dn0HawELA/GBiNCvjNLPB2v/s2OPlH70b4an4kBxblb00GGqSExhiC3iXgvwOVEi4Ubz9mNqLZ55VY46/2Y4DIkZ7TdVhLGFYHeof7q5tW85shnNRGAi+jFFp/ENNJJHt/+fUwrSLIrUKak7QJKraBfTmb5zNLiyekC2hCK/B0m3YuNbVi1qLI4ZaqAWLMgNSlxJViBmv/J9/+VFoo4BkHS7jjXhu+K6fjyQP4SwVDMGVHXm6p9FClain4MVE+b9VNc8DGCso2FQb/4LCKhiBIZI53CpAbTF2LMK0J+QaKva2tSOI3aCUYlT1WkduUPhusHusNnSEy3xAl4LDT9WIwrrJSTeLIOEw9AJ+0PKjy0DQja+A6BA5W1LWaH84u7X4AC83RNkfEMf8u9OtjAaBr6EsjtwjKlz0L+NozVPl9rppfrBthZeRcmBUb+GqmwwvJQ0RBUDQIDxz/3Hz5Yr1mBPiVIXYabldtz6+baMtA41Jw/3K1ihjm7V0pluiF8EtF/hStkeu30R+AXkfkXq0mIJ5ABe2T4DpiVEPWm1kGJVGv+1U2Kz6LolNAGGrE/tib6rSHIXBKi6wGyLSTIYjJgu6jb4BBgP9rYoHiuTy+w1uCIziPfyFr1cjfSsNOTqsjXhMD6cISbeTifQ5+AYF6CSozSnYMkLoImiVRF0bnrKH2eR9I7JA9TyoNNLq9G4Bs294M/UpQDNhnH4=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kkzrpGhtnsS9UltCVPFzYb8FGzYUyrrUUaJPrqhKULMGGVcTTMd86rFrIM8nb2jzyzDhc3gOEmFikP46ttmoAVokWaiu66Tyk11tB1sNkfYYvaDBeLgQxT01tOJKYKxA2/TUpaCtd8T+40SsrZLlI+obhkSP9NmQe7FFXDywlSHXFQdtCdP0MMBRBm0I075tG74gPDkWTG67dTJyAO66Y61Zzv5iDecDNXjz5V1EzNDDJJpPui0G7xd35D8iWbmpZySM7etCARzU6tRTswgeVyq1kuPYx3I9fz3DP5NMMZfVlaG3DQMIBhCjQ7Y75KoS514Q/s1IRWwpl5Rflw2dQgr2/cXdZjgDT3jGUXdomXjmpXon0blrqCRGj31NvikCLowju444v6ZUj56W37umaAjnhmzSY/U+mu2Lq3QsP4hSlc49E6QokZuSoVyhG+ZC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:24:45.3151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d076595a-88b2-4103-d1ff-08dec1412fef
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8467

For K3 SoCs, ti-cpufreq depends on k3-socinfo to provide SoC revision
information via soc_device_match(). If ti-cpufreq probes before
k3-socinfo, soc_device_match() returns NULL, causing incorrect
revision detection and OPP table initialization failures.

Add a needs_k3_socinfo flag to ti_cpufreq_soc_data to properly handle
probe deferral when k3-socinfo hasn't registered the SoC device yet.

Changes in v5
- Use dev_err_probe() instead of dev_dbg() with updated error message
- Link to v4: https://lore.kernel.org/all/20260528090510.829513-1-a-kaur@ti.com/

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

 drivers/cpufreq/ti-cpufreq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

--
2.34.1

