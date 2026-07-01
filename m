Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F040536C5BF;
	Wed,  1 Jul 2026 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923124; cv=fail; b=q4xoCMj9fXSsWh/piXL5WaorNnerX3TC9Ia2zqy0+yH/5HL0ykpeInyUXRiuEnsUm6trxWf+bgFSt2wK3IQqmx/JcUf4AkwMGkVctycIg9p0wU+2fUDtdAX8u1WaeHHSCTNTCVchHZfffd+fXkqvmo5/zgGfPv61sRoBx+obJ+U=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923124; c=relaxed/simple;
	bh=K1FO2MsiT8Atv5nnZeE90PoqOzWtZcWYhB7DubNfCnw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ijeWAjaYSaO32SfgsoxIWVcLGjzhbotCbBDb7sqjwKILM+02CfO3jRt5hJm3Rj5aEvcbHL5wTcEeEBLzdDGWrIQSk+Gr2gpWfNH+2p2ymYAvcjmocmn4wL0W7Th3U5tjtBwm+O28oq4XBgV0nWulw9bpD9fLbP8dUMRyBDe4bAc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i8UniEuE; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i8UniEuE; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i8UniEuE";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i8UniEuE"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BPfrPOlZCKItXb7iuTc6sBGqZBFgW4VjA63l0/LQ/XrznGGVciLibJn8h8UPIvsx75lWbdFGDsDjuyGoGnhhmTs8JkPf/bEUSE3cPDnaepeKW8zCnYoEoUc7uqSX26/bidC7sIZc5oEXJ5EeNhLwqee+q46mV43s9idCDI3I25IGw5cDpP6l4eObhY/1ySAZMVBTTE7ZBQ/QYf0Fei9ZO/a3q3vW9XL1UUQ4hbDE9K6qrD/V3res9iwjEyQQLpPvRDVpKjskiiyU0AXi3bGSZt9z0/luxyOwA2yfNdoo8MM9sPicONhPE8f/QRrZl97FzdMge9pTvjjwtdqkZzSgRw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPj5O1nFcfoStQ7/wyKDClxPcahkr8oQrI4MMgLX5cw=;
 b=dPF24Xc40LO5KcZ+j+VBHwhZhAT/dIkKTMxq1SGy0es0bmMfaUHYzcG1+0nfL6FV7hT/TKfRsEF4bisT/0Zuct+ZpKm3h13ahfpkqMp5eyi5LO3b3W1dO4v5yeAC+Ybuszwx+o8bGt94jKB82aFgosjYiELuVl7+7o0evsTcSr+c9CqOIdR/dXiODQDIjVMgSj/dKYk4K9/lcazLealZKUMPg0HVSJrZ8hChAWwrlcS+bDUDG3oA6xSQts30JMFTwP5SIIWPapOHBb1TA1peHZg1nvV+G2aunJQYsUDBH4slLn4841oQhMmaJ7R2kGppolqBg3bOaNQkCzB8aueNsA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPj5O1nFcfoStQ7/wyKDClxPcahkr8oQrI4MMgLX5cw=;
 b=i8UniEuE26t8OpS3lbxipJYHJbY4JOmPyHxEEWb7xuLjIeD8ncz01axS25s6Ltp0PppWkjYCOR4qDpvaxLFjCIfcNN9iJCVX4uKL2/SfoLiU+ElbjD55oRS2zijtqW+k8/L9VYVpKK9gBZ9pRofkYLJVOxLnW/+blIunpXw+8BY=
Received: from AM8P189CA0014.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::19)
 by VI1PR08MB10008.eurprd08.prod.outlook.com (2603:10a6:800:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 16:25:15 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::38) by AM8P189CA0014.outlook.office365.com
 (2603:10a6:20b:218::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 16:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Wed, 1 Jul 2026 16:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MALL/iT/nURz5RvCKzlHcreqyADf4Qbv7xGf1aOuFWI6OBTuYiE3jU/Lh5+1XJJyUer2Qp1fFTx63zBv22qXCy7mCBoKX8gtvypjal5LZnoUOrcVa1vtfnad+pn0HG2f7cNwb6GSl8oGugYp7EOsnIh0IofoliP9vyuj8BxdeUBoh3VKKHhN6cNX+WrO1oatrwWcf73DbGkx4/R12Cx04Ux65KlHb6n/S0ekIhVE/8ya41Wfg9CdpL8fD3/waQmgFBz0LwRVXVmQAyFYgM07LmrUbvapJl5K4sDodYdwKZMqASDaodFBG0CYlllgoSskW16ifvzMXYcrzt6wJt/TrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPj5O1nFcfoStQ7/wyKDClxPcahkr8oQrI4MMgLX5cw=;
 b=US1PkMLFLdR6/qzjP0e6Dpz7FGzs9kltAkiluDAHYR7JZmLnLycR3XCtRiObvXacZyZgGTlpvDgNViHAu+ZBjXkWohjXUCeD53+1QkTRRw9yaVnvPzVhV8srt7NeYuFpVBY1bYr/EkMdlKe8QcsQxG1Y2bqPbHw5IYRLxMTwgLVnEAytQrwjdeY46Eb4wjAbKLh59MsNE0OSUNOaDAEo3zflH9RCuNqN5gpO37kfYxBHKryLoBh6vohgtrbcLQGyUwgPIwoQ4QqDXEFqYHzGotNwEBq1hOSXadoUnnUulfk7ki57XHFHw0cXGAHH4O6ly+a7V+QsZQ/Rh8PwAp74Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPj5O1nFcfoStQ7/wyKDClxPcahkr8oQrI4MMgLX5cw=;
 b=i8UniEuE26t8OpS3lbxipJYHJbY4JOmPyHxEEWb7xuLjIeD8ncz01axS25s6Ltp0PppWkjYCOR4qDpvaxLFjCIfcNN9iJCVX4uKL2/SfoLiU+ElbjD55oRS2zijtqW+k8/L9VYVpKK9gBZ9pRofkYLJVOxLnW/+blIunpXw+8BY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VE1PR08MB5646.eurprd08.prod.outlook.com (2603:10a6:800:1a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 16:24:12 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 16:24:12 +0000
Message-ID: <83f2d177-3832-47a8-83fa-a3f558f78273@arm.com>
Date: Wed, 1 Jul 2026 18:24:10 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug
 and unload
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260623095403.3407436-1-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260623095403.3407436-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::15) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|VE1PR08MB5646:EE_|AMS1EPF0000004A:EE_|VI1PR08MB10008:EE_
X-MS-Office365-Filtering-Correlation-Id: 72236ae9-ab69-42b8-9e3b-08ded78d5527
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|11063799006|18002099003|22082099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 q63Mkknaksm6Vg1wwhEqAxCdU/kPWrSI1hi81k/+gNPY7taln9IFO47IlgPs8vfkdy3Tcmz9jH/f8Z4q0zzK3X7eghGJq4cg5TGn2NszC999q5oh/gYFGgIMcgtWJQiDtFGWOH/jI0SQ+CwG03qIUlORaDcDk7JA8mx8fPistE+l89uHjEIk1dkDKmrjgY+ZICuMDlwFCnAdJCoSocsbZ9HjHIZcGbi+rk4ytZkEJSlcY6wZwv/vZUP2eeJ+K1F/AKtmQdb/jkmpdEaTu87c7u9iSF8s9rul71dXK/qUa62q3mHWMb6eKP6Y9QdxgtdS2JEieT6qhc0/e7AtSAljfJTB1TswLblPxV07mBKHaHxN59XY15JYSdInDPtDPjBeA+sBUTVJ7dmxSZwRHvURjjVY7e2nU0DjVLkjVJXqf1TRBaMX1ZPdDBhDdn6NwhIIsKcYwqhml2r+AtR90VpRkAXLh4gFTIJxSjh0X8G6gh8xVV/Vr2JhsUVo93UGYLIRdtBVhzEwKBwH6jFJkccftySYq/WvM8HClmAS0HP14hiIXO1VpZGRrlR3jnJ466YQJ7LwXKBO2nykfmamXhEI7u5DRcwULQXYZ7RUY05bnHxSgCKyNB4egEmD8us0uQr9M3swogc1d+1NcxvzkVGuamI8ton4E5BmrpoQ/ku/jZM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(11063799006)(18002099003)(22082099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 kLwIjcCqetrRfvB33dFC2c8NlY/y5NVt6IeW90ONJ1ZdhEGeKEStg8y4S2DUNd4cCUp2poot4hwzXdMEXDaXtDAZmJyfyBkGyAI+fgZ+yLvNM11cXNXY1Z2S1qmWXgoUI7RSNG0wZqXv95ZblZiKqk4omBSWSubFipu5ytEtotUrrVnQ7KW7kSF1mRnmPC7JVoLn2c4sUgUJfvRw1ktBDhD6oBpC8x+ulxa20oZOxS1NadCGKIKJDXSV+O+20rI5TtBXLf8aoAD5+6SkVBlqMhqKDzO8I2yFGac7WUK4a/paYDiwVD/3tGta7spC5im0g5iX5kDvyDQlpu5curAdRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5646
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ee55c856-79a0-4f7b-3da5-08ded78d2f65
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|14060799003|7416014|376014|35042699022|1800799024|82310400026|13003099007|6133799003|5023799004|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C/5ITte8IMYRvH8JDW7WYQYSHjOETvuW1WIK3NMDZDP+XSSK3U1yGLhVthIMMtGJz68vOuEQmXJ6SqTFspYEIAw67v/gZirSFB2KM4o5TOzZGp7/MtFyHb3nv13sTh91wHvQ/zir5cAkkERJJu0QYJnMA6PFCZjhKBiCTzSYFxy6n0YWv4e/Qzk/fSx/IVzUOIfvA1qZpvtKvTZfX7e0pGbf7nIVuDneLjUpsIBpeeBjED4D4ahhG1PFonAc74QCgMwVe3AriU7DHtNCvmDyMqSRidTV4EQYHys/US/jOkA3FeJgDfBsvlZ5zORosofOE7NL78u7HvhAtIRM5kw/7kaIKoEqz4isZox2lped6N0ECBE1+NB9l+nxcyAtQDtF9KczsR4L8YlWSYs5iRTmkYu3a1+mYEm5xWzldQgi9X81TTNEAwVDL7f5W28HKYFYXbDnO+5GsHSEpkhetX1Z89cqp93K2gCMhKQv+FE5zl8/RMAb5NpQ07jJpzxIPWO8zj4xa9O/JQX3tEpcm1/Ufvv7+DCgsHyQUEmzLc0lnE3Vdh6h0Oo6k6+UATe/ywSu1FMyZqy34hYk0QICDFP00BAw5NLPYevfwkvjAh13wkccNuKBJ2hb2GE8lDZGUGdDVzevCpdJO0ZhAi0fq5nG2+24FgxkwhFQr7Y3khn6+jW4grC7tUeTa1iqVzQebQUcK8vff2RAOHuCo5HzV9RaSw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(14060799003)(7416014)(376014)(35042699022)(1800799024)(82310400026)(13003099007)(6133799003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	apyh6XrdtUdu8VfWfBNWrsrL0lwMjKizrCDe/YyeUvb9s89XzJCsQ6xskLfVTJ6d67p88ltklLka35uYr4Rfd8CvpJcnI2N1MzVpKdZrjCU5axwDxVC53mV9t4Sy6pw0JtS24TP73KYA02I3O8o9Oh3iJloUU3ZXQY5lID5OaIwfyABCr9lv/1p2o+8Yg8YaFuo7EPEeXGH9pxUEqBdj37fGH8s6NWh+WOuEAWq4XnPul8O68t/CAvIZ/GWWntiiFgPHIi7YEpzi6xkDyWF1UBbqbHWNldx3156PV6fWZxSjkNVHj3ZgwOjCERLWqL/EmsPdOfcp/syU5AMVVslCXdJ//6K/p27sNWrYPNm+Xf8Xjha8wO+Z+tY8d3deULMspIKR3+W5t5MdahZGCv+Y65FcZf7motrfegP2QC6oY8BeuaI4JANwETf/wKWwiroY
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 16:25:15.1120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72236ae9-ab69-42b8-9e3b-08ded78d5527
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10008

Hello Sumit,

On 6/23/26 11:54, Sumit Gupta wrote:
> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
> boot parameter) can be lost in two ways:
>
>    - Across CPU hotplug: the platform may reset a CPU's registers when it
>      is offlined.
>    - On driver unload: the value the driver wrote is left in the register
>      instead of returning to its pre-driver state.
>
> Add a small table-driven mechanism that handles both:
>
>    - Capture each register's firmware value when a CPU is first seen and
>      restore it on driver unload.
>    - Record the last value the driver set and reapply it from ->init()
>      when the policy is reactivated after CPU hotplug.
>
> The firmware value is captured on a CPU's first activation rather than
> once at module load, so CPUs offline at boot or hot-added later are
> covered.
>
> Reapply is only needed on a full policy teardown and bring-up, which goes
> through ->init(). In a SHARED_TYPE_ANY policy, offlining a single CPU
> leaves the shared register untouched, so nothing is lost there.
>
> Cover the OSPM Nominal Performance, Autonomous Selection
> (auto_sel) and Energy Performance Preference (EPP) registers. For
> auto_sel it replaces the previous unconditional
> cppc_set_auto_sel(cpu, false) on unload with a restore of the firmware
> value captured at the CPU's first init.
>
> Suggested-by: Pierre Gondois<pierre.gondois@arm.com>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>
> This applies on top of (not yet merged):
>   [1] ACPI: CPPC: Add ospm_nominal_perf support
>       https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
>   [2] cpufreq: CPPC: add autonomous mode boot parameter support
>       https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/
>
>   drivers/cpufreq/cppc_cpufreq.c | 194 +++++++++++++++++++++++++++++++--
>   1 file changed, 186 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index a3fabfb07fbe..d6ea2cbde187 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,174 @@
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
>   
> +/*
> + * OSPM-set CPPC registers tracked for save/restore. A value set via sysfs or
> + * the autonomous boot parameter is reapplied across CPU hotplug, and the
> + * firmware value is restored on driver unload.
> + */
> +enum cppc_saved_reg_id {
> +	CPPC_SAVED_OSPM_NOMINAL_PERF,
> +	CPPC_SAVED_AUTO_SEL,
> +	CPPC_SAVED_EPP,
> +	CPPC_NR_SAVED_REGS,
> +};
> +
> +struct cppc_saved_reg {
> +	int (*get)(int cpu, u64 *val);
> +	int (*set)(int cpu, u64 val);
> +};
> +
> +/* u64 wrappers so the bool auto_sel register fits the table signatures. */
> +static int cppc_get_auto_sel_u64(int cpu, u64 *val)

Should these functions be moved to cppc_acpi.c ?
IIUC, the issue is that cppc_set_auto_sel()/cppc_get_auto_sel()
don't have the right prototype for the above function pointers.
IMO there should still be moved to cppc_acpi.c


> +{
> +	bool enable;
> +	int ret;
> +
> +	ret = cppc_get_auto_sel(cpu, &enable);
> +	if (ret)
> +		return ret;
> +
> +	*val = enable;
> +	return 0;
> +}
> +
> +static int cppc_set_auto_sel_u64(int cpu, u64 val)
> +{
> +	return cppc_set_auto_sel(cpu, !!val);
> +}
> +
> +static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
Ideally it would be nice
> +	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
> +		cppc_get_ospm_nominal_perf, cppc_set_ospm_nominal_perf,
> +	},
> +	[CPPC_SAVED_AUTO_SEL] = {
> +		cppc_get_auto_sel_u64, cppc_set_auto_sel_u64,
> +	},
> +	[CPPC_SAVED_EPP] = {
> +		cppc_get_epp_perf, cppc_set_epp,
> +	},
> +};
> +
> +/*
> + * Per-CPU saved state for each register in cppc_saved_regs[]:
> + *   firmware_val      - register value before the driver touched it, restored
> + *                       on unload
> + *   requested_val     - last value the driver set (sysfs or boot parameter),
> + *                       reapplied on policy reactivation
> + *   firmware_captured - whether firmware_val has been read, so a not-yet-seen
> + *                       CPU isn't mistaken for one whose firmware value is 0
> + */
> +struct cppc_saved_state {
> +	u64 firmware_val;
> +	u64 requested_val;
> +	bool firmware_captured;
> +};
> +
> +/*
> + * Per-CPU and not tied to a policy, so the saved values survive policy
> + * teardown/bring-up across CPU hotplug. cpu_data->perf_ctrls is per-policy
> + * and freed on policy ->exit.
> + */
> +static DEFINE_PER_CPU(struct cppc_saved_state[CPPC_NR_SAVED_REGS], cppc_saved_state);
> +
> +static void cppc_cache_perf_ctrls(struct cppc_cpudata *cpu_data,
> +				  enum cppc_saved_reg_id reg, u64 val)
Is it necessary to keep the cpu_data->perf_ctrl.[auto_sel|energy_perf] 
values synced ?

AUTO_SEL_ENABLE can be set using: - cppc_set_epp_perf(): AUTO_SEL_ENABLE 
+ ENERGY_PERF - cppc_set_auto_sel(): AUTO_SEL_ENABLE ENERGY_PERF: - 
cppc_set_epp_perf(): AUTO_SEL_ENABLE + ENERGY_PERF - cppc_set_epp(): 
ENERGY_PERF

cppc_set_epp_perf() is not used in cppc_cpufreq.c, so 
auto_sel/energy_perf should not be overwritten inadvertently right ?

> +{
> +	switch (reg) {
> +	case CPPC_SAVED_AUTO_SEL:
> +		cpu_data->perf_ctrls.auto_sel = val;
> +		break;
> +	case CPPC_SAVED_EPP:
> +		cpu_data->perf_ctrls.energy_perf = val;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +/*
> + * Save the requested value for the given register and CPU, to be reapplied when
> + * the policy is reactivated after CPU hotplug. Also update the per-policy
> + * perf_ctrls copy so the saved and current values stay in sync.
> + */
> +static void cppc_save_requested(struct cppc_cpudata *cpu_data, unsigned int cpu,
> +				enum cppc_saved_reg_id reg, u64 val)
> +{
> +	per_cpu(cppc_saved_state, cpu)[reg].requested_val = val;
> +	cppc_cache_perf_ctrls(cpu_data, reg, val);
> +}
> +
> +/*
> + * Reapply each register's last requested value from ->init(), so a value set
> + * via sysfs or the boot parameter survives a policy teardown and bring-up
> + * across CPU hotplug. Also keep perf_ctrls in sync with it.
> + */
> +static void cppc_cpufreq_reapply_requested_regs(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu, i;
> +	u64 val;
> +
> +	for_each_cpu(cpu, policy->cpus) {
> +		for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
> +			val = per_cpu(cppc_saved_state, cpu)[i].requested_val;
> +			if (val == U64_MAX)
> +				continue;
> +
> +			cppc_saved_regs[i].set(cpu, val);
> +
> +			/* Keep perf_ctrls in sync via the policy's CPU. */
> +			if (cpu == policy->cpu)
> +				cppc_cache_perf_ctrls(cpu_data, i, val);
> +		}
> +	}
> +}
> +
> +/*
> + * On a CPU's first ->init(), capture each register's firmware value to be
> + * restored on driver unload. Later calls for the same CPU are a no-op. Capturing
> + * from ->init() rather than module load covers CPUs that appear later. Also seed
> + * requested_val to U64_MAX so its zeroed default is not taken as a request for 0.
> + */
> +static void cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *policy)
> +{
> +	unsigned int cpu, i;
> +	u64 val;
> +
> +	for_each_cpu(cpu, policy->cpus) {
> +		for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
> +			struct cppc_saved_state *s =
> +				&per_cpu(cppc_saved_state, cpu)[i];
> +
> +			/* Capture once per CPU; skip if already recorded. */
> +			if (s->firmware_captured)
> +				continue;
> +
> +			if (cppc_saved_regs[i].get(cpu, &val))
> +				val = U64_MAX;
> +			s->firmware_val = val;
> +			s->requested_val = U64_MAX;
> +			s->firmware_captured = true;
> +		}
> +	}
> +}
> +
> +/* On driver unload, restore each captured CPU's firmware value. */
> +static void cppc_cpufreq_restore_firmware_regs(void)
> +{
> +	unsigned int cpu, i;
> +
> +	for_each_present_cpu(cpu) {
> +		for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
> +			struct cppc_saved_state *s =
> +				&per_cpu(cppc_saved_state, cpu)[i];
> +
> +			if (s->firmware_captured && s->firmware_val != U64_MAX)
> +				cppc_saved_regs[i].set(cpu, s->firmware_val);
> +		}
> +	}
> +}
> +
>   /* Autonomous Selection boot parameter modes */
>   enum {
>   	AUTO_SEL_DISABLED = 0,
> @@ -766,6 +934,9 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>   	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>   
> +	/* Capture a CPU's firmware values on its first init, before any driver write. */
> +	cppc_cpufreq_save_firmware_regs(policy);
> +
>   	/*
>   	 * Enable autonomous mode on first init if boot param is set.
>   	 * Check last_governor to detect first init and skip if auto_sel
> @@ -812,7 +983,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   			if (ret && ret != -EOPNOTSUPP)
>   				pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
>   			else if (!ret)
> -				cpu_data->perf_ctrls.energy_perf = epp;
> +				cppc_save_requested(cpu_data, cpu, CPPC_SAVED_EPP, epp);

It would be nice to handle this in a more generic way.

------

Theoretically, we should save all the writable CPPC registers,
not only ospm_nominal_perf/auto_sel/epp. Maybe saving the
value could be done in cppc_cpufreq_sysfs_store_u64() ?


>   		}
>   
>   		/* Program min/max/desired into CPPC regs (non-fatal on failure). */
> @@ -826,7 +997,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   			pr_warn("auto_sel CPU%d failed (%d); using OS mode\n",
>   				cpu, ret);
>   		else if (!ret)
> -			cpu_data->perf_ctrls.auto_sel = true;
> +			cppc_save_requested(cpu_data, cpu, CPPC_SAVED_AUTO_SEL, true);
>   	}
>   
>   	if (cpu_data->perf_ctrls.auto_sel) {
> @@ -850,6 +1021,10 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	}
>   
>   	cppc_cpufreq_cpu_fie_init(policy);
> +
> +	/* Reapply any saved values lost across a full policy teardown. */
> +	cppc_cpufreq_reapply_requested_regs(policy);
> +
>   	return 0;
>   
>   out:
> @@ -1039,6 +1214,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>   		}
>   	}
>   
> +	cppc_save_requested(cpu_data, policy->cpu, CPPC_SAVED_AUTO_SEL, val);
> +
>   	return count;
>   }
>   
> @@ -1111,7 +1288,7 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
>   	if (ret)
>   		return ret;
>   
> -	cpu_data->perf_ctrls.energy_perf = val;
> +	cppc_save_requested(cpu_data, policy->cpu, CPPC_SAVED_EPP, val);
>   
>   	return count;
>   }
> @@ -1193,6 +1370,9 @@ static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
>   		}
>   	}
>   
> +	for_each_cpu(sib, policy->cpus)
Cf. comment on the other patch, maybe we should not
actually set/get the ospm_nominal_perf value for all the CPUs
of the policy. We might just assume all the CPUs have the same
register.


> +		cppc_save_requested(cpu_data, sib, CPPC_SAVED_OSPM_NOMINAL_PERF, perf);
> +
>   	return count;
>   
>   rollback:
> @@ -1258,13 +1438,11 @@ static int __init cppc_cpufreq_init(void)
>   
>   static void __exit cppc_cpufreq_exit(void)
>   {
> -	unsigned int cpu;
> -
> -	for_each_present_cpu(cpu)
> -		cppc_set_auto_sel(cpu, false);
> -
>   	cpufreq_unregister_driver(&cppc_cpufreq_driver);
>   	cppc_freq_invariance_exit();
> +
> +	/* Restore auto_sel and the other saved registers to their firmware value. */
> +	cppc_cpufreq_restore_firmware_regs();
>   }
>   
>   module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444);
>
