Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942C245012;
	Fri, 17 Jul 2026 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256890; cv=fail; b=ohrOvaadDmp0cWI8mxLJoFpgLgZvVqIqvyvsR1l42Y9y8i5ShELfyLaOOA+6l1gr9E0XLOJQK9AXCaESY9jRfrhe/14822jfynVtxjip0DHjjIOJZwzWYAu2CdS5Ha+umLp1HNjlIzYDr0deUNx1lhQIFksK+TBjMZmUz0SpZZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256890; c=relaxed/simple;
	bh=w7f0iIBQprEenVlAT4Clsr4mJknJDo7XDOuy/orTpwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bgk8Wn6bMc1YqQOIkucB8ZzEWyaESO7URmZ1mJvVAlBJ9NxNDYnp3hmMjyBkKZL7E6N+TsyGr2uBFv20IK9nNSO5DxlBP+O/PlchyF3rQmTFHl1qOESYrrMVn9IJpNtO/R0x/VblsKKCPTmjZl3hRTXtNbRrzMxV26EBnRAYBpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZONwXReo; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZONwXReo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TG9Hi7HqzuMLf3IQdEhaSwKeOFmwLLohfpEmsm6y+EgHsMZJxfbzfcZRJaBs7Yh8tj2zvk0eAcHO6+/ZF7kPRQP2UFYYeE5MyIy7/XyH5FhDnmL6x7hQ6exrE0FevxEAYdx9N4gWgAwA6kDbqPLCBHtZd6qQsAbNZQ1tNawssQ7xxFAP/uWS3ypU+9rc2scd3nLlsjp64d30EyeM0rSN1CvFWMpvY0ND0GZSn3E+LzrUS0uHE5IHTxnA9qY/pxNy9vN9JesBbGawvBkGDyKssSQtxg3CnFU+dcr4fRynoZy2M9mJL3xWT071I+dkGED0BzNaL7CigkHs+spRR0JH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g51sNCnxOBmHrChOv2MutFwFhgfVcd32FAxKcu8hqUI=;
 b=two++XE7KwZjz3tP3tt5GW9uGOHDZ2VDDFyNZPOXbGerTA3bK/e8sW4ERlV10XHLAGesVGxk1KfTYXCrqnL2lqdlS6XiITGV6Te9+OqHNjqjOF/TMYbmJVeBKbcvYWSJ7JRWxX1bJPG0TP/0dldNZXqR1FnrG6Vdms11b4lQzN2HLfIAl9OzCyEmo5QthznNlwAVO2LZcuOHNGMhYIQ6b2HZV76gWhYQCAWMy2fVs2X7iy2tzTlOL0Z3qKHGmu3vqX2z93jVcSNDOaVaRsX15/buUqNVG/NnKe3tmEDG/eoHAS9jDKGwzkLFXhB+RJnEpjOm94kVNwvD59utvsGlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g51sNCnxOBmHrChOv2MutFwFhgfVcd32FAxKcu8hqUI=;
 b=ZONwXReohssAzjlFfJqCP2GOPP0eZcbp/qRDAvyIiFRJLEHYhE614SyA5pxjsTTjp5SmmtC6P/1uSRXkZnzD0t5BO7CF24zoT/XNLjZA2vZ6Yz5cA3wNaGN0dOW0Hys7vy10QNyeoqGqHi6MqEzwoh1PevaMHLsGK/jldECFqZQ=
Received: from DM6PR06CA0096.namprd06.prod.outlook.com (2603:10b6:5:336::29)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Fri, 17 Jul
 2026 02:54:44 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::75) by DM6PR06CA0096.outlook.office365.com
 (2603:10b6:5:336::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 02:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 02:54:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 21:54:44 -0500
Received: from [10.136.35.249] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 21:54:41 -0500
Message-ID: <fdb525fc-bb52-430b-aa25-bf56f05db9d5@amd.com>
Date: Fri, 17 Jul 2026 08:24:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] cpufreq/amd-pstate: Fixes for "Requested CPU Min
 frequency" support
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>, Perry Yuan
	<perry.yuan@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260715074822.16324-1-kprateek.nayak@amd.com>
 <63b26408-d75b-4de9-b3f2-eed5687a8b09@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <63b26408-d75b-4de9-b3f2-eed5687a8b09@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 490a09d0-08e7-4d95-0a04-08dee3aec19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|22082099003|18002099003|10067099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	SQ/YYBoKAR7UEBMTeT5lWMfqzoNVmsJMMXazaolmVX3YYApLcU7Sm23lcyl6L5wMrgv8Q0xstKXHhbpMFT4vG2wDmaY7I7SB0p13N5hWd0qoG/SIossI8vrS7w4rexDDkeghc8T0KuxYqDMcqoUJjnzttFBMdPy02ddb0yQ3WcHVok5e2KrwlBkIBFa3Wh07keHQ2guJtTPTowEHOWIv5QdgUQSVR7XjZg6FHxzTxcQjOISmSb8n24GnXgxlyGvdVZbsluTYe1hvy70moGzVteJTsM0DZBsd1QOtc90fJZws4TJb41T3jAFzHI479fC24KPFYCXjzggXMghQeP6aWlOTDTlsqCvxyjvFwMvnVr94R7za1mXctX3hF8GlJ+fJ8Kn2rtcYPl1pxKMucRRUev5EB9XV5QfnibVU8e0eunzzJy3rvhQ9KXQefwr7LmgmL5XhsLaqyBPHOQRczu9ZgpkFdRfAPed71748WmYIPF4t7kYraTAjxKggpohpRGQ8HT8hymAtggGWs9K7TL+hhNG9ASkxLtPKA9n8S3PEh0tihmDmgKF2qZCJY2rmULKzXkDYKe7GsTQijumD6BozW/rTMxj+OjO6V+TQ4LqhGL7iVimbMxfgAkHjY5dCHyivMJcZ7wXlNbee7iulXQ9xraC1OH5m7gnjTXRSoiWG3y3E2qLm0cTGVK1qjSyryY2GW/QTFtD9ZEZ60z5fUIMJcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(22082099003)(18002099003)(10067099003)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OWiRC1/QB+hMspPEXcnn2ZJ4N/Tqsgb8O9xaEe9FLnlRyJ9VSUiTfqHTyulbgR9lTy+OQmarEYBB8u+UJmrewXdf8sT2ZX9hOPehwNzN5SI8MCNGPzTdZMF+7XCkAFvEldvbxmDcrv0F5C0LOGEKnWo4/wvHFsRmMdjQft/eezmHTKaxIJ8qe61Fo6KE64ZSE19sJ8Wxajjc2A8hkmyBeLt94fEwb/3wS2Bo9ss16+2npmoA0muJv2/TMnS4kFnoDQ6BL+5N/WcTUE1VP0NbzR1RryulWDrageYO5pXWz09qBCaiaRe3Y58k5HhP7aRNX1TSfSawFZswPXqvws/IXd2iJadjjv9qWPYwVxTPGpjA19+ZwRjcvPkmXYmodTMN3i52Rzh5B2HCctI+PV1z6jC1vySlLMe3iT47HMzeK08l1wihq9E0XfZinAOZhOkR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 02:54:44.4758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490a09d0-08e7-4d95-0a04-08dee3aec19e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172

Hello Mario,

Thank you for reviewing the series.

On 7/17/2026 1:20 AM, Mario Limonciello wrote:
> 
> 
> On 7/15/26 02:48, K Prateek Nayak wrote:
>> It was noted during internal testing that amd-pstate active mode with
>> performance governor always sets the min_perf to nominal_perf despite
>> BIOS having supplied bios_min_perf as the preferred idling perf.
>>
>> Users who set the "Requested CPU Min frequency" from BIOS are known to
>> have profiled their workload at different operating frequency to know
>> the best configuration and amd-pstate should use the same as the lower
>> limit when configured.
>>
>> While testing the fix for above, it was noted that kexec fails to
>> persist bios_min_freq even when both, the old and new kernel are aware
>> of bios_min_perf.
>>
>> The suspend, offlining paths switched to persisting the CPPC_REQ MSR
>> state at the time of suspend / offlining with only min_perf being reset
>> to bios_min_perf.
>>
>> msr_init() path only accepts the configured min_perf as bios_min_perf
>> when it finds rest of the bits in CPPC_REQ MSR to be 0. This is
>> intentional to prevent stale value of last CPPC_REQ from kernels that
>> are not aware of bios_min_perf to be mistakenly interpreted as the
>> bios_min_perf during kexec boot.
> 
> Is it a real valid case we need to worry about for someone kexec'ing between kernels that are aware of this vs not aware of it?

Since there are defensive measure in place I thought it might have
been a concern but as you said, I doubt anyone is running one of
those flavors and kexecing back and forth that often.


> During kernel development; sure this might happen.  But I would think once this is available in mainline any of the distro kernels will have picked this up and people will start with a distro kernel with support, or they'll start with a distro kernel without and upgrade to one with.
> 
> I can't imagine a case people will go the other way.

Ack! So I'm thinking of changing Patch 2 to:

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 27cfacd283be..707e1485eb1c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -462,7 +462,6 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 {
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 cap1, numerator, cppc_req;
-	u8 min_perf;
 
 	int ret = rdmsrq_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
@@ -478,16 +477,6 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 		return ret;
 
 	WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
-	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
-
-	/*
-	 * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
-	 * indication that the min_perf value is the one specified through the BIOS option
-	 */
-	cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
-
-	if (!cppc_req)
-		perf.bios_min_perf = min_perf;
 
 	perf.highest_perf = numerator;
 	perf.max_limit_perf = numerator;
@@ -495,6 +484,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	perf.nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
 	perf.lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
 	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
+	perf.bios_min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
 	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
 	WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
@@ -1046,6 +1036,13 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 		return -EINVAL;
 	}
 
+	if (perf.bios_min_perf) {
+		u32 bios_min_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.bios_min_perf);
+
+		pr_debug("Found Requested CPU Min Frequency of %u on CPU%d\n",
+			 bios_min_freq, cpudata->cpu);
+	}
+
 	return 0;
 }
 
---

It gets rid of that defensive check and leaves enough breadcrumbs to
debug any issues that might arise during a kexec. Thoughts?

-- 
Thanks and Regards,
Prateek

