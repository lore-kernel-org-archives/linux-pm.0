Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8D61FCE;
	Tue,  9 Jun 2026 04:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980643; cv=fail; b=dGPE5zhIwCEAJwNaXJa9U24aY8GeK4I+7rJEiv1NjbWhpse4tFVNgxbv+fF2dSotML+vl/XAZA4TvBQ7vx85c1H0/iDJTvnlwC7vtbOnHd64YyXCsVak5Wl/q7x1JqgBVNGanv6YIz9MIcz0/JXYBvQyTgNs5b02+b98fWgjlB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980643; c=relaxed/simple;
	bh=RU8aqWxSPF903dw5DIapV6ID9V26MaryplqiWJsra0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dX2JxCBUjuadUsFeA/l3pErdATgDawjBP6vbGNKbK58hMnkeB+rL/NzbzjzW2ar/gsvQwul0MtBMtD9A40lUVhBb+dBSQmZuG/9AMznfhKM9wTLfrhTKPoRJ0GbJndDCvQovtemow+iDsHvdaoX7sib2jDHwQUcQw29q4clVIhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZYL5H0F/; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZYL5H0F/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD/tQjCLIaE74uvsQ9LhkIcgqfWO6+VlQEgdzvQ7IbG5h+PoJpI7zkN7YVbdYP7rD50LIyTcuULBNtxDJcLupG2rOZBoX8QqIwFuAEtY7CAj+3WHcwV2r5fx8SYlJungjHvrLrET3Sg9f/kdHiGB3nx1sWOmyGQqfu/jkL2rUOWZbxA25ZsaLqPGHhNY3b0+DmJf/AGP46vZHLhqN/Nw+7bGNTU7eJj1qvJ8EbIrnFnCKJ2WTwBz2zafLY29dIcVuUagr7iT03GbNjLrAePU6Pv4mLIfO8LPDU5aidVBumKeLGnm4lNF6Ko+vV5TunNEDnci86lHWFfE7Ec2LMCptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eocNTxgGATp5a+tPMI7561PBW2QyTQgalmVenjtWuNM=;
 b=cSXyvWaH2L1OCtEUUHuHyC1SwAimFGL7/Dei5J7GdbUifFJNKnT3snJEkXXxFTxtul/CCOAB9cLeCFhD3AhUMY20e1SIl5ucr3sfaSQ3miEm3mj1twT2J/M3c1Vd6CzT4WdUU/EHbrva4HAChdic+v7j5dD8R8zWPKMar9NGajZGlRl6KPK84dP8nIgH/MK3t/ygoXGJmnT9ztRHVLILEFNmXoMqZQIh8JEdU8eypMpIVsN33OudTzZxJabXkBS7Pk6K+PRP8W+vukXZeDOm+MOcj/ynfhfxJoJq0iihM7hefgx4zGElpKAC7guZauW4csaMJlrKJnz/0LvwjfrYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=disroot.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eocNTxgGATp5a+tPMI7561PBW2QyTQgalmVenjtWuNM=;
 b=ZYL5H0F/Wzpg+UCsmaEurFSoghCO5e7n1Pptx/8qWFddDLavnauyvvVGaUGLz2vSY/xTtxpUrVSMzsy9gmjCvCi2S5z04Su8riDY1aAvfJnKsoOFgClGiDKmQO2wBHi4uqtRPi9BW8BTQqc2kxFftI2wPkqw3CW0Zs7udGHqMwc=
Received: from PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::16)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 04:50:37 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::43) by PH8P221CA0064.outlook.office365.com
 (2603:10b6:510:349::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 04:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 04:50:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 23:50:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 23:50:36 -0500
Received: from [10.136.43.95] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 23:50:34 -0500
Message-ID: <066e9b62-3479-4709-b9fa-cdb0264fbd7d@amd.com>
Date: Tue, 9 Jun 2026 10:20:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] cpufreq/amd-pstate: Cache the firmware programmed
 EPP value
To: Marco Scardovi <scardracs@disroot.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <rafael@kernel.org>,
	<ray.huang@amd.com>, <stuartmeckle@gmail.com>, <viresh.kumar@linaro.org>
References: <c97c81f1-1254-44fe-80b2-89f82fec73f6@amd.com>
 <20260608073614.5738-1-scardracs@disroot.org>
 <20260608073614.5738-4-scardracs@disroot.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260608073614.5738-4-scardracs@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b253ee5-d87b-45f5-09e0-08dec5e2a5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tBJhhx+i2Ur/qwD/eLx7YDa8Y78RaeEF/Rs3CEUIfVUSPADLYMiHEd1VRRcTDn9V11llES+m0Tv7zoaT1UF6swY7ID/+o+Sfb5RK6F3x6aHeM2nC/2YG3xP93gSHSjrFvdA79MZUA6He6TIVTuHMiCe9lOcSQziLxSFU12ol3lQTXhAay0qE/rNuSd7Tn/E1oy3ILCSAI+a5jnXWeBptQdBvvDjtRnhKjQaLHkmObkFhbSOn6JOpuJCtFhqmhCsvj4/Mg3u2vB1Y/cgeKI4ifkxd+/zHuyLRizRelryYIG7cniNRLvFxQNMWe+eNjeLkxkHSnjwlOKe3XUHFFgE+09TzBtJBc7TJmbAZ4rgsP7ae0kXaOfcoj3AZlR8/VwG7/Sg9ukgoeJuxibw2zyDVP1rz+tfx0LoH1SgROOFBjQX6HmnoXnDmRJlnEaAjsMoRnsosI4PN3Zrs21o7LVurcifCvrMPrJ/lxvMvqL18efwDo9Iv7f5BdvqKdkHHFTwjOqhSoFj78hXgpWwnPzIccsxwQsYSvqH7HuILXyvpsqKMQzhlWgknNZbwmORS6W2aKLQMFgiLzaUkFtT0oZtRYqXatPQPsLW+kZqwCm/Y2eG0oB/C4SZMgDsyjnUrp1jbCGO7pB70jt/3v/3jZuRGNLh6hVvX55RSMmAGwY030KOP4isvBgERk6S573xCPw8wgclWfk2Si7HUlEUjyJ2PtfXZDYd+iD37hqRYDSP6E9o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VtCfZ+ezgTG8lWYmzsHBooUyqkvtI4wQBlholbS4Wy9WXIy1w4o8dWhmPHmD5MJN2Mc59JyP8mCu+zwH+GHf5SEACz4vaVQjRA9CM97fL4H0Su5npPoj8vyEFn/i3bsmCuDOrmSEUKipSn7ysmIEw3VjoJMVsBdK0TIjkNVH67O7LDIzhfblWbH+YCKyetlZ4C6aqXcKm+Q0vzJvIKa+vynThG+WJRZsJ5cFuAO2bAUxVChVT7oNUdsEu9UlNMNK8Kz13LeHc9qOlONDWfHLoJrV27vc1tWKn+G4tlmtdpe0YrP0tP4x4BneLl2P8L0oalyWRurLVTBc6ETYlV0E3m4R69aFIl22smMjrApI6+PL4pz+PBOChrF7EzbT/BFiOckXvfA23EsLbp1CiznmfuE9UwkIlBNUHsvJUiVtCXNoPPzl4JuZ4I9BSfd4iBF8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 04:50:36.8592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b253ee5-d87b-45f5-09e0-08dec5e2a5e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

Hello Marco,

On 6/8/2026 1:01 PM, Marco Scardovi wrote:
> At CPU EPP initialization, the private cpudata structure is allocated via
> kzalloc, which means cpudata->cppc_req_cached is initialized to 0. This
> makes the default cached EPP value 0 (AMD_CPPC_EPP_PERFORMANCE).
> 
> When initializing a system that defaults to performance EPP, the driver
> attempts to configure the EPP via amd_pstate_set_epp(). Because the
> requested EPP (0) matches the uninitialized cached value (0), the cache
> guard check triggers, and the driver skips writing to the hardware.
> 
> On shared memory systems, skipping the EPP write consequently skips
> enabling auto_sel, leaving the CPU in non-autonomous mode.

nit. this paragraph is unnecessary since you've fixed it in previous
patch but Mario can drop it when he is including it in his tree so
no biggie.

> 
> Cache the firmware-programmed default EPP value in cppc_req_cached during
> CPU EPP initialization. This saves on an unnecessary reprogramming later
> when the EPP is first set.
> 
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Marco Scardovi <scardracs@disroot.org>

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

