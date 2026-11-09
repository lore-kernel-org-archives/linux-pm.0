Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254093;
	b=4ez0YLgnHYv3M+L/M1T8eXUZKScno+Lr/dZLzRLM4B450dAJqG3DoJuAU7oQRdxTsjIw
	 OsCtluHXY+jcknxVA2ldJ1b9VpfgrQgLhU9LYcpEoeQlJEK8SKhRbbyUUqxEIJhFS1UpV
	 3997acjQAg8FXyUU+qgXXGOF2BeBbmx6B5WOD6Fuvk6o+NYqq+Cccykcg2JUOZXmef+xO
	 79/Y9uIHNMz6rp4A2XZi5Pdjd3YUX87rhotzZxoB+y221DifxRLRQcpsgNakyLwIWR7OD
	 tCWwpBoWAu99qsKB6BkzKPkRzPpWjRTkfdL4nzRclg0ICTGEP5rTVsbo/j+PbSFqOHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254093;
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
	bh=K7jzdxWF2/V6yIz1LZhXidjiFgxN+6mS79kDPoc/UEA=;
	b=l/TIf9Xd3x2RsvsGcjCCTgCvgQgYcnhrkTGXTbvp2UCNVN4luc090ZInF7NE1Ji5eEXh
	 Cql8VyQzbFgd/D9aycLorpHZHZ4CalUim0uf+20S8lmgAWxpBCWL3O5zPMoKhiijKf4Sn
	 FXd8sIbqw4nPLLjtppBet6sInFRQOlXfzefSa79c0hauP82fajqB3eSslhmeFm8bY6Wc8
	 G7iSIaLH1wF0r8XjAUf9X19WhJ8bl3RE8ZvB3RsuFS2/dR0mckA7X3b0EjBBtwK6lefbc
	 cj3+kpdmNbY8nmjcY4nuw5nlQYUu2lTqS4hD6kFXYC/x0584lU4w2HDgsjB8rqYbGJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ss17axtf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.47
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FB60A2604;
	Mon,  9 Nov 2026 19:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B42FB60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ss17axtf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHVtClUj7YKmo71a3ptbh3fQzGSBCMhW+pdGVrxK39Od0EFTB7toNRVpcLYnyGzLpxvcnefdpqofVmrR7T7jUt/DsA1etzCaYMKMXXZIRPu6GZC3y+Kdx9Xl51MewJKAsYsvqaUHzJR3UtaRSexCgHOGHxjp0v5/DsDcq1vfgd2Z4igUdxzEQDUu8wGJQpGT59PNAs5VK8np498xGSzZxl+PxCcg3P8Eu1I/lv7/lPUYvke8NfxaywRPd//6hinWio4ORql2fptlPp0aDYbtR4J9g7g3CAPhQJZMqbA+TQMcISRrZvavlIMe9A6t+6jSQw6temrKNUvZANT2OpCOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7jzdxWF2/V6yIz1LZhXidjiFgxN+6mS79kDPoc/UEA=;
 b=p38ONvds4iXBgsdSVJ/YV2PvAD3ikovz3bt4cqORgIq/wRhtXco9O+QQzYyEQXBH3ZtbU+4ULFZqdBmz48MAUqnOcNAqFn0L1fg4uIdni2aTde9TmXfDw7FY51uStWD/PwA++6xyQv6+/1S1AhKMhUNyG6kkBv3hJfa7bu07Kt4oPrbJs+WgtH/NmsREvDDIB0aHgFuJfJ3c1REuXAh2zEWg7Cu0v9mL1bQchScm9WkEst03TUULlObft73MhhsBCLu8ow/MAtoA6Ady1OJBTa8ND6ppmE0FXcxFsXsrqsKRDm0WKtyIrNl7iAXZM5dQCg8yUSiq8+HqiDu8nF5GJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7jzdxWF2/V6yIz1LZhXidjiFgxN+6mS79kDPoc/UEA=;
 b=ss17axtfVOtpckQDe4K2pNT2OkCXaqE/OKthP8o8cVxGlMVTd4jphAFqSHeMUoUf0z0xFbBhR/vXQ+E6+3w1X5Hlm8uh6DuMq8yMXNh183xsPlHww57O4745zW6/J6p3xqVWveMHTV2Ieb4KDxWKPy10G8PJwxEK16Nn4T9mGDQKFcnbLdW1JsUfVypk5ryHriZtZWbDfwJq9+JI5ce62uGGCEy09lUzz7FIsArFiD2aw+LlVZqKoLtpj60K/F+2xxINEEs7vR9xB4Wtps3vIeyyD7rTrjBZnev8aPZS6AqFr1cKOyB8exE4SXa3hwhdVQ/xSZwjYVN7IkwE/zahQQ==
Received: from PH8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:510:2cd::20)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 19:54:48 +0000
Received: from PH4PEPF0000B611.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::7c) by PH8PR07CA0015.outlook.office365.com
 (2603:10b6:510:2cd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 19:54:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 PH4PEPF0000B611.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Mon, 9 Nov 2026 19:54:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 11:54:32 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 11:54:31 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 11:54:24 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v10 0/3] ACPI / cpufreq: CPPC: Add ospm_nominal_perf support
Date: Tue, 10 Nov 2026 01:23:57 +0530
Message-ID: <20261109195400.3600561-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B611:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1a296b-7952-4a0f-6b47-08df3e9b4f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|23010399003|376014|1800799024|18002099003|6133799003|10067099003|921020|56012099006|11063799006|261102123227099003|261021123027099003|261022113327099003|261021121427099003|261022075727099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	OfYtLyUP/F0ZxvWXbCWTRkxFiVeDY2MSF8/He+Bh7JZ6GMPLIB1/u1AEeZBVzj1mKk0Uy6Nj9Zx0ntXk8q/04m18FvnHsvxeCMw0lXPYRcyv6kSS+wktLZbGFB9nTq0caUys5a9j0IvMuBPRgAXw9jyAgBl3745Ngyf6jf0JtpjwdL+KpGPeXT56yxXMV/SQuxlULtMSwXhuiaF4MsqiWJN2LVlBr1eqx2bm3gpJcy9nh5/HXkePuKvqUY62grt+Uhja1TAq6pu2dOF+bCPXdr3vz5Ct3xYfDa902fplO7asx5/ddqj+Km6UuC/yjw+YatlPjvNMfE67g9M5jw4B3fQREO2kH4fsyBy7db+a3yB8GLL2VcvwLYmg/fNPctvtY9gx7xEGsy0kch/nxPdGkfNtx/Q6wc05FRLSiNRuvQVmj6UZBjUfIBcqhQ26mgjotSF1tB59QYrtsXIATkO6vNBImvhIk+cW5+I5bnzj3A89aPZGUiu9sJWMm7ltlpT4G4u23N5dElSEuFn459KrjMg4Q58O/QEPnKIhyKg9e1UMTwSGIeHuqPBb6cXrnpF5To1SQewf+R4igbp0VXTqd025FnKZTGrsTNgNci9lywSinFBKTIQPbs3PZKF8FeaNuXH9IPMGzRp1JrySbHbdOE2X1GL8jz/yHMuFYHwP7mG0c178w+Z4XovafHW3lmrRMEGAd5wBjN8MnmiDnU1L7xPGGNYri758fpXTzSZxCYBc66IWSBuB6f6CJbtkwYYm
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(376014)(1800799024)(18002099003)(6133799003)(10067099003)(921020)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261022113327099003)(261021121427099003)(261022075727099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BTAuT3pdBefrnslwVtxLpf43R6vOrENlfbF/t1AmBtDUcnkdAscFGH+2ZUhYJCieRVv5wShoNB+Z2MzRFwQYnqhd8E8He5IHBaHt/G96+fVshnJRxiP0sKOFXsr6o4rMZjJBfCKyROfiWALzr4N2UCw6vKsngbQ7j/wg8Bwst5I3KY6of+TjExGOIi2O/z3uto7MTdnRohXfZBaG5GXQ5/lEgxPov1Y6m/kCxhiRL/KFR2tM/x/D9VhNdcGf0Q3JrrGpYsTNen9jnJXfzNSgZidx696w755K+n1Yh8jjDUs5LGXxa68yGG3rvzLh7uoFEJkbz9FJfQeUAojWi3mGChCT9qeJfGI58v2ziI4Pia9OWQz0wVvCx6Ms8631OFaeHY+U3IeqtK1JB8jh59yq0GM1hckvvOJmGuOochQOSe1s65wPWEuo8FeznDjfejfR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 19:54:47.5692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1a296b-7952-4a0f-6b47-08df3e9b4f05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B611.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

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

These are patches 6-8 of v9. Patches 1-5 of v9 are queued in for 7.5,
and this series applies on top of them.

v9 -> v10:
 - Drop v9 patches 1-5, as they are queued for 7.5.
 - Patch 1: when the register shares an access unit with Performance
   Limited, keep it reserved in the SystemMemory overlap validation, as
   it is write-only. (Sashiko)

Sumit Gupta (3):
  ACPI: CPPC: Add ospm_nominal_perf support
  cpufreq: CPPC: Add ospm_nominal_freq attribute
  cpufreq: CPPC: Reflect the OSPM nominal in boost and limits

 .../ABI/testing/sysfs-devices-system-cpu      |  31 ++++
 drivers/acpi/cppc_acpi.c                      |  56 ++++++
 drivers/cpufreq/cppc_cpufreq.c                | 173 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |  10 +
 4 files changed, 260 insertions(+), 10 deletions(-)

v8: https://lore.kernel.org/lkml/20261030172745.2045743-1-sumitg@nvidia.com/
v9: https://lore.kernel.org/lkml/20261106193304.3347374-1-sumitg@nvidia.com/

base-commit: 22f2a52b46d52df66cf0a5efe4d22296810cbcee
-- 
2.34.1

