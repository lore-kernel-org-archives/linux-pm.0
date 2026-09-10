Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086303AC0FC;
	Thu, 10 Sep 2026 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025551; cv=fail; b=Er1fDv2Yv/ETE7jeYMuEeS8yvs+KjcnLvIebf2RfG9aUuAHkhCOyXszkOEStreA24mvIur52XyFBxopIM4mlJIbHAtHgxTMZuj78xXi4oaqGi/nxLlX2I4dCszu7XIT580iKU47PfnD/kJ29XeIesVZ809E9NmUE5YkV2vUIeeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025551; c=relaxed/simple;
	bh=J3ADOhthKTF9IFebgLITi7HtFXM0xf2Mzd0/b52zCVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qcJ4MbvcWjm2bOC/qM90/3ItXrgkkNgJbfmb+Ooj9ty0xrwwSiE1c7VIaYXb+fv+1ehIEAXnfyIZ/+tIvSYDpncS4cVdvot+zBBrbzLuZZhRUOEFkqoYvfMjyRVaW+nNHQnrmEbwhHe7kASL7izKnBXfNxUX3WFdd4Afk0lUmxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HR3Sm+nj; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HR3Sm+nj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNHjL2Y4WcIfvVaTsE7J1uqt433qurxA4OaA0t3TleCn7gsfn7UAIxWeszsRjpyuUFm7wFiTHO5yQJiQsDcWi2yn/stwYMhpyY4J3TEdoctTPEsOiP4P7xDnmOYzSClvezMMSNpdic/fm1k93QXP77Vs7mVcUo2Kx7Du4pbZpBw1GH9qTnzoyhlaupS1C0bZRA73lVdKPdWMPdLY21SGIFeV+co9XS9Cz0aN4vuXeeiQIgpJ+HL+Rh3Ec5BvTLbJ8IBpzXyWKI1e9iPQZCKPHmBpr9CHYSBkwkvb1b2Aw6dkeAgwRhKYJvdNeSm1LMT9kMjeu3tRFPAnMfMtWRtr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnxr3tm8SVYvfFuJLIsEGvFF8C7830ApA1OyTK7h8sw=;
 b=oO1p6pTP958a+GjVtygy3Tf4n6XVrud8yZ67Pvc5u2DDTkDeNK1Is5ZCLV4iTOGp+h3Iuj8kbTQVGIekv5Y8g22KLHDgTWJEFGQDvWXKT2G2SfJ4vog5vf/B74PHLRUCE1uMsfQeHFI+UiPpGm2QouHFCmMHBz3S1ki4hDuCGCA21FbZJHWXu3235stBhMQzNYdjWEMvbPuvGbPUPeanMFSsDLZjrNY7079sPJs3QlwUTTutDI+zBHVaFUKxVxUJov0Mvik5KrJsWU3zGTfFxIbivKHltsJ6GJCWPLuvxKRcTi3SL/mDbJXMMLetV3DFf2JT8zFHBKSU8tfUopzbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnxr3tm8SVYvfFuJLIsEGvFF8C7830ApA1OyTK7h8sw=;
 b=HR3Sm+njNUnTOkgnTv3QNPzzrW9P1PHTSQ4Aps9NgEy7amgJlPDuyGSU2pzrWMkZbiBvpwbqmducNgoMeVd07h/xQIx59Sd9RwnineATudZjKzQw489Jm9PaP5KGIWPPuebB1NtYYrbpSgboUBl6dzKdzf9FyhtRG9/kxRRqxuM=
Received: from BY3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:254::7)
 by CY8PR12MB7539.namprd12.prod.outlook.com (2603:10b6:930:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:32:27 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::13) by BY3PR05CA0002.outlook.office365.com
 (2603:10b6:a03:254::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.4 via Frontend Transport; Thu, 10
 Sep 2026 07:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 07:32:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 02:32:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 02:32:24 -0500
Received: from [10.136.42.177] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 02:32:22 -0500
Message-ID: <15beffa4-aa61-4e9c-86b8-764fd43989b7@amd.com>
Date: Thu, 10 Sep 2026 13:02:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add support for Zen 6 client EPP tunings
To: Mario Limonciello <mario.limonciello@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
References: <20260909033623.454449-1-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260909033623.454449-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|CY8PR12MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: c1046fe7-da59-406e-ce78-08df0f0daa35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V0ou9UENFUmFoVnyCSWcILGtzN2fvhJskWTSm5L0kGTWNz7Wwq3AHi5naU7DxbG0tI48exGxgyEzEN0WilbFGIhFIzfk6XIqSRH4il4/mX/PXSsGILdC1icuV9/RQL07hG5RLg2iaFlMmRZ0XpBb7t9S3EtqzVHarPI3Hw2x5MVcepDo0XZ/hicWE107/hlvxhh3SK3/eGy9NuMjWiBcmHwiLx99V5/ALXD9oTwSJNmzDsfq0UXToSQIrE495fatUtomLft5OzdT5AEiImALw28H4hzMmv3bRY3GMuvog+y2BAXO0ANxXyi1cNwqkGm4iGIwDNsV/Xqp8edWQnKUdw5AZT76wR4oTMjDPjyX32H4p5NEKqoCX0xwYAc0TyPfQNwyI40BJxQAmr2Xf2sCnolE2GyXxA/Q7DqWk/HR4mq6NBEQKJfDw+z1ufphZEUrTPPj/Shx7n5qGczaynEIHfvS0fMg+WeMl9gncJUKM4Pt5HSznHE56nmfvbIfyZr88TgMVbrgbgyNYCdupdNzwkTuAeuPX/wtEiHU4mtA46MUTHo3GB6EOkreG4LgRZ2KYlUaV0IE7yM33DgSj1TRX6wD6VgG3xqGsJJkFzKo58vO7vC61ia4UMQO3qVz8X8+cPOWY5BFsgjywCZtWD1zcQJYtwY6S3BIpVqca2xO4kXzfUnLan6nc8H+QF9u+pbhwcZhBKrAT0/XWv3TgrG2lw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JEe22hATx0rxig5CgK+94tP3+wJOYxr1aKZATtb/Ls11fDYkYXBhr9UEAGgsSjHPnn4IGy1CLIOVvABeVCVdcM7PF2A3OFRj/R1XaEAd79rYtM0aJ62evNq4CK53Rnk2Ee04bxqwvaQmq+tHTU2JmiXbjjrgjrInMGXV2fCAC0Abfb/+L0Sdz/zoAGT7sRBcWD9HWwamLq/7HR6V/2TrXzYbV8w8bnP38eGiBnm88lMOSKI9g3Ge1AaZ1rvo9MkcSfSjxpS5SW83yF5NRjRZpLkl1EwJaPh9cOFpwvxNBDaUSzKhRlfULJn3TGkB/+1L8MvHyRBWwOxMu5lIXuUOvIxs39w+J68qdECBvdLORXqfan0uvJOlvFbc/HR0wqs2wFX/sVJ8bzTl4A6d7VwxaELLUzgMT7bs3z6J8o6Zq49OxqGVBgRk0zpDOYDQJNDE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:32:27.3223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1046fe7-da59-406e-ce78-08df0f0daa35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7539

Hello Mario,

On 9/9/2026 9:06 AM, Mario Limonciello wrote:
> Zen6 client platform firmware uses EPP values differently than previous
> platforms. To optimize performance and power consumption tunings are
> applied that match platform characteristics.
> 
> v3:
>  * Enhancements suggested by Prateek to patch 1

I took it for a spin yesterday while debugging another issue and
everything ran fine. Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

