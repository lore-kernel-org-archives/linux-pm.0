Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741C34BF930;
	Wed, 16 Sep 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584536; cv=fail; b=NeU+EFUpZFoG4RqAaKO2wiWN5zoKjnvPjSrBzNmRlP+nwRBL9OND58mrrLRfJf0vzSpfio1gC7jzyJ5BiV09TBJxo7/NhAgsSK/EjfBgwGpYGO0xobRSzWqYnG2w2wCZ2ZM1wb3DrpPcs265p7tycD6p6t5gN+ai2u1pTx1rt08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584536; c=relaxed/simple;
	bh=mjw8lwt8A9brlw65cBBlDUWhOTcLA8FsKt7qfQlePkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SA23Kjds6D7IFKoMG7SZUOrbiw6NZ+Es2mR7iclmw7ceSSb1VBFOhPeiZ3yFYyvp6HIfntMQ/BWhXqWADJHl2NlGmgfJWy5Rk9Ibiw8bEet5Tj/wvACy5OpM0S/tqVzkwZRg0lQJvXGTNjIaMjbefvn+gbGj5hWr+v1ljUgZkNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qu95vjzX; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qu95vjzX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmv3bMfilf+Ak71m3SWC5vF4CXkCwi/H/HrqWks5G+i8dEaXGwYHAzP+ZH67C+GwPNpmsPa9gjOtVeP5GR/0I3Ua2ZQcX21JjHCKCElEdrZFNngQj2DwS1qcDmrSResEnDw5uFy/tgRn8SBH/iFUKO0lhrqVY9k+StyiZ3yroK9Yalp5hLxbMmTxl6udUPQV8b8ELGkzxk4r0pBWemcXSJy6ZHDy6meJ9t5p9a9Ykxx6OLmLmCY3A1IyLkswMIb/Pm/+TsAgzAP5eUEJa8IcudnEKYQY+JPa+xc8KPZAMZV35SaXO2mEJNBctrHbwacYBDmT2/9KsX3g2XI7nBuI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7QvFUG/fS9CjWAD2Do+aZL5ccqwaMmT7jFBcP1Neks=;
 b=q/TZfDAgRDN6VSyIZeGww9KQss1OQahMC5mqQ++YGy2m45hlZ3ad0PKPZEP09EPy/y+IXpEUutfZwBZJcVhhgVpvBwL5PKQOamHdmG9aqbKBOxXcPGQmwroIscNsq9smLCgAZByakmOVOHOVSvxhIheu8sBspapd5R9Qb9kueIZk8qeRtmrwFj8yh3eStAt72vNQodAfOGWJA6ybhL0kJ7XO/hk5Zw2/kWNP2+XnriydOGqyTa7L1c7Axz6sJrLEirErH+M5951o1Vbg10lp8FSKPNZycLJNQdiYuxPIhT/iNJL1XgwXT23+ETA9qC47GfzEfYxRYYcpAnS5Z1DFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7QvFUG/fS9CjWAD2Do+aZL5ccqwaMmT7jFBcP1Neks=;
 b=Qu95vjzXl+eM32Jp05Ojily9TDEu1SHAUcOqrbCx72r9pc35Cb2spacR8u7oKFHJkUsDyymVy/LoUtu9AqEX5OkH4b3BMcZ8VbzhEIPwPIc4k6AAyYu61qAyBFzejP8s7nAGTcpdBJ5GOsYfvxNpDH1yyg58CZGhvppbQVbWT/M=
Received: from BY3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:39a::7)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:48:29 +0000
Received: from SJ1PEPF000037B6.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::1e) by BY3PR03CA0002.outlook.office365.com
 (2603:10b6:a03:39a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037B6.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:48:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 13:48:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 13:48:28 -0500
Received: from [192.168.0.226] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 13:48:20 -0500
Message-ID: <3c251348-b3cc-4ab1-bac1-5209ac4f52ce@amd.com>
Date: Thu, 17 Sep 2026 00:18:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] ACPI: CPPC: Make autonomous selection helpers take
 a u64
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>
References: <20260916103820.1760297-1-sumitg@nvidia.com>
 <20260916103820.1760297-3-sumitg@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260916103820.1760297-3-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B6:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 1add4ca2-fca1-402a-4690-08df14231964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|23010399003|921020|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Aipp9tCZkMkYUcaMfmzoV974XS4NTTsvQfIGwiaAwzwU/F5VnYrcrgBKYzGSwMtQnjHTXTW1RlLfVlMHde2PDk4OQLlNtjlc8UGjBPWWtnyKF6pINUzoxaAZzljBU3hbXVC/2+N0EhaLThqIIjaUgdYZNUZyCcBVUpIZWg6xnGODjnTH4kWwG+Pcr5uWyZVAYNJevzWQidApKOvKg7jA53Hmwwcd1WllytK+RJ/GzB26NAq2kwww8uaquLDWODJQU2Ixpt8g4ynwpDBOUkMfihlCY6HHvbGJa6BLmvlsAn9Xt+V7H1PQurLkvj493wNxQd0PMUUspdPN/XTFojKjPpmT+M1YrixGc5nmM6SudJ8FaKW3BTA/cbfiudDghxrgTt04Iba9TME0gkKUcZzbnX8KHePKnTTtGalVSKatA9+IjQIiJ1PJTK//0hF1rDzNcOARUR7fuWXsczOa88luWPSVC1mtyBpGT7ng2BoPTOgh5YXUf9f4CmAAIXIrWInDk7TjVzwn8AvUAvZgLTAHdoc9OE1fwxCGFubWhrafpFpbygyfQ2k2/I6OGZK0Csgn8DpDwDSKvNiLJuMZ8tQCJiIBuGEjy9jSUbnjCxbJPZUciDzYxonrQO2hGI8hA9yH1gu/Jd4egr/W0hYbXage3ELNh8NZJA4x81MCMJ0TaIFAL6KKUWnVBuI5dPQK1iI7GmB+XO3xghs/iaNE8nMUwQ69c2loKvWih1LgdWEvUhnP6d3MUQ3quzt+bmWrMPMo
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(23010399003)(921020)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RxTsTbG48pn5di4sO3grKUrOtII2QePaRwi9GLmidGJ7ZL/tL/yN+7wyMHEVtC5kmfYX9pm13Te2vzmBm/AVQXBKmEypCDtydw2r23k7IR+BaO/o9XKYllnBy8CByvq3n6j7vfAktoDwOIT0AwZM150000N7rloPvxc4bMbpV3ckhkG7REnvCdRVo40laeAD4vy8gqGAz1O2d/u/02xfXSC1/KGWZj25j5O7M3NpI5uijrNgo6mhbGr/hKDN6fMtzbbWtlkYj8lF1uKuD8ucdliY5VHp8GewHL++tQU0Aiho6kLDZaRkVhk52FBCk8Ye/4t5ll5oztdLAe9wSWnhOWpuch5Y2nghqGLfYkhXSvpcpszQCevfpOPNoz018sq72zGLBCLRv9eQm2swoFpuZyxRDUfmmLO0yKrr3jjQwlgbCb4d0kmXESs6lKGk0uZa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:48:29.1028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1add4ca2-fca1-402a-4690-08df14231964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093

Hello Sumit,

On 9/16/2026 4:08 PM, Sumit Gupta wrote:
> cppc_get_auto_sel()/cppc_set_auto_sel() use a bool, unlike the other
> CPPC register get/set helpers which use a u64.
> 
> The next patch in this series saves and restores the OSPM-set registers
> across CPU hotplug and driver unload through a common table of register
> get/set helpers that all take a u64. The bool autonomous selection
> helpers cannot be added to that table.
> 
> Change cppc_get_auto_sel()/cppc_set_auto_sel() to take a u64 so the
> autonomous selection register fits alongside the others, and update
> their callers.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

For amd-pstate bits, feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

