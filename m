Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBE449B1C;
	Tue, 21 Jul 2026 05:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611008; cv=fail; b=rKvCRW2ggLpGGPnJhzc/Sx9r72jO6g32b7KujEaTwzgHDOVdNfhDhhmAx4l8yP0Ix1wAcfs9GODuSOunZ5I8Cq2v0V6L362qQLBHbFo3YLu2aMEJReSEqnRMQTq5r2+3XUzxVuBqsbAkUPJwYmFzp51Zuiu/Be5C+FZorpK6o9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611008; c=relaxed/simple;
	bh=p0WguAv6c+P2Q0SNaDIj8CiymKeZUh0+wYagYr8s+FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nVqjFoWOmwCyr0uL/x2gw7NYNJ8en+ahmr9qGXyrK5nBSJ8jM14ydBOork0Th6INFpFnDL4mUQ0UiYUe3YqeMV7wygAYbnWGdRGDae1Oqd6hHQ+U5RAFQ+DXY1eKsdexAf1MJXNJG3cc+7D4J8mmdmw6Kzquf2mop5JkYXcaUfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=faUcDvKk; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="faUcDvKk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfuO3z2wRaJAFVJktjMgmYC29gT5nvmbhKOQWlpb0A7nl1KsNICBLEIPCOhoWjLW0jKyAlsagC2jOnUp/ZuJmbmLpOxamHc17xFnR10S7P2p44qBGqhtpgkejTUkwjm02nI4EyopGwHXnoWOesNa2RsrUseMnVQ70wn8w0eosteGkg53w2YlYJzy5IbyrDA9L1l5LApKvaqnHeaP4FZl05RwMFoQtPHn8ZzK3Klja0EolkRK4Txufg4Yafpz1TcEmqiffGVWNxOeG4Bh5gToN26stCaV9OwFdK2MYZXkng6NKKMcyBMPfmZR0LOcih6Dqx5myq9ORmpub46S7ejYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVPGJ2sAaTFHaUQeDhqDWGGCxKWWkczxS3Olp1Xz7/g=;
 b=cmUqQJrm+4P66eD52PVWR8qH+shOEwUPyg+eIY/kl6egPJIH9g0sN3FRehwUeMNPnP/PiVm5tWkZ9EjEFl7chrowW7sJIK3MAOvSFRsIIk8/oMhvxIh/gqUfOPCdN1uP7q/7z/m6OhIAMdKFl9SxU8k/IucythdVedvcwIGqTthZKCTKqGyadT/nVEzl0YpO0jKiCFqWd74NO710c1cZ+hoH9tgmSvBwbpgwxFoCdNEbpLopS3DDOwbSCF3GU9ho/o+bmEm1JZwYvn+YGsaFuZxu3FZajHYoOEfYV0ZWvR85Gyb1QReLWMuLlRDyVzz6g2mh5EaClbuzfxSUpPADEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVPGJ2sAaTFHaUQeDhqDWGGCxKWWkczxS3Olp1Xz7/g=;
 b=faUcDvKk40+WLnUaTpT6yFGyqYsvk3WTPRsw7QNbQUsZldOBQNsn3XHJxYQ3LDwccP8fH99RJvzFH16yUjrDdlxzr5YHAfh3fAXt/QnpERiV5lfBSUxNhmyB3Om8cm9RKJmdrVvp2lKrrO+k02AeQuOD2t86BU4b2c+HsNCsVNg=
Received: from DS7P220CA0108.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::14) by
 DS5PPFB297DAF97.namprd12.prod.outlook.com (2603:10b6:f:fc00::65d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 05:16:43 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:25d:cafe::36) by DS7P220CA0108.outlook.office365.com
 (2603:10b6:8:25d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 05:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 05:16:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 00:16:42 -0500
Received: from [10.136.38.108] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 21 Jul 2026 00:16:38 -0500
Message-ID: <88f20967-7f4a-4734-bde8-940e338bded9@amd.com>
Date: Tue, 21 Jul 2026 10:46:37 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Bail out early if
 !X86_FEATURE_HW_PSTATE
To: Rong Zhang <i@rong.moe>, Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Borislav Petkov <bp@alien8.de>, Jason Andryuk <jason.andryuk@amd.com>
CC: Michael Kelley <mhklinux@outlook.com>, Michael Kelley
	<mhklkml@zohomail.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260721-amd-pstate-vm-v3-1-8b59574fb714@rong.moe>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260721-amd-pstate-vm-v3-1-8b59574fb714@rong.moe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS5PPFB297DAF97:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e7dcf9-0685-4b0a-f743-08dee6e74084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|32650700020|36860700016|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	roGWIY7ybP5yvi2N+iqRfcxdvOS1g7PihcRxVV1GKl/xiwC+7FOIhX4dwYuW6SLWqoAUl4UhZoQBDurfnpAv3ycqh8ACIPJuHD8EQ1WBBLTUiQzPtqib0/0WWJ3QB3eP0mkEdM1+/1qa6Kr0CukmE0/no/YhzX19Lwy7UqgZkBKDUdF0PeVCRMzx8Z3+F7yUeYckr/CaAYaMZotSzk0pIriwiCXyckExSAFL5zzFTXY1AzTVvuaGRx3KNpRNpNG5kyY6E+GU8NXkvnwM9wxTSPZjQDpIqgcXjs4TrqDqLKCDwCK7a13qls3wDP42jkSejJQzruAi0g5FOS4n9nBqtrnLpsl3CAMFImU4qRc5lw90kDW3eZ5j7WTFmIRtXX9dCWWQTHpgeV33+F0950swvAUn9E+6xeep84QoxqB1wTJfdmvJGtAqQ/xXwMAobUtXlAiUCD7xmIGHo9fIPjcvObsKyhRil4JkER9rsiVxCFIeqMMHd39xqxY2I5Qk+HSragWmAwAGE1xObgeZtZCm+o79Cub66PlXbyRwD2zzQgmbqKNJLjZMBz/qglgVnfRwuckKE/blVYMOSWJAfSU2PdSbLqk0y08EgfkLKa9Cxbgee5OIOgPn66GHcOj++p7qlFSrENqgyjTUWKWjUdUhq9YGrgJr+fNbwhZakEwncOjGkgdRxCR3EkHpb8m4HoaEkRIuDEsTt+Aq9mHiJhSv9Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(32650700020)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+GK0ekI1Ux5S+Wsznwn8syFQbRXaRuGcTzMXeJ7v68jFyO30wXV6zwucgudOn3Ok04G7+PQejbnKpYGRG4Fdw8ZlAkT/DBs3cy1EKgKZP/TfbY7MF6Kz7vkKigLUYHYThT0JJ2Gp1gWy5UkJMt6IWp9afxnNxEqX21SWn3627lgQnL+X+DJa+1RCIc8ZpdsbBBC0AsyaUKcmSgCjfjnIawA2CFE3isCRJL65Mgye+Jp3G+P7F1EjNIfVRkjt0mbOG0lhdoYUv9Y3cpRFlCyFIP/s/2amPesAHSI3q8POek7OBHSKoRvl1/TRHxOqgptMDVPm7qKQQBk96+OQvu8utNFSsHnqY22zn6OWfxFduYxjxwiAlzc7743mOXHu1a1vRlXjtzi6vIrUUTQ4HCBfB9UEDPj1oZxEAb8qIgItmYFaPQ7oIadNA5roh+FFlKgX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 05:16:42.6666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e7dcf9-0685-4b0a-f743-08dee6e74084
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB297DAF97

Hello Rong,

On 7/21/2026 12:17 AM, Rong Zhang wrote:
> When booting a VM that simulates or passes-through a relatively new CPU
> model, these warning messages are printed to kmsg:
> 
>     amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
>     Please enable it if your BIOS has the CPPC option.
>     amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> 
> Technically the check is not wrong and acts as a safetynet that prevents
> the driver from being registered incorrectly, but the warning messages
> are noisy and incorrect, as the CPPC feature is neither supported in a
> VM nor disabled by the VM's BIOS.
> 
> The CPPC feature is disabled by the hypervisor as it makes no sense to
> expose them to guests. It creates a paradox that the same kernel both
> disables CPPC as a hypervisor (KVM) and warns about it being disabled
> as a guest.
> 
> X86_FEATURE_HW_PSTATE indicates if the processor supports frequency
> scaling or not. It is disabled on virtualized platforms (namely, KVM and
> Hyper-V have been reported to do so) and is always set on physical
> platforms that support frequency scaling.
> 
> Check for X86_FEATURE_HW_PSTATE as a prerequisite and bail out early if
> it's unsupported. A debug message is also added to help debug driver
> loading issues.
> 
> Fixes: cb817ec6673b ("cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported")
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Rong Zhang <i@rong.moe>

Thank you for your patience! Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

