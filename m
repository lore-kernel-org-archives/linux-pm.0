Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076D24886A;
	Wed, 25 Mar 2026 04:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411800; cv=fail; b=TO1a2RxU1F6OdI4Iv1H/rUGsrDospIbYlIu8LBldG6FwY+Du3yhjCZJ/YXMhLDFc4ABxbbeSMXntFpp1qBDKGrJDV2/KdAw8rev0W2VAhPiv6ijlCVi+UCfiFd24nMz+mmrlV/mhguu3amWOfApY1VGfQoEJ7A7Asd7KF8DM8BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411800; c=relaxed/simple;
	bh=Au1NkM11Zutvb16ESTs77YhtJS8Yz4AYdpqvHxDYt/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WK61LZIWNASU+jJOCZD8jnUNg3fvLjf1yoSZMzPcGPZHeM6wpQaSf8airR7HHmRMbzbbiZKBaeevPY0Gs7zOI7wEs7DVEqFnHr7Oo5Jl5OS+oZQQ5LhFvPqn6CndrZ7SDxH4gF8zdr+sWWf93X6mF2jA8Yn6l0M6XrC/UiVCnwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cgkMxrur; arc=fail smtp.client-ip=40.107.200.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cgkMxrur"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/AY+aUYLjqlscR8dwIn6OX5h8KWBbsgNqh+tAeKTSkEIwuzTJw+Z2PWAYRWDoX2XmJugPl3DnvjlQDeGZosnXvlCrMN5N3wVRyRQukE8pyA6IEhTt0l1yWR/bzKamqsyhiNe+umRyw/CXUskFiPtg8AMOgelToBnsxBiMiEWjcJ/TcTJm1DbzPwCS/A+Eqn/8+Qqdu7N5MwBE+1gyGM/x+wHTm0WSkNJ6My+oWBCBoXXXZkJHPZ1VGyEUI7MvqeFJR/Tlw83F3Haohoz5Qmj7uLj8uaPyrDjRjXMg6ckqN/2f7UggPRZnk5AqSAkb0EjAN5d703dSr2GW5DFLaOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4PL3/Yg0p4uMX70k9+lRAAlF8NcfbwNiutL/lKz9ME=;
 b=OWUPyIaBF/1Rwc84w3kjXDiad09NSgmfTRJeRVYHx2LtvNrEn7eK7yAeynw9FO/YaPvFoX2o0tK+eOGZj1ecATmhmuXvZC++YOBExaF1Lr5mcrVF+40YICHTkhz039J5cTv92S/wB+qTLp8kVGa/ffGIKd5cROK+/BOciqwB8YvYjJ1W7ZqTYN/eKPu/5WfoRAHIBP38m94S4mHmjswFeh+HaLcIvNvm+a12kvEQuXQo58/V3EPf5qVN44VDl/xVAK+5QLIIMTHCxt025a+2c7ejUdqCqfbsLRBWsV339RSaPOCdVlq+vnKXYT5ixht/25MvUwob7Jzex/PkcBKSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4PL3/Yg0p4uMX70k9+lRAAlF8NcfbwNiutL/lKz9ME=;
 b=cgkMxrurDv/Mh/v2wNAsYSdvfM/kXCDLtoiPuk/iMHCJPpPvibRq5jHlc0rYtF8fHK39w+4lNVrN+5O4KMUYlHnWMQtDbz80FCRYHaNHjecjRQSt1kbdTjovIaZwfOAvRspKBaCn1DiChi3YXxTvTT5XZgKYl1pXPDJNbcW6zeQ=
Received: from MN2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:208:234::14)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 04:09:55 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::2a) by MN2PR16CA0045.outlook.office365.com
 (2603:10b6:208:234::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 04:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 25 Mar 2026 04:09:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 24 Mar
 2026 23:09:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Mar
 2026 23:09:54 -0500
Received: from [10.136.39.136] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Mar 2026 23:09:52 -0500
Message-ID: <17bd7fa9-bf01-4ee5-b3aa-cc75d6409cf9@amd.com>
Date: Wed, 25 Mar 2026 09:39:51 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] amd-pstate: Add support for CPPC_REQ2 and
 FLOOR_PERF
To: Mario Limonciello <mario.limonciello@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-6-gautham.shenoy@amd.com>
 <48262f07-a852-44e0-92a0-1215bc48e9cf@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <48262f07-a852-44e0-92a0-1215bc48e9cf@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 36845a46-2b2e-4276-f372-08de8a245ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6ux0J41HvbJ+QReQR+dNPfviboBfycldVDLJsMcuKbhmwpJVqcD6+ETt8Rv5XoJCGp6W5reRQfrszEV+njhyFL1Pj2DzgCZIdw3e12xRj949IIbexa2HMs7b5+gUKITCUboSK15uAR7nYc2l2bfSOrUHpQ3xMLlyvqZLpFRCIBSPEGp1BemfU8Vbk6+SnwrqVl6oGVVV+LwuZzcaTHHK3HN6hWb/OcUEMHDjXp6Mr0xbw8zxYO+F/a0DbW/+5innHJIrKdSdUXZphDFRV9n5k/Z48qd+oZIR9epxisBEuUJUYnYi3NU8QUAvVaGF4o/VF836QQnkua6IXiXSwEQZea4HdvtHgddSuhiDTvC5sd446QKU5KoZvgfmuEgja0lMG/6M3pVZSUZF8zTJMtElRnJpaIbe9nKVfvnmvTA8WXvqE3J6+kD/RctDETWS6e3D9Plna9jsyvqEDTfc8PVD9ycYhTV5aMZZVe23gSAzl/2gxWsLoXO1tXUd+G1EymNP+rzgH7EuKqcHPmkYtzPuBUIoqHDstjkJlc8McpkOJcP7zQiCa8NiG5fUvCmyIBpMtajJGaCmKwt9iO5/K6tUOk2bFZkCNrGsC1/R+TBRaqLV4urmf42nWs3z9ZjQIC/qxuMpLucxBZd3CuDTPVFSbc+523IgHooBKR/ND8hRIUNyE1Nv4g0Ppja82QiL5DH1ZvcJD5L5yBvwVfc0yPJlUyYefPt2LsAGU5V6GsmiRA9IRD7vq4cmmaBuVM//UgI4xXFG1z8uaY6AS/MKXIph8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6AWOOAdGf6hIuEXLrMAueltcPVNJnXP+g5Z0j1dIaxhheYIXqJlPi2sRJXi2ufAUmwQAmWGxegvsMrB60hzzfNHwyXVjzqn9LNKOhMtdixC9+sZHXF4VvbbNp/Kj+pEOVTk+XpxMjL6bGXm+Iu3YSNt2hgynMv/EaM+KNDDvGV5KXKa6L+4Ta0ueAFOILy5nl2pUSLloYjZtQWv/76eW30JKt+7a/rZPUM4eZ4T9xF1pUa0bOREAN3MQyJ8S5owXuf6r3swfQ6xfgh7NWzilTrocmBX35e3PxuEcq4GGBvHc7fOfavN4wyRtwZwBvK14qpVIoxcnhdQ+8tdk4fVUV7IFo8c3TqF8k6SoObH3MU6nXvKhCo3pgXUCKEeiMV9NZI3PDLpYZOlviobSjoYaCd5pFvpPrCgUVPRuymd4d0gwwwDmH2B8owFQE5p+2vUE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 04:09:54.8218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36845a46-2b2e-4276-f372-08de8a245ee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003

Hello Mario,

On 3/25/2026 3:08 AM, Mario Limonciello wrote:
>>    * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
>> @@ -87,10 +90,13 @@ struct amd_cpudata {
>>         struct    freq_qos_request req[2];
>>       u64    cppc_req_cached;
>> +    u64    cppc_req2_cached;
>>         union perf_cached perf;
>>         u8    prefcore_ranking;
>> +    u8    floor_perf_cnt;
>> +    u8    bios_floor_perf;
> 
> It looks like you forgot to update doc for bios_floor_perf

"bios_floor_perf" is an internal detail that caches the initial state of
"FloorPerf" from CPPC_REQ2 when the driver is loaded.

It is only used to restore the FloorPerf to the original when the CPU is
offlined, the driver unloaded, or when the CPU is suspended. This
essentially resets the state of the CPU to what it was at the boot so a
kexec, driver switch can start off afresh from the BIOS defaults.

User can read amd_pstate_floor_freq just after the boot to know what the
default is. Do we really need to expose this?

> 
>>       u32    min_limit_freq;
>>       u32    max_limit_freq;
>>       u32    nominal_freq;
> 

-- 
Thanks and Regards,
Prateek

