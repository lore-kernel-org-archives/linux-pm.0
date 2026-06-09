Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FF2F1FC9;
	Tue,  9 Jun 2026 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989494; cv=fail; b=RRHv7AvUU5ShU5iHoxyPjjk3Hohbr6QEQIsgkAE0cOfDO7mNafVs6ChAIgkr/V1G0355tuRNdGC9yc032zlQF2U3PHHBOJVmpZGX8dPShMFT9uIFR0eoQEDzumHPFrkzSZEFMbyQU1rFMFEyGacoX0B/DccfXK5/7z4tkwOvurM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989494; c=relaxed/simple;
	bh=SVstsKFgPWBpG0OyM1Eah610EzNgtN0U7ApxB3rLhbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hCKQCKNcZZ4fd1WwVzGTI9Sg48E5/NzotR/kvNsa3G2cZHLReyFPweJFS8ZNdgifIDskKHBIbIOdic663mWQQGd7CAyTEZyKYmYdvjobsI44znMz6rucg3VPF4Y35G+ZiZXPys9I3QFEGC6CSU5kZ2NpwOMgy5gBGfWAFJjvpPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=20NDaWs9; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="20NDaWs9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yB9YeePk5RynZh0uzg3cA/JjBT9pMiJBIkr7TTpOtBs2FvC7vfR/S5OKlNd7o0nMTjJTivyH2D0Lwg2ysoaEB9T1AkWx7DwCP9yl7rOzm0OfaIK2AhyizblSFKjJr3niWF7jtIvvAneOyOZaB856Yq4EP0odpC+wc+/BSl/EGAuoUo/SVAqgTHxkhnhfiSnxXvm+MBRLxOuJ25IXpj6fQsGYc4SNmhxMWl04ySmq62AJCyNcv29oBUbwrDkdbZGUEATZwSy4GtZFmYTVigIekPLaZ8KdDOiAHKglRcIKa6VYnO3TXqfVTkt8RkIuzVK9dZqDqFT8PIbmtG+UHuvpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B51sox8uN+N/0KTwGhLdTKCRU8FWd3LmVeuj0X+qxDc=;
 b=ekRal6FYDKf02e2MY2b0Pu0O7P6fHL2ooFBQoQ6WrvGJLXfUgZ+3zM58NfPuhvcX5P8TjNC1EM9OSX1/uWnEOLdy9UdkCEGjyVFjpHywJw7MDZ5OudZGY21J1+UFEb3YCC/JQJ6lJVf86wepd1Zp2HKKcQBf3zSB2LEcUwCXZKfzQcjHUJYnPFTR3R/AkPsjFwvhGaPmukdrgdtn5/Q1EdgMbsDD0LSUckbs9hD2bYwrQHXN5UCjg+TPrieEQTR7DryfcGzLCEAtDQ0Do0pvTOdEfEbxb9ycDK6Z6xx4hfdjd6vRTfPxMJy2fvGhtaVdFH8BFw/v0Q1F/o1j0mtdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=disroot.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B51sox8uN+N/0KTwGhLdTKCRU8FWd3LmVeuj0X+qxDc=;
 b=20NDaWs9P6ojVHr9AH65wsQnDlx4vnxZ9DBluw7pPCDBHIoT9lhIIlcBi6qZm0Xvu6niQkoEXwwxpeDnoMHyKhR7V/kRnaheRCDrx1eFN14JonRjRkYVnz0pVozfK049fk3tCjiev3OMkQgQQeAUybBJFB6lS31PCkDG++ofmE8=
Received: from PH7PR13CA0010.namprd13.prod.outlook.com (2603:10b6:510:174::20)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:18:09 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::33) by PH7PR13CA0010.outlook.office365.com
 (2603:10b6:510:174::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 07:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:18:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:18:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 00:18:07 -0700
Received: from [10.136.43.95] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:18:05 -0500
Message-ID: <d8bc45af-d8bb-48fb-9f3e-5188c8d79c8e@amd.com>
Date: Tue, 9 Jun 2026 12:48:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] cpufreq/amd-pstate: Fix EPP and auto_sel
 initialization
To: Marco Scardovi <scardracs@disroot.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <rafael@kernel.org>,
	<ray.huang@amd.com>, <stuartmeckle@gmail.com>, <viresh.kumar@linaro.org>
References: <c97c81f1-1254-44fe-80b2-89f82fec73f6@amd.com>
 <20260608073614.5738-1-scardracs@disroot.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260608073614.5738-1-scardracs@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 690aa791-2d4a-412d-56d9-08dec5f741d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KR23JM1+ikYeINn8IlmC4sV8tjKygPHrXKTZMt0lGXzhpzJLbI4xJU4kENDu1lEXIL6F8trjyYcdGXlfRGDD5iQ0593iRUUDK07Kd5fesfaJfVcau94TI0FsHr+6Mp78Wq5r9rDmLfXArbRTveNy1c/o7Wzn89ywm5shKPlESpF8BrjWgJTGCL5gpav/H1ifAIQ5Y8QTunFLPznVJT8C56uktBUx+zNzLDH8X58JXsZkeNaVxMdDK5Y/ixbv4Sk80zFaCodbnGyQg14hHOheqbBszkDKTuqbuRZIp5MlGuz/vIdJJ9ESjaFM0KrC1z+WEssz6Mzw70I9OsEyhcLJM+bDIU2vjhwIkzRcxnZaamQb9GdOC4ExVGdTBrDay5U5cJTqvK8yvmZncOZG1e9pdkBBEh6Oh23DranQZ9H3d6drjiHzeyo8lUfIQRLWr4hz3bKA0MFuuG+akfz+GkDWx2USu1nWyu8IIto+erR3U0XSPohDr7urPAzyatA4+egeofr80isL50M3Ht/R+BZYOKbvs4KJ+PgnY7vr7LYkGZaho8Rr4YyHVdKwzRrF6IcXeoWVhraUD2tC6vCSvsM/F7DZ6hQVgaGBb31n/q/5UwccOfhUyKzQQVnZNe+pmCfF+uazb0X4UPOK/LWLGT3j245d+1BS3AmwnGgpV56JljX8TSYpfhzcMYOOKSikVIi/DF2ywIkTXiSnuYJIUbJiWfzPhUj9uYce523Tw08b08k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LrUiNz/C+FgiB2UWXTudjL2xd6BQ4c+6jRSzqWbc7aJAITm5HY846Khi5WcdvDNDSbt2Wr0zqnFICgS3YmkiWYoOyAZfHWiorqGTFvWWP7yPmas5o+VLklUUI2drsesib+hnc0qqMAYwCP8neazdWXAzBxKj38oE/95nZ4IVI0Ph6OEETlxl66YIDWBML/GQpDVV1wTbnNoQvljsxyyDVPb5dPLa/l8HfzqJI3XNWbayM3LCzGs5s5pni8JLd+KBcuqSNOMsoD10V6L5sUMFLUPH7L1h6sqd6T5ll+9c6r0niPYP4NMIVNVeVnpUKSVgTSa1PuHDNwf3R734OZGRIN95rUx7b1qfQEIOnR3TGrCmzgCeOnRj2g+Nv3m8qdqrAHYHYp3C7aQM7jhhXEmMcBHDzPgbPWMCJDubDrYjcsEo+BDgPAir3Z4n79iKF6Xa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:18:08.4333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690aa791-2d4a-412d-56d9-08dec5f741d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298

Hello Marco,

On 6/8/2026 1:01 PM, Marco Scardovi wrote:
> Hi Mario, Prateek,
> 
> I don't mind splitting in more patches as far as it works and make things
> easier for you on backporting and verification.
> 
> Changes in v5:
> - Split the unified patch into a 3-patch series:
>   - Patch 1: Change EPP helper return types to signed int and add error handling
>     in amd_pstate_epp_cpu_init().
>   - Patch 2: Remove the active-mode early return check in shmem_init_perf() to
>     ensure auto_sel is properly toggled on shared memory systems.
>   - Patch 3: Cache the initial firmware programmed EPP value in cppc_req_cached.

Thank you! I just tested this on a Zen2 system and everything looks
great. For the whole series:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

At least this time I didn't copypasta my email ;-)

-- 
Thanks and Regards,
Prateek

