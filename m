Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA238D403;
	Thu, 28 May 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958596; cv=fail; b=c9Z4dCAZn+ghVYnFygkzJHht5VS1NGMuHtHsuHShYbh7Q2K7WyAQz3w5sYQsCq9zvtfKJY7TxkxVXSj+zI0BogOOwRdMzzZYEAw6VvQXXhqJlhm8sBVcKFQMsO6BJQfOCBAZ8Ks646qiNaULhYGXoO6sczIHVC2yZ6jWLtdikv4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958596; c=relaxed/simple;
	bh=C5bnyEM5wa67C5mJ6dXBor3AuCyztjv+DI8/V5DMaSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n3hQ2LYKM0kndD0jsvxNOexVL9F6CveVWiYb2RdOBMPUVz8bYhtpSwqR+VEPEdGCQSMxBOecTaYQ/Ov+lneZmE+V2W8PLOeIqDaBV82g2Ivv8QkSv2+3NajhfCrlRPDgNeVA+ETkoJTfEVHW+rrVAVg1snWX48MCeACMSyVbs0M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l0ZckSf0; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l0ZckSf0; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l0ZckSf0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l0ZckSf0"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ejdye6n2CX8B+VOBPBkA/fOwmB0v3XlBC7gJ4UNq2Bag7nvLVTy/FVcyl4PjZmYsGi+Lmd3gMOk7l4XCH07pY0z2XsI3JUCLw2+UWyMxIoWAN8MvpjUgZMCy9brqWVCA7w+KkOvIFYfFpBiDUekDASyCdjpnMgLxiBRD5z9kRLB7Jlbeb3gqOp9muF45qPY0YYJy00QE/bbk8woaeKadHQ/MpJqTefPsMkj9Rev3qWuYrlmA5tVdpXbCTFDB/FaEM094GdgdC/jaetjGiXx6lmfJx2nyuZiqZVjxrXcQDuTgOpQbLvwpcEDrZtB6RIysaIf8qoqPabjd2H4FQ4i30w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMGI1HdI6tH1EMMpOkehXMfM6aRlpUcHZJsPE7sUGy8=;
 b=QiBU917rmU4Q7YiA9lxUhVz9ETfcIfYfom6wFa/YsvwNgdfddX0dJcfah0T2MvfEPqy50SwR5wbY8asgc6xM0+anVuM5FfJuv4Nd/j52rstrbIhw3uH6dQ61nsscpTzDPbpkCX3y3mOozh624BirCA3Ar4NvQ+1Xehn8pOxf5vPtwZVtJaAjmLmiiqVQ8dpRIPhWZBn+fe2294sJWPyxIWS3jssKttQXIaskr6tYwqsdP9/dorVZ9IDjossyKV8qqscWptdiYI9lHjCQzNFCe0KMgb9aIqHOXajj3crY6I03XfnNPbQB71DQ0t9tKjqLOXiXeCbaiBNS8t2yzN3MXw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMGI1HdI6tH1EMMpOkehXMfM6aRlpUcHZJsPE7sUGy8=;
 b=l0ZckSf0QUhbGUUgQfiv1w3RsQBlCVBt+RO80N/eXLsH1qOR2aPXtfBZM+rAWU9BbDMQM1EEUT/sY0Yb096/z+pu3TH5aVq6NyCb4TFYWm7ReWk4HLkSV4DQVwCmwGa544NSnVWyu5/iFRoILrcQbtI7beHynOPl4qJh8z9D4fk=
Received: from DB9PR02CA0026.eurprd02.prod.outlook.com (2603:10a6:10:1d9::31)
 by MI3PR08MB11933.eurprd08.prod.outlook.com (2603:10a6:290:75::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:56:29 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::5c) by DB9PR02CA0026.outlook.office365.com
 (2603:10a6:10:1d9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Thu, 28 May 2026 08:56:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIMk5Q/tFwsjPTae5kDGDKq5HkaELPy8P8Xh5gxHAXpNiE2c1hynUniUnSLh0rJ1VjYZXkDvmivbGRqFGIHekQL5xFMGeD/r0KbICIj2CPbE2+vUoo4jqobfzl+G01iHQatN6u1GZ/27Adzq/oHEIxkGZ2jg9/aMyOxPY9T0K2GjUkjuFowmENuOk/a7VBxMGgei/qMlZaZE5uio9/AhH6CFTUbIU8GW/37zTM1SYL5XqypzMGftMPoL7Y7i7GUd7X3zPBxNOc46OzMayibpYv5Wh5K43ze/e4p1VIi8DIa5asRQtLKDgZfW512JsOSGPStayk4PClm9xva547mkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMGI1HdI6tH1EMMpOkehXMfM6aRlpUcHZJsPE7sUGy8=;
 b=saM8RhXLEMhDEzDj20/xMr+9FP1aZwm96HBYBK35a0NuPxRqrrEkUm5UZ76k7WznZd/nEcCPwmd1N6ejZQo1ZrFIpwicjoKqeZJYIyHoswYXX8nXEkWvAsZJALQKBJsvMk44fVLpIoLFr/u19S/rxVRNJSkMeQlHcnO4aA1kqLi990mVLhkdcxvLY23da2pDv8qH5vPNk6Sg7vEqvawr9/thI3jeH1U9JddeZKC9efd+V8zhpue6nNIf+NHACJGQBO/AKTOROeEjNVZlTpb8nloxjfAYdbliKijGFTliOms6PyBmRFdRVBEYVYjfAzsitzXZR7DKu2f4mqfRnRWuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMGI1HdI6tH1EMMpOkehXMfM6aRlpUcHZJsPE7sUGy8=;
 b=l0ZckSf0QUhbGUUgQfiv1w3RsQBlCVBt+RO80N/eXLsH1qOR2aPXtfBZM+rAWU9BbDMQM1EEUT/sY0Yb096/z+pu3TH5aVq6NyCb4TFYWm7ReWk4HLkSV4DQVwCmwGa544NSnVWyu5/iFRoILrcQbtI7beHynOPl4qJh8z9D4fk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DB8PR08MB5450.eurprd08.prod.outlook.com (2603:10a6:10:116::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 08:55:26 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 08:55:24 +0000
Message-ID: <31854023-7a24-4662-9515-5459fde41aa1@arm.com>
Date: Thu, 28 May 2026 10:55:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cpufreq: Set default policy->min/max values for
 all drivers
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-3-pierre.gondois@arm.com>
 <5jmfuo7wi4zqz3cv3voeheq6jm4xaxkwrnsprpjwewtk6v6qjs@vea3o4u7cyl4>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <5jmfuo7wi4zqz3cv3voeheq6jm4xaxkwrnsprpjwewtk6v6qjs@vea3o4u7cyl4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::13) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DB8PR08MB5450:EE_|DU2PEPF00028D0B:EE_|MI3PR08MB11933:EE_
X-MS-Office365-Filtering-Correlation-Id: b03bb1f4-b500-44a7-4184-08debc97020e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|4143699003|56012099006|5023799004|11063799006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 V05O0vC0UTnyww7L4sYFgfTfnzBDnlVHxpnNpBUstx9/9M44BaEMoAHMdQVtcQ2f7+AYSNDGBoIXBWvOH2t4oYNEGhp3buXQVR5elrH7RAgjaKuvjbQ4uUW6hpouXJ34WJt3XmUk4b2f5S6ymAz7VyxxhXlPI7thoWiqumXa+hTqi5S3Ud44mHHnz8+NzWbzQcLEXyNqkmKMQR0PEy/DanVhlx945F75NlYmxho2c+85q2nrwA7mnagW4D66ow56vtAGviNtOWYjwz6X5qlxTNOK/qzpCNXQr1G9yVElTMABAAWjHdmZ/kldxJMU7hwSUXUQDl0ubCRHMNdPmR1QVUY5SdWRYHZhtDgRXCbL2YXLlx76Xr3qHHEgV1sEpvC9gr8V0TLiyJ6L1VpXHlCNggWROp8D7dtt559X2GKeWkcyvXr7pMOyzgbcwfcphxRaKcn0s/9AYVncGX7lS+4JfhfQlNny88Yx7ep/lfzbTZgAN1h3BYCB9cRrgo3/ImidSNYICqQef20dZpQv81HzaeaP6eUuj1QR+yMrCCbVaeadsFB+b99d0N2Fqg5f/RAEm2Hph0RG51QfbtWDLkKwraU/g7MkUo7TCYaO0UEdw+Q0rGWl9/U+jobQVKe1N6ivLD/xlJCY80ilXhYQ6r9mpQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(4143699003)(56012099006)(5023799004)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ivMVUfp0uW1+QvXWwudlclGj7laNrZZAInDc1nA9bGgEgsfs6PyQPXwBcYNrH7S9/XEt/TvGRA3nvzEk3fuQGUzGcNsVteHJ/Ayi9u6sRLcDWDHJuoqnMK42yKePsrGzJr3Hp6f2PIuMnPIUs51kxI6ns5QiRIfh93Ykbf9ttPpxNNonMfINChKiKbvkBxvzEQ69j9TgW6asUDeaM5PF/Li5tFbtV2AJDUXag/3LlgINykOWNSQC0PWf+VgaEXD5whJWCJJ5C2iuAFqxi+pfcF/tixSm1cCmuYBOdSRp22Fq2ylAbtSIilZueGNsuwR52Q0Nd3DSNC1MOQ6JDvkfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5450
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	53ecd7c6-96e5-4cb8-0c14-08debc96db61
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|36860700016|1800799024|376014|14060799003|7416014|18002099003|22082099003|4143699003|3023799007|56012099006|6133799003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	zdNa/hk5poirh7dqlvJxFHg+pCPrjZer3cBwyeI6G3d5AL6rBTZwzFUAJ+YUgzzssqBuXY/RFzI3v0mowFGg19iM+PMyvRwJBUpNbkH75sp2AY5sDdOKdS+npwVyqAsIcEgCGV8kS8nGQ+5burKb6gvyKH/vjdlYilnmMb0H8XK5LIye3D0l6u977he0WgRA8lkayquLpEpoKqV6dEIVyjaJ2Enhem/SQP5ortonnWmZwzHZmAYojSjf+Zv6jS3DHICphd0Zs6oENufOix3hUc7xtTbfrCwL5ykuk0hoygPyVCnVWiiJ9TFOAHNLnEpSjkF6B0g7N4iHRca2DyzAjNqhuILCOM/eHq7vf0IQmPzX2ilvAT34eymHprobP5qFTvYZNiYrcnfJQgnHDJPoujXQTPecMuLk7TLKwQmklvBrNMpqeaCRg2MaGIAkmvg1C5FeKV6b6Utu89/E0ZnvvSRm2sDuho8KWwKDZhypajoGChbzqiVi49k/ciQarcySqsmYUPGNmFrAH5La3V4R3SORHoKsGFdCLrDjuwnimTT6ucKCp0Qxrq98Q7wkGLoss8pJaQ3BGULFv7QrZ2KVy6MWBTTu3ESuy3bpIsh/xt+xlGCDb5QdHW4dUNgABbMNnfgHn2NTcvSflmguBHsExtF04rj0nP/Ji5tibK8p/vKTFkqyj+chpeUTe6348Mk9
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(36860700016)(1800799024)(376014)(14060799003)(7416014)(18002099003)(22082099003)(4143699003)(3023799007)(56012099006)(6133799003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G5mGIMDSijTDYP6aZ4gJDivqP+aLhVqOYFe7NB9XJdNqF0kBhe2WuzdTDB1eRXeb+iXfc9UyID8RiUSvrYw5dJpyx/6Ub0klOEzzz/iNZaX4ArXYcoZOdt7V4lxAS+/Fe2ZOd0E9LuHB6Ie5YxhaSWhyotNn77c+gEXGBDe+XPD7W32NKUao+HdEftXPQrTVQNQ/yhY2QH4fUnBjp7AzSPyh3Hex3SLs1nOO4IlTQra2+9TrK0QJEo8yC2WtC1bamZFr1NHg3gZTP2nafd1m5PCHKIfI/MECmVLLFoiKFslZalh5gBoWH+/CvnUky+WnRZW3JPOJ0tBOqNelTwIkI187jGqEs5ueTZpR0rZIeXbdD9zZwBlEYSH8abdZBzTQBB2fOm/+5Vy0YPQ5igvFqqZ91se/dqbW3hv+GF9O3XKtiwt+Cq4MimmyBX1aCe2G
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:56:29.2747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03bb1f4-b500-44a7-4184-08debc97020e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR08MB11933

Hello Viresh,

On 5/22/26 07:43, Viresh Kumar wrote:
> On 11-05-26, 15:55, Pierre Gondois wrote:
>> Some drivers set policy->min/max in their .init() callback.
>> cpufreq_set_policy() will ultimately override them through:
>> cpufreq_policy_online()
>> \-cpufreq_init_policy()
>>    \-cpufreq_set_policy()
>>      \-/* Set policy->min/max */
>> Thus the policy min/max values provided are only temporary.
>>
>> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
>> cpufreq_policy_online()
>> \-__cpufreq_driver_target()
>>    \-cpufreq_driver->target()
>>
>> To prepare for a following patch that will remove all
>> policy->min/max initialization in the driver .init() callback
>> if the min/max value is equal to the cpuinfo.min/max_freq,
>> set a default policy->min/max value for all drivers.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 034603c2af325..9e2d9d3fc5351 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1401,6 +1401,13 @@ static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>>   {
>>   	int ret;
>>   
>> +	/*
>> +	 * If the driver didn't set policy->min/max, set them as
>> +	 * they are used to clamp frequency requests.
>> +	 */
>> +	policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
>> +	policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;
>> +
> This has nothing to do with qos-init, we should do it along with:
>
>          cpumask_copy(policy->related_cpus, policy->cpus);
>
> in cpufreq_policy_online().
>
Ok right, I changed it in v3
