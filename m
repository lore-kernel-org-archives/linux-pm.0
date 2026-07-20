Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB325B0B7;
	Mon, 20 Jul 2026 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784524520; cv=fail; b=eY3shmskIRI1V3VIEN/cNdmQ5hpfvkJMrKK01Yv0fgBilSoBHx5pMsMZrzcKYF+ULY51T9QjB5ADk5YoUU0VyAFH4btO7lDvzZ0f0IfCuoJqb1e9jTjsxRKdCPipv0CHsKLT9DRphx2/oSHj5BytRCJh1cpDmXNV4pW4jxi1An8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784524520; c=relaxed/simple;
	bh=m55l9AUzZqA8zOms/8lp9uNU/sBGEpKa0cagZENIYQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NykAs/USEjc7wZc0y2ie3IYDY7hthL0XBv6nX0YNAVyKOVLJjNGr/v9w4zCZ17FhqrtB9wUJiEzZHg6t7++m+nr6VMpeiMOWTby/bDqBXDmUaaK38VLYUBYPtGvJ135/lEw/g1d007xO+OqNQ9rsJ1dRBb0ZqC2WKKL71VxzUag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ubz0qthc; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ubz0qthc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5aLm25IX9BzuwY9Is6J1YHhTNfll6bLw2M+wU4crvODSvCur05kh3uBoZg1TO4eQQpj+9/3FWDkExcEpla6pRy+u5QNyGjJ3O83NA+PwtCedU0w4znorBC369sn5AGOR/QFan5CQ60AelS99xHXZtl0cDYN8p4XhuZYnBnmhBTZxgCRqRLAiMr9bi2eCXjcuEDRbqx1pqApvkfErBSKPz13sm151Jfe0HvxxGMJLstJkmx1QDOI0c6VzCQLkusmz4fMMI2PXonZ+EuVAgJ/9RMTmkldCSGc444fstyaUEz29h1vsL2f3nQlraOFJXftZh693ROuAloquVlNeuajNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvxee1lLy2+FfUeiwfIOD8TYS7aBN0axzoqHP+FWo6c=;
 b=BVVE5u41Av1kPMjO6msa+s/Phdq7o8KZB1ziKUYR4E6xkbujNZf5HU7msxt1w8gIDiZ6x8QmdPJJntS4s/Pck7yKFPQfE8a930vUMSEPoypm7LLS8G2gEP5w/pu8aqTQNdVZPqtlPDDDtY9+0ezJ4JNs/fYhf+y/wb21VBweY6hwFoB8viEGnVT/XOY8bXoQhWbHxSLeBZbdnpvr0cV8UIt8ouws7enY01ha4qdWrDChPp1Tv/DxDYpjc5qCYOUDcdp1dllBua/44VO7STHNRlTVRbmDn9aHjyNNZiUA+zRXbXqQ0zmIgHDk29LLmlJYf7U3lh9R+q0vgg642e8DJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvxee1lLy2+FfUeiwfIOD8TYS7aBN0axzoqHP+FWo6c=;
 b=ubz0qthc5cI5+Je+zjpoM7MXZ/6Uvi7UXId2oj8yh+/+AQQE4B3z1ksswtCSwncGZ+lXdXSJS216zdoS+PT4Xuy3FwX/4yJzxRBRyP+5/qunJnaFNZ0fO3iw040CT7gL/5O4mgGbYvje+1kN8wMT3Ws9QLY4MmKja37eky/AlpE=
Received: from CH2PR18CA0023.namprd18.prod.outlook.com (2603:10b6:610:4f::33)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 05:15:00 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::6d) by CH2PR18CA0023.outlook.office365.com
 (2603:10b6:610:4f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 05:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 05:14:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 00:14:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 00:14:57 -0500
Received: from [172.31.178.191] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 20 Jul 2026 00:14:50 -0500
Message-ID: <09c77f74-bde1-42e1-acaf-77afd32c7379@amd.com>
Date: Mon, 20 Jul 2026 10:44:49 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Bail out early if
 !X86_FEATURE_HW_PSTATE
To: Rong Zhang <i@rong.moe>, Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Borislav Petkov <bp@alien8.de>, Jason Andryuk <jason.andryuk@amd.com>
CC: Michael Kelley <mhklinux@outlook.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260718-amd-pstate-vm-v2-1-6ed5f3b2c89e@rong.moe>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260718-amd-pstate-vm-v2-1-6ed5f3b2c89e@rong.moe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 27580e8a-bdad-4ca8-3eaa-08dee61dd8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|32650700020|36860700016|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	A2mGMmXHVVc0GIuX2z2hiMCV5aXDvvdwkc2Gc8RScmRURidgdOc9ITBda3LlNZdrKlkATNXk7zRVlrGfBEJ+ZOCWp07IlHJKHZPhINaZ7mG8DLAKGGc0lf+cbyYezh7isETK7FG4DfStIttu65emGFo1ON6M7MHKHVQWLxPUD60vZnD2D38+O8dJgJdBRx7tpHdWpYkI8BNtkkwFRFZvOuEkc+cwAFafCNYakEtPbJM2VpQivAF6o8pwDitUxYYIZZTAX3jhkKDNdhx83xUfAQx/YCfkWBwmZPZtMf6D7HQn2YdEVHghhzyZzqoVET+cFWv2DOJWk1E9pJtN153Z4rHc8Rmut4wZFHx4k8ObPkYODDelGN9TEgR68XaEUTuqL2KfOw3M6y8y6aDNqq2KxX7tK0BFtiKZqe19OG6VSOAlEfnyGRnkJaiYVNK+OuaAsaiihDgIT7YyZjlIDIIhgtCc+Vy399fKOm5+466AZhGKF8TZB+KAgvG7x06h6C8GGIXxIaBqF36Ks65Ytb/GLXGXglCm35iCPazkWKMDlkCMX+TYTtqP+S4QcTXeuuEeCmIiQe7LEtiKowjOyiUQ2DQc+L92RpCbqf/D/cburu4CBMYTjpMOftmkXY+CJlQ/G7C3GA1mlIGtnJV0MEJH2juicfJm4iaJ6S1qJ6zLx7Ec5I9y20Hs9b3eQl5uoucsYNjFrWYlNQcuzDRHoF+Jvg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(32650700020)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CyTRjsRLbQrBSl8QlbYWDsWJMzoawE1fnt1kBF7D/K/Ke77iH3FdHJakuTiWbOTcvLx8HAOJ6ZVvXH5aP0e1W7EDeMTStOci6Je05U6l+pflA79K4VBHPP++vOMQs7gz66xbuEKzsMNFTGeDKxDTacknc1N3k5OQUrnXZBuhahU2tq0Oc81BNTlUY28I1qEWrUX/vH2LIJJTr3jPM4mzThsjEfzNciNUVUZ0IYRhWxLRgdx4vfo9V9f4J2ku/CdKDXsDJ9MmLhg0PQlXxXYORkszsVqIlYf+MK3Qr1HpeCBQNSHckaxXWh3pCxKhd7yyqTh32Jr8rngCwAdWphv0OrAuJOhBcGmmAcyWivs8Pv0fvuahDZpCg/mx13fXi4mIbs9lBkPVQ6Hku9envWfRIR6kzroZYK80BPNG+Wjs96Db2/ghY8pnutAVIhotAd1r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 05:14:59.9317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27580e8a-bdad-4ca8-3eaa-08dee61dd8db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

Hello Rong,

On 7/18/2026 8:45 PM, Rong Zhang wrote:
> When booting a VM that simulates or passes-through a relatively new CPU
> model, these warning messages are printed to kmsg:
> 
>     amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
>     Please enable it if your BIOS has the CPPC option.

This is message is printed from amd_cppc_supported() ... 

>     amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> 

[..snip..]

> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a74a4cf99d22..877b4b30ecd0 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2228,6 +2228,13 @@ static int __init amd_pstate_init(void)
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>  		return -ENODEV;
>  
> +	/*
> +	 * Do not continue on the following checks and emit bogus warning
> +	 * messages if the platform doesn't support frequency scaling at all.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_HW_PSTATE))
> +		return -ENODEV;

... so why add this check in amd_pstate_init()?

I personally prefer having the check in amd_cppc_supported() and
returning false from there with a pr_debug_once() saying processor does
not support frequency scaling.

> +
>  	/* show debug message only if CPPC is not supported */
>  	if (!amd_cppc_supported())
>  		return -EOPNOTSUPP;
> 
> ---
> base-commit: 94515f3a7d4256a5062176b7d6ed0471938cd51a
> change-id: 1cc24037-amd-pstate-vm-d6ab4c959bd3
> 
> Thanks,
> Rong
> 

-- 
Thanks and Regards,
Prateek

