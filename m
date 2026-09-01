Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F0476066;
	Tue,  1 Sep 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255105; cv=fail; b=PSxlcJwNzV19w1YzSWHr6vkjnGO1553je1tZlBNzFsMtqr0DZxJs83VZgtK2JUVvlzJ8JEmWrYPkSTGMs/4OR25VYE2pxfbSkUcc7zW7UkDNBumPf1w/MrRpHLWJ2GoAS4PrbGiWB0aungli1HCvNulSlmMSyI0PKYK5a/DtF4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255105; c=relaxed/simple;
	bh=GGyUiwmYqAJ483+5OFY71DVW1U4ZIdFLqH0YfnsGf38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mNGb8TCqOxW0uDwZjyZllVoIZ/kx+7hPjTa5d1VdDK75snMJbXQQzLpwp+7FTboId96cKQK254nNN+0G3S7u8y+ixtzThsw1zotkpyQ19U9trzUE2bSnyahvQoc4PnYzZ2Tsv5ZaPhrOrULRAP1p0zrOVwgJt556AgBOkLy6hpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3rIKlWqU; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3rIKlWqU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhyEaFo8om8qKIOjmpuGq1koJwb57ECz2JYGrHqFLTdyn+vnf1lYPXzMlkuRJOgaPnEM/ALbd8EjI7oWkHdiPallWpEFnQfNV42ze+in4cAly1Ixjus5MuxDNuNlZicUm1niCRGco6x8JErifwGqZ90zu77dDAexwokTxlKeV15S2ygiXCVxDpme/09TE9CSDHVCMVUr3v0Cgs4vOnSoV1Qhz6pte/H/PThMSETPw4Os7pzG9Y89r8lyhbwEW03Bkse6RYwH7Srh4hGC+2oJ0qRlnasMwwgDA612U512+nPosZ9voUZkMjVltWkV2iH0odmekFjoFKEc1QgFVLatRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRsX6juNXbMTSgQHVpiVIiePsRtbsrbVYrITVPNi1tg=;
 b=Puo4cpj9+ajXbzeBFIpH/zbUewWsYIjZ/HYoD4I4Baa2z5OJmYX3SCr1iOUNy0m9rtus2ZpcIA8EMz3f9abVFTw/wXCISTl36lPmKJ6ANfVNcHn02s7r7dt87DAtUSTsHwOxHSyPS1YAALq82xgbYeOaHTI0/4zx7Zjw1zu191ZLgaVEQ5SvK7Uwt1C+Bgz1n4B6HyBW9MN25LEmF1pzJl/hcDis93chPaYSsGz24NCNeIzdRVICRol1UfbsKM2JJxlJAcsHSzxpKltDkKxlZLo1+DDffDwuYp49YmqcZ87wplGp4d63qdNJ0/T2qr4U4HSv4VZosUeMpGKqZwN3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRsX6juNXbMTSgQHVpiVIiePsRtbsrbVYrITVPNi1tg=;
 b=3rIKlWqU5dYMvGR4aKRLx/NeM0Y30QutOZmK5gVP0EFhG24qxf/EJtsGzDXWEeFA9373wlZx0oPGr11LCDQeXbhHQSJ2HYjETfoHdU1G77k5us4hUiAMbgd4LTJneP6lyUrC3RTTwe9oeWtlv+5T9QQIxUgWJm1ghzA2tnvceBA=
Received: from BN9PR03CA0769.namprd03.prod.outlook.com (2603:10b6:408:13a::24)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:31:35 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::9e) by BN9PR03CA0769.outlook.office365.com
 (2603:10b6:408:13a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:31:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:31:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:31:22 -0500
Received: from [10.136.35.162] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 04:31:19 -0500
Message-ID: <f18fafe4-f873-4080-8ddf-72fb6abec557@amd.com>
Date: Tue, 1 Sep 2026 15:01:14 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: CPPC: Refactor boost ratio handling
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <x86@kernel.org>, Vishal Badole
	<Vishal.Badole@amd.com>
References: <20260831194428.2287055-1-mario.limonciello@amd.com>
 <20260831194428.2287055-2-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260831194428.2287055-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f2bb01-4bb7-4574-a4be-08df080bd106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hJpei7zwjhW4J5x+nd+PkgrYlNhznQ3F4Vt5p2pTOUy1jz+zifDRVFZVufwbcGd1WQsoNzYmu6QA88appSeRm4Uqp81v1caVMkz2AWB/GWHKLlDhcwj1bc3xGHMfkXbyx91fEYDv6mGSIgPjnR7aCdlIlQrlbdWgwUywcTwZz9Edk1lDFb7ap7cRWFCDVrveWzMyQW6sapUcPLE8q34vwTlYfmLI4w6V1daowTKCgvpJbNcyfjBEPCD+2aqRUYYIUasgRrzmLZXS1HaQrpSU2QUJ4ftorAIdRvq4QYCNMLT4YlOj8qD83WHak2QYRp9It5DPdue+uBwVKmDd6PzUicLFDuuBDajvdKELmpCw+bg9cTIOh39vhaNfN0M/YHosRSz9qJa6lmhatYiHCrOB+dt4d9H4bTzfENmwn0DBpcwiC7erWjH1kqcLCTLIi6ANRIsEqzTRmC8bjnwUgtURk4bfsJRDuKgU0KJXg+z9tUPJ/Z2MFfr7NbJQ7TehxeBUAkQjEroSYRN2QNjfNfZE2ckt7kRKApF76XZI9mUXAIsz83nj+I8zSlx029yzXhcfkTZyyKIcnCTgfdXTYoexcwodFkvrGnawFH68Ro0Oov/sSP6preKhzQlgY4hnV4i7VJ9LkhCQc87M+fGbuvhQqbS2dCBESoKq59ZPxIiRKz2HkuI6xN8BUQ+4qUhaDlP9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PsxPmwzP7FN45cDAQDbbFYMoZ0J6v0Sd4ukmZKZSjJgv3RbfxOmkT3m/QEICspUrU1dr0wz+S7Hkvo7Q6moiikDnwEE5eLiytBREfpuSzakW1aYNWQZrp+HVzmGS+QRtG2rmfNMH7UfVuaogEwhEHJca9Zsd4rIY1u/h8THXsFitZpMPGraWfmA5+gr1XyZPD3w72QTRrNvHQ/8wbrvfjasYq1ONUwb4rshUG85GzLsMxS3oNazfDzxo6g6eEqYLC8Hqk/etZ7EL/Yk2BUDGZd0DIjnVkwV7EyDW+IGYxSnQ9N5+O8lcH0u1Mtjf/XLQpruyx8+jNJiTxEgwjTth7V0IQAyMpQ8yMr5vO+SEDOPrWx4Ztm8dJRV5wPDwhg1REwwJS8k1srcZn5VZ1sdTvVwt9dfTWRKN+8JMkBV4MrSeh7BJb1qo44pb9d4i3vxR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:31:35.4046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f2bb01-4bb7-4574-a4be-08df080bd106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464

On 9/1/2026 1:14 AM, Mario Limonciello wrote:
> +int amd_get_max_frequency(unsigned int cpu)
> +{
> +	enum x86_topology_cpu_type type = cpu_data(cpu).topo.cpu_type;
> +	const struct x86_cpu_id *id = x86_match_cpu(amd_zen6_client_ids);
> +	const struct amd_max_freq *max_freq;
> +
> +	if (!id)
> +		return -ENODEV;
> +
> +	max_freq = (const struct amd_max_freq *)id->driver_data;
> +
> +	switch (type) {
> +	case TOPO_CPU_TYPE_PERFORMANCE:
> +		return max_freq->performance;
> +	case TOPO_CPU_TYPE_EFFICIENCY:
> +		return max_freq->efficiency;
> +	case TOPO_CPU_TYPE_LOW_POWER:
> +		return max_freq->low_power;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;

nit. Since we don't really propagate the error codes returned
by amd_get_max_frequency(), maybe we can return 0 instead of
-ENODEV, -EINVAL and the callers can simply do:

    max_freq = amd_get_max_frequency(cpu);
    if (!max_freq)
         max_freq = /* Fallback */;

similar to get_max_boost_ratio() pattern. No strong feelings
either way.

> +}
> +EXPORT_SYMBOL_GPL(amd_get_max_frequency);
-- 
Thanks and Regards,
Prateek

