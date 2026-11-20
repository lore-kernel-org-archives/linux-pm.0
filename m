Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.84.10
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795176524;
	b=bio5PO8QelMjRKINKsxTpGG3tvRkPoOdxfHBUHqaoqgQ3JdJeGa/BTRGlzGhQU5Qk8Zf
	 kLQ+PO+xxHmQoqlw82I7aDQlltDuUQK5Q6tun61TDad0o2T3JwgCnAM/BYzDk9pmdzkdm
	 yjX2sksHbqpWE1A83oImHKh8QJ6g91Nj0zetujhJZjctVq2qe5BT1g6gHDcdM7BvFgMUB
	 fQj9ox7KZsJUs/8UWFfNrAecrXRiMAKg+A9o7B2F4ukwVKLrSbUil0ZFYQflSr+dbTS2+
	 DzkJ1nPGZ7AdVb/ffVwYaHCXBGVL+1TQNWszozY/7iU0ghTr4z52g3ZAEr32zT6Ndvg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176524;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IYuS4S/xJiaGt8dc8YWcvLQPr+dr3uFt9JHqvt4/Sc4=;
	b=wMN3H+rrINmXZrJiyFpVgEHtEJ9MTCbFcVBQvxubGpJbbw08eJ70DMmcnk/kauxCwvRf
	 UfhYxMFvT3LqTJ1ejvJmN2D7CzZyOh+bFJcSJTs6dUvMzccaDcSUotTCxHsi90XsPG2Cg
	 gRkn0jNYOa4DVGjp+Xj6CBT0hYT+GLJyog2sJ8tUhUVSrGPqeOzeDD12oISspd3K1LQEx
	 yVSkWKok2ZpOGQ5UvOTgqKli000aCrM2dC2syWHV0LDFq7XFwl1Ac2vN1wvkKNO3/HxWW
	 xtbPSwB1LGMykdc7K26WWNOKLjqIKgL2q9ti2UipC5kIaf4cekJJbBYvheF6kFQvOAw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=fYIn7Q+t;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=fYIn7Q+t;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.84.10
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CADD606A326;
	Fri, 20 Nov 2026 12:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CADD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=fYIn7Q+t;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=fYIn7Q+t
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=C0xZHlhxsLqcUPipKOksqTL749rKeqJHc6JQYpiu8nhme+KsE9JQAwvI/cnvP+YUCyt51KukWGoIyiL1j/UYFtIpDN7S6bX37vL2cnuHRH9VXD9xyT89dBO1EoSqrM5snFKTHBxxkGY0oKTGr0KgCY13GR/qRjyPps2MkWW0nus8ApiIcr65EFKMUqCTv10C26yqfofyyhSS1YB/QgRmSWAJjsmCbpI74Jy3ywdeDVNt5I39NSpFhTdB1pzJ+G3VrKDPA6HY4JRwXxZ72oi3G3zo19Jncs27k9jFWnnewO5mGjPsklQMN7LOuAXN5BJab6k/syMKXp8jcR/fMBu3wQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYuS4S/xJiaGt8dc8YWcvLQPr+dr3uFt9JHqvt4/Sc4=;
 b=pDG3te89mm8IxwZ8rAmFhtpq2BUnbHiP5Vtw6pWXQeVPu7wzZUFeT35MbIGAPxFqGBXW8YqGJqsLnAsAQu6DHIXLrILez184jmbfjs+TvxXL6hl1UYjAWmodSULPKM9QYnahrYMmLLzkzjIZ/0j6AFUr5CGv2elJoYXCllSVzwh44E40z9C5X/bCe8nuyWohruJWiRHMoCXpRhQZKfnz7bvajKlthgtTHAn9T6RPZn1Qo8WI1CPMRkEYr1GO7aXnMMKOtlVffVx+LmSuzgLpn4rvSBPFB2UyUT4McPwTVHNopcEREhl7Ounkw1+axFTU3HLhQsAw/uiBAyiCzSoiWQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYuS4S/xJiaGt8dc8YWcvLQPr+dr3uFt9JHqvt4/Sc4=;
 b=fYIn7Q+trAe8XzpbBJuwDYQjFTxVI+S+a8UE5x5GO3cQq43leN61AwOzeTmcAHLafkQXyZQSDVmaJgrK09zCa4bq1rfogZSE5tuWWU/ZWgs7+XUu4YV8nP4blATWt6psFQ+LsWN4/K4GGWXtTsSEaBxwjexzbe6JBFdtg2j0YHc=
Received: from DU7P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::25)
 by VI0PR08MB11821.eurprd08.prod.outlook.com (2603:10a6:800:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 12:08:37 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::a9) by DU7P250CA0012.outlook.office365.com
 (2603:10a6:10:54f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 12:08:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 20 Nov 2026 12:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zE/naAxPkUltvOFRAsghxZYTxeA2CN0QQs0J8IOtmlhZDrZZgoxM7LuqdH5eqZRazcuMi58k1+9GkpQZH6Q1PtV35fJkOO1XqPTuDZ/mF9t8lmJpvJG3XV7XNc93l3GPzKW1fNSW/K+YgNjpFCXIuV8zs2t1K1w+kJMiX4agoCmb3UnVhmnwPkMt+0X3xpHOwc9tv6HF6PCTVdsRQOP/HnlJtiDNHtooYIbNnSe3R7fG0VBeZucbAxWUueE+zxTakDiYeXMtwrh4numIcZr+epXFR7wLwSMCazsePshfW7agqJPyo8a/h/Y1BIVYHRDBaQV2SA2vdsw+QWQWzVlTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYuS4S/xJiaGt8dc8YWcvLQPr+dr3uFt9JHqvt4/Sc4=;
 b=ybCG1uI52pE1OmmgEa5gcLma/32N4wL1EjMuOsNSQsBDTrH0u6c/87Idf/GAXlf3bBlLMVIKbrELu2izD0DvdXCGQqNqdO0H0S66bvqFUKy/eUoz8x6vIkeW2xaN1c1SGMlhD45J+GPWmkTXk1uvvybkk21FHxeCa61o4RhoSleEmYLGAWEirMrg0hXqIAjSzDDIgH/qoxfotcMeoZpz8zL5iD9hf0sJapkYk7Q22pvOqdT0g23VgHXXJClCbfJnUXGzrz0kW6nUkZb+v23d0K9wvd47MrP5ZSxjnfWdGSEEz8K9/O8xSS1AAlikg8LgQEFJ+zHr7GdKnOdhDTwTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYuS4S/xJiaGt8dc8YWcvLQPr+dr3uFt9JHqvt4/Sc4=;
 b=fYIn7Q+trAe8XzpbBJuwDYQjFTxVI+S+a8UE5x5GO3cQq43leN61AwOzeTmcAHLafkQXyZQSDVmaJgrK09zCa4bq1rfogZSE5tuWWU/ZWgs7+XUu4YV8nP4blATWt6psFQ+LsWN4/K4GGWXtTsSEaBxwjexzbe6JBFdtg2j0YHc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by BR0PR08MB134991.eurprd08.prod.outlook.com
 (2603:10a6:2c8:44::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 12:08:04 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 12:08:04 +0000
Message-ID: <6d6a84bf-29bd-47c7-9243-ab0b9e2d7f32@arm.com>
Date: Fri, 20 Nov 2026 13:08:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: fix policy max not returning to non-boost
 freq on boost disable
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Ananthu C V <ananthu.cv@oss.qualcomm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Oleg Keri <okerixx@gmail.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
 <auhMD2-5FD4BqImG@vireshk-B250M-D3H>
 <avRiWsxCEAuBouBZ@hu-anancv-blr.qualcomm.com>
 <avwtsmp7Mqacbbtl@vireshk-B250M-D3H>
 <av2aFWw3kh11U68A@hu-anancv-blr.qualcomm.com>
 <av5_zDI4bg28H_6e@vireshk-B250M-D3H>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <av5_zDI4bg28H_6e@vireshk-B250M-D3H>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0183.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::8) To BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	BESPR08MB999898:EE_|BR0PR08MB134991:EE_|DU2PEPF00028D05:EE_|VI0PR08MB11821:EE_
X-MS-Office365-Filtering-Correlation-Id: c0115b79-17bf-4918-9698-08df46ff01e2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|6133799003|18002099003|261009221727099003|261009223027099003|261009221227099003|261009220027099003|261009223327099003|3023799007|11063799006|56012099006|4143699003|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261021135927099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 RspEp7rReVmeVwb7Q1rT/dkUXt96zfqTJsQ6omMn7TCiFbIhERhQP08wYeyxTCazAxYuzJ/+XmF+pijAV0RyqjJ7x1iGEcuksv8XHIRvpFuO+NjtwxDb7nQLyKfofp1VX4Bvwtl5HekEOCZ9h3HyDPvtYgkB3foigU5WYZvUPQzbmiIYxvpnyXr3IwsuywPf1pWL0DWHWqHNrT6utX/7wT2bjNhZsXQoKQseb100KC/fdmDwBzDC1E2Jdi8kyx2cC6ZlDLCLR1BrL/XC1e2w6QtbWVpskCb/oCIKmiHvyT5H3NPSaVSbIl7YZXEB03kqpErliXfkjOCqE3uFfo/8Dg8DcMUmRXzrPF7M15SFFaRewJnN4Vg7W0p6VX/UeQUCtj8TTcvJH6OHcwmXAuXHqkVeJmP+6Zo82HWPZnYhJVVq7BPNzcZQizx5rK2gmi4xJXU2TD57EjynYW4YMs7htqhmh0cqSb7twqD4Bf5vKQee0jyLO+3axfzYODW6i6BytWC5SH2Y/nqJIYgtSe00JUNnqAfxS2VGLeXHuj6v3aoiSq1d6YqGVRltVZDiDNsemoEonMEgsZu2r7uAMl7mEr0PIOfhGoWso0ZAA2logj4xtpIg5Ec9ymHQuRLTl2XgVoxG6KSjOX/XB65A+YhzGLA+om5zfeRuf6he6TIpkvA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(6133799003)(18002099003)(261009221727099003)(261009223027099003)(261009221227099003)(261009220027099003)(261009223327099003)(3023799007)(11063799006)(56012099006)(4143699003)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 g86U55LukKo9raTR9Ml0eW5HX3yrdWtbMYBAFcO+juxBSsi476xqzKI6176laap2fTV9Fwf0ng92Gfya1d09/7leAJ2f91CFNm1okzEobB7qyBO/oRriSPz58DWxI5nZa122TCPeJUa9HVi71t3Zy7RQBL35HXpRgBqhebmAPyP3zUaycvoaVyW2YmXtc/Xqy8qOnJrff0j4jQB89QJwg8mw0hVSvdbDv1d8NccQOjDrncLqfOk8XEfvRRVUs1dniW7Dx+jmVkbhQAMYh0nIpRuOPkSf1eOyu/qZtx3619+T/sf5q7wIbOKaCkzuDZPbfZ+bDzctyuB3Wy6FDot7Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR08MB134991
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	45064015-545f-4b2b-a637-08df46feee21
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|14060799003|35042699022|7416014|376014|36860700016|1800799024|6133799003|18002099003|22082099003|3023799007|11063799006|56012099006|4143699003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003|261009220027099003|261009221227099003|261009223327099003|261021135927099003|261009221727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ONyJHvFrJ6RC7NTjdr7/qvFmIRNx+BmjCkIs4ZPGsFWZCiQ5Tz5RokDeYO/xzCy2b0WXLxLvVGfndEZ8xbxqX+EwkSMsWY3NtR7+UBkt35PYVdOOFfg1fJFmWu4vhLw7FxY91vrORF49hg4eC/iW6yl++F+KNtwct2N3KZD74KYgju27qVd9D99RWrqTwnxNlTVNB4ra5mT8x2UZsRh3mV9IMV92QwEwTKGnVYGVdGDIVfp0p4yDURVPwSZuLHuxFOMxorzIeXBAIIATz3q1jIeSvn1LwX1/UdKhe9sD8BiNi1FhGGfVFa/LMwRtETSbxTYkN5oBb4mZiYE38HhhgaHCj3PZmrP07Z28VFQqUOIR4iPJMp5XVbn4DTvGolt5MaswD4F02UawCvoYn/R6yj674/Z/ZnK9kdzVLRdvP1pjLZ73YQkT7O8IFG7x+dmmuxePWFZp4RxGsETL/VLAy7S3S2UUA7vwuA4ABQN5RaiS2zfC+rHGpPyGnJ3tJb6XRITS9r8x8gAlhCpH9kRY2WskRBjXFKKbIvqDaW5AmVy9aAh956bTfqyBY+bBAQVmxv6UqQBa5GlRcgcbKy+O/3wJDjAOg6Rjw+V2jxLPYdNlOfi4tPQ7WrHb8CLMIIEUigKDnC2pYSAEHudrqbtDzRmAC0eMbG9K4jet6r4MhBjGfoOM/v7/FlnM5nw1CgaLxM/Mr54kk4Br2WKCeuRk+Q==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(14060799003)(35042699022)(7416014)(376014)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(4143699003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003)(261009220027099003)(261009221227099003)(261009223327099003)(261021135927099003)(261009221727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	exxEyOge9INoU6dVLKtu2Jv4Fw4I0P6XMeLy1Y6AhBYt5TiDD18sx4bxaKga20WRW/9Ep+QOQVkjHGgtNmcmIAtabN/mTJHwMK72KRBIt3IMsBeTHfBl2uTpPQ73a6Jbev6J06fPcU7E/OhrBvchXOWYcoyUF3PifVCV2F3lPXamq3V9Epte5+LppO8kj7errM6XZfAvYNyVnmfPjoJSoWEzcwrmwysXz3EmITir+GMsFa8NI/jUXHXkwxI1pRc5DQ5fbXy5BOJCquBvY3LndnixcYSUBYasVrWhxDIXfaTjvZsaBRQs7atDmwV6J7LHq64f+Gt4zWA/dx8itCZ5eIGm5FrzQpn5hFDOtIT7nU2ga3oWFuNZNe2p8Jn23DaTtVxSODLIWC1YTXK6vBRGnzv76lpnrdKJki0NhHAF3hm5MDrCzBDCvlBVgxRawIiS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:08:37.1044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0115b79-17bf-4918-9698-08df46ff01e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11821

Hello Viresh, Ananthu:

On 11/19/26 05:49, Viresh Kumar wrote:
> On 18-11-26, 17:59, Ananthu C V wrote:
>> This does fix the issue of policy->max not being able to drop down back
>> to non-boost values after boost disable, but I found another caveat.
>>
>> The commit 8c83947c5dbb added the following change a few months ago;
>>
>>   static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>>   {
>> +       unsigned int min_freq, max_freq;
>>          int ret;
>>
>> +       /* Use policy->min/max set by the driver as QoS requests. */
>> +       min_freq = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
>> +       if (policy->max)
>> +               max_freq = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
>> +       else
>> +               max_freq = FREQ_QOS_MAX_DEFAULT_VALUE;
>>
>> this max_freq is then subsequently used to update max_freq_req constraint
>> for the policy. This means, assigning a value to policy max in freq table
>> directly will cause the same to be kept as the max_freq_req, which if
>> boost is not enabled will be stuck at a non-boost value. The boost will
>> still work, as policy max is set directly, but the value will be above
>> the allowed qos max;
>>
>> # echo 1 > ../boost
>> cpufreq: cpufreq: policy12 boost=1 policy->max=4723200 qos_max=4454400
>> cpufreq: cpufreq: policy6 boost=1 policy->max=4723200 qos_max=4454400
>>
>> This also means if at any later point any limit refresh happens, the
>> value will be brought back to that qos max, which is a non-boost value,
>> even when boost is enabled;
>>
>> (e.g. here with a refresh_frequency_limits(policy); call after the boost)
>>
>> # echo 1 > ../boost
>> cpufreq: cpufreq: policy12 boost=1 policy->max=4454400 qos_max=4454400
>> cpufreq: cpufreq: policy6 boost=1 policy->max=4454400 qos_max=4454400
>>
>> tldr; is that it will fix the issue of the freq not dropping down from
>> boost, but it will introduce a new potential problem of boost state
>> potentially dropping back to non-boost freq while still in boost.
>>
>> So this alone can't be a fix at the very least. At the bare minimum it
>> will need update to how max_freq_req is calculated/updated, etc. If
>> nobody assigns values to policy->max before cpufreq_policy_init_qos
>> is called, max_freq_req can simply use FREQ_QOS_MAX_DEFAULT_VALUE,
>> which is S32_MAX, as its value, and not cause this problem, so the
>> solution proposed in the current series will not run into this.
>>
>>> Also, can you please explain the issue again in detail. I am not very
>>> sure how you are reaching to this issue over current mainline (without
>>> the first patch).
>> There are two issues the series is trying to address;
>> 1. freq can go upto boost values, but they cannot be actually used
>> 2. once a policy is using a boost value, that value cannot go back to a
>>     non boost value.
>>
>> So with or without patch 1, which addresses the first issue, the freq
>> can still go to boost values, which can trigger the second issue. The
>> logs relevant to the second issue, reusing from the cover letter, is;
>>
>> \# cd /sys/devices/system/cpu/cpufreq/
>> \# ls
>> boost  policy0  policy12  policy6
>> \# cat boost
>> 0
>> \# cat policy6/scaling_max_freq
>> 4454400
>> \# echo 1 > boost
>> \# cat policy6/scaling_max_freq
>> 4723200
>> \# echo 0 > boost
>> \# cat policy6/scaling_max_freq
>> 472320
>>
>> The reason why this is happening is;
>>
>> from freq_table.c:
>>
>> if (policy->cpuinfo.max_freq < max_freq)
>>      policy->cpuinfo.max_freq = max_freq;
>>
>> and from cpufreq.c:
>>
>> freq_qos_update_request(&policy->boost_freq_req, policy->cpuinfo.max_freq);
>>
>> so cpuinfo.max_freq is only updated upwards, and that value is used to update
>> boost_freq_req, which is a FREQ_QOS_MAX request. On boost enable and disable
>> the cpuinfo.max_freq value stuck at the top will be used to update the qos
>> max, and the value never comes down.
> Pierre, any inputs ?
Sorry for the wall of text:

cpuinfo.max_freq is used for various purposes. This patchset corrects
some bugs, but ideally the usage of cpuinfo.max_freq should be clearer.
cpuinfo.max_freq is used as:

The max hardware freq.:
- cpufreq_schedutil.c::get_capacity_ref_freq()
- arch_topology.c::init_cpu_capacity_callback()
- cpufreq.c::cpufreq_get_hw_max_freq()
- intel_llc::cpu_max_MHz()
- windfarm_cpufreq_clamp.c()::wf_cpufreq_clamp_init

The max boost/non-boost freq. (i.e. without the user-set constraint):
- processor_thermal.c::cpufreq_update_thermal_limit()
- cpufreq_ondemand.c::od_update()
- cpufreq.c::policy_set_boost()
- cpufreq.c::cpufreq_update_pressure()

cpuinfo.max_freq value depends on the presence/absence of boost. It is
thus hard to know what the field actually contains, and:
- PATCH 1 adds cpufreq_frequency_table_max() to get the actual boosted
   max freq.
- PATCH 2 allows to retrieve the actual non-boosted max freq.
are trying to rationalize that.

------------
The following frequencies:
- max hardware (boosted) freq.
- max non-boosted freq. (i.e. nominal freq.)
are CPU/platform specific values that can be computed at init() and
which will not change merely because boost is enabled or disabled

The existing. set_boost() callback implementations are mostly
retrieving these values to update cpuinfo.max_freq, but this could be
done from the main framework if we stored these values (in cpuinfo for
instance). Similar remark for cpufreq_frequency_table_cpuinfo().

It seems there is a lot of code to re-compute/update these values even
though they should not change. Computing them and storing them once
should be possible I think.

------------
A. acpi-cpufreq driver
3c55e94c0ade "cpufreq: ACPI: Extend frequency tables to cover boost
frequencies" added a synthetic entry in the freq. table to represent
the max boosted freq. as read from CPPC. Entries in the freq. table are
otherwise fetched from _PSS entries.
538b0188da46 "cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost"
is known removed the synthetic freq. which was added in the freq. table
as it reported the synthetic freq. to userspace which was apparently
confusing.

PATCH 2 "cpufreq: fix policy max not returning to non-boost freq on
boost disable" modifies cpufreq_frequency_table_cpuinfo() to handle
this case, but maybe it would be easier to tag/flag the case where
the max boosted freq. is not in the freq. table and handle this case
separately. Doing the following for all drivers makes things
complicated IMO.
```
/*
  * If the driver has set its own cpuinfo.max_freq above max_freq, leave
  * it as is.
  */
if (policy->cpuinfo.max_freq < max_freq)
   policy->cpuinfo.max_freq = max_freq;
```

B. The new CPPC spec [1]
The nominal freq. will be writeable in the future, so some additional
synchronization will be required.

------------
This patchset adds a cpuinfomax_base_freq field. Maybe we should also
add a cpuinfo.max_boost_freq field to make it clearer when someone
wants to get the max hardware freq. If we find a way to know when
cpuinfo.max_boost_freq is a synthetic value, this would allow to
solve [A].

The new CPPC nominal freq. should always be lower than the initial
ospm_nominal_freq field [1]. So an additional (struct freq_qos_request)
for the nominal (i.e. max_base_freq) frequency might be nice to have
aswell.

------------
Short summary:
The patchset should fix the bugs, but IMO it is still not really clear
which max freq. is stored cpuinfo.max_freq.
I think we would benefit from also:
- adding a cpuinfo.max_boost_freq
- adding a (struct freq_qos_request) for the nominal freq.
- use cpuinfo.max_[base|boost]_freq wherever needed, to simplify
   the .set_boost() callbacks for instance.

but this might be out of scope if the goal is just to fix the bugs.


