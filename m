Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E953F1046;
	Mon,  7 Sep 2026 03:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753515; cv=fail; b=OuQWnZcoJHQ7k+W0Tb5jnr3e1IwtpyLTjOyJyJa9yIUJFqrMOtEP3htfOH8zgQpDVGphfVlM6thVFFqV9iUHtV2f6lmclt2dvQPJbugqJlyRxMwNgxol9b1e241MXafkStxMfYOYS6Y+SaIArta21LWrirZ31Qwmaz9jeGDHOCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753515; c=relaxed/simple;
	bh=MIKgo7pJSHi4R6Fc6MIqV634p+ojSaQibEgxVGynZ3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JcICQRS6RskD+nWupZ88tOmsJhVi7beLRow9G6983E/N+PJkbq4b/VctnC5SNbgtQX0zbf/1/d0kQdcYr0k29c5Kl30HLWTfw07NmYnvq5tAjaVLeWiW/sbHSsmwaunzBjw95QmN9al4ZYUszo9E3sFUOJplCnC9XGjWkdqdVOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e6//eibZ; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e6//eibZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgmcFnEUOHQb48kNEOpfeaTHhUSyNmu4rhoNBRDKXYN3GWBGTqLaIpJRDLB8j5bQpRXT7lgN/JB9cetkvDH0RBMKqXiC1CJLahcAq8yWhlfjaoIaAKR/nbf9uX8XaqZ4cnzEChbjtRVN3EdQyuxNzU6+DG36hvztG+67/IboB6uaxfeJQ7K2vBzMWRDZrJ1r3wmuDgrtpj4zTaNt36xFUHM12eYRl2qaVssobgEDvP+cI7ngIoAV6PWpyI1vHKuM0MNXSAq3n3mm2H/vYetk5YXC2ggIcpqNftPOF5aELQzWPsK0FNnkL6vn64CNhmnoRUV3sK/6/Ec3C9Kl+Tvu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ROediwCISLOC3NKV1oNJMK2i4R/cBdx1LSH1JM4rwQ=;
 b=QeCmO9edrgYl4cvXtdJUVMCiOSxmQeJaDmH0qHe458Lydr63jrf7TUn4fOD3B+5P1qqEyawUNZw9Y58ieXv8IJuclSfD3fudTDcRe56MftoMTBYeVN2bgy0DL9YRTYElfB6EmOR65lmBO314aWmB673Pb9cNRBxxGUeu4Ay0qHFmaZ+hZdYoS9FfLT7jbfx7t39VFh3fT+GmTpUDP7/kyPmwlpMDNUfrylPp6CsCdv2bzfpuUHmz6dyhZcjqdvYoEKwOlwB14xvwwkBtchbA6FSo8efKp7lQvyekfSTmVtiW6uFUfABvBMCyvJT4MuCfg2GvhvAuGHpoo2FKhEX8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ROediwCISLOC3NKV1oNJMK2i4R/cBdx1LSH1JM4rwQ=;
 b=e6//eibZgZPL1LHpaWWLgPZDIbG1U4qZir7pV+x6AYE51AsGQMpmIJchijct1WuV3VAJ/67hwgWwHPyagZcRbuGnXtEz1afTDPTHzM1tcd39xvD12UT4LCU6DGy82uQBrXug2K8O2MuW2wj8Oq0bJ8KAzHNJiHCv0N/XoMCjfy4=
Received: from MN2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:23a::15)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 03:58:29 +0000
Received: from BN7PEPF000000A6.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::a7) by MN2PR03CA0010.outlook.office365.com
 (2603:10b6:208:23a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 03:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF000000A6.mail.protection.outlook.com (10.167.245.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 03:58:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 22:58:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 22:58:27 -0500
Received: from [10.136.42.177] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 22:58:25 -0500
Message-ID: <4a577dcb-3fa2-4d28-8b86-757dd67cd6cb@amd.com>
Date: Mon, 7 Sep 2026 09:28:24 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp
 documentation
To: Karl Mehltretter <kmehltretter@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>
CC: Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260905010706.57380-1-kmehltretter@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260905010706.57380-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A6:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: cbcd00fd-2f65-4bbb-f01b-08df0c94472c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UoD3JHrqymUtTbyEoQmTEWgCwVwA3DPiM6vPHpTsNFIWoCqwKXNw3tApznSFAJqcxICRo/qiWCnbrRHEIscWSLWAf2KInfsbxP3i1x0SkSCxm53yvdd+QdAL6LcbFNWEvwL/yEXV0FZh7JLWnEDBa3mUn7uJsV/43udEHY1lCuki6OJFcQqsf2rcCJK4juQOrR+JhJB/w4wocp52i7skyu/rwo/3t2rzrN0yCN0FJ7W/JJMqVqhdAPwI8QLvHkMHeMmddewLoFoC4g+8Af5nSGGKa7RkjlsMD/nLC/8MwSXYdu3wKov/wmI/L2d/jZ1zeTbbj7eefLD7fDm6nYWSKXKZfvJFEfNgpzZsWHKncbhRTqFqLwYJ/WFkg5dpYUu77wsqv914sL0Z4Wo5HcJUGWmSVgTun8XK/LaRWpFf90pAaHQBWOOUr452PcezWtVJ5m9qpkWup3CagQUPwUsVp7OF4Zb5VsTmTi/0na89XYXyhBCvGFwouwOpLdlGwAuqMF6+nxwJ+R5ZYv/NO+n7iYdNEx03lfgjjQ/S43BfgLmpwXxfv2fiNNP9g+61Arz+1lDncWwseaGG60V/HdwFr10Dx0cegmBbdM/XP4XJAHJHAU/9KptZW+lvMbJP2FN3+EipQ0x3XtpwKv3gFtgxGEv4xJ8TeqnvUzz8lbCfL+gHo9/1jx642yD4Y3nvcUo3UcVTC+Uf7uROSg/2vUBYSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jUmYiRxmDWEnep89CDY/vmDEi/2xQfTURWCU3U2wcGrjqHVNdaMXZOybelaju6N9fs5JvJ775F6OJaz30vyQXoM8J/4uBqTsZcHEA0HuzuFy5dJIKDErMHRAkL75xCcnQB0AXU95aqwmZqYAbm6aqfpG6ycRTpVdzvfdmBmaPmqQpvavt1q6x0qRPyrzymNP8w0Ync+aPJjpTpm7kFWOmzLI21+GW2IgsI+XSirMPOyUjJ5B9fb5diIZZRbtqx+m4N6SHptSBw6DhKJQPrxBvzTJ/Yt8vwaPxAj9yPKvhK3X+N4arbCqzp0ziMSBGHZlCLOTT7xhYEfUcVkMyoA2/VauKjnGfSGEkz9jOYE7iNekIniuj6VyEWaw3OlqvfF0Qp6//G0tjNx3XHy0KWyVYu//BFyZzxS2cpA2EZ8JsZ3R64qtrscWNwfKkMx0xv1I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 03:58:29.8287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcd00fd-2f65-4bbb-f01b-08df0c94472c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649

Hello Karl,

On 9/5/2026 6:37 AM, Karl Mehltretter wrote:
> The amd_dynamic_epp command-line parameter was removed. Dynamic EPP
> is now selected through the per-policy energy_performance_preference
> attribute, which is already documented.
> 
> Fixes: 32692fcf61ed ("cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and "dynamic_epp" sysfs")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Thank you for catching this. Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 -------
>  Documentation/admin-guide/pm/amd-pstate.rst     | 6 ------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4a12805a50ba5..1fa37bce5bb3a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -499,13 +499,6 @@ Kernel parameters
>  			disable
>  			  Disable amd-pstate preferred core.
>  
> -	amd_dynamic_epp=
> -			[X86]
> -			disable
> -			  Disable amd-pstate dynamic EPP.
> -			enable
> -			  Enable amd-pstate dynamic EPP.
> -
>  	amijoy.map=	[HW,JOY] Amiga joystick support
>  			Map of devices attached to JOY0DAT and JOY1DAT
>  			Format: <a>,<b>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 6fd72ba52df20..4c5d3d8acf645 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -481,12 +481,6 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
>  always be advertised by the platform. But OS can choose to ignore that via the
>  kernel parameter ``amd_prefcore=disable``.
>  
> -``amd_dynamic_epp``
> -
> -When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
> -autonomously changes the EPP mode. The default is disabled. It can be enabled
> -with the kernel parameter ``amd_dynamic_epp=enable``.
> -
>  User Space Interface in ``sysfs`` - General
>  ===========================================
>  

-- 
Thanks and Regards,
Prateek

