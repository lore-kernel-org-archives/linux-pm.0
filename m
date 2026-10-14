Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D934D4CE;
	Wed, 14 Oct 2026 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968638; cv=fail; b=ZG/akEsSOLFiA27JPU6KnKeqydzU0IFvF/RS1SEkUKqoWlE5LBw4l4UK4hg9NRbl0mrrFvDj0u9vyc+z8WDjRxvxLvB5vdU5cowqWSK/6oXEo83T7GWLACFEvNwKAmYgw0kgEJOhTKExrS1dZKIp0spaczfY8LkpRFQo79GXM6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968638; c=relaxed/simple;
	bh=JEOHvyc5KEzUVRFGnTslXtt0bwF2wwILtSrmLUPr0Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O5OAqNfls30BsMxZizP9GFHs9ZfS/G9UmVl2Fer7sQrt8cvWHJBH8qkGf6juzYDd7Wb5hZynRg4XZRYu43Y2oq15UE6gXd+ivMyUCK1nDqKVPB4NRqUXibIZ29kX7NsjYDFSdMq1Ay09lHmbcNoc6EOCnb6CGB5vAOzrDXtCEfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kly/rwuC; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kly/rwuC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1SHywBDk0t4Jwj5mU1qzqfuW3OoWkqTfhKgoTw99qZM3khBJ0hy+WMXcnz+rEv5FfjaqAWZcWUADngKZISH5JF7UEnjQlwKeBxcCLBoH9tLyPJlNRlsdKq+L3gTfGP1M5Hp/zwQ/CRu4Nc6x/n7vT1AKpk6frdf2DOWU5pzh/0iXiuwkpJ8Hh4OHeXkzwgobXUTrpIX7BUwQsQg5S33mLNZjhNQ/5dNDrw7TXBW8EnhM4Lr50HOZESKeCR80dX8rTDF/4av8AmgL0T3ai0gT2h4Dqzpx37YytGVj3Gnxc09yHIY2AWbkDmUocS2PE7FFGkqIN+EgAb3ykn0ubLUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL7YcLUpyzlaM2e48ee1XWh/3qwaEdO79lQEuvsk5gw=;
 b=weXUMX4cRY3YaXqE+L7ad20Y7z5jftsLOwxNnhgwq0KxnU3nOpa8NBe9CW/GV/SuDgOeKe8IQ7RJmjMgAZ1p9JahE5Maed04YfpsQHiga375kfhlNSTc8a5Ar1mL8u6STqI0PdKudgK6CMQVJVAw64DvO2Hm3nml6bh8M5QXUEfHiHCtiYK2f3YF+M1J/asDtcfkcaPq+yAl7YfT3D5a72VUWK6Dc0y7OjeGTRLIPfjXzeyi3m/J69TuCrpXgsKwxFqtoz8UpAkL6DmTdvuUzPd2NjQtyK5EOB4ppMiC74by2b+VOK6c8+QS60A0nl0+947GSw0v8qwgP43zRM/g+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL7YcLUpyzlaM2e48ee1XWh/3qwaEdO79lQEuvsk5gw=;
 b=kly/rwuCZv1qu4njJ22YLzlljMkVHuG7+fBud3z6BenMVa30iDOfKPZXJRPQz03u5ta8k782NZsG36CvZkJQ/2/2WAlgkYVZ1y98/DBP3N/n1sCs9N93NiniOv25jKGL6zyvA5Z9K4SNZknhRwrZHqK+okzyqp7gj2hA+WPhymA=
Received: from BN1PR14CA0008.namprd14.prod.outlook.com (2603:10b6:408:e3::13)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 09:03:54 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:408:e3:cafe::3d) by BN1PR14CA0008.outlook.office365.com
 (2603:10b6:408:e3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 09:03:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 09:03:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 04:03:47 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 04:03:46 -0500
Message-ID: <e2a7a5c9-0886-4130-894b-dda93854e36b@amd.com>
Date: Wed, 14 Oct 2026 14:33:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: Preserve names for aliased EPP
 values
To: Mario Limonciello <mario.limonciello@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20261012205559.3421297-1-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261012205559.3421297-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: da7d53c4-5d58-429f-f69a-08df29d2127a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	gNm4JY1tnsy80tZtQHZ63RzF65veSxT72fV70jdPS1gBL9R8d97Y/6blPlhCfmb3CUqOavpU7gSSlm8Of+PPpKALMeTCttOlflZ00PT4MiChl3dWimb2lDZkr8RsK5jKcoJchVmILxT+0VSwDE9lN7B804QmwsfDB7gP8Hg1zLQEmSNbMdHoGbGR4+GnIa91yg8gvYUOkn/lXSirp6Sfw4zhXGNMbMC1EQU/xMZvPJVFJS69vn4LCkcc8L6/M1nYIvMX+kQidryhKGXbvlvNOvegDE2i8TgNK8taxTBW3t8GeMtyeoZsBReIyyQtdLYf+nrxwy2Z7snJ5TKCpIhlHZO5Etj/D94oeArJMtXixurqtkPm4t0fUw8ChBqZOUQRKfchwoktCJfuBI0R4UFiQjvMpomyWFUkIbDeawJwfRxgUNGgQz8MHhaUb9/BJGXU6AV65EWw2sJweyIPHbqk590DQOULFXC81M1gg9O16kYQd8geQYKw0DrDCF5yIMT7FeYJi4cu/+hE4BSGXfUNvYVmrU2bViCyEPY/xMIiLjVKIGbC2oVqGNw7Yw9F+AOEjij1ddxlK57FX61zxgV8mvavzU2FGxs8tUhtCYk4OYRS4x0UW4acoBkISKASizjmtckD4uc7HZ+PEQYKHY4dSm/7l2qF/cttqcIPry8nFdqMHfKcrmhwYjXVW64xJZchBbEoNf2hkAJyF5T/XpYNbA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GGR2yI0gjaxLxf32MWx6ZdJXgCr3bV+f47wRTPt+LAd7yY+mnsNeQ+wNBoJcfWlQoBArpcUl2f1mOxkFhemfLrZHiOmn795LZqeL48uA2PxvMvrR7DBTNxorw61iXRavehzSnBPYyM2/12K1XA9GAxlnug0EdraYSh/mJbMxUBkBFnNjO+LFj2XlWsXmvgOwYqu+lcRUWHXKroOfCeytweZQhdDr2y4Vl9Rk7hViNdtvCbUPwmOQ4CdI1B7wPCQOFndZnX8ohAlpb8oKKurHJ0r/PNRthX6TdGS7dfR2smxVhYZesukLcC32q254UZQtzqqLD7DxbcAw7FuuH8S/wJjvUCyutnnk9Z8NbDXDkAptWGRiG6LeQj030w2scIwHwYRnQiBZYN67lRL3BQ+rw2oJHF5ZGorW4k0qr8qeFao3HK0ytMzvyLwzigsG9emI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:03:53.9425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da7d53c4-5d58-429f-f69a-08df29d2127a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536

Hello Mario,

On 10/13/2026 2:25 AM, Mario Limonciello wrote:
> Zen6 low-power cores use the same numeric EPP value for the
> balance_performance, balance_power, and power preferences. The show
> callback currently scans the numeric values and returns the first matching
> name, so writing balance_power or power reads back as
> balance_performance.
> 
> Cache the index of the last successfully written static named preference.
> Return that name while the cached numeric EPP still agrees, retaining the
> numeric lookup as a fallback for boot, firmware, default, and dynamic
> states.
> 
> Make the unit test require exact string round-tripping again.
> 
> Fixes: 52763c00945a ("cpufreq: amd-pstate: Update Zen6 client EPP tuning values")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

One small nit. below:


> @@ -1548,6 +1551,14 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>  	if (!cpudata->dynamic_epp && cpudata->raw_epp)
>  		return sysfs_emit(buf, "%u\n", epp);
>  
> +	/* Several named preferences may share the same numeric EPP value. */
> +	if (!cpudata->dynamic_epp &&
> +	    cpudata->epp_index >= EPP_INDEX_PERFORMANCE &&
> +	    cpudata->epp_index <= EPP_INDEX_POWERSAVE &&
> +	    epp == values[cpudata->epp_index])

That checks seems overly defensive. And I have a hunch ...

> +		return sysfs_emit(buf, "%s\n",
> +				  energy_perf_strings[cpudata->epp_index]);
> +
>  	/*
>  	 * Map the cached EPP value back to a named preference. Skip the
>  	 * "default" slot (index 0) so an EPP of 0 reports as "performance".
> @@ -1980,6 +1991,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  
>  	cpudata->cpu = policy->cpu;
>  	cpudata->cpu_type = cpu_data(policy->cpu).topo.cpu_type;
> +	cpudata->epp_index = EPP_INDEX_MAX;

... it is mostly to handle this case. Can we instead initialize it to
the correct index and say if epp_index != EPP_INDEX_MAX, use the
index to derive string always?

Something like below squashed into your patch:

  (Tested with amd-pstate-ut on top of your patch)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8eebba922219..1f64726348bc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1504,7 +1504,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 			if (ret)
 				return ret;
 
-			return count;
+			goto success;
 		}
 
 		if (ret) {
@@ -1533,6 +1533,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		return ret;
 
 	cpudata->raw_epp = raw_epp;
+success:
 	cpudata->epp_index = epp_index;
 
 	return count;
@@ -1552,10 +1553,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 		return sysfs_emit(buf, "%u\n", epp);
 
 	/* Several named preferences may share the same numeric EPP value. */
-	if (!cpudata->dynamic_epp &&
-	    cpudata->epp_index >= EPP_INDEX_PERFORMANCE &&
-	    cpudata->epp_index <= EPP_INDEX_POWERSAVE &&
-	    epp == values[cpudata->epp_index])
+	if (cpudata->epp_index != EPP_INDEX_MAX)
 		return sysfs_emit(buf, "%s\n",
 				  energy_perf_strings[cpudata->epp_index]);
 
@@ -1980,7 +1978,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	cpudata->cpu = policy->cpu;
 	cpudata->cpu_type = cpu_data(policy->cpu).topo.cpu_type;
-	cpudata->epp_index = EPP_INDEX_MAX;
 
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
@@ -2030,6 +2027,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 		cpudata->epp_default_ac = cpudata->epp_default_dc = default_epp;
 		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
+		cpudata->epp_index = EPP_INDEX_PERFORMANCE;
 	} else {
 		u8 *values = amd_pstate_cpu_epp_values(cpudata->cpu_type);
 
@@ -2037,6 +2035,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		cpudata->epp_default_ac = values[EPP_INDEX_PERFORMANCE];
 		cpudata->epp_default_dc = values[EPP_INDEX_BALANCE_PERFORMANCE];
 		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
+		cpudata->epp_index = EPP_INDEX_BALANCE_PERFORMANCE;
 	}
 
 	ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
-- 
Thanks and Regards,
Prateek

