Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBF2BEC2E;
	Wed, 25 Mar 2026 04:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774412310; cv=fail; b=sqDEQsS/1D4Qr9Y53AXsiXjb98qD0n+/GbsRJ6Ct0KAglcz0qW9VQ53QiDD8KAoCuzjyG3aM+Dc3PgTm0FU0TXTEhB0tjGokt/YdDwj2S8d1rAjjdowNZW1MD9B9mTQYTN2DHOj1+4Dewsya2wug1aOz3v5IeczI+FMgBFNEDA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774412310; c=relaxed/simple;
	bh=pfDJ2Urd41jqrLFwxVuI+hCcazjWUBKJYb+bynw3CXc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Ci/u++ynluQr8Sm5ksJa2kk2rYhbbL0NqYczObQXj9MOY3NvsEFw6FF4Do5pdRyTNF0mCDSXf/MELPzt0LYL00hd57fVg8eBsqZanFEKjIXJEA4WxCaPOg2CkDRezkgzc76+XHy81qWAgPCRYYntSnmC1xPvEIJCexlCLMQkXzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=STS4isM0; arc=fail smtp.client-ip=52.101.61.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="STS4isM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUG90yPMufNiCpWH0IkKxbrRqnBN1/EKzdQ8EE/ST18fbW8gNs2XIFuCdBXveHFBjmbNVaIdcWcD2nhAi+FopqrrNG68YL25qyr/ngggXnI+2LZbn21Uql182k9TdSPPZlzTZ85OttM/INkvBOGD5ej5YTZNJY0NQ19+146YiGecTHtYYsVKtQK6NmBc+T4GSOIfMYDrKTLCQJm/S/Vmp7JpKTOLfnFYh6d86DK+scNWnSBW0E/6B296tbaukBLC2+noFZbuEuWSrIyagXDoTR5OJ7VJln1nmOMXqKkU6TgOS48PI/aLSW/e6HBtaaWe+cSxpUmcx5f4p3H9dkBzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWInjNjjIdZOXwmXN7szVsu9Q9dSrCQsX/Qlp804txY=;
 b=LDFL3F+doDt29JpP8A1qAjkJGLhjqa2mFH/Ltkn9TkYb0TXZWgA1a5NH8aFwiHY24XzXqxgCRFZjR3oHPvcUmOUFMS2sduUkU8HJB7+vOWM0U6D1UWUWdVOwpgyIWNvQlOfFKI7PrpoLb9nP3hfuvrV0AqHLHWPS7TWdvHrt6/dEtudyZA08Q1Oyt6fwa7OXg/Sea6ZdYd3UJncPHt956In3f/nE6P2QolHnc8V55CElTxoqmeQXhmFPZ5M9B2Zyv2mX4dsOSVo5ifSsv1JvUIUyHUCzvcM+GOnbhrEARa3uSs697ZAU9oPvW0HNUWp06SVl65quAtdUA6qF+a1obA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWInjNjjIdZOXwmXN7szVsu9Q9dSrCQsX/Qlp804txY=;
 b=STS4isM0D2OM59re4JkTs8ypjNo45BnQQzxkbIz8c4nQ2hv+0o1kcWNCSqrbvf0boF/unH0o5SaBjB1lLlOQLsf9rpdiDwVg29TNVUfiyiRL+SFHnspl1T9KSTRP+CdhbzoerCzqeyRVCLOGdRWvlW1NPIwCsY4yFA/qfsToyZs=
Received: from BYAPR03CA0032.namprd03.prod.outlook.com (2603:10b6:a02:a8::45)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 04:18:26 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::4b) by BYAPR03CA0032.outlook.office365.com
 (2603:10b6:a02:a8::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 04:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 04:18:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 23:18:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 21:18:24 -0700
Received: from [10.136.39.136] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Mar 2026 23:18:22 -0500
Message-ID: <87d583be-89e2-41be-94bd-21ce04b986dc@amd.com>
Date: Wed, 25 Mar 2026 09:48:21 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] amd-pstate: Add support for CPPC_REQ2 and
 FLOOR_PERF
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-6-gautham.shenoy@amd.com>
 <48262f07-a852-44e0-92a0-1215bc48e9cf@amd.com>
 <17bd7fa9-bf01-4ee5-b3aa-cc75d6409cf9@amd.com>
Content-Language: en-US
In-Reply-To: <17bd7fa9-bf01-4ee5-b3aa-cc75d6409cf9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d38163-0b5a-4765-0412-08de8a258f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	E72qrWL4BY8n50ISYMOHa4fI64P9i+TLAUSd/wx1NE2pi1Mt6j57q5yp1Q2L2nK3LxyWdqup5ONazLV7soMEhPYMAb1PF+Kbb1zwxfzNSecqLjV/1MCSs5Zl5BXB3mOgLrgqilnp5Q6ryx3oazAGpM2Q9N+mfAC8pmSeD+yEEv5boSYiWKc2BCFLh9bF34VMIcJeXh91ZbF/UCngo+Q18zPpPCC7Ek+RMAOhKJWxpej+B5Qp44dqbhBEOrWNI0A9oSzsogTVOTGe82ixdbWaWGrhK3xtEpViREZbvh1FpWDT3Vk28zlCZw0zDW+OeD3dbkP3zKCqpYO7JUQ0LrKJA3nF4/QkyV7A62PEWRZB7GJXEHkhkGr/xOwfzU7ay2hi+zknqZDE+dJkUXP+62WKuR65epiOjTRAi1K3EtePzDK8aGexAc1on+wMGLVkfL4od1a9mSDdO24nYOkfVLDkvAUEuy23/TKvgqaAFjuneEhKLxTpOrDJRmoN83UPGeZWXlmyVoIgcdS+XADKv82PZzdGPahS2iRgv3bNjV4Vz5fMKsIJ1l/lRFx8AGkl8l9fPhg7hCECb6suqAzPw8fkKX2DyVgOpGcWmkT2llT6cIfo5AiOTB26hwA0gjtnnAwdcCtNwT0Kc9k7bJ3a86zpqmiWp/JCGk0En1YU+Ix3+N2CuPqVxlWhv0uwCFnbf6B0Q018kS1nStAJFcd70jYtCHbP4XhujrK4Mj3TJdHJS9I4nzPSKkRLLUBSjcCRNba2a+3R2iTESY9bv1OAIVvHMQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y0vWgLH/83MTlWKaBo7Nbr0iAjAdRY/8/iN16HsZ77DhAXGnd7TaPmxeP6WNG6WaPzy8qJFJjjfHWyo+OT/FG1R6vKVOBBWTrGWwoCDCRRffo2pxEos5iJHCbX2JNndYgVuJBblr2LwfwANVE+XsYkPFhmRvpM29eOt6315xvAc8CHt7y86cuRQIe1suEjl/lWiS64MLpA2Eg7uSglvb96sY6VyapXWzi+5gug0aCYQqerCLhUoCN4M3aflQHhx2X7XmuTJ/rG0pGTqlarIpQB2RELsFj7b7FJao+2gFsNHMQJ+tta9GtnGzohV4/M27MHesRPuzNuEI7SMnzeOSSl1JsAsDHLc2uLsDgJcxbWZ5F/VlF0y9Rw/gY4mP1ZU89TVvuUeNPf+V51ijeHhrNbQrMHMQvrDcJ3+mRBL4FajSnWnulYdttuhyhTUq6iQc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 04:18:25.4254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d38163-0b5a-4765-0412-08de8a258f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464

On 3/25/2026 9:39 AM, K Prateek Nayak wrote:
> Hello Mario,
> 
> On 3/25/2026 3:08 AM, Mario Limonciello wrote:
>>>    * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
>>> @@ -87,10 +90,13 @@ struct amd_cpudata {
>>>         struct    freq_qos_request req[2];
>>>       u64    cppc_req_cached;
>>> +    u64    cppc_req2_cached;
>>>         union perf_cached perf;
>>>         u8    prefcore_ranking;
>>> +    u8    floor_perf_cnt;
>>> +    u8    bios_floor_perf;
>>
>> It looks like you forgot to update doc for bios_floor_perf

Me realizes you meant the comment above the stuct! Sorry for the noise.

_Me goes and grabs a coffee to wake myself up_

> 
> "bios_floor_perf" is an internal detail that caches the initial state of
> "FloorPerf" from CPPC_REQ2 when the driver is loaded.
> 
> It is only used to restore the FloorPerf to the original when the CPU is
> offlined, the driver unloaded, or when the CPU is suspended. This
> essentially resets the state of the CPU to what it was at the boot so a
> kexec, driver switch can start off afresh from the BIOS defaults.
> 
> User can read amd_pstate_floor_freq just after the boot to know what the
> default is. Do we really need to expose this?
> 
>>
>>>       u32    min_limit_freq;
>>>       u32    max_limit_freq;
>>>       u32    nominal_freq;
>>
> 

-- 
Thanks and Regards,
Prateek

