Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2B5304A8;
	Thu,  1 Oct 2026 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869493; cv=fail; b=a6KjWdbZBa33wizlf5C66qY3LKKOMVEODRvoA3HjGJhvb9FDXtxhrAD1MKYbRfe8oreTfwBysS5kUdhaZpXf2W5L17rlnd0C1ZifCIpzpclwXLYjVEKnYD/sANY7J4ELMAmbvu11X7NTkeGdktlfUchO6vtH/RVVjbJgdg2PLBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869493; c=relaxed/simple;
	bh=eXwvNRoZkneUeEZeim8ntWLFQTOAg2QvsrD4AdBgcko=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i4oi4G3Rpx5YKB09ORZIBS3bxiol4hfsgGCSQoGTx+Ox1SPEOwCkkwFtlk4z6V03nahvBEVgU/3mvCDPXPmZwqJTX/b0hC6pJg6gIjs47wHbbIzp2umb4c8GUyCif1kiqeAWC0vvQd8EVMQ8aF/m9SxRt1HXUWNYez0kjWF4xGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jLTDaYOt; arc=fail smtp.client-ip=52.101.56.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jLTDaYOt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK6aAeD5OAO3qm9huOYz2q+BWq6Hg7uWlcm24xs6588vS7TXY+ihDkGAAt4nCXmaHQqvDBUH1CF1aEKxxSLzKS7u2FF/UjaeKALLdNeJJ169vbEwWGhIAkG0W3SbGnkP4SnUDq18ekOdPP4LPt/oaqucJoNsoS9Lx0SjySqK+E3dUOWN8vglZ6WrfJCVRh40K6qQzM24Tu+S0inc8jpz0M+hEtrI/NUk/JwiuzCGGcBTDrnJOsHyF0lGQKwQGgK3zqnXIRiureREBmn6D2lWH/9Cs78qiQYS/ER5tqdwgf/BBJB8d2fzaGq0OGVWBFICR0Rrl+lUi6NZHRobyBD7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ3LJyV3x6sYJkTipLRH5eePBZKCMORpJ9YDbLNAH54=;
 b=LJPGLt7ojW5AFT4HoI1kVxegr3AhijZdB1xblEnK9qSehGCr6Q3eVoCPcW7hN2XlzGIPe3tpzq2VFQwxl1ijeTnnfPiaQILjVQZzD6UTsMgI7ju5lGyYHD77ZoBNbZvFcYpX8iuvPzHXNqLmpSVx1flSuT3Wy03yRELf87cz8/2njoOlc+uHCSov9SaVxpUrQVFrqpDb8qCEr/V/gu6sky1+UBJbGlVnov+CeRzI+3CzgCIkWxbpamq0BSr0OSxivxFU3VP7Gi/ZITte2Lb2eshuZZY90YveIGvffZfWNPAr0qL8b+RiRl5/Wy6wuOHjv2yrR6x2Xbbfo+h5QhwVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ3LJyV3x6sYJkTipLRH5eePBZKCMORpJ9YDbLNAH54=;
 b=jLTDaYOtzE/j0n3wIVYIKDYVgCqN5yHDZ6a1kYKMEwUToYDlz/vDLvU5870yxF3177l/Wj18AmcgHeyfTp/XKwBLNCfbgZIGuc04FTulhD9ATvT3cbShNItOAOyTwFwSx+S/unu7oAg38c6kPt1C/yXH+ktYBmagRl6tY06EQaU=
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 15:44:45 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com (2603:10b6:303:82::4)
 by MW4PR04CA0302.outlook.office365.com (2603:10b6:303:82::7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17
 via Frontend Transport; Thu, 1 Oct 2026 15:44:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:44:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:44:44 -0500
Received: from [192.168.0.226] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 10:44:42 -0500
Message-ID: <b673fe38-eb8c-47c0-83c3-732c9b122234@amd.com>
Date: Thu, 1 Oct 2026 21:14:41 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix TOCTOU when changing driver mode
 via sysfs
To: Mario Limonciello <mario.limonciello@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>
References: <20260922022347.1270746-1-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260922022347.1270746-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 640ab08f-7744-475a-20eb-08df1fd2eae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|13003099007|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9zVGr3ux6HXMnVA4XpXYrrU26EDGhvjIdqkT77KbtD2J6HBbgSXK/HtI6cRfADNAvhi/rv5/TSQNeq+Hr6sj+fiWnhjOoDiEGZqm1gsyA2TGw8jSUyxBzbNFWiSvmrB4Iu8NiYAnmAE9pso1LJLKBeDX1OFMiOzAPWgksLhlM6ey4nPX4c9e7gEJxl5wVMRYs4q/xAWW8UyN7Bt9HixX2pprxe1kVjFzPZI3EzHXF3sryM2mdljeTnT37UL7JF8qBsHf5Cz8sasyuJv1YJQUMY6otBvS3POjyejBtMXjX9qM4SLST6LTsPYkyl+xw0DuNYLzZTmgZ0EpGjeGxFOTOZLAJ+rviC8wbwrExD8g5U2ASkgsv82u8M5aGg1Hhoocsa7nTUmePy19Zy52lhiIe7y/1Ab/bjdpAMbIbMg99ibMP3lM5vzj4cw5k9ONeZ2Q6qgzFS7W25GytxtvsLIsgu8vcNkMmsP5EIB4/6OvGqsFrVP3w5jqG5XuYYSAbw86fj2W9Fj9UYDegctUbe4HrhPKSwLSUH/Nixkd66pBpZgcPYgaKCZPkyap3i5on1UrRZMKRDzrw9UHyj64XkM9//PTbUcuMGNrgKdEsN7fGzGJLLvv1CvFTuxmOSqu2BZRI8cTXoSACTFxACoIyswT+A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(13003099007)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fs6FHjJuPMF/EA8si7P2gTl9j/kEMshj//f+eo1x51Zc2Ca7AQyt66xqKODiGl9utXM/usbjBcpk4eSOYknqIo+DSGmRxfmkmdg1hgpZ8/HG+HoQg0wO4U8MgG/BsFZjiwb8szDwYZdGGtJpwbpNlLx1PdSwVqfqayzMFpDVetONCOgZoy/nOVFrUiwVQtX1BtwsJRS7Tn54NVdgCrrZidjH5r3UinwE2Vm5d3fEaJJ4ji9/qLuzB7I1xEM2+SfxE9TJAjrFvxNWG5FJbR2gGVJA5GqtznMJLJW+Z9/4DAycvKbZbhMiRAQ4g6NmhtPUCIPSclncG6tyxE7ChoqOzWarVnqG8yOKocMIFwWVzmd2RkZvkUp84AGIcbAcq0b03/B0dUPOvUZwjhqHsUdaseQkgs2SFENv2fzxMdbqNW8orDvvRQHqyysHf8FA2ynm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:44:45.3108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640ab08f-7744-475a-20eb-08df1fd2eae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735

Hello Mario

On 9/22/2026 7:53 AM, Mario Limonciello wrote:
> amd_pstate_update_status() evaluates mode_state_machine[cppc_state]
> [mode_idx] before taking amd_pstate_driver_lock, and then re-evaluates it
> again once the lock is held.  cppc_state is global and only stable under
> the lock, so concurrent sysfs writes race:
> 
>   CPU 0                               CPU 1
>   -----                               -----
>   // cppc_state == A, mode == B
>   if (mode_state_machine[A][B])       // sees non-NULL
>                                       if (mode_state_machine[A][B])
>                                         guard(&amd_pstate_driver_lock);
>                                         mode_state_machine[A][B](B);
>                                           cppc_state = B;
>     guard(&amd_pstate_driver_lock);
>     // cppc_state is now B
>     mode_state_machine[B][B](B);      // NULL -> NULL deref

Oof! Very interesting race that.

> 
> The re-read under the lock can resolve to a self-transition (NULL
> pointer, immediate NULL deref) or to an unexpected transition that
> redundantly runs amd_pstate_driver_cleanup(), double-freeing
> current_pstate_driver->attr.
> 
> Take the lock first, then read cppc_state and resolve the transition
> function exactly once into a local before calling it, so the check and
> the call observe the same state.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-f86ff3a6-55df-4eef-8e4d-62ac270dba25
> Fixes: 6f0b13f16f7a ("cpufreq/amd-pstate: Overhaul locking")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

