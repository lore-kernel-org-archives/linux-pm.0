Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960B38D3F7;
	Thu, 16 Jul 2026 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224841; cv=fail; b=auXlWTOlI3QofKq4CMW8iwZ3YAQN2hNNfTPSG+7mTybjG04YeAX1LjzjwXGK4ktvTq6V1qaQSMzL9mIHO1MLFOULO7ZqNs3WqUtFdvyw5keySv/GaUBiF8CRHRylom0e1dyYJ+SacZbVyo8+MAyLVXCqQj0o/lZtP0Wo9y8SBw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224841; c=relaxed/simple;
	bh=yvYcXPIvv63w5oYX5033VlpKIfPszmMKoTLA+ZoG8dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jw4XKHkZTox6cJqlNQjy/7wa5Ctt1AGNj7MbaAQLSF9hpvCmX4dxwYmOQ3eXXsxrLqXBPoi+Mc1XvUoV+vakSw7+JXB0nB4S71mwe5+EtAja6CR9CUxUIfgbOcqdPULtVbrmrEf50WTscUyswREkDMBw1uRnlTSV9EtFqCDpTg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aHAJ2vtc; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aHAJ2vtc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cc6NGCMUBMXUDuoLle0kBC7fqeFNOMkyT/YPb9MvijA71khdmFsucgfIVmrI2tOJTjkj6PvOkQvkHhgZRqE+6BSOcGO1SlyVtVPRaqT1TyjUPQU18+ZnuXqzRy6ujRq8TqSPaIbMcGhNDhRP3jK4dEBQ7IcUP9jdWH7kXA7Wa2OgWKLQi8pC+zxtNQzOZLzTks9YlUxJVR3ehyfwLkZ9kIPWJD7ODape4xh7LcD+UgNes7n5OT5XW+xZ+T0jdtB7g4sWWUUl2BpTK9LrL2viB443NL+iGMcH22iEVsDrSJ/0BOfYPvJx76x7zEjdGBBpeVG/uP1On5QADDhn/ph8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5b10SiMEv/ML+kvbp4/07oWfgu1OcflkeRisNdHXQw=;
 b=tqVl+s9dc+/D1Hh03eqQjE0POUWQtdB/UOriRpTcAPs6cTkprpnrIo9E2C8eEs2QTaaU+uRQO3IosCoeWGYDcQY9yXtuQRFzrqEDxF9Dbno6SftnW4KR3GURALwYBvFr2Ey9tOQ1cKn2A8ZHf7CFyLkTKPuRCs65PWmrAABrWZctRs1pnyV8biDfMlxmnU9psSAON6PtStATvAkWWQ6WZEsiLZBNP8GLkw21gJ5Tjdg4EvxqSErHch59c1417uLj6zSvJblxBnVOhqhIm5zdjx72+S6K2ifCCtLkLhW7tuKTgVVX/QxoOQSSYdk3/cUhM9EczGZlNw5/Ug4JZf+omw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5b10SiMEv/ML+kvbp4/07oWfgu1OcflkeRisNdHXQw=;
 b=aHAJ2vtc4d5cN93jnMrbPGLSTtHVUtOZIq3AWhUlCCJ5q8hZwf/+/j2CdvCJ86ZQOVcs4WYxm2Q63YmM3QKjlrMfBjxIpZuS7WprTFZP6OTUDu5Ja+cu+zJF1YWOmvLEkcRYzecOEPA8xnNuxAfw4/wGxxVbBkFaGfiUttug6MM=
Received: from CH5P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::19)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 18:00:29 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::90) by CH5P222CA0007.outlook.office365.com
 (2603:10b6:610:1ee::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 18:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 18:00:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 13:00:27 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 13:00:24 -0500
Message-ID: <7caa23a0-bcf0-41a5-a600-99b33f418020@amd.com>
Date: Thu, 16 Jul 2026 23:30:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
To: Rong Zhang <i@rong.moe>, Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Michael Kelley
	<mhklinux@outlook.com>
References: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c3a0c2-b4cb-4c07-edf7-08dee3641eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|32650700020|82310400026|1800799024|36860700016|376014|6133799003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	npPMUxyWLehoWde4QbFcYpGSYg7TT5GFcs5d9nphOwLLDd6a3rUKDoHbUBsYMH+CYVjn9T++OauldKKEmJiyWkzCD9bkumhWPoCd90NR5+jzjmbczo7K/KRjwdiw/fzJn1lIfj9oByNuT06YOGchhP/eA+GIWraa2AWnM77Xqpy6HxeyjpNae6aTOTxJ0gK1fwdSjWNOrQbjqQ7gIzF6nSJD//Jss3u/AxHA6klY50fNH0PlIknWdGONjvoqaJ6GSv/xZEnSvnkm9FruTo3RdygLS0Tp186M4nL3NxiFyziA598D1ikAJKfPm4GRhlmCNfMKmtl46TKBp+Thiv8qFFQtuUx4KOBoSyrYPrlHvbqzCtPIb8wSc/BvXnEisMogxk1agg8ucVwkIfS6Td7vgezCgTPztZ2ziHpVEpEIJrT69zOb3f6Yzeunpdp/6DHbC65OmAg5JQ7DT3SXcU4eVSXX+2+502hZNmSVsWdqsYUZH7RGOaMRroKNAbRSDoONzXrkk/Es+invyD7xsBM318nuDydTMkB+mBRLgRG3PNCwQ3rrkMxP1u9E1Jsza+QIs24c4/LMIhxdPYDRXySEaqzjRC5CJ8GyguX3cJdl/4853XToglETMdQ98d6IHRmlTg5KIir0dnXoU9vFEkbivjpUq1chWbYKHbaEvyX1vNQ9Zu8C069+uvy1R9U5rm/7bashlGt0VjkbyOjRoCTU/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(32650700020)(82310400026)(1800799024)(36860700016)(376014)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	caEdotJBsZC0of6oYb2p3CqHJKfxTU+eFrNWnR8hC6TLFgyA/SVeuTnWYWTzLZAbpeO4G8zWlvkaap5R8maJ0OeIdlU6X3aD+4vnu/oujJJ8GL1td76y3vXEfq4EAiBIalezpUxX6bzAt9vGi7rJ3RCb/M+uATo7ahmg/6YfaH05hxcMNo2AvIV34amUjxPcrHJZL+zP7rOzrZDCuEGfeSRFUpardiF2kZ48X3ierV1/VCCefFP//rUloQxQzddK2wrl5GHVRoGInKIyoWlPZF4Go4J3IRSZ+Zwrf38p0QvH5W3uNyi88bmdAQg3/d/JVqQfmEV+l/WB1VBU7KRe/EnCMVbPsaoz6jJdyZYrq4KGpgmA1w3hEanYLEQYRd2TcP5i6zin7a1fVGnuK8MMrycYDd+1jyMELvc/2r4QAeXp3VA2DNS/HtTxD81jnuGX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 18:00:28.7380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c3a0c2-b4cb-4c07-edf7-08dee3641eea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

Hello Rong,

On 7/15/2026 11:11 PM, Rong Zhang wrote:
> When booting a virtual machine that simulates or passes-through a
> relatively new CPUID, one or two warning messages are printed to kmsg:
> 
>     amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
>     Please enable it if your BIOS has the CPPC option.
>     amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> 
> Technically the check is not wrong and acts as a safetynet that prevents
> the driver from being registered incorrectly, but the warning messages
> are noisy and not really helpful, as virtual machines cannot adjust the
> CPU frequency from the very beginning. Moreover, mentioning BIOS here
> makes the messages even more confusing.
> 
> Fix it by bailing out early when running in virtual machines (excluding
> Xen Dom0).
> 
> Fixes: cb817ec6673b ("cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported")
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  drivers/cpufreq/amd-pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a74a4cf99d22..f2115f935318 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2228,6 +2228,9 @@ static int __init amd_pstate_init(void)
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>  		return -ENODEV;
>  
> +	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !xen_initial_domain())
> +		return -ENODEV;
> +

I think, instead of this, you can just check for X86_FEATURE_HW_PSTATE.

Using check_amd_hwpstate_cpu() from drivers/cpufreq/acpi-cpufreq.c
here should be sufficient to know if the platform supports frequency
scaling or not.

If it does and _CPC object is missing, there is a good chance CPPC is
disabled in BIOS.

KVM doesn't expose X86_FEATURE_HW_PSTATE to guest. I'm not sure if
Xen does.

>  	/* show debug message only if CPPC is not supported */
>  	if (!amd_cppc_supported())
>  		return -EOPNOTSUPP;

-- 
Thanks and Regards,
Prateek

