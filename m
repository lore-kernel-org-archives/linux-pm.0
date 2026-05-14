Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4043DDDAB;
	Thu, 14 May 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763916; cv=fail; b=vBF2rICJNIfa+qJ09tCyqzrrpxkIh2EzZV/NCj0zVBeqjOdYD8ZNvceGH6GXaDfI2HWF3KkIJ08xb+OIhCLSJmtzm+ClCeWwww0/XOSTqFjI+PlWRJ3wlG83pdr/bMV7c0dCiSlLAJGmAc19wKTLYQPeEgpWtPk2ProTFR1u/18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763916; c=relaxed/simple;
	bh=6Sc3CkR5brXRT8/PdoXwvcZBq+xfmjBkBoCtC3nGHJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jXx9TjWTJmoVgOxGrKQUYuaqisdfiEG9175L0R1Dtdp8Fj47PcV/VoKfriiJedFrNJkp/9xVjUnD8dhc5lmm52pmONmPGcaKuyiAnXTLRYaKJjNJPXiMwyi4NBhxRR/mLwyTe88n9zZEEqWGfm/IU8a6pT/V4RwW1KEdNDR+f48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZvrJJ111; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZvrJJ111"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzR2Lc9kkK4bMr1wGxYcGqtC8OX1BixWnK744HvUaEdTBn/6KaJgl4nhFHVaoq2WoYndIzO0ASjjk69HW4auXIh6sGACD+YVxpXZYNEP9XDcMKP7OPtMol5mI9DZOP4Qgh149kTAf0dk8XprIVQ1eg2TippAT6E33Zo+lUU8JB1FyNHKyf7JWhlrjkRKV9aHFFCKs05L9sdRv8hLZZhLGSEm9qp+S1P+i2gsbL0saiOkjd3CCUT92Goy72iXMdXX9yvqEhs14Onhp8+bVx+epb75RQ2ar/XgfK3daWzxAjOHwK79c6em+2JQ7BwsBOqdOD2xHVDNIuJJamIKATLe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjY0U1Cc1hDV7hreevw+81SNJMGchAO1EALxrKLg5b0=;
 b=jbxakOKHPXsvRKJS+cE8eHtSPYPh0gOt41P0ROKwMz88FIXi/fx6a/bRGWx6uMaa0gayw5e31eKAmNp5JtXgxGjgzAdmApVOMcrfiBP1Pkuh88Pq2VOW9L9AcMnyh5EGKfhvcMZZFIMMNex3mrIg8p4y5dY0JaOdcWqrL7xaapwpDzUj69uwiAEbOvs+7j49Yon2P4dJ6DVVmN+5EGusykzXxg/b1VeoRzYBYKbGGpClw+Orz+kc9SGNy+tFOAQImsQpJHBifX/cHwgCE5ATHoDDsLtkidaCviNDQWhssEU+6hOQ+r9RrokWF73yHMfPeotayGhEzpZT01FE/W/hHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjY0U1Cc1hDV7hreevw+81SNJMGchAO1EALxrKLg5b0=;
 b=ZvrJJ111EnY7sWa03JA4p+U8sWwb2dYld11LHHMBRohCCYzPMsCtFQHRWMauiWfiKIhDncInwPhzt/TUzTFXwDVGipPuGgQMvw3TdDHDE7ECcqQtqENZEG+pm1JC/8oEWdesE7RptImvbEL81OUI2UMjlbqp1hevqCxY36roMlY=
Received: from CY5PR18CA0046.namprd18.prod.outlook.com (2603:10b6:930:13::8)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 13:05:07 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:930:13:cafe::ba) by CY5PR18CA0046.outlook.office365.com
 (2603:10b6:930:13::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 13:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 13:05:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 08:05:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 08:05:06 -0500
Received: from [172.31.178.191] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 08:05:05 -0500
Message-ID: <3633a2df-73a8-46d0-a430-8f9502cfffd9@amd.com>
Date: Thu, 14 May 2026 18:35:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Drop Kconfig option for dynamic EPP
To: Mario Limonciello <mario.limonciello@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Stuart Meckle <stuartmeckle@gmail.com>
References: <20260512221947.1652988-1-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260512221947.1652988-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: c0496571-4865-4c49-e979-08deb1b96c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|3023799003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	R5YVkzPNoQusiowWQgznl1Tqkhm5D8sHbPbMX6Q28qmU+WDCW1UsFzn5m10c5md5bcuNDR5eEWj7o709Y8SJ5uVx/hQMVKu9Z54uOy8uLln1cb+y1s6MuLaClShKLRtkD+dtKrAnAFqzr581f6ZZ9iQWYLPW8KnTai3XfrCNeXxnrVsljtoWUa9/DW9I+fK156jLwZKau0tHq7Efl5NUhchX1VoMMc0mhPi45CEdTqbyTp/grU+1HXGIRxGlH+ReP+WsxD2W/4o/2hMSrTi5qkGmgxvwa1d/QhfcUEp35Bo8DR8cja5x2BN9J3P0M68q8j9Sv/N+Tgss9AVZ9sOeEcM9vt4VUXEqBQ3Jt7pAUbIbZbl+LTAABE03DFlyJPAy9VNEctboVSbKuAO9aEmc4az4MDfGOxgDPP0D6E7v5ctrOQhyiQVB9IfKY9+1ew8OYuQOP2XCXp38FUORhJGZn9hLF9bzNz9AeCaQ2xHC96/QB+8tzHT37cLpg4/KySkkpM4ccy77RdPQL8iHui7IMAXMNqMXi8/AVrR0rQTjeOub2CBpXTHFPScSj7gYKidUeFhogIpLnVRqm7089t2YLOnq9oR+30XHuTwpUfH1qXrKUAs6kCGMPatJPTi50mHsVNV2njVdTVwX1lvyPOiIKFl1rp3xH9GxLZ1xZYx7e2oSbQlb1tJNlvAdWBY2bpi1S9bBlho5vnm/4GGWAJQinKceO7SwSsE+HlDnIr9o5wM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(3023799003)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5S+9ZSLE1AjZmXz1O39hN3KnGCJ0VqOxIbwhJErQdvasyN1732SBh3JN9G0a1X3IKKzJeALsuOYQjCrdF+yxwWBDPcenNZJ8sqwX6ZjzXzRSGBpteuo+jCkZ1ojP2cbpxJNHw1aM/vKLKjtuk4wHsDY13Vednxf8mn3tmgLFj+10vcWgB3w2clSI5PfP9mOOQCQB5fdW5sFGLOo7UI2VsJpUt4m613dfixbWIfrTJx2nGHIMbdQkq2ffonmdqZvW5DXE3Fiv0FcoSMqPszv7OO2saShUyu4aM+cIGU7Yh1cMmRDOpqbusZCEJzlib6pmTlXZKwKnEWenxbJrL7crEcLaaa2zDx53VbKOrMcuLEhewsQ3+lmmGEy08b5W7tjBDLVOpFVc4g2/DLYmDg9e9bQo1I8pfnQiS2kFgo1JcQh/yNe+W63TN1KfbKZAXbi1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 13:05:07.4059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0496571-4865-4c49-e979-08deb1b96c24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794

Hello Mario,

On 5/13/2026 3:49 AM, Mario Limonciello wrote:
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -358,8 +358,8 @@ Dynamic energy performance profile
>  The amd-pstate driver supports dynamically selecting the energy performance
>  profile based on whether the machine is running on AC or DC power.
>  
> -Whether this behavior is enabled by default depends on the kernel
> -config option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be overridden
> +Whether this behavior is enabled by default depends on the kernel command line option
> +``amd_dynamic_epp`` is set. This behavior can also be overridden
>  at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.

Unrelated nit.

This file should have been
/sys/devices/system/cpu/amd_pstate/dynamic_epp right?

Apart from that, feel free to add:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

>  
>  When set to enabled, the driver will select a different energy performance
-- 
Thanks and Regards,
Prateek

