Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B23358B0;
	Tue, 21 Jul 2026 02:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784602323; cv=fail; b=OZe/D7pFZO8GwAtxmuNccfb8TyLEtFtkfnY+d/gj8uksuykxgGtK0sY0/eXkYGaaSrpPmpWyW21Z5Vy9bNuI0G2Y/gQESrcQk4OUmskhEGCWLvCisazstp+ds5it2J/s8KKcT8yAw9FUAcSyBRNclNVAywDlSaHn0BvhAJ+CEi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784602323; c=relaxed/simple;
	bh=IkmU7PT7gaJIV+MNPnhGanFR4DkjkNfn+9C+6MzCUkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YpXpWWurdOsBgkxyS3JajYFTzbAuaLHsZ4dvXB2UrrHPdlytiBjaF2+ExD1AeirM7ZJT9G6ueCs1YTuZbP8xNR6Q10rLqJHq09wPkIhvezfM3Oe1fxu3v9jwbn5juz4HQVO5qAHojJJsjrZzHkM4w/8TsSaoZwbQ579ZhaBzzik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=45X1iWrW; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="45X1iWrW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR0iUgQ+m8flllSxWy9wyT6lZZweylW7VgVQvaA9YD5D5YaiqHPp12LZL5VmOY4RmZW4HBRqStWzg+zPaXtITFVlgYUDYL48nYUzMzPy+an9jfIncaIg5U1d6o/+Li5kkR8cJqeR6l3n/8l/VSEmIqORMZkujVBr0RhI4axmK5Bwhx0WP3eK5c6s7zECCyU8RVpIvYVS93t2SIciwSl402XwL6EtpzogDp09qJn2L55hheePWff6DPEb7i/BsqSJOYec2N30chU+b35DTzCa+1vuz0Su+AndTOcMomBBcXRVPM8VFHSNkfOo8Wo8fB9zatGJi4hdrqChh35iPWy2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUk81Eq7jHETbI4ncLNVWehpK7tmxJrMXE6pvAa8Mno=;
 b=qrj+TWpN3+ln7byCD3iNZ+tkEq3vFxWij83QqYbKuS/9V2w4jdoT0S2jk/rURPCu2i/FXuTplSEozVFV5JfZPLPwK4bHG4sW3JPaEKE09fO4PkZ/e8Fbab8cYi+rk4+2qanNICCoj3wcf3xUrU69xBV8gKj9R7NTs/PDyhnZ9oR4JThiTcCwukOLp7K1BAWP1FqML7+bBYiMovjcj2axtzBcMEqnsB26+p8vXYX1koJ5ojBsoQMTtHDHDlzST/Y5M62hLrKJv2zBwvak7CMkH3lIb0n44iREwBYV4UFW8+/Ea86lAqDdeaW2RW1jKE/N7q3CuBBBlShmsrNzbjmOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUk81Eq7jHETbI4ncLNVWehpK7tmxJrMXE6pvAa8Mno=;
 b=45X1iWrWxZDtjAvM6XtthnO7aFgJ792q1e7/KwWi4OV+zbW8yjxGMmBoy+TqiHhvtFmoag7YU5fxVj+8otvvT99C+G3KhNz/iL8G5sjc4eJhD1BWDQxjDcT5mpF0LpkucZYpPVF7jiZBBEyyR8yCQ8kGKgCLIV0EminsdI+2zok=
Received: from MN0P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::11)
 by DS4PR12MB9660.namprd12.prod.outlook.com (2603:10b6:8:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 21 Jul
 2026 02:51:58 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:52b::4) by MN0P223CA0020.outlook.office365.com
 (2603:10b6:208:52b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Tue,
 21 Jul 2026 02:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 02:51:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 21:51:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 19:51:57 -0700
Received: from [10.136.38.108] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 20 Jul 2026 21:51:55 -0500
Message-ID: <1fcfa283-2233-41da-a3b8-07ef331bd03a@amd.com>
Date: Tue, 21 Jul 2026 08:21:54 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Loosen requirement on lowest
 nonlinear frequency != min freq
To: Mario Limonciello <mario.limonciello@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20260715174318.18235-1-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260715174318.18235-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS4PR12MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f333b7-2ca9-4412-cf38-08dee6d307ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	i2Eee/6PJ4xfzo04B7u5WEpSHp8ux/GoehK701ICYLqAr9zPlN8/Er2ZU37AiBMskJz3B02iV6yXDz4BIoNTL8uwtMWZkkOBjrcRCtspkx8nYDUSkGXdUeQxNkS4AiIiL/g1AKZEcYgaSz0BKxwRxVTDeJWmrSDZjmTQkligR0Wk/4ilzK4mdVTeUHrO0mqVCnPI45h2k/NQMliPlW93sD3INFE+kroXItAzv6AKir+1N0USXxNTrwnLyXbz15D4hIHCM78Bkg6WczRklqnuVT7/5O3eo7qIR76e3lo173ymM+1So96YR5om+Wciec1n+DJUKNLRTYr04I4Cjfs8+BgeRyAFtPHIbYYCUEiQAyYTZmg8mMtO5gq7IWYdQCqiSTIVfFRxAr0MW97u1IiUjc/b8F0bZjFqeCrdmQFdtm5xjunVyi5baSFGL9rFlm36nB6Pyso/O/hbYIgGIpa/8bIRwVzMt63uCWU0Gg8DUyWIDfGrjmMIGNJjcoenvOAH7qdia/onR5F1xMuw7XyDsfl0/9HyKhzXs9dbBSsLWCmddNhH8guFpygFbmJzIVlVrx7JSY/5bPc8d6TsE0PAc7DMgaGxyGajI+CT54/v7LI9gL016RX/dlOrZR63dSFMxsr4JdY4FTcDZY5kz2V3P6kHVEq2V2hB0YHKbmL9LdgR0mrfW+rGXz8luBjPdoawL3ZQY14bknWf8bAjvW6toQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n7lg8iPfRtNliczMZ3KheTL39sSjLUOtsKYlSpV3ftNBpJiEn/xEemcQDqfUt85O/ejjgts9Yl+REf5X19gMYJxkfpH9T+zyNi+VCtIYZk6WJRRhB/NrhoARmp+7XRt/GnFbVFbMQDsePJUppbGLy056RQuoguPVawPaI7+cZN6f68QeAdtHJwGC1U0zS/TGuDFijPd5KEs+7Ihc7E4AUr+FQEpVRKOw0yn9ERfFANTiadz8IBSYBtos8LyMzPAxvfIVeomTszdhSPoSsaJfWsKxFp/mE1x/ANqiM55bg++3FVQqSpMaPFdGriPmTFc+5bEfj4MEwJ5O9DliD5VKX9DiWUFAFm8ziH0sqjPdp8ajXFVrya+Fb2G12hVd4jyCrZcoQtQPoQSdUcsgSGcU5stf7YA0P1XeRCOTQpBeUiOiQwEjsiJvprzTgdHlkspn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 02:51:57.6225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f333b7-2ca9-4412-cf38-08dee6d307ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9660

Hello Mario,

On 7/15/2026 11:13 PM, Mario Limonciello wrote:
> This requirement was introduced by commit 8f8b42c1fcc93 ("cpufreq:
> amd-pstate: optimize the initial frequency values verification")
> specifically to aid in debugging BIOS issues with invalid _CPC tables
> on some older systems.
> 
> This requirement is too tight for new systems though as some systems
> actually have lowest nonlinear frequency identical to minimum
> frequency.  Allow that combo to work.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Since I've not seen anyone complain about this on servers, and neither did
any of the machine I ran this on, feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

The "<" check should be good enough to catch any borken BIOS.

> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a74a4cf99d22e..3d72337a33369 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1031,7 +1031,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  		return -EINVAL;
>  	}
>  
> -	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
> +	if (lowest_nonlinear_freq < min_freq || lowest_nonlinear_freq > nominal_freq) {
>  		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
>  			lowest_nonlinear_freq, min_freq, nominal_freq);
>  		return -EINVAL;

-- 
Thanks and Regards,
Prateek

