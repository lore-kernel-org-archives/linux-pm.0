Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794668623;
	b=YQLQg3eSEVz0D7wNdLfGcD/mtbBPK1CaAsGaKYAK8PWdYsCehQ/0BmRfucJ5HPYwVGdV
	 +pwIHAvuB8QmwbtkGs0hfs/tneDe9bXEVOBn+XofsH9FR70lmd8jH7/ca1gnIaIHbIXO4
	 9oIBol/FBHXOvpyurerTWMm3C2OBNXSN3Ev4R7I1trtug1AMePfoFrBLyfVUGtTKNzOkF
	 IAj6gNAkE95+RRt8K23vyceiza9RMDjbOq/bjQxp2mx1KnPUZQXcpUAVGRJrrzkmw8aIc
	 eC9M4cS68h58cCSh75VoDAmeAub1LfMJo7RgLejzWBXLBnlaGr+xeIbZZC1+5RHVVcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668623;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mJoCEFQPkdwfynPxgjPtszxttKm2pP/mqNOquyYEblA=;
	b=24e6APd94WAKKPcm4FYB1vQMfYWwNa1yLATk9vbRzFs5SNLjx7lO9wKGUB8MTcVc96cD
	 3m2A2A51rOA/vJYB+SdsE/iWKZXMLlinIHWcd2LTVB7aDdzxLK465Sj4HF3Th3Biq1R0+
	 w/37RWq9l+N4gHlXeosOtssLWoBmOLoo6IuQ9Ub1d7/LAutPQ9YNk9/nfXqVkJcmlpbSg
	 4apRm1wt91vrtgHZqOsrCBX0xF7o4++CTH/9aWoOHNERvVLATE/i2ButRL8mNPtmH7r8k
	 ER6OWrjH1xoT6dKSoJm5edAnE8cLrQ9g0KhJEHox2dYn725PvsL7qF+8qobuMJTfErA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lYByZqAl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.2
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D733606A32E;
	Sat, 14 Nov 2026 15:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D733606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lYByZqAl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B34wWwS4hptUgpruU2t2OhLraSOeuX9RKH6OzkeaWOWscjMSg1gztO04vxQsPugyRpTX6Ls/1S1n8JpbvJg/3wgCgX2IQdaDIqbc0dL8veXGSulb3GFffREqvfsBUCRr0HhE3IPAmPALVxgrRqpbP2cSvyClLkpHtff9S7ZRvcWwEdntsv839pRz2WJ9KsX04o8fLTk2UiXzDwCc/rZiK+CykFeZCLaKuPZ3tNKyxqcoN8mLSe9HwL28gm1rVpygJFoVKd8kcmqcc0mcpmD95PLEA1yqafxPufJvO8tSJKYG+MFEkFGNKtMkWPa3wugcHE7VDUmTH2xTioXiElDxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJoCEFQPkdwfynPxgjPtszxttKm2pP/mqNOquyYEblA=;
 b=KoaqnK43gTAt1zeopx+FKwRiSJF34edlo95PZaURvrWWXi75RSD7TaxVLIRlOn+1PY8Nt9FAT0dWgDGJThUJUmZ8Yt4X6idyICnJlRLCyxiXMgUNn0nvq3CSESwxnclaCew68svwsn1BrNvZ57Io5GGMM0b8j1x/jr42QJbIKqiI9//kOjt/Hj9LSFONIrU4awphw55zWBLDr+yfuPu8UPVVEfgfJSNIqzWbdInlux0Xx7Ii70Vn9e0IbHl1XnjbPUaFIMzzRDfXMmaseN10Ye4hgR8umHu7B6Cp2rVdUb/sTR17Sb+YICqotbgf2NXXvgPQbWiU7IXQX+v3lSr4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJoCEFQPkdwfynPxgjPtszxttKm2pP/mqNOquyYEblA=;
 b=lYByZqAlxX9B598pciP0ZjjgJ2GZr7ViFwddFw5i/upqCME6w3ztbRDDAxcNIf11FnEngKtZ1g20H3gOMb6iXfJKm8tb7+XnunBp+wH3IC5aLg+QlO30Wb9zwHyTr31UT9srym3e/JPl3/QOfL0/IEg4f8otK4T7wDKR8TaU6J8=
Received: from PH7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::7)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 15:03:35 +0000
Received: from SJ1PEPF000037A5.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::5b) by PH7P222CA0016.outlook.office365.com
 (2603:10b6:510:33a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Sat, 14
 Nov 2026 15:03:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A5.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 14 Nov 2026 15:03:34 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 14 Nov
 2026 09:03:30 -0600
From: Vishal Badole <Vishal.Badole@amd.com>
To: <ray.huang@amd.com>, <mario.limonciello@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH 0/2] cpufreq: amd-pstate: Capacity Aware Scheduling on hybrid platforms
Date: Sat, 14 Nov 2026 20:33:08 +0530
Message-ID: <20261114150310.1377654-1-Vishal.Badole@amd.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A5:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7134b84f-5fe3-4b06-2106-08df4260744c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|921020|11063799006|56012099006|261021121427099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|10067099003|261021123027099003|261026140227099003|261102123227099003|261102130727099003|261009223027099003|261009221227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Tfyar5LBsQ+E0ojbJpldkZP82d/i29e2X2W0uXB74iAKcKX/umkVcG6H44YVSqnMxwAT/c9BTtFignml6EwXCXumRGwQZnFAZvleAs+hutzQDyBUCZKlsVf5Ln8WOunBh/Ms7GURz8Kh44/j2SzTQhQ03pIuxzjgD2KLXk/yISV6IpOzZdYDLO1qwvEu9iuTq6phGT95d52dLGBp3xYV+0P8qElEnjSVYoeQbghFtxAsJPpU8dbRh1j8c5Qq999uZz41V2RbCACR3+hQxLyY8lBq0CPpBTKL1Wa/yxsQ7naObUNOT/H0ziwzKFu5uxKJRcDnJo/Xw9VOpjlmx9kU3j8NXYnpnZNxmtzkmYfW2XVPqP7zAPWY0jTMIH/LsfWZPQYpd/1BcsqDUOsAD5fXLv3ufiFnBxlOQOW7xa2pQzZInXbVigzofUgv03umu3i85SpQf+jIkM4sWm6OpHPo+rkHXJMTgb3uTRg2H7gtHm1HjPBYix2B0y4SH9oSsfLco1/kiv6Jj0BcMz1JgPd0CbMzp9vryEPbiuTu7e6GPUncKxUgV+Tz5p8qvBVzgB8Eo0c6VCgwo7FdRZgYXUx5qaxkF9+Qs1VqSemAe26G1T8bC8KARTCrCckYsdNoweKsuk+OKLE+H1EyMj8hndBjzOSze6D2aBckp4lu+ZEjRCb4R7h5v7/wzcN9bOqZHDIHSgDHE0qG3ztf9qI8WZdMC7NsaGx+SXreLtpWj335pTldURNQT3HHBeTLEcnJ6NGK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(261021121427099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(10067099003)(261021123027099003)(261026140227099003)(261102123227099003)(261102130727099003)(261009223027099003)(261009221227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K9E+AZJf5xgzFodGaniLs0nMIh5pxwq7gZUAxBs8BKVSjdsB38BV5/tn6i0H2uVvcOYS5RtE9ewLjuBwqUuef8pJxnJFHoixkFYCvJG0/bBBoXh4wMyI6kds7OicYbeIUg+MQo/wT16xxTGKhaMWdHVeV68EjqKeZl7QblJMXoOKVll/ARGcQCsAaa/hel20eUWTUfayBd23rDMWNO8kGIQOK3YMOScOuNqORf9RKaCYdlS8EUu0kZgBeeEaDqx0/ohicTS1iMCEmXao6obfLZQfu13zQP4jSGud8ChPXRdvhfpCxI0B3VPmJsmZJfquGM/tfYfC5Fd3dBHc0yyzwyDLtzggVZAu/F5pkfN/Bw4D88n+q/zAsFm2qsMRTzQCvGetPOmetjwhu70Xz0zF3nHriVbFftpIXYwNAVjx4hzeFNNLMie/pJK12BnH52F2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 15:03:34.4073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7134b84f-5fe3-4b06-2106-08df4260744c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915

This series enables Capacity Aware Scheduling (CAS) for AMD heterogeneous
processors that combine performance and efficiency cores.

amd-pstate does not export per-CPU capacity today, so the scheduler treats
all cores as equal and places tasks without regard to core strength.

Patch 1 makes amd-pstate publish asymmetric per-CPU capacities via the arch
hybrid capacity scaling interface. It is enabled by default on supported
hardware and can be turned off with the "amd_cas=disable" boot parameter.

Patch 2 makes amd-hfi stand down when CAS is active, since both manage the
same scheduler state.

Krishnamoorthi M (1):
  platform/x86/amd: hfi: Stand down when amd-pstate CAS is active

Vishal Badole (1):
  cpufreq: amd-pstate: Set asymmetric CPU capacity on hybrid platforms

 MAINTAINERS                        |   1 +
 drivers/cpufreq/amd-pstate.c       | 102 ++++++++++++++++++++++++++++-
 drivers/platform/x86/amd/hfi/hfi.c |   8 +++
 include/linux/amd-pstate.h         |  14 ++++
 4 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/amd-pstate.h

-- 
2.34.1

