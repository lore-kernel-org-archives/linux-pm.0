Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935B2853E0;
	Fri, 24 Apr 2026 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035443; cv=fail; b=L44s54/AiGIAy8P167+YY09cCnkCGv673ynQlukg0bt+KFUN4/rU5R/ss9NblvpAP6wm+YPJJ6cAmNebUO5GfC94u43lRRD8iJM/ZWw+DGjruhv/PeZS2+wGNqlPTXpznD7NX2Rn1lcQG1MdQSUu9rCDku88ws0xANS0HnPiHrs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035443; c=relaxed/simple;
	bh=uoWPdyuNb3gUPNTrqrfjorW4XX14EM5wSyYTOdEf/A0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CvBnKY306F3srm7et8yHdj7U7XXV7EA0JOSFh+pfklxBSN3U2fTsyAfDXgkxSRmDYG8Se7wLO0cuIc0DN2yAqbtOK8qqlw8wxqvi6kuCcg7HeWATXSnVd1+V+84bPwDVRPDfT1oHqev+WozHLcY/aDXr2rCHce02JNvNr9t6BSc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=izYIz9Mw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=izYIz9Mw; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="izYIz9Mw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="izYIz9Mw"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PgkzmioDTkYsQV5l/usCUyEwb4OJUjNIj3elg2kWBR4C/jg53boHuB4Q6XrAdyPlVMbRxnf5krWk1+rVpJIfmiozx0Ihr5E7OLkfFVXxROW4YWELdcPtY0TGn7agH85QEgHcaSSrmVHayvT5Z8GBK8FWBPPAGOilMQVfjS3kpUJdB5abWcJuUTLRvjEqsE4P7zaZreZt6pWoU4hY/63S8ZNea6oPMvfRcSzExoFvNUhvVoMd1mlSsg6KPf6X3d0cgMBH1DcoW0HOXzpTyDSKklnJe+MvEYoFl3S+qF8J8v81NVPFPgjcAxwM0mj7KZkRpFST6znqqwB34724P+enVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDmouBAWP00821EwFCvLgl9hyS2RmnyV2az0cm38R+k=;
 b=ddWWfSQjD0z90yoO/0hSUAygGfbVF8GnNUhARCU06w9OJkFLiNHu7KUKnHTzWBIQriiVXFgqxEztoBnBsH/XG3GC7SK0BClwxYMj5inDNIYByVV1oJSqVcg/RZ02dJJth1F+l5JULoHDM/GqN4WkpPMwS4VzPpPMz+2pwPJ7nQEP7tI9xpKT1taxQ7/xLO5JQ7EgYkgY9RCHj+t0kCjj//HAJ2DBI7jzk9C7ektmDODsEZ2KGHB7arbxFFd6ZxJYGww8FFlmhCnp6LT7XEnNNhWjND1qAGjgBKtHbajzfjGuJpKi13+JN/7D5PE0WLGJun7Za3Kuvn7PON4XOj5YkA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDmouBAWP00821EwFCvLgl9hyS2RmnyV2az0cm38R+k=;
 b=izYIz9Mwos+wPInnQ1bnmJZLoZpvroyKmnh7yNzOM2D8H2zcVanZbvGGZBKvnZdaxGnS5XxZdBWIybNMIlqBtfU+lCRPtgA8AQpyxEAPTq7mwGY3dx76a9QbbEHHQSPxPwtY1gYQEvqYW9Tma4P2lqh81wQA51ukaMrvIeSf3/s=
Received: from DU2P251CA0003.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::13)
 by DBAPR08MB5733.eurprd08.prod.outlook.com (2603:10a6:10:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 12:56:56 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::90) by DU2P251CA0003.outlook.office365.com
 (2603:10a6:10:230::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 12:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Fri, 24 Apr 2026 12:56:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/yXif/9vhcSEwV77PgqV34fx8+QtBKcuXlx4XC9GxgcyBL5IMngI2hbD1pdK5NDEs3lLaut9D18d3liWpTbfdgC2VhCILq/8LarV3ZjHky0Rte2vzojJElW2iAPnTcgpviw3Tm+u+IhXKv84pEJbdsbENsj0TkccwZRrJJ+vN53hnlxkhcG2i2rr0hggpCqWbcNhO2oNa8Y2vaEFpwtBn3Qc2odqb3iFqy3PitkUQIgKdS55gXiVNWXWlQO5vEZMxAz7iubAEM+UeBBAmIUzHwRqIQ1iWOGzSvykZhPZVtgdd5P7I4VKL57ILYpZnQWUdGbJ8/eVoXviroxf7jJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDmouBAWP00821EwFCvLgl9hyS2RmnyV2az0cm38R+k=;
 b=L7iszXkpsWw2AHKSFhypHFHBYUDD+c97SF2ccZf5A50rwA+Crq5dtTgDQkmWadM05BAjOZpoolYu+LbrZQRUydpFezRrqTmh0KS9Vz+epuDRHD+PKL1lqV8iT0GNKte+A9JP9qMXwyXye7StekkbPwiYTyOr5y35K99e3lUOIzKHEzpMidTX440uVBgcCTkCMxrEqsg+glOzA8APVMKbrmvMqz1FF1zpTTLf6JwCAdtZT0SJYQ67vmRd3gciR9884wljl91/nmvCDe0MGHVfXzU3asc+LJExmz1xd1MESN2gQD00qGI7jaC7qfFyXUaS+ICQgwABp3QS3EJ2t6bmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDmouBAWP00821EwFCvLgl9hyS2RmnyV2az0cm38R+k=;
 b=izYIz9Mwos+wPInnQ1bnmJZLoZpvroyKmnh7yNzOM2D8H2zcVanZbvGGZBKvnZdaxGnS5XxZdBWIybNMIlqBtfU+lCRPtgA8AQpyxEAPTq7mwGY3dx76a9QbbEHHQSPxPwtY1gYQEvqYW9Tma4P2lqh81wQA51ukaMrvIeSf3/s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAWPR08MB10090.eurprd08.prod.outlook.com (2603:10a6:102:367::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 12:55:48 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 12:55:47 +0000
Message-ID: <aeb16dd2-0eb5-4fba-9b45-b5ef483ab7b4@arm.com>
Date: Fri, 24 Apr 2026 14:55:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: add autonomous mode boot parameter support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>,
 Thierry Reding <treding@nvidia.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 "ionela.voinescu@arm.com" <ionela.voinescu@arm.com>,
 Krishna Sitaraman <ksitaraman@nvidia.com>,
 Sanjay Chandrashekara <sanjayc@nvidia.com>,
 "zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>,
 "corbet@lwn.net" <corbet@lwn.net>, Matt Ochs <mochs@nvidia.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 Bibek Basu <bbasu@nvidia.com>, "rdunlap@infradead.org"
 <rdunlap@infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>
References: <20260317151053.2361475-1-sumitg@nvidia.com>
 <4b1f100b-e699-43c1-a06b-5545056d174c@arm.com>
 <b8debb30-67a5-4d2b-8c08-8fd287f7258e@nvidia.com>
 <208360b1-36a5-419d-80f4-431914407f61@arm.com>
 <0fdc7e64-31aa-4bfd-ab27-dea2f349693b@nvidia.com>
 <8349bae0-ec72-40bb-a6cf-6232d8c0cfe2@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://pierre.gondois%40arm.com@outlook.office365.com/Sent
In-Reply-To: <8349bae0-ec72-40bb-a6cf-6232d8c0cfe2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAWPR08MB10090:EE_|DU6PEPF0000B61F:EE_|DBAPR08MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: d77baa69-daf8-4959-dfd1-08dea200f76c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 eqEhgAMvc4arkJalF7sdWdu8N6s/VaCa46v/2EGELxH1NK1F34kFBJODsU+5CyREV/PMT8FEXDMUoJzwC3PVFZ34e3L0Qq2HDHhHRg+hGjiGx6n5hd2gODMCn/4A1L99xGpL7mpdgBlaSjwz+gSmEaR6UORBXs+l7gxBtdDKt2WPyDNya8lhjD0LMLT27xJd36pnQGQCXfVqIaaBWTzK9MFFfSOMry31F1/usfVxUh73FB9qWJtMOdhsqtVh8SoudTu4yYfLc2kqbr/aFEB2hi4xVV7dnzVS+73pYt23k2MJtPfO34076T71XgOgsyRQfrPSEZCTxloVUegn/fF5aMqT6JE1iunxIGITRrGuJUimIHkZ9mPi2F4cxLV/uFJcQ7+ooNuBMFayOu1+OQxbaIgVxjqJpGDSEDOZlLk8f7Oxb7OdUrmAEO/sXipJF5gre89uVvmc62zzlVAo2bpAeEclkyls4ZqLJv8ddUXvQFNchEGK+ApdFbhvJBmUvvF+EPNnpvuhTbOIL/j8Q9g4CbhYQ/T5Jo2OG/knlQ1vsLt3YMo3ilu+0jO7Pp0Q9BynCkO1FTmHDcDVQ79JJSEIG4ZO0pshLXpxTkv+b0f6QbWMMqSUIUWgzfEALQYqxb2OCHMyVUkepyRu00u3ua/v7phtXbxtuUA1fyCr2S7J4CPYYcCT5KHeoT4uC4j/3B/wonflHQ7Sc1284L3fqf+DCCQj0GnT1NZjHtIjtnt9Md4OSmHb6R65Wedre7MuDDMO
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 c/VyUbBRzFNz1nWU9BAvlMY6o+JVV/l55SqilxgPUmN1snYgQ6OheFaWX3oRxX/srZ2663uIPAruyjEXqPHF/9fMO8/5cGu/rYzGdGx7sdyMF6IuyLyM3hmBAtwXa0JlAwepWqkWtMOeA3xSIfQmxXARSe/UEpQuXlLULwV6catsSU0emvrlncBxqGF2pOPINSYhVRswfPuGr6WuESUmnNoemo0/OssYRiVtA568s2IVwJX50nah34HBEkFVP5douRQ5UKX/HMwcsfJPPQJg/59aTixhGN0+MtrnBe0bRWOydmzj7gxttMKWop/8PtPqtQL7qKkUH2UVDzycbMMkBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10090
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a6aea381-3c92-4c21-ad65-08dea200cde7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700016|7416014|376014|14060799003|1800799024|82310400026|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	jGzd78BarACFmOQht1NGxmE9jjEhlmp01ICPPNS8hGXE39Top1mvgSDubWB0aqhIdblvl78/xlBfKSWBUIbfZ+cxL54GyuKPt2Xt18JYwlmzqs/Fkl+vS2H8R2PMyJbs1SmDhPpUIWHTc8KqFuIoWx6Y0/Mwd+9+aBEQnffndNR4bddJkq3eEzce2JlVNG8CWVUPhEVlikZs8EqCm3o/+vKdT9z4IwvUfUJB5uBJkD7U4KHItKCN9wk7DwjB2h13k1hygdpWbwF8M6fTc705ot9TDii1a9RkWdqWCyr+7MwFWAEQSkGMqlKLYzqMjDze+A6nXOuvlO3jeY1wKK+xQvhY1+w0zAjTnfJ4w4WcvqJHfQESYIrk3Krx7Xe5wQPmG9Z77D+8VTniL1Ksifl0ZIw8AMh1TBl8ixqSaBEC8OCYoVhLscBWswdu/OBqO4vSG22rT+v2UQHHAofHYr6E9stsuLxhDUbWKTrHwcf/eXCFq3VfydAWUA5BgQSpef0ZT4gX+sf5sprhVT1nfNqoWaD76oLtS+cn1WIbiOj/alA2Ouo5DklKKzsE5yyZuBoxu9UC5ye8Boyk7PFU7qNopOEmJAx8mFZcz5MxsK+mO23WyqXmKUozyoP/CNZAGbMlEyk/y1a7KjU4kSyuih4l40DKB1PPNzCOjj9sykRyLmI13AvKKyuOan3MEFeP6bwEP3MX3Ied/vwFjvpYC7648QJRGXKxW7l1doHJls5g4GwpH7yIuuFuwCeJly6TO4KPP9IeAfcskCmgBo9saaHKrelBeVVmWUP1s6rIzDPa+v8=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(7416014)(376014)(14060799003)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T/NBG5BcUHemB/F8fVsEzW7iFu9/eQFD47nud/dUAkhizcFjki1iDyOsZIwP7223PhGC98NC0xoClypqaVRvuOrJaB/YvqQ2lOBxgq690qiH1yTJsynBRMzOdDtXNrCqxmZqJ7WylEKezMZW1y1hU4ILl3N2QeaYyjIcVKlIe4Czn2U4/XXXt1HyJVQKGQ8pwpeNUOK1tW9Jip1BaHZxhsH/Peya+WjqKaVyb4y2CqYHee9NbS03tCZNH57M16KekWJtQAh7ygN6sD4hVHmh56N43zrTZc9DS7BooMbv8YjfCIYlGGNQDyB0c7xtLta4GvEWwjPy3+yIVT3CDjmPiQuiQkpEFWZ684X/ujsGEt0+eDizgN8GRc2Jm/1KVSiREDi2QEjCazSPQadEQDu4m8bH9f8G8zaB4oJDOgp3gaFyxCNN3i5DGR3nKKXXUFce
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 12:56:56.6836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77baa69-daf8-4959-dfd1-08dea200f76c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5733


On 4/24/26 14:10, Sumit Gupta wrote:
>
> On 20/04/26 18:37, Sumit Gupta wrote:
>>
>>>>> On 3/17/26 16:10, Sumit Gupta wrote:
>>>>>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable 
>>>>>> CPPC
>>>>>> autonomous performance selection on all CPUs at system startup 
>>>>>> without
>>>>>> requiring runtime sysfs manipulation. When autonomous mode is 
>>>>>> enabled,
>>>>>> the hardware automatically adjusts CPU performance based on workload
>>>>>> demands using Energy Performance Preference (EPP) hints.
>>>>>>
>>>>>> When auto_sel_mode=1:
>>>>>> - Configure all CPUs for autonomous operation on first init
>>>>>> - Set EPP to performance preference (0x0)
>>>>>> - Use HW min/max when set; otherwise program from policy limits 
>>>>>> (caps)
>>>>>> - Clamp desired_perf to bounds before enabling autonomous mode
>>>>>> - Hardware controls frequency instead of the OS governor
>>>>>>
>>>>>> The boot parameter is applied only during first policy 
>>>>>> initialization.
>>>>>> On hotplug, skip applying it so that the user's runtime sysfs
>>>>>> configuration is preserved.
>>>>>>
>>>>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>>> ---
>>>>>> Part 1 [1] of this series was applied for 7.1 and present in next.
>>>>>> Sending this patch as reworked version of 'patch 11' from [2] based
>>>>>> on next.
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/lkml/20260206142658.72583-1-sumitg@nvidia.com/ 
>>>>>>
>>>>>> [2]
>>>>>> https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/ 
>>>>>>
>>>>>> ---
>>>>>>    .../admin-guide/kernel-parameters.txt         | 13 +++
>>>>>>    drivers/cpufreq/cppc_cpufreq.c                | 84
>>>>>> +++++++++++++++++--
>>>>>>    2 files changed, 92 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> index fa6171b5fdd5..de4b4c89edfe 100644
>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> @@ -1060,6 +1060,19 @@ Kernel parameters
>>>>>>                        policy to use. This governor must be
>>>>>> registered in the
>>>>>>                        kernel before the cpufreq driver probes.
>>>>>>
>>>>>> +     cppc_cpufreq.auto_sel_mode=
>>>>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous
>>>>>> performance
>>>>>> +                     selection. When enabled, hardware
>>>>>> automatically adjusts
>>>>>> +                     CPU frequency on all CPUs based on workload
>>>>>> demands.
>>>>>> +                     In Autonomous mode, Energy Performance
>>>>>> Preference (EPP)
>>>>>> +                     hints guide hardware toward performance (0x0)
>>>>>> or energy
>>>>>> +                     efficiency (0xff).
>>>>>> +                     Requires ACPI CPPC autonomous selection
>>>>>> register support.
>>>>>> +                     Format: <bool>
>>>>>> +                     Default: 0 (disabled)
>>>>>> +                     0: use cpufreq governors
>>>>>> +                     1: enable if supported by hardware
>>>>>> +
>>>>>>        cpu_init_udelay=N
>>>>>>                        [X86,EARLY] Delay for N microsec between
>>>>>> assert and de-assert
>>>>>>                        of APIC INIT to start processors. This delay
>>>>>> occurs
>>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>>>> index 5dfb109cf1f4..49c148b2a0a4 100644
>>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>>> @@ -28,6 +28,9 @@
>>>>>>
>>>>>>    static struct cpufreq_driver cppc_cpufreq_driver;
>>>>>>
>>>>>> +/* Autonomous Selection boot parameter */
>>>>>> +static bool auto_sel_mode;
>>>>>> +
>>>>>>    #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>>>>    static enum {
>>>>>>        FIE_UNSET = -1,
>>>>>> @@ -708,11 +711,74 @@ static int cppc_cpufreq_cpu_init(struct
>>>>>> cpufreq_policy *policy)
>>>>>>        policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>>>>        cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>>>>
>>>>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>>>> -     if (ret) {
>>>>>> -             pr_debug("Err setting perf value:%d on CPU:%d. 
>>>>>> ret:%d\n",
>>>>>> -                      caps->highest_perf, cpu, ret);
>>>>>> -             goto out;
>>>>>> +     /*
>>>>>> +      * Enable autonomous mode on first init if boot param is set.
>>>>>> +      * Check last_governor to detect first init and skip if 
>>>>>> auto_sel
>>>>>> +      * is already enabled.
>>>>>> +      */
>>>>> If the goal is to set autosel only once at the driver init,
>>>>> shouldn't this be done in cppc_cpufreq_init() ?
>>>>> I understand that cpu_data doesn't exist yet in
>>>>> cppc_cpufreq_init(), but this seems more appropriate to do
>>>>> it there IMO.
>>>>>
>>>>> This means the cpudata should be updated accordingly
>>>>> in this cppc_cpufreq_cpu_init() function.
>>>> In an earlier version [1], the setup was in cppc_cpufreq_init() but
>>>> was moved to cppc_cpufreq_cpu_init() to improve per-CPU error 
>>>> handling.
>>>> Keeping the setup in cppc_cpufreq_init() helps to avoid the 
>>>> last_governor
>>>> check. We can warn for a CPU failing to enable and continue so other
>>>> CPUs keep autonomous mode.
>>>> cppc_cpufreq_cpu_init() would then just check the auto_sel state
>>>> from register and sync policy limits from min/max_perf registers when
>>>> autonomous mode is active.
>>>> Please let me know your thoughts.
>>> FWIU the auto_sel_mode module parameter allows to
>>> configure the default auto_sel_mode when the driver is
>>> first loaded, so there should not need to check that again
>>> whenever cppc_cpufreq_cpu_init() is called.
>>> Maybe Ionela saw something we didn't see ?
>>
>> AFAIU, the concern in that review [1] was about error handling as the
>> earlier version disabled auto_sel on all CPUs if any single CPU failed.
>> Per-CPU error handling in cppc_cpufreq_init() (warn and continue)
>> addresses that. Can't think of more reason.
>> Do you have anything in mind?
>>
>
> Actually, one case where cppc_cpufreq_cpu_init() would be needed
> is when CPUs are offline at boot. So I will keep the setup in
> cppc_cpufreq_cpu_init() in v2 same as present in current version.
>
Wouldn't it be possible to loop over the "cpu_present_mask"
as you currently do in cppc_cpufreq_exit() ?

------

Another issue about relying on "cpu_data->perf_ctrls.auto_sel" in:

"""
if (auto_sel_mode && policy->last_governor[0] == '\0' &&
     !cpu_data->perf_ctrls.auto_sel) {
"""

is that the cpu_data struct is fresh memory coming from
cppc_cpufreq_get_cpu_data(), so it might always be 0
I think.

