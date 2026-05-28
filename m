Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA923911AD;
	Thu, 28 May 2026 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958617; cv=fail; b=gwrK7+0Cx46owMlpgB/gzGgYNSqbwunpYJP4bbZMtLzzjmo48ie8319I1XRtSRQ1y1RRRKDZ0Cc9LZAY4Nbkwn3T9lWDkyK0ZyOcswfE7aCI74vBPvjn6fdvTx2PiA3jg4hj8bxRVwmOxgacAPK7ku6cI/BHIPtjiEJ5f39PA2w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958617; c=relaxed/simple;
	bh=K7tuIMTbHJYFaYRIe5AJncRnqOQLw9mdaB7ZERX7Jyc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d81s6ZgCe+XJo7lE31OHFgmjS7HTFPBNLCOlHhVBRniWip40tubwjt6Li2BA4cU8y08NnzyIdrJODMyJ0v0yPVnbHhzfmcYxKlW521dDpwuWPoMfUo1EGXr3XuXHeZYMcWq8psbJKD623lveJ1PcBgF1WUKgpTtVhLOco6UIWKQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K+3BUok/; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K+3BUok/; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K+3BUok/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K+3BUok/"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vTHCRl0Bh9X7tbqe61yyry/xZz9e+gxTcDIuwzdV0GTpzYeOqVjhU8Lr73PZrdESMOVy7rySl5igdt17rJ1+1uWqU8qdoxHwqMHOk+LuLZnCtkY3Ct+uiz7GHy1zmQkZ5zoXlVGSYbn1WgAdKi5HXpL5mD2sfzU2fWZkwUvU/tCwTe8lqVSZ3SpgWZSdBQVp9n+RYIcLgTWT5GT9jPzoFgoWMQaZ0UGfJn60SjQVjj3W5Q4MyqZu4Z9cJByGSs2RsHzZVbZqb2PKrxS5b86IMmJ5JyDal9I9nU6m7Ll5rLUI7Y6jX6pG80Hb5KlANNNCI/u+MXCH+brdnwlewUkKYw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0FlReazdrLX7xl1YCeBKcpZSsZ7Pbu0ACZs5VxkEPU=;
 b=trTwd0+fU/C8hXbachZp0ttSxTZV6YcmJuuuYtfLsg5UyVh5fOb1/nAZ9RU0zyDe2J7nHhzvlf2nZsiKb/nhIz0akUkmThv5+qiShLiesHhk0nYIuTGlklYhXRlkclglTe+ud6RbsAfJNDyQq6ibDj2izM/030F+xu7ulPBTr4sqE9FjANWIsgO1pQmpcUOVh0LtWaxR5veD1TBaLGm6GN5XYUGSkUmsAiJPDfQOhL9iw9m3B3OangcD+QFDcddijoVWEohEU6FImW8mYnvQCvhUwbV2eRPZOIvbP/hybdx1miRiTs8Sqi263g407oiRq7kgl/NpbDg6/UmZL6EFFA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0FlReazdrLX7xl1YCeBKcpZSsZ7Pbu0ACZs5VxkEPU=;
 b=K+3BUok/XaB0n9d+uLf7S/r4JEFyiyGyV1WFnZo88fnXvqo1eLl4g1/rVXwcFUVN5MMDUy+NmXmT/JQnnFMT8G7XaHasm8LSnragyxlrv678GrfUXJpMwLDg+V/v82/1d4P1xABa9DIVZ2sNT21RuvxM2ys91Is831OcAnIAV1g=
Received: from DU2PR04CA0037.eurprd04.prod.outlook.com (2603:10a6:10:234::12)
 by GV2PR08MB11491.eurprd08.prod.outlook.com (2603:10a6:150:2a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 08:56:45 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::b) by DU2PR04CA0037.outlook.office365.com
 (2603:10a6:10:234::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Thu, 28 May 2026 08:56:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJvkk2M3+gdzNBxqXwnhkqqcgUkxUB3j8MDT+foO6yfct7axXgQY2Vftn7OOMYolPd7a0ZHvmBOGBzFWtFMORd+XCjyZrBpiDHnN8RIqLHJYRS5vBGcyt5VhEwR5r3tBwR5kQEGo4q0/X9fjdr8xnEqz0uDVjR1Oe0QS5kM+AZfsiKhMuERGYX8PK7r6ZEiENJy/aB+BhZMLRs4T/BQ7dlaac4gy5L4OCpC2LIqqzz7EOJ3r9vr8Lnmrh7D2WEyd6O1remGeSMZUxgG5c67OsacXqRknZnDpSk0zJcQg+KpS3zcbEWTfmTBegphC3nbQIFS5BYe5522NbrCrc6xoYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0FlReazdrLX7xl1YCeBKcpZSsZ7Pbu0ACZs5VxkEPU=;
 b=DpBjwNUjDEbGATjqm9fGUv0ktdqGXaivVWnKjRcB3pZOOpfP2gil2HufSYR6Fecf2UPX1lTicJ1a+S41tqmesD3AmIe9tM8HzFa5TMn0YOqUv9szTFziSFRjDJ5sQHG6Pb1RVrp5PeRUXpyM+nVEEsTX4wW0eZH0AqO+6bqO63Hc+8YA8j6uCVS++Eoof6XjC0JBIx2CSvpfEQPwx/LLfRd5HzNSvN8xD2WKKnyACmZSQJE3cIBQ1lPV4pcyJfXJbwCiM2BOBML7Jej54bQx4h3UCahW1TKUenUclbgFx3UEx2auWD7z2X/SeYq6+oaa7RdkfZSBBe++m1JupFXGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0FlReazdrLX7xl1YCeBKcpZSsZ7Pbu0ACZs5VxkEPU=;
 b=K+3BUok/XaB0n9d+uLf7S/r4JEFyiyGyV1WFnZo88fnXvqo1eLl4g1/rVXwcFUVN5MMDUy+NmXmT/JQnnFMT8G7XaHasm8LSnragyxlrv678GrfUXJpMwLDg+V/v82/1d4P1xABa9DIVZ2sNT21RuvxM2ys91Is831OcAnIAV1g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DB8PR08MB5450.eurprd08.prod.outlook.com (2603:10a6:10:116::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 08:55:41 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 08:55:41 +0000
Message-ID: <c7353d1b-82b3-46ee-ba0d-319004a55f3f@arm.com>
Date: Thu, 28 May 2026 10:55:39 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 1/4] cpufreq: Extract cpufreq_policy_init_qos()
 function
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng
 <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 Sumit Gupta <sumitg@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-2-pierre.gondois@arm.com>
 <cbf289b8-19d9-46b2-a80c-f72720686c46@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cbf289b8-19d9-46b2-a80c-f72720686c46@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::10) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DB8PR08MB5450:EE_|DU2PEPF00028D10:EE_|GV2PR08MB11491:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c122d2-8723-4f44-190e-08debc970b2e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|4143699003|56012099006|11063799006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 w2S44V3EGosgbZuLYFIXbM7Hqnl3CnY9lPZWYjcDlQOxtoY8LiG4TetC406X2r2JUIKBnsFvGE1lW90cIC4RAeu1Szv8I5iuLJCJhl32cUPnhGB3fv/yYJVoypxBof0VvPnhIzE4B6ZSqOLxzye6QCbfZUdbtBQ4h8Gl/pg2TOYwxkAIHbtmTGDV+Eiyg3DClfZ6inTlO2bxr1ndQ1S8IW1h8n6qmuJDaGlSBUfY20tg4AGNq2msoaiNtFwHNZTHLRYqbF1Z38gbKN7EAsLYEvsVuxUTX2PyUA3HtYPxNaLU6run4Ql6jiIxW0pu5kfKquTrANO35f7TwURST6FkyiLbID6utUV/UW77pd1WyAHPIbgZla/DJFVBkwttWKaSPs0L0iVCGfz85WtNGZZ6EzYb4nwIuc9CFWXfyaWCx8vfoncbI1k3j33kog1G7ovJGtJjdHBNvclDZGSggXtG7eqNEP5HRUzFokxekNi9awu27VrS3WpcSggugkEAoHPDGxTDJMDiXgln0XtmeTegfozZnJbB7RnKLIGO1jYHGN4k++FnCTTxB4UBMQpuSOjJ6Ncu+YDH8Of3g9tUA5LpVxignzwWeI3Vo1pwIRdOwGRNDKCEJiruZ54UNaVX8OLgqDFuJ/dJgiIY5dnYCVmwIIXN79H/VPMWzNu9QURaWVheZryMVNUI8ve0iVdvm9UX
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 KaosXn7FAOfgTlzeuT+1iZhTs5v4XUPg0iqE4menF7xOt09x/5oQ9vII/FWt9uAu+akBSDVyu8t6bR4eXIpgJCseutAkndUSjWnSmpdMRDcxLI09CFHt9PP6piRHjv0RTgJ1+CN5qlV2FWKZbP0l0sGBVedRoP8lPLCtVcioI+QPteMPikHR/0h2e7U0rStk6ZBYNVFfnT9V5Dpa6O8IROx9Yn2a8D0Tn0ErovSYRQ/v9LEviaCG629WBLG/5Fys8LS9drZxAfh59zi82qccjr+mvayfUlXbyLOaVB9cFJGy6FPBbkeo1R3DN1CF0yX2PFnMpL7v8j5TEKCO/gB+Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5450
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	85fba731-a41c-49fe-934b-08debc96e57c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|82310400026|35042699022|376014|36860700016|7416014|4143699003|3023799007|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uDIc/uAKCqzyuO5Be/mwexJ9hk/cm0WU/Nie7mmsST6r4Rp8WKcDfVwEP0v54QAmXwdBpoyIA/pd6HMiu6EfZnURXUFUF5vDOE8fYdk8NE0G4Mh/w/PYy4zJYfw8kYdHGi16Tj/Y0kx7jFHdWPlLrbLc5Pe51SJr1BEwXIOFIc0sToqog6aJ62b2bpfScNUd/H07Rxk4wtrRjxYGGDLTzqo4LWnGo+p7U7q8fplkGp8CgMac3Pam6xJlGiyx8E+us5/xEfwOlSj0nF184d/YUWWptjN2GWuPFZTVA5Xm3xoQ27fnT0RQZsPcmpUrzIKPvZTP0kJDd6StlhVfUMdZc/pFsKYa1sIGgar4CIdJCq3hsBjTkXzUtXvdpj4/yX2AtwBItX7Mn1pwNyelf9ikbRH6jz5gHLMJVmquY1ZQI/xQrMygsFTuF3tY7sFpZIDhQJBVmdoTwvBIhhzeEmpHvfcZKfW+kM8gkMHCGWPNJjTuA4hlJoCHKGGJBmW4kGXDrMuHy15sDyfXDPGiXouYz4D3ZVJwhJltXq6DKY9TW8bjXJWIPPvKh7xx37oZlb+UIo1pHOjAoqv347DNZgMJZSZBFmLoA2nhBwNm/PVhx+YYVt+piVuicwP5jtnbK8R/lZxK8n3nV3/ihrIQJJyc2erOBmJTD3vSsoHi86Pu5s37qRNCoQT0eVMCS9AE6M3nILQOkvkVj7CChrtGERE8mu0H2YZxqUcO51vK+7ZmqvI=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(35042699022)(376014)(36860700016)(7416014)(4143699003)(3023799007)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SGm/e6LJiY/9R1WsHEAS58AD5+oiAm4QWf8R6cDWXju3LlnyJSfgUh/gVPPgDtIEAbHkqQXBe9Vvd52+5RL9CwOSDCb+lxM+OUSkR4kNz/JdPtwGzNrEqwa4auKt1HU66KrFEOqpJ97Tco5n/XofKqHlAUz/yXl5/ZeM1IqYeNACCy8Ga8e61znszhS7Ycc/S+E3Dut/0Ffw86ztfLp8zfkoNt2haPFjz9bQHk06MJ65tv08rLw7ztppgxxhN98tBJEW6601yE45dO69ZPBODTkJ5VWX1P0Dj+r+xK0kBSgOJogekZDMXUFsCA1SXlEEhDTjSJLCHQVdJ80cBnoI+JdpLlx5bcSwMt0OsP2pQgALHE4Hr56+BDzv9HQfRFY4X1thULJvDjEJpigRJ3iwmY2CilKk22wDLYo8dHMUwQtN43v4Nj9APCo0PeiwNLc0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:56:44.5818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c122d2-8723-4f44-190e-08debc970b2e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11491

Hello Zhongqiu,

On 5/19/26 15:51, Zhongqiu Han wrote:
> On 5/11/2026 9:55 PM, Pierre Gondois wrote:
>> Extract the QoS related logic from cpufreq_policy_online()
>> to make the function shorter/simpler.
>>
>> The logic is placed in cpufreq_policy_init_qos() and is
>> now executed right after the following calls:
>> - cpufreq_driver->init()
>> - cpufreq_table_validate_and_sort()
>>
>> This helps preparing following patches that will,
>> in cpufreq_policy_init_qos():
>> - treat the policy->min/max values set by drivers as QoS requests.
>> - set a default policy->min/max value to all policies.
>>
>> No functional change.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>
>
> Looks good to me apart from a minor nit inline.
>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>
>
>> ---
>>   drivers/cpufreq/cpufreq.c | 53 +++++++++++++++++++++++----------------
>>   1 file changed, 32 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 44eb1b7e7fc1b..034603c2af325 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1397,6 +1397,32 @@ static void cpufreq_policy_free(struct 
>> cpufreq_policy *policy)
>>       kfree(policy);
>>   }
>>   +static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>> +{
>> +    int ret;
>> +
>> +    if (policy->boost_supported) {
>> +        ret = freq_qos_add_request(&policy->constraints,
>> +                        &policy->boost_freq_req,
>> +                        FREQ_QOS_MAX,
>> +                        policy->cpuinfo.max_freq);
>> +        if (ret < 0)
>> +            return ret;
>> +    }
>> +
>> +    ret = freq_qos_add_request(&policy->constraints, 
>> &policy->min_freq_req,
>> +                   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    ret = freq_qos_add_request(&policy->constraints, 
>> &policy->max_freq_req,
>> +                   FREQ_QOS_MAX, FREQ_QOS_MAX_DEFAULT_VALUE);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    return ret;
>
>
>
> Just minor nit: cpufreq_policy_init_qos() could perhaps return 0 on
> success.
>
> In the original inline code we only checked 'ret < 0', so positive
> return values were not intended to propagate as part of the API
> contract. Returning 'ret' here may expose a positive success code (e.g.
> 1) and make the helper easier to misuse (e.g. 'if (ret)' checks).
> Returning 0 would keep the semantics unambiguous.


Yes right indeed, I ll do that.


