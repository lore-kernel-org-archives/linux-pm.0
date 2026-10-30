Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793381335;
	b=gp0G8NF4XhybgaxuLhtQCYLn8b5vl0FDBlgIbsXWcj12RoDaGF/zbJDRwlSLFqV9NUEt
	 jTAGzji1aoRTYsamibUKDBtoeywzahprlJXG/Kqg86at3ipvChsqOdxPB1968A4U6g4Xe
	 /0Ix79jMh770K8ZfvQTEVFJ9A5nPd9Z/LvIF9XSTelFsOyWIsLr4alHApIVCppopsGB/p
	 vr1VBrXv2kpnTZINow8kQruGG5exAQI4n7zk3tyJ3im5taz5rW22vXc0tovWiDNn1g5xC
	 1JNuDjS2irXlw5bHVKD5l0VVVtjO7eMXYzOgzfNMpGf53l0/OSXvU2/vx67pf6ztXeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381335;
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
	bh=PmF8R1FIxeZYiLs3Lg3CgiaU29jbmSbx0y4xKE+T7pg=;
	b=0LC/d3nXQaPmr5UhsnJqVVZvuhAdP6AOb0fXFyk6dM2yS24D4y1y3n8joR/YSIBoI2tB
	 6If8gomyCb0sstme+yj8ir5V7kbWCNNhqc/5eoNwsVli3bJ0N/p+bCOqBGdk9z764/OoS
	 SuLkCwVZPatmuZ25N6SQIVApM4pMQKeOCjNEw6pmtGchL56xh0UnA/Wei/jvMqICld14u
	 bd94VYB7y0nF3mDbvuRNs6/U7ZqvV4k7Q0k8W6LynGmryihI0R7qk6pZKLBr+eogWb1fM
	 OFhr/0nYCOoqZ+KCCf5l8UlRrqhIxZlQKFck/1jWOUCy/qf5x9kntEkOvVG77MzdeOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HfpWOKF0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.37
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0C606A31C;
	Fri, 30 Oct 2026 17:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F0C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HfpWOKF0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTd+n21MCv7/INsrtSVLTdIQWjB73/QH1BQJc5dRQ4Mi9FL6Q6QEVwV8xnG8oWMqdmFngLEbN1IT/i5S1LYvvTkfCpxhlSFaDJY0s3fWOXoyclVM7VTOYiVnau/ZUIdOlT6EI9E5T8VVt6CF/XFphZK657dXpUuwbxTpyNnZj8a3Sh5fXOaKmfDmzN4LHo5pTNQ+XcgSMdBpU0OMLSJ1t8OJEIbAexnr29FJwCaEO0FLh5phYk1La1680//YrgSCEBVhHe5jiLCqXFhzzK6sVD49tJcv5+18CFF15YPkD4Ci1M4xin4G+7v/8cfTrFH9fF1t/hLJwAMbk5qsBlYc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmF8R1FIxeZYiLs3Lg3CgiaU29jbmSbx0y4xKE+T7pg=;
 b=mdkMsjAFhIvydUt3JSIlP8g/fAUc/infEAuJJ74QVGR6LJDad6xzKjJ8biVSvm6h9bhk7MfoXy6N9cJRjgTca5D+z/KcvrbYhkT2WBvMYCDJD07wgaGgbxUTqBYwnjWpN84vYsfq0uXlpw0QQvrOtUzMkmOlATnXaQorQQ1uRoZnbyw7niD9eFU8bnHChgSsOnhLG8zEFqBZuQjDnb0xMSZdfK3vmT4LYkEageAUgRQ7sLSh2fuo4Ed0uPlWiiA9leean/A7YUfV8OipBCpq90Amt/3BQqUKEagbEOGSaHH1h6C4sOVhScNBxGHsR8/zKBZVaWxh3azWWAqER6JsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmF8R1FIxeZYiLs3Lg3CgiaU29jbmSbx0y4xKE+T7pg=;
 b=HfpWOKF0tdO3GCFIFacZxYS6iRi0CL1KTwgHj3GSkpzsrrj6WXMb4acwQdGnHGEBiEnpHFAh/rFCYptDRjhpMDyyFkMsgs/dCLzDPOayTjtcab8A6eEuMkniTzVLvTMe1l3gjsQbQQseptNDO1wQOQbk7ZiCu4u9ea6I8bEJ3kj9eRuJ+/+dBGTYa1wO5pB43H0rUlKk3o75Zqz0iU4rhg7AOBsb+Se+sOKz5bXSmm0FrhDlV7Y6lPsxQwk2SFFNLddqKnGt4KxWjAGJFtgEhIaEzzmiVhMYMFvjICxC78fuIIBj9BrPIM/hczPlug/2bzAdbsiY12ZPWOsWhblQiQ==
Received: from PH7PR13CA0011.namprd13.prod.outlook.com (2603:10b6:510:174::26)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:28:50 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::17) by PH7PR13CA0011.outlook.office365.com
 (2603:10b6:510:174::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5 via Frontend Transport; Fri, 30
 Oct 2026 17:28:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:28:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:18 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 10:28:12 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<mario.limonciello@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v8 0/3] ACPI / cpufreq: CPPC: Add ospm_nominal_perf support
Date: Fri, 30 Oct 2026 22:57:42 +0530
Message-ID: <20261030172745.2045743-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 69635693-8218-44ec-6d00-08df36ab4204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|36860700016|82310400026|921020|11063799006|56012099006|261009223027099003|261026121527099003|10067099003|261022075727099003|261021123027099003|261021121427099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	D321eenmDnZWE0Lf+zldyuwcRY2b1PjdL8s6IkxL4e4NkVB8u2mnPT2lF8uArW+N3FUhdFG1xNtMLF5RB/9t9HH6XsDWcCVF6QGAiqfByKxKzJzsVhb7alex7lGAPMCX1wTrzUAXw5tBqbUZ02yEIfcevYDEptYduR+fIoh1vIAeIkHtgHLj5azV3svV4JjDKH2TjtWIIGaSN4a5x507DUv3DCdi3RgDQtblaLUkoYAPWQwRwclrL2lX/8hiNCVNxwCo45cZ2MC2izKeryBr8AVeIzmI0T4giHT3RXi0PGfZeoF/Gzd9ZDTS7Ci6PaKSFEDczoa5YV+wjKsAXMo77T17JpGWJ5g03NjotRbZvdEE71LN8gjz2iweNid8TMCt/bF9wkXXp+13yCK89pZlpvlT0v5s/NhjteJr2kU+7oaqhNo5GbO/FpTlVD1K7kXfqMbCVe5eKeoz6rbhCj4Gw4+qnmWvXSf+vvfg7Ge2DDxL7hwsWKyeRKli4PRhlGjmWDRngoEMvYMWrvAAupXcAvh0ZdsNlOgmG3Eo7o9dx6Se3l8QnaJQLYXiuIOyxjoP/BOVQCGykWYLKCLF0GqkHNNQ1LvSzAPhsquMPhi1sasOFTRa4//rzri8MY53ftk/wxMJ/X0XNw92u3IZfG9W2fL+dxYvW/6idub4OR1fFBvtwCti0t4I5AuXwVNQPAQjo1F+TIJ4MdFE9cYtAz2i9vVK7pQgVH1wagI94e6XT06q6pbsKTtw1NajpcRCPLBJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(10067099003)(261022075727099003)(261021123027099003)(261021121427099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c8utxPes8/46ffBL8aJm6hoqd/x2OUQWbtw4wWQu+aXl5SzYmf3rR+kHDBXubXApy7mDQr4s422BEZUHdOaUPV8hvtrV6Cq+0q8PIQLVEHEzXdMe7LW0SzH1Iw094vZPAVhyi1T7cSViwNZNs577nKCBDeUz3eRFRK3KDisf0BhVGaS5IB64yNRTySk9e0yjcT9C7P/r1TAYls5uWf03HyxoxSgoFfp5Xe3vAJ6mmKCNnckV/zeBkaAxo5lmaBQ6ikViGzx7nfS2zcF+KGIoREEWsYrB9MrDhL1kMs4KSeMmSKMsBGW8YLrF31qGdyHE2PpzkA2j6U1P6xZOnazT8XaqMdBCGEJNGoLb9V3V+Esdqg6OWyYVayC5HdkC3RhslaacTZ7LkadyEp8KqW1MrQ2Sqt5u0grHutOHLEdooJ0YYLJAzefQFE/MRKucSRRp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:28:48.4253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69635693-8218-44ec-6d00-08df36ab4204
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227

This series adds support for the OSPM Nominal Performance register
(ACPI 6.6, Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.

Unlike the read-only Nominal Performance register, OSPM Nominal
Performance is writable and lets OSPM request a nominal level below
the platform-reported nominal. The platform treats performance above
this level as boost and below as throttle.

 - Patch 1: adds ACPI helpers to write the register and to check that
   the platform supports it.

 - Patch 2: adds the per-policy ospm_nominal_freq attribute in kHz. The
   value is kept across CPU hotplug and suspend/resume. The register
   cannot be read back, so a read returns the last value written.

 - Patch 3: uses the OSPM nominal as the maximum frequency while boost
   is off. Lowering the nominal creates a boost range on a platform
   that has none, and boost can then be enabled.

This series applies on top of v7 of:
  cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
  https://lore.kernel.org/lkml/20261030092416.1993889-1-sumitg@nvidia.com/

v7 -> v8:
 - Rebase on Christian's CPPC fixes series.
 - Patch 1:
   - use cpc_is_writable() from that series and drop cpc_reg_writable().
   - add the register to the list of controls the driver writes.
   - take cpc_desc_lock in cppc_ospm_nominal_perf_supported(), so the
     descriptor cannot be removed during the check.
 - Patch 2:
   - make ospm_nominal_freq read-write. A read returns the last value
     written, or "<unset>" before the first write. (Christian, Mario)
   - keep saving the values in the store handler, not at init(), so
     the driver writes the register only after the OS sets it. (Pierre)
 - Patch 3:
   - document in the ABI file how the OSPM nominal sets cpuinfo_max_freq
     and caps scaling_max_freq.

Sumit Gupta (3):
  ACPI: CPPC: Add ospm_nominal_perf support
  cpufreq: CPPC: Add ospm_nominal_freq attribute
  cpufreq: CPPC: Reflect the OSPM nominal in boost and limits

 .../ABI/testing/sysfs-devices-system-cpu      |  31 ++++
 drivers/acpi/cppc_acpi.c                      |  44 +++++
 drivers/cpufreq/cppc_cpufreq.c                | 173 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |  10 +
 4 files changed, 248 insertions(+), 10 deletions(-)

v7: https://lore.kernel.org/lkml/20260807214837.863209-1-sumitg@nvidia.com/
v6: https://lore.kernel.org/lkml/20260717215330.2215058-1-sumitg@nvidia.com/
v5: https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
v4: https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.com/
v3: https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.com/
v2: https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/
v1: https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/

-- 
2.34.1

