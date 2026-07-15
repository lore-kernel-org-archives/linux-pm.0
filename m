Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399093C10A0;
	Wed, 15 Jul 2026 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148482; cv=fail; b=W5eJPtwh3fMbPa2FpBzYfHY7FCiezyWHh3GySdvN5VCVogmXQSNbtJPhQxSAgJEYFUQY055UVBE9yCEriVX2DvARDLUnD8lOiQBVfSmjQx+3kd/4BLWdI7wB4aPaheV3FF1+e0/OTCNF8wn7ABmt/kXieT8COiXmh4vWB1P49F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148482; c=relaxed/simple;
	bh=FWqFltcZxcTOLhu7DqNvOyO0lmG+bji7dQC1NVQX3+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G6hVGDSgfy77DGmqqZ7oMHycPhuZxbZl4idAh8M6lrBxBmDjmx8detSpscmxqV1thV1t40Jt34Mpqg4cKXwEn0v8XcO8c37psaboLXmhSH1/ayW+yLu3yuZEOnJM8vbXTBTCzCbrvY49a1tOnhxQ3NmiGWRQL8BWu+9yABP8BG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cXDx3BcG; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cXDx3BcG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bb71ykzlvPefstt7NsbUBR82sTprS5bzO4DNyxESFKfr+phbrxZVYzoSSkLigeGHWNiMzY2xANyC6I7rj0p75FyjjPZWP2A74HPUdHFFvEdnFfUbCQ2xpZvQyDJJ/avhIRN1vawpBSaady+1ALRrQ4pZkcxN2Q+ZpJVORYMZ2Y+NctIx7Or/Vet/7LkyfkVFHZZtrZwsNDCZ5PDBD7C8pqMTy0W5boNEu8YPVxTCJBTW3oOSqGRfnQKrRhoINvYNsbTRzQGHtHxhRCN6tXgoKl7F/M1ZsKpjF5aDWdnVTTciBRhB4I412uuDB/s4G5F2AVdQqvW5u3yXEQEv3XXE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTffuj54qVqTSvgwXaAAt3SU6foN55djpv1eDRmULZs=;
 b=OXWlVHvICESzG+N0ZwtlAjmCP8+tREZjbY+cDr7wdS4Mtdd2Wa+gY7Hm5fdnZW6R72ViRGaN9Rtz+1fJuWorwYHYkKOT5cuS2ACEAV3liGcuh4Ok9Bunv7QSkcrI8yCWCEaDOJvEWTwUGgmuWZn9Kt4IIfgteCnZ0Myt94OprbIXY/ZMvpwzNI4EBsf+rhjnj0fz/FZaq0xsBCxtMMYpWkW1aia/HNThPLgbCuP3CmazRnygNwLfqf6kHh7ZV+LoIGyoz0PoMMXhlcXGE5jYFHwtSOZdQbK6Zuzjwf4c5biY4tfpoRsDLPioBiVFvWhRrzW5AL6AqKjD3fzX5Sb7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTffuj54qVqTSvgwXaAAt3SU6foN55djpv1eDRmULZs=;
 b=cXDx3BcG92L6p68noRvAdxailDOz+46gpJCDt0tSxjq6MA13hpbcQLpLN4wHs3TXIwGUrB0pZsl1Wier94kq/yJNr2LfzOL8cbTjAHSZciyqSGWcdIWuBQ0+OMs2WxEvfo2YTp9KbDVmTqiOtzSV2mzyrvF5YdUHaB7Tazl5yFM=
Received: from SJ0PR13CA0079.namprd13.prod.outlook.com (2603:10b6:a03:2c4::24)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 20:47:56 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::f3) by SJ0PR13CA0079.outlook.office365.com
 (2603:10b6:a03:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 20:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 20:47:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 15:47:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 15:47:55 -0500
Received: from [172.20.46.244] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 15:47:55 -0500
Message-ID: <61a141cd-c72a-4ee5-8273-ee721aa13f68@amd.com>
Date: Wed, 15 Jul 2026 16:32:53 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
To: Rong Zhang <i@rong.moe>, Borislav Petkov <bp@alien8.de>, Mario Limonciello
	<mario.limonciello@amd.com>
CC: Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
References: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
 <0c55d331-bf98-4e6e-9de5-35803ead3c0a@amd.com>
 <20260715180454.GAalfLxn3Wyu-fRjoT@fat_crate.local>
 <ecc292377a145741f47ff2422b72fa95e57a725b.camel@rong.moe>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <ecc292377a145741f47ff2422b72fa95e57a725b.camel@rong.moe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eacf181-60da-4b49-ebef-08dee2b25977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	eGCPXd0Iw3bYl9rDZ259U96ysVM10MYKoB0WA+8/hSz3wiPRvZnaiEHT/KHsAraRpCO8Nduj30ESOvOwqAg4UsxBECh/4SWXUR6WLN0sWpZ0hQmiRbAolRyNBmhumqVTQPqSjmsTjy/HmmvJqFjMgAteM1ljAO8zbusrv4hgTZu4CjPC/E3Vh2hCjWnB23j+VzTBmzeEW/4UGW5OaGFCXVZT2pT5F6VjASMRI7RyB6c486Ba9U6FO6BEsBcWMZjfb7lQFX8s7BpBoHiO6a6vPM7BF61SfvzIA5cBmqw+GZ2ADLwUSMiOS5FVosutHUqdNgm+1WUJyQe3uAHUMte7mDwl19Cm1hQ/kXv3yp2xjtOIWE8DdtfjZjngOfaWMTKBm+bMlNE3V0Pvh2Wch2k46JoHwFnuvdDJjBnx/IBK8Q9qu6mdIk0GjD15OUDHD6CKThg4r1xg3u3P0Je6Lg046A/vyPdwJR2fPj1unRBR1VvlrbAvMRIX8PsW7NTCWU6rumS6gLhN4U87cu5QL4Y1ZMnITtCyEkwqBe10qjrDX+KZ+0ufE9cDlKthWUtVnpGkg0vp3IwYoHRZTgx0S8LSS5lNGFNY/SRRTAMaGAugiGakSBMRqY+3v+huR2itF/0COMsdG35d3t6xrk8wuhI5f/MdeeBBAltiWxCpY9ef5pdilXmMw4XAEtc888p/2UsbKnE+m/Yo6ooRqFgJinkpQw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3wIzV/PEaO6qq5eSL4eag6nrr3gNLLApNBCQXibOjzVYLPClG7T/HB6icp1onmd3JGSTpGxd3q5/aKNVVjXf7mg9kbZi5tf6H4kgXIwqOusRN/3yVDA99XY2Iu8QvyRPqodSPLKumUdd1zyWk8JdvpcyZuz0k8jARbbLdN4KJJlNfgVAds+uvro1e6PW7rXxNQAKmynPHDFzNRNChO5EolBjcmJ425zqjzThMKTn/klBXSk6zFo6qzwbvglkjXoKU/r22qwoxmM8n7RSV8QwDuTgLgvqI0exciaa84KVT6VEjUrvezHn67JgBYIHN6PJBLGca+3jW1AZ1s9gxYaF+VB14CDPgo1jQGhSBFf6TpQU6Syr4HuLOB1IJ8sBVBddZ9qPo7DHNIiRqWnI/d2M2HwMq4v96LtAusCY9eX97+FAaCNwgq0e/kck/cuay/Iv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:47:56.5009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eacf181-60da-4b49-ebef-08dee2b25977
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

On 2026-07-15 15:21, Rong Zhang wrote:
> Hi Borislav,
> 
> Thanks for reviewing the patch.
> 
> On Wed, 2026-07-15 at 11:04 -0700, Borislav Petkov wrote:
>> On Wed, Jul 15, 2026 at 12:46:24PM -0500, Mario Limonciello wrote:
>>> Conceptually this makes sense to me, but I would like some comments from
>>> others if this is the right way forward.
>>>
>>> Jason, Boris,
>>>
>>> comments please?
>>
>> We don't care if someone "passes-through a relatively new CPUID" - I am not
>> sure what that means -
>>
> 
> Sorry, typo here. I meant CPU model.
> 
> I usually boot a KVM with `qemu-system-x86_64 -accel kvm -cpu host
> <other_args...>' to test various patches. These messages is a bit
> disturbing to me as they are KERN_WARNING messages.
> 
> FYI, my device is Zen 5 based and always triggers both messages.
> 
> I can also reproduce both messages with `-cpu EPYC-Genoa' and `-cpu
> EPYC-Turin'. It's just due to how amd_cppc_supported() is implemented.
> 
>> but we won't patch the upstream kernel just because it
>> dumped an error message in the guest.
> 
> Well, the reason why I decided to send this is not only about how noisy
> it is, but also about the correctness.
> 
> The first messages says:
> 
>     The CPPC feature is supported but currently disabled by the BIOS.
>     Please enable it if your BIOS has the CPPC option.
> 
> The CPPC feature is neither supported in a KVM nor disabled by the VM's
> BIOS.
> 
> IIUC, it's disabled by kvm_cpu_cap_init(CPUID_8000_0008_EBX, ...), so
> the upstream kernel both disables it as a hypervisor and warns about it
> as a guest. What a paradox!
> 
> At least the first message is nonsense in this case and the paradox
> should really be fixed. If you prefer preserving the second message
> ("the _CPC object is not present in SBIOS or ACPI disabled") as an
> informative hint anyway, how about moving the virtualization check into
> amd_cppc_supported() to only mute the first one? ;-)

I think changing amd_cppc_supported() to return false for 
X86_FEATURE_HYPERVISOR makes sense and can remove the message.  The 
heuristic there doesn't seem relevant when virtualized.

With Xen, the Xen hypervisor itself controls CPPC.  dom0 
(xen_initial_domain()) doesn't need the amd-pstate driver.

Regards,
Jason
