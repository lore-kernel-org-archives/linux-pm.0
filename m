Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C406285CAA;
	Thu, 11 Jun 2026 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188398; cv=fail; b=oASzZrIM/mann9roCqRGn4qa89cG2OF+AFxU0C9xi/XTSxE/TDoTKgbpDiorkbvT6RNPr1xBpCZTmShnDpxdmK63azwk5CKsAkCD2uG2WrMEBkPRf8QFW6Ss+Ygj/ag3hxCBVsVJFg2wTWamkP3izylMFGy/Mh3jNwY6Hu1CbLg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188398; c=relaxed/simple;
	bh=j6HWz9BlXycNqB+XsOV5B+nJRLmlmse3HKEOPgVAQ6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gictlYXrZ7iMxySyKdE6nXqBGTWfY7+L3EgScMz6Z72VqnWtPDFJhuwY5XgbjZpeRkj0b1pxaJagz6CymLnZR+/6W5v6iXcjDzfeobcWp7bPInQdZ4DKfl5B3KSoLz4J9jt5IDVwNrjU7A8eHSZw6d+aFUkZRfp8etAiucdYBFY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lDfvWMvW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lDfvWMvW; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lDfvWMvW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lDfvWMvW"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PrzKHbw3A5W4jm/CBMlExDxj+ThITasQokO8DTNx2wZL/jsb0zyFcOfKCXn51mMUfdZuID4sW/BvH/v9TzTikrNu/drf1jaLcDfptgDZTuUKtgfZJcjUGyiWXdj5WQDonnDF5D9/rgJ/zgEDDDGh8lu4LKriQCf+Vfn87naNN4IkJ5x961MiwA4BtUzaMRbHCOstBfdpSZhupa8NiAdAFObFRTGsdmCLnJPuBIWoa9pNQLBr77vKb6ab3MiIzLNmdFQl0Wc895q29Y9M7ElNr32VM96JsbLQdQrr423ePNDv7AYjVKuokbM5qUh+iyVI9xZL0yFNwbwuAJGo7sW+3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YEgSMVpmT4jGMwn7j4EJTnovCm223mKfQvTNV6JlcA=;
 b=VQZ4EexRu9h5gArVKfVw0Xh0klvcmHO9HSYFGwQkyx4aqZ8zUtf6t0kTZbpntoCIv4vk0p/6Yfsx546NmI8uDlHVGqMF7A2rvWalEGiD42+XMCXPdP7rv3lAj+qAJ9Qa0NsubJToOH41WP3mvZXwK91A/BlP0DQ4c/OXy31k0b9q3QW61a7C+DD5A5PLcqY01Q7rOpzibhjgOADZzSsBCX0my46WJ6+zS/an3hCgYSUYvLI1F6KPzc7KsN1sExLMn0QKD3AtYg6/KkKKhfu1BuQFycJXrOFlMoExXdUOv39UG92jdRFUyCIxvJn2XmVtg1OOxZutC3lKmK7QmjsaSA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YEgSMVpmT4jGMwn7j4EJTnovCm223mKfQvTNV6JlcA=;
 b=lDfvWMvW8Jet1/AKcQr5WRFrKrH5TfgsD+1rf65eNUAYqVcNpxHnRdL/Y4aAIpnPPN28yb1DwIcqryUbW5cmNZMORfhMjFFw3gTZN0CI1RIs9rHjng9LW9fGaqrfI2Jk0yj4sxl/5dHRRanAiNhqd8KL2zvqKfRjKEZpS3rs75E=
Received: from DU6P191CA0041.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::21)
 by PAVPR08MB8847.eurprd08.prod.outlook.com (2603:10a6:102:2fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 14:33:08 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::79) by DU6P191CA0041.outlook.office365.com
 (2603:10a6:10:53f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 14:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 14:32:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuJo6pRfuUmL46zHAE5wavyClKtGGoTFTwNwfbgXYBW4Avt3eTZvgIuQAZoE/VqPImiM3Av0s8MLGyi+qGaOxGx1OKEY7+lQOwrCduslgrDi5vRQJ2ndr1XJ8uRyBBbtg58szZApLwAZbl1Ww3AhHSGvTNs2HY2mb2bUmzdEXQB2EN7q+uxQt3xeUu/8MIE1O88xh2MSwVYUN8NQoikXBbTYuLOGT0v77d8qpbKZmW/BCAMViht2YMMfhESdH1Lk2LSmiWuITrM2lpOOGj7PU6D/jza3wzIuVSIibjhslVh9PfQ9ppffQ8ZOYym5pMYjPsfAssdpo7tVp3t9/wsixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YEgSMVpmT4jGMwn7j4EJTnovCm223mKfQvTNV6JlcA=;
 b=a/EnKHDGM4gD67gFKbFYDgYa7Kq7G1jCM/VBWxOIpNhqajntK8DSaE70gra2Bo3PkfV1cMPCpYkUFFNflH7Cw9LNGBQo56EDKCDWJBE5Nb96Ix9C77llnX9Srg3eWMsHyqDq0GIZ2XNpvHpOiguM+fwhCi9zGSk3vwz0vyWZmlkR0DojBy8SNdBQMNZzZSqmgsjdx7xr/0/pnmaJP6heFPnvdpCjwdMb0dE9kbzMt3cTum1vW7tKzLWjDnKNG5GkieyDjETkqAKg/RiVqlIgr6UxXl2gO23QGcn86y7Vync6mYtnBuEExMSaXvp2aycA62bdqBSO5+DP/U2Q9krA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YEgSMVpmT4jGMwn7j4EJTnovCm223mKfQvTNV6JlcA=;
 b=lDfvWMvW8Jet1/AKcQr5WRFrKrH5TfgsD+1rf65eNUAYqVcNpxHnRdL/Y4aAIpnPPN28yb1DwIcqryUbW5cmNZMORfhMjFFw3gTZN0CI1RIs9rHjng9LW9fGaqrfI2Jk0yj4sxl/5dHRRanAiNhqd8KL2zvqKfRjKEZpS3rs75E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VI0PR08MB11200.eurprd08.prod.outlook.com (2603:10a6:800:257::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 14:31:33 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 14:31:33 +0000
Message-ID: <37f4fe05-39f5-4e7e-9ca2-c9f5eb79ad87@arm.com>
Date: Thu, 11 Jun 2026 16:31:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org
References: <20260514194822.1841748-1-sumitg@nvidia.com>
 <20260514194822.1841748-3-sumitg@nvidia.com>
 <457972d4-eabd-4db9-8d82-b4c6a5f79465@arm.com>
 <5bf877d5-42b8-4e0d-9afd-6cb9c4b45bb1@nvidia.com>
 <86780f97-29ee-4a72-b311-38c89434b707@arm.com>
 <ad12ad81-5d39-4090-b53a-13480e85731d@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://pierre.gondois%40arm.com@outlook.office365.com/Sent
In-Reply-To: <ad12ad81-5d39-4090-b53a-13480e85731d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::20) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|VI0PR08MB11200:EE_|DB3PEPF0000885E:EE_|PAVPR08MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 27183599-7b3f-4215-d6c1-08dec7c64963
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|376014|366016|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 7X+pWF4RiZMFyBFQe4TyA0+k+jyFFJXfvsmSMb6tP+XG/k1jllZHlCUyuB2uXCMaX2Yzu3JD2a9/Xe8Gm+IqgLqcZw/E148WmUeDtzUmiCzzITtFl6lDE0SZA2/HZWAnvB8pggTxQiNVZ0o8DgTvGgCKnAhQyg/oJX56E6ZivoOlAgrb8bNcf5Qp4xe++0EKTq9BncpxejnniOPhc1xZCDvtTuh11eT+TVdRjjuqTPomHhzmaLwoYMTMeV4ZHU4NIJa1jy7d3Vuu5SOrTL6JtcokCMNLhICM77bZjeFN4VbhS+7xxOr3wvGGFKUNor9TI1RpWiYFaKwpyH92Pb0J4MR2Uxsp5hLEmK5NaxX3P/gyYIQgS+zgeixT2JQythg5myxFevLuEnUgLE1HKWrrRatXJnq8t0kVrHVzP/CqZfdN1RrKcIu32JLmr/9fBb4ZZbT9Zvud31Mi5gkE27OO+cwDZX9bi4W6PsJHpWvKXl20FaZZzNohEYIEPZWzTRnszDhah2JPPvB5SBkkbyYnYhGGWz59hOP2Gj3rx+x93Il/yN/2ZUgA2F8CFZWYLktp5Z/vbnSEVGoLrZvi6WmxWf/2EsnVttwWkbk9RH1HcvFEeEhQ5aRJZz0uoFjJa54YC0+RPa4yx5ZUzLc2hlhK5fQ+oT+lEGlZtyAJAgI+j9b8DokTYk2AQQ713zEtRGdM
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(376014)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ZO8RgPtl2KDA2v9gCK8IDeyD25ZfeGvvFSRqNm//EBVS4pMy9sMqVRF7eLHjXM9kPAr0SOgFmvfK2D3jgn6Hr/oGK/V5FJ/pGtnWFs36e2GamR/CNlOp+cBvwEhybRtPw6aLbD5IPJOe/4R20TaD4yfuzV4XDBoqAcOTKkeqRk5ptqHIB1NEUlNGm6p/CeTX8Sb4JGB+xRsY6hjzFu4dlFhl5AIoc9LUM5/lrqFZABpxByG6kE61cZ4UAeTWfUOLPKJE9RQLVdrS4nlvJ4UnxmHlTPOeHTfSHCavItpif8pJALrpHtGr08OMFLeSFI9qiaWG7mRBCOky9+WDNijyMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11200
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0b41011c-e345-4025-de4a-08dec7c6228f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|82310400026|23010399003|376014|7416014|36860700016|35042699022|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EVl7z1nvcmVuag6Agl2lnoMZbQfhJRLGN72c3dydLe8ud+OTzqZQPqKViKA7WduYTNoAo/iY7HDpBosU4Ja45jzeHGCPbrlRkpTVyFpHZL5J7FfDW9stcIKz9rx8pCBES9SGQ5e80UyteEVb8wt8+3rqLVMbeCt+QYGakGPtRF6mD9crDU6JyNCusB5G498TpyOusu9faVWZAeRGQSDx4pXEpIZYzL2Ws+kbjZ2v1WDpCBefko28f5wW0tduJaL9QarHyMtmir4F5iRfadkTlTY+Ro4c1XMxNJDObUeSRj+RvKbcMb/5SZErPXBDcqSeAXay4TIVXO3sIcBj1eZsVqs4ZdN1aeaIKkPMZt7vpCVYyt1LkBhzMahyrNJ+T5h3bgMmucp6BwNyf9Zh8Ptl59BBiMd8Y4kMtOwXWSJsSm6pLKjpmfRgqtP2XOTRHRxjoxrM7AbrcxmVMb7V9HIrH6WgqZ/1CR9rZY97VE5GBxi4dTSMh6lN6OPt4n07TM93zA+NWtAktR41DBoM3qGNMQj/Be6Lta7xsE4Fr7NNRW0ibT/ERqL9578ubAwA0ycEd/uy0Cu0bYJpMdBg8dgJO0rRhRe5AhC26/MkKL7hiqNg1F1C/AHIv1BAoD+w2myKN7rzxXaEhNqC+CSr000VJMo9J5KlFLszzuYp9giWMH/QezhqThSONGusShp+2wzugkeY9SAaSg7odN/EHm6Y6ECLe4AeXhxrBMfalyUWS/k=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(82310400026)(23010399003)(376014)(7416014)(36860700016)(35042699022)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RgmSNg81zYtCyVx8a9i0cunAWZUXuVFdH6R+WcdnNIe4WFGC50b+9dvl5hsT+t4wq6Nf8/VbHfoh+VgpjLE/DsDN2q/+AkhJlZh15cmCJyn8izzCkq2v4SzWd5a4riBGooPbFFhsTes94JrGNn8EWJJ87gqM7xK2SqavJ1AC3EpEKpbKWC2rtc2Z0xFgbLjh9vbwV7F8ClMZPBAHdyUnzx90olUZorjXZXwFrXZblarHRIfWgKJmjG6C5j/a5smxKECczDwn8/P4zde2QatPWU7HswFq4ufRSiqAUZRn8mmiqeXrJnXt7QwETh1we1cCSPw2UDTzt54ifBo0ZKWHKDiMdt5n5io0nav/HDqZxmTkpu3+XnFRQs+6AQAmCWsbtQYMei2dnr3fc5RSDTmzx4h8469of9ysWZzMnP2JJ9u6iEAqDVZFmm329V+DRjgZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:32:38.0743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27183599-7b3f-4215-d6c1-08dec7c64963
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8847


On 6/9/26 10:53, Sumit Gupta wrote:
>
> On 28/05/26 17:37, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hello Sumit,
>>>
>>> Hi Pierre,
>>>
>>> Thanks for the review and the complementary patch.
>>> Going point by point:
>>>
>>> 1. Rollback for a partially applied multiple CPU write in
>>>     store_ospm_nominal_freq(): Agreed, will add into v4.
>>>
>>> 2. cppc_get_ospm_nominal_perf() and the show/init/exit coherence
>>>     checks that rely on it: I'd skip these as the register is 
>>> write-only
>>>     as per spec.
>>>
>> NIT:
>> IIUC having a write-only register doesn't mean we cannot read it.
>> Cf. cppc_get_desired_perf()
>
>
> Good point.
> v5 reads the register via a new cppc_get_ospm_nominal_perf().
> So, show() returns the register value or "<unsupported>",
> and dropped the cache/bool.
>
>
>>
>>> 3. Initializing the register at startup and restoring at exit: In 
>>> v3, we
>>>     dropped the unconditional cpu_init write so user values would
>>>     survive CPU hotplug. The spec also makes the explicit init
>>>     unnecessary: "If this register is not provided, then OSPM must
>>>     assume that the OSPM Nominal Performance value is equal to
>>>     the Nominal Performance value.". The unwritten default already
>>>     looks well defined.
>>
>> The concern I had was for the scenario where:
>>
>> - the driver is loaded
>>
>> - the user sets an ospm_nominal_freq value
>>
>> - the driver is unloaded
>>
>> In such case, the ospm_nominal_freq value will still be set to a
>> non-default value. The modifications suggested previously would
>> allow to handle that case to come back to the default value.
>>
>> FWIU, we have:
>>
>> +------+     +---------+     +-----------+     +------+
>> | User | <-> | CPPC    | <-> | CPPC      | <-> | CPPC |
>> +------+     | driver  |     | reg       |     | HW   |
>>              +---------+     | interface |     | reg  |
>>                              +-----------+     +------+
>>
>> So if we want to handle:
>>
>> - the case described above
>>
>> - the case you mentioned, i.e. hot-plugging CPUs
>>
>> maybe the scratch values should be stored along the CPPC register
>> interface. This would allow to handle complex cases where CPUs
>> are hotplugged and the driver is loaded/unloaded ?
>>
>> Note: the same kind of scenario should apply to the auto_sel register
>>
>
> Right.
> After unload, the register keeps the user set value instead of the
> firmware value. In a follow-up, I will restore the firmware value on
> unload and reapply the user value across hotplug, grouping the
> OSPM-set registers together (ospm_nominal_perf, auto_sel and EPP).
> On my test platforms the registers survive hotplug, but that isn't
> guaranteed in general.
>
> I think it's better to keep the saved state in the cppc_cpufreq driver
> rather than the CPPC register interface. intel_pstate and amd-pstate
> do the same.
> For reapply, will use a CPU hotplug callback rather than ->online/
> ->offline hooks. Those are only called when a policy gains its first
> online CPU or loses its last one. cppc_cpufreq also has shared
> (SHARED_TYPE_ANY) policy, offlining and onlining a single CPU
> keeps the policy active, so neither hook is called for it. A per-CPU
> hotplug callback is needed to cover that case.
>
> Let me know if you have other thoughts.
>
Is it necessary to have cpuhp callbacks ?

The cppc_cpufreq driver should only support:
- SHARED_TYPE_HW/NONE: in such case, the polity should
only have one CPU
- SHARED_TYPE_ANY: in such case, configuring any CPU should
configure all the CPUs of the policy. The only issue is that
we currently don't know whether the CPUs in the policy
share the same CPPC registers or have individual registers.
I think it is currently strongly assumed there is only one
registers for all the CPUs.

For instance, if:
- CPU0/1 are in the same perf. domain
- don't have the same CPPC registers
- have a SHARED_TYPE_ANY policy (i.e. writing to any
of CPU0/1's CPPC registers triggers an update of the
hardware for the 2 CPUs)
- policy->cpu = 0
then:
- enabling auto_sel for the policy means configuring
CPU0's CPPC register
- if CPU0 is offlined, policy->cpu is updated to 1 (pointing to CPU1),
- then reading the policy's auto_sel register means reading
CPU1's CPPC register, which was not updated

So using the already present online()/offline() callbacks should be
enough. It would also be good to check that, for a policy, all the
CPPC registers are identical.

Note: having per-CPU CPPC registers + SHARED_TYPE_ANY
policy is theoretically valid, but unsupported FWIU.

Let me know if it makes sense or not,

Regards,

Pierre


> Thank you,
> Sumit Gupta
>
