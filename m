Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793329893;
	b=aMYM9bXalJw18lux2HNDD3Ce+GMZ1VQLadkYyiorjfm/zMpH1Nxc8rsiBgLTv+jf4rXc
	 uzlxPm0HQ2UB192jhC5BzbAHRD0ie01QwrqhrqkDA0umlN/66qyUNiJHAZH3oSp8TPv9/
	 6aG37Q3LBw66bPrJ2h73WTV/ihUyeIRdf6qb0vP+aU3NU1QaU7zQcT8YCh9ZUzc7DlGLp
	 Klp4qTfvdNUQrXYUNm59jz3lZaOjwenMrrQKpzEbcEMzm2U149TT9dxVxFlVFSWOQr7GC
	 KsiJsqBrNFz/zhm23aw0DgZk6dZzteztRjI//WuTgz2HUFX2Syzfmh4f3RHLQmLrHPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=d0vJaYtbtA91+Vf/GaOQc33xhrhE/oqWDifSAWuAHcI=;
	b=P+1IAZxk5bh6qYRDEDaiSvAC6xXSocFRDkmgFwdMruOmXnMoMCnsDgCAr4lS/bhXDh4s
	 +dFqRJBGfcBG8/eI2kSwmp77A52RVXO7HjspLhbOuxofrhXb6YqCkB2/pTsVQfdxIbhr3
	 nFlax1ej0Ee1sf0A0n95/6i5v75vb9LGJrZksETOqZxaknOv0JOa6gi+ngyK1+vaz+VLV
	 pq7AWY0IfphhpT/KnbzxHtWKX4f1F+Xl1Y9m3nobvIcTHUxQeoSeZYSXmi8rlVQVGj8hk
	 M0T5dKrXYKTmxzBfMbDk2gdQBmGZzya7SYgfuPYlrT9RvOmgNptACjPfbVeJxdcF8LA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MWEaTqtC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.15
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B1606A31A;
	Fri, 30 Oct 2026 03:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239B1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MWEaTqtC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONK+ODdhW18owO1nTIjn1zheYQttU1nh3eg37/Am2oGah9qNilVe1tGspWJaPegXoDrkXrMKZbyZ6BNIs0/FVIce6Gnhv1u1yTDsmTTISVSxu7IQgY4J88vJDDNLiOoYqeGZAM5hG0P3OqZrlKWiS1x3hb35vUUgIy1eZViSdhMhEoFOIR9p3/pOKRQh7sliR2bL0Cxt+98brvLDOcVeEprqRMitxk97tGyXMZXkpKjhjQkOK0lDV7eLJPxfl7C+kD1rSu2VNL65LyTZXyWRmj60PsMvjVy8PEMtZyDnrXWFufE3BQDwZT5UraR1FQzHaNa299vhCOw3W4FHz0PWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0vJaYtbtA91+Vf/GaOQc33xhrhE/oqWDifSAWuAHcI=;
 b=Q7CgVVvXzLdsZxMG7Gynfuj9Rv5jLxT9kMtR7wYwWG66j0dincnQgvpSDwC7SZdIjsXR6ESkra4mdyNKM/rChBr4N84qMfze9iVDLWTrDIaKxo0uvjtkmhdvF7/PUiLlZl9fUYpCcsUIJTw3WneOqY+5rzf7kx7v3zo7wJkj+ssuTdjvjM69oqbw3NQbQmX9pMQrznwcIq+IPoOBSvulxSCp9Yq5RDX+/nX+P+VzCJHDyNQASF0nODs8eBgIKJqhN3wJnA5yklVZnv+jMZbS/kEN5gLOFuGwqfNH+E8gNXWPmgQb6Q98UT05tUuvzqL5RcbOyZIgukAegaEf2DpiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0vJaYtbtA91+Vf/GaOQc33xhrhE/oqWDifSAWuAHcI=;
 b=MWEaTqtCdk2G011NgIHBp1juITkf3ceahfMWETt4ncrblDe6QqLwvTT/4s9RPmRN7YzPrQGJMkeuG8X/Nc6UEsr1QboECbyjeaKpKCQNFa/mh1ROpsAQxerBM3pCDa4Kb3QLDDpZJ8Whf0F4pkOFVwOEPAj0IvpRbW1mA9sAfc8=
Received: from SJ0PR13CA0092.namprd13.prod.outlook.com (2603:10b6:a03:2c5::7)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 03:11:29 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::47) by SJ0PR13CA0092.outlook.office365.com
 (2603:10b6:a03:2c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.3 via Frontend Transport; Fri, 30
 Oct 2026 03:11:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 03:11:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 22:11:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 22:11:27 -0500
Received: from [10.136.33.84] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 22:11:24 -0500
Message-ID: <aa198417-036a-4531-b8e8-6cb9c4809d2d@amd.com>
Date: Fri, 30 Oct 2026 08:41:18 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpufreq/amd-pstate register write fixes
To: Christian Loehle <christian.loehle@arm.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
CC: "Gautham R . Shenoy" <gautham.shenoy@amd.com>, Perry Yuan
	<perry.yuan@amd.com>, Huang Rui <ray.huang@amd.com>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261029121945.854675-1-christian.loehle@arm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261029121945.854675-1-christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 547ea344-b641-4717-d0f0-08df36337dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|13003099007|56012099006|11063799006|261022075727099003|10067099003|261028144727099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	MOuc3z4hwU/NY/QtpWcqUsLS+7CbnqSoPNIvRF5NIWsAm4xe1BUSa9MyoMv2PClJ5sR4slt9qKrtX3fD+RVhT187yHiNXACbSd9op6/t2KnT4RXQR5fST8SBp7cyV+qJ/hi9Jy2y2OC0SdIH6fR9bOOTD9Db1JSx2/deTRPMNf8171+hJx44KD64ATV+bUI2NJl6VzzVWdO6vc1ILSgbRg9qehzIKkOxXmXK8Ss6P+L7LFWFP8+CnW0HlOmfJyfuqfB5hY7gaszzDj11E0fYf9IM947erX3R0PlMAMz0kJE7zn00DewJMEdxiRQKsp0qBQSzQsyG1QfaP9FW1d+yQc6MvblehsiixVZPZ0o8ten3dWkHNglg0OOPoRFYRCvWDNtfnl9y7Gvm4dg6sjxaa+uVzhAfjEJqpR616xUF6qWPVi3FFPBN/vZ9KSOStm0Rhib+x0grbOuJFuIXmbdOSyf8+1WMr0lPjRKXMM6KGNZOQe2qzEzWL1wJQUF5QttVvsp298Vc2Btdv15NyvHgWs/SAkDOJHetzOrT51ylCmRPzrD0jzAfyje5CqKbeV9NQG0usdnn3UCGGpjesScxkzd3+HkgWqZkoWdKNhAoREnK3A7ou6NnWQioAoYhfs0PFZS78ax944O+L5EkQ4hdylzA4WuomoyvofCwW+cUdBY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(261022075727099003)(10067099003)(261028144727099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V/ShpqiPJB29PLVqmXU7qhDByzz6dLUlZMUfqB/1oy/FBkphWuFFfeiAPVvvKGcpPGfDj1fCV7zGIU5HlKoqqQg9NJ7CEbtWN3mBcAmTbEpIbxgv68xSivqiPCHKWuEJ1jUfzhvlBBaZoMWE7N8NjHBa8avLlViBof77LZ2EJBzm7TI1cmJ1GAg/5VzKEMwwNR/FJyxFNYSTeLub1FKcB5jO+tk6Gz16OtdKcbsGE0B5zOo4o6c1R5gt5KgKSmvdsgNenAQLeAQ/OLNGC8wGqaZGTItk9J2hkKIqUb7gFSN+ufhru5feg8N3tp3BzDASliy5GeKSWcV2817+u7LRuVE4Y+OFMVUuieu8flEOD5kzCl5mddTiJ3fmFvYk3rZosBMTBgftw5sTnjcNhPsGrrHJLNGjBurD8yoglpgihc8NAh6ZqChE7/fe7Ec3KmnP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 03:11:29.0288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547ea344-b641-4717-d0f0-08df36337dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

Hello Chris,

On 10/29/2026 5:49 PM, Christian Loehle wrote:
> Two issues that popped up when trying to integrate an AMD machine into
> my testing for acpi-cppc, in particular for this (otherwise
> unrelated) patch:
> https://lore.kernel.org/lkml/20261020121846.691218-2-sumitg@nvidia.com/
> 
> The first is rather straightforward, I think the case was just not
> considered during the refactor of the Fixes commit.
> The second is part of the resume handling and was introduced when
> that restored the register values (DESIRED derived from policy->cur).
> My platform seems to handle it well, but it's still strange
> behaviour, so why not fix it.
> (Also of course the resume value will generally be overwritten and
> therefore 'fixed' anyway.)

Thank you for catching them. For the whole series, feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

