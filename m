Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFF3C871B;
	Thu,  7 May 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146422; cv=fail; b=aqX65eFmLF+tNJo3DEip1LN4lyfsRNdUUH3tN33Or3ZPXL1y0zaGo0r5ipd9+gtkcw+Xq/4f/3jmP6ayJAOC7nD9l4prlEKGadm3umiHghJYzPTLPaXJuT1MtMAg3gI5CmPd24QrEJeH/qLINNnuleeMdjWmmKA5y+h0cbQUSg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146422; c=relaxed/simple;
	bh=KDf+7bouuiEhclYTBH50lH5eTr3rfahFjoHmmZdG4cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uNLyidcRZi8pSJf9oRKmXqSO2JubDZVMZOtFHNy0TJ9nKf6jNwoy8konLsneuDuuEL5DWt4dsbAsk0DaNojIQdZnvpR4CoCxMf3n+PfPYEY6meSy8W9h9JVM3tORJTQWAE6pnl4ktD6Jltjhag301Uplc7XlwDV8JCX7MfSvS7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kN3ERng1; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kN3ERng1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdp0+IOBZLgHCkm0TUQMLw1CkT0nS/nJBzCxZuuo8vNghJRPTvqD3DeRyPXbBdGQZgRtN51kL5/Gh/w9qjcjOl1fzGN7NInO4Yreh74WDPZtuEIdFykXpffG+kDqkxc58Z2zbC3Huw7VOEQwe4S/WRoxVdLIMXOYJEujt1qKmjXtvsems9SOQR5c5wuniWsoq8w/49MxyJUsjUFV/RlYat6rYTiy6fLS4nMHvMF+XOPD/dEc7pDFyILxEPZcuXfLmW3fOszqh8rtiH50WI2OLQbnSpzc4f8Hv+ua7SHkNcHr0OG98jyJmtwfBNqBEIR6+Hte7eWJn7Bax1lS3BixyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d9RiA9O7pb7MKe7aXnFNfUf6nprSVBBgJqRtQqi6TI=;
 b=XgfQ3ClgmIMDeHHignoJ1R9UtigHpY8YFSDPqypFo0/c75xzkwGX900O6mWH50qSLy0I7yoziXlbbCYgm+qFb5dI4fqFdKKxqTcPUo+8fTjP8q2HV5wdhD61QW2hSfpAHRljVD4juiKCUW6uFAEFxTvdQCgblsj80Lnqwj1/doNIgJUi1vsJBK0DNCo8Hi1bgJjcL+1HE1uvBwjBY6D29TEH/Oa04hN3Ai1jKoloGQ82Xw30cbXwDYPqnkkzVCqxymu7gtaQzw5hV5B3nEEiTNykvbu9TTwbrafqxg498Ilxr4XHtXB07HduUghQ3wGPUo19wV39EfOoBsLnFACc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d9RiA9O7pb7MKe7aXnFNfUf6nprSVBBgJqRtQqi6TI=;
 b=kN3ERng1QS2Vzzwv5/EzBodrBHPS+6S9d1HkENt2wEfIcJ8MrBlhVSctGXruZIaZ8yy2XvsqH4udhKJvNsxQj1SnWayQtid/d15hjR1N0JBLuagjOpIIfJ2bVtThBcDKt1SGQ/BTlIAUcxfrgBlHzflkwVXniHXNRj0U29nNR84=
Received: from BYAPR11CA0097.namprd11.prod.outlook.com (2603:10b6:a03:f4::38)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 09:33:37 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::80) by BYAPR11CA0097.outlook.office365.com
 (2603:10b6:a03:f4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 09:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 09:33:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 7 May
 2026 04:33:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 May
 2026 04:33:36 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 04:33:34 -0500
Message-ID: <354bc88d-6e9c-43b2-a472-1f01d6682858@amd.com>
Date: Thu, 7 May 2026 15:03:28 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Add CPPC HighestFreq support
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <x86@kernel.org>
References: <20260504230141.484743-1-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260504230141.484743-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 20587c8a-0519-43e8-de9a-08deac1bb75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	w+fLKDBiKNeFFKRDmooFi7dDGCJx1b9FAb3JX4aMqz8KePNUvV3SQ2xM6hBkB4xP/PYzzLZAm1USAT6H+hKVOYtMhPhoVJz3ta16YqvevO8vnTWi/uT87IjiQZ9FSn9IsR5DwzfG1OQTL88bIqooAGEZkhXE26UIEcCukv1ObO4zhuQdqvueQxvMCEiRUKlQmqhKuRmyUo4stTo7o+J0sGyBTk1yWdoPMIHZQp8ZFCwLqBS+xNyszrhuWQyupirdqkNIiLVflivbILkX0vy4crXBLNzZ2aAISgRVS9veq7rLT/ZwaffwiEKOP2f5mB4NNZn8Z47AFB2++16/YCmxQEPj8AUM2s/DLKloyFuP0UNqwzNoaRMFsNrNPiQbMmMzQe8r/8g4Wxr2hXG9HYHt1KmX3JAfvSpkfmU5VtEiWqYvS/8bZVm9kWfYr+VR2RlZ9tAofrmH42O4U4RuZtge31LsBRV/D96TuVNoRYlm329kW64OncmfbbDMa9+YGS9S+UmHpWbHjDyrCfSsk6K1HOByPtrifXEmpiSk8ENUx+2LqYcUQ0eK2g/8ACarfmgyKSKt3Xg4Id4ZJ9cfjBaytO2ja2635cFJVKWLEamtdaJIBv14B0Kp1nir9kUUMSQuJrP0+iggbIq5xUc621pPd4+sSTbUv80xuCpFXk5zfRVBfmAUlK9ihOjcQLGTerSG6SXHAyG2RlqLpr0T9+ANzHXgy32p60G+o8QQ8byZ3UE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h6ArbLEdwXch8qVPz0sghwJemOZcZlI6H2DofRgTvAZ3GA3yoFbzGqwN6pROUstRii0Ab5UUByLOrzew2En1cEh7Qg8pVs5iLHCenrzkiK//QLHwye+Q5D7mIDCnGE8ldaVLXDVKyaaOsYhX7lostQL0Ej7e/d4NXrEasrKxsWpNt47pe0wpUAuCWjWLR0p4Ddd8bi2+4pzB8hJP0qSyoi6hR8q00uWte4qdSlgt1AChmNS+XmqS8Mw9eJiHmraPq/mQ9IRiddhUiU8dkmf7t9iCZw0S+mvUO+RnbL3AQPlQmu57bKZRSGFbp9NNWRdednmtJfxIWnhKC3vWD41fCNpWFiy26GGSGz0YAH2KSUTRO8EEpb8Uu3N3+v6bgNuOebLiKI/kI14aosst/M5I+kRPPk5a/kSdMc85WYeU/wpPc96ThnoOrkuBdz4ctN94
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:33:37.2190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20587c8a-0519-43e8-de9a-08deac1bb75b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339

Hello Mario,

On 5/5/2026 4:31 AM, Mario Limonciello wrote:
> On some systems, the boost ratio cannot be accurately calculated
> using linear interpolation of CPPC performance values because the
> performance-to-frequency mapping is not linear across all cores.
> 
> This series introduces support for the CPPC HighestFreq register.  This
> register is under a proposal with ASWG at the moment and trending for
> inclusion in ACPI 6.7.
> 
> This optionally provides the actual highest frequency eliminating
> the need for interpolation. When available, this frequency value is used
> for more accurate CPU capacity calculations and boost ratio determination.
> 
> This series brings the existing CPPC definitions up to ACPI 6.6 and then
> adds support for the ACPI 6.7 proposal.
> 
> ---
> v2:
>  * Drop CPPC v4 patches, these are submitted separately by Sumit Gupta [1]
> 
> Link: https://lore.kernel.org/linux-pm/20260430142430.755437-1-sumitg@nvidia.com/ [1]

I tested the series on top of v7.1-rc2 + Sumit's patch with both
amd-pstate and acpi-cpufreq on my 3rd Generation EPYC and everything
seems to be in order. Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

