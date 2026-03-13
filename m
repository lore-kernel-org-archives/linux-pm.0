Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3638655F;
	Fri, 13 Mar 2026 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412147; cv=fail; b=XUX8exXeVlB5yRjUuDXmYssPC5wpjhBOA09zhDKS0eOPf1/RoFqkMa9JzCELpBlohW/7RZTGPCqOm0SNe2cp2dKx5/zkvnbdkFcgEF1Nn0j2wBRZT+QvJjkKWWzI65Gz3w+bldmasjDVjTXgy0gsve8syGq1BXFcXTLtMYLP7JE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412147; c=relaxed/simple;
	bh=9K2nGJggDy/qYp3oXFOcJfYLc5ce27Heophb7lUNs6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+/JqdK6k4RLgTZCTaZx5qdANZ8hvibN3ydz9UyM5hB6dGU6H4faWn7phaZqNnpfvs+QnNpm0zT+cfButCktmsjZigbV3Lo0EtZrMMHyu6Y5pJpgiLAwJLiL0xmIFkgm9707xsGMMIyqDVoVd7rS+ZvUZGcyydcvLfUXKTaEiJg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WyQL76Eo; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WyQL76Eo; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WyQL76Eo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WyQL76Eo"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZI8XKpxylVUr1H5hJI06JAdQ4WD4iFZlHjpeaUxFKEOQjFTb2EHsYoxEWeLqANLG2l47Z7rHp8u3+fr8fUvF63MiHPQj7tRzRDZJitC0M/tiXOX3zoHOj8qgM+kgxFf/eG4rNgzsX3NZZFlHYhqRffepgs5pcfFB8JzGTJhLfYkWI8vzOO8A0KDmtJ7faqGwP7+Pv2zPmATetcZFLU+akEt3h70R4DWYWPR1lese++sM50xvbG9D8hUZudSm4mHdonlsR3FJPU2rs5szuG+kgZaqMj9BWphFeIWoNqwlkUwTKpToyyiqyf+PUsaHaescJJReSDGqXGoVdsLX/peDZg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K2nGJggDy/qYp3oXFOcJfYLc5ce27Heophb7lUNs6M=;
 b=ujzIaZanZDgP3XEB/fmuUWJI0B3vpXfKleTT4k2RuCvXFPDLN/0qjDs1QulrQ39yzzWPB6cqLbRkYQfYbWLSwsdv35lwQrZ/EgV6wN2ewBycBNirxdhTdk4CI+WDxRJMP9WPsk+UJ6CHw6Y2AD/pzY23UZm+3mlg8MloniZWNl3Y4kvqaK0ru+2jp8ix2LAPx4cc9AxFvkrG8p5H3Ik+ZuPPyo3LsAdlOIq86kqD9OZV7W6vQTZGtit3SS7P5G0fW79SNxkFEEiNbRIKi4uF8noP81WZmusqtgNgxHB4LzGlQKU9ixTa0WI5MpV0XgV5MpTFLP2hsSnEdCxu8UwMkg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K2nGJggDy/qYp3oXFOcJfYLc5ce27Heophb7lUNs6M=;
 b=WyQL76EobRHR+7pAXtIpvkLxooaGLwNSBYzUMFQpZk9XJ4Jb6o33H1z3kKSeK3x3oLIxsjqb04ThToqXIUKCtS7c+gE8Yqq1QatV2Dv4vKFrlYgfEzMtUF/N/g6f0XN/dO3TmLhKxXlU8dpPR877Gm58SxeWYvnpBG6kV9FDeUo=
Received: from DUZP191CA0032.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::10)
 by VE1PR08MB5760.eurprd08.prod.outlook.com (2603:10a6:800:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Fri, 13 Mar
 2026 14:29:01 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::29) by DUZP191CA0032.outlook.office365.com
 (2603:10a6:10:4f8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.30 via Frontend Transport; Fri,
 13 Mar 2026 14:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Fri, 13 Mar 2026 14:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5cQU9In1GCFT/4Zue8B9syX3+7U95rkFGvrdV5bN4FnuVj9dQm2caScQ+7soEDyiPkLKmZimgQG95x4h6zouJFWz4uTxqkgp2oouSczwdDMPO0SH8JhCUNnjSLLvGhU4ZOze1stNi3/k1fd09KkhDgCqB1nKi4pPLqwmPOGzkKJTxklSo9fmdAMW0pbFWNqIaEJxTLyO/IUl1C5L9UHOcCI1G04sC/WdAeNTZ/N4pHvj56THKwXBt/stytgOUt2pIQQXXquDucb90lHgJ7UU+Qvx1arV/kAw09SDIGqD25Srg+86yu5iwBh5gK5GjEXXCm0eq0UMQaL4yo+TRdZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K2nGJggDy/qYp3oXFOcJfYLc5ce27Heophb7lUNs6M=;
 b=o9nTcpaiZQ8uy4qXnEWAdJHx/WfotDSYH2Lo93x4+IHyPDoQNyUtUiROIwdgsafZt6y0vGtJQ8pp31ezPLcwsnx4cYiL370Ny0Ezs560n0PWHoF0rrMJOhDNY0Fp1RQFriJbadEZHEQSvm1NHu5/pXu4aaW3evvMb/ZMaWE5xuMYWjBboSs1Gmh3H4+JL2dRArVdfnoqmg0WNr6bFPspkpI4oyP9FI6LJUSd+wSJqt9djrlNUV1y4mMQ7rRuFB3RrI+181+shi6SPPygnEftVcQ3g/5pJ1Xi/BLTZQidM5zixz2fbb1D4nqTHw94+chCAsdCYLej49ApUnHSGhE/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K2nGJggDy/qYp3oXFOcJfYLc5ce27Heophb7lUNs6M=;
 b=WyQL76EobRHR+7pAXtIpvkLxooaGLwNSBYzUMFQpZk9XJ4Jb6o33H1z3kKSeK3x3oLIxsjqb04ThToqXIUKCtS7c+gE8Yqq1QatV2Dv4vKFrlYgfEzMtUF/N/g6f0XN/dO3TmLhKxXlU8dpPR877Gm58SxeWYvnpBG6kV9FDeUo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB9290.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 14:27:57 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 14:27:56 +0000
Message-ID: <9de529f5-9bec-4ef9-92ec-bf14258fdda4@arm.com>
Date: Fri, 13 Mar 2026 15:27:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] cpufreq: Introduce boost frequency QoS
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <qjn3bgedmtbvrdjlhjmns2h4hcpx25vfzxpbfcbyemxr435lhl@ctbmdiye3cj3>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <qjn3bgedmtbvrdjlhjmns2h4hcpx25vfzxpbfcbyemxr435lhl@ctbmdiye3cj3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0072.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS8PR08MB9290:EE_|DB1PEPF000509F9:EE_|VE1PR08MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: c602ce6a-a44f-4f2c-1ca7-08de810cde7a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 vQXNrCJ8uGylIkFf5P2VjtsD1tXWTmLoHzepuLUQoYhi5cnMeCzUOemMfS156KJsCjO+4neIGId+ZB0fTngXaHnKgeMi+R9VEyl4Yx1FY82ccE9d1VeGM90AINTrN7e4xcCza+HcqJ86v3ikOG7skuge6FBpHWJQul3YIVSB8v+bf5nkcZtBYVedRRvFwI+a1R8Rr5ick4OLrqIxP11pFJ+YyK7fmM0S7IdjB2wegCAHQdxJtTI/AhtiiMWAS0PQ0SBPzLVH31mE1GOPOceLpJirKH88WTbgPgI22A7d+d+KByuprvHf10pgi6oNm3C/tNKDdLKPhHSHd5l8qIzIy9B2oDb95w+0Am8GFAa1dJyS6Qc2I35nXOXnGP032BvNJMSPE8QqiILBVBVtEYN3r9ZQlD/I0z1C2a+3N5vAI3HAX1eJk8ywySoUdeWwMpOvmiz90AhB0ObWTdhCDBxv4cORIjOmjebIk6msVe2kplIx5G7yoPIdoS3eygNSkUUAiiFlqYfYVIee246gK50f4BQBPt7etI9OCXenmiowWBcfRhGBL+Po8YmaWefnYhsHHoksPhUz4+0Og9TRGC+L1Kef46gyy9hzePhJXIhFtmi+6LSDfZ9p2bk0id30uOYVv71Mqvn1sHvJHBAH5kVxSa5YWRkn92qjxL9qyTIt8hrjCmsoUS8BY2Jx6ycBC7czatbvIFM+tsVFtcPcqDw1C2uGUZw8XhqMQrCv9JInE9A=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 aM3TFPOYIPaCsr2CnmOMyafXFMAVNjXAQHkswaIU/u+Z8d2N80vagsB/p8GiAoNFpReH/Cagfx5S2CP7HLRMqfrMlsou7t4010YHZzKvcigyP0DI+maE3h0dlTRXESlj+g5FlgXFmStPSQrTLsFzROK81qRdlFEnkZ1i6FrY7rCkOdXZ6ejCsI4hhxhmzTl0uwrm8ocLin7sFVaFG9VX1Qam+InirZMOIZvZZmgaLY+IMQZvjxd6lf+/ny36JZFlm62F516B9XCrIs/p4gwNqbPS6/V/HGhANwJZqHim04f4BbXoWK3hczELigJXMdJwwOmrhGSrXPwCLcv2mE62eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bef69fc3-3064-4bd5-edfa-08de810cb82b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|82310400026|14060799003|376014|36860700016|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dNREvu4xZXMUkg/+ZiGgU/pFN+D+WFKjq/wJkLttYi0wDvKbfTpZscAiJ86MZf+oryP6cpgS2Z2++BBd5IQg5kkTY0S5ijYzw05D2UWEjtUJgwT+AotDwLD03k37+C/BZLArxqaOK/Sh8Hbk5JUDGCNHdWjH1eQ/zR6qlMNF6m5TuyaEw6Di1ZoGSq8t3lAngnol4VdkqSWImmqogKYg4ztq5jXjqflLurGKl/4Mj5k4YzRiMPjo9OdZtQ4FZPRgdWYZZXiwv27/D8yUMxUxakdcl64ZTYGeUJO6CNuyEJCDRgrzU+4mEcmJKRpjbISgGaNA30M65m7L+/oX9nNHz3nPvjYQZrV2B8cFvck/9kP8zEkWM7qYXPdVrxePRShUfcdd2KfWyyLb4l/eUHo87loSRfKRJ4hkuK3Fockpq+4tMcn7QN/yMyXUTMe/SDv2eFxIrtfcc6icfbXOFoXG9QwBCQ3esKmyUBqv8GJrbYvCBYua8pJKskuUZYr1QJMlftJkdrg3uT3myyZq0H7TUw9lCWdN+wTYAy1JQyEjqsUZyyoHrSAdKNOW930Sm/YlAtqrwMe4QRZw6EW7/VVC9twLzkSc0TlAdkK5h+rV2sNs29b7uNAHy+z9my+xREj2vNnRLobcE4MF/SFBNtG6qsa3QO7RafUQiC8CTTuluACZ+2zrebgIOImuDJymb2kAyNv1d5KXfUCnb/9n8pjxkaNGbOMkAlKv58PHGlgQOAGi7Kx+EQG6Pz93s7g3991VbrZCiTPhqlSRgr44/hOTGg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(82310400026)(14060799003)(376014)(36860700016)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QrvsKokAgvwL8mP0JPcBBffdYg61XmycM3RYTjG3GEdRHhCH07m3OQ1ldjUrVLaDDjafR6IGhQjg/+PAeeIG2IwjRrKHopTO9PuSQb+uz5xQFZ7t/cyT5yz9K3diVrq53duBiS52C1catRb8GzF8eKPiw0/RDJvWU8kkmsN7h8htt69tod7naiBErl3JyXCD5CgT1VGlx77cYuOxo4XFaZVgofCKD94J+7Fwq2zUmdqAFqKEc5elBzlZEJaEtRf00bADoaD+S7KdZQeIaEfjZTwWT6xIlNay0vFEXUFgVpEc/PnoHBbYuO2vLLaTcL/1qSBsD80ZlvsQz27NEeCPgD3MiDaIF5yky2rI/xLSaT6OYTwlbU2WeRrJikNMsPr0kxVO1MuLanDHXE/ZvbgTv+8euxm7s1OfZS7yF7tEmrluzBFq/o9foExyZ5/i+0RP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:29:00.4314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c602ce6a-a44f-4f2c-1ca7-08de810cde7a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5760


On 3/13/26 09:13, Viresh Kumar wrote:
> On 25-02-26, 09:49, Pierre Gondois wrote:
>> E.g.:
>> On a Juno with available frequencies: 600.000, 1.000.000
>> Boost frequencies: 1.200.000
>> Using the cppc-cpufreq driver.
> I think I suggested adding this example in one of the commits (it is useful),
> not sure if it done yet ?
I might have missed the comment sorry, I ll add it.


>
>> Without the patches:
>> # ## Init state
>> scaling_max_freq:1000000
>> cpuinfo_max_freq:1000000
>>
>> # echo 700000 > scaling_max_freq
>> scaling_max_freq:700000
>> cpuinfo_max_freq:1000000
>>
>> # echo 1 > ../boost
>> scaling_max_freq:1200000
>> cpuinfo_max_freq:1200000
>>
>> # echo 800000 > scaling_max_freq
>> scaling_max_freq:800000
>> cpuinfo_max_freq:1200000
>>
>> # echo 0 > ../boost
>> scaling_max_freq:1000000
>> cpuinfo_max_freq:1000000
>>
>> ---
>> With the patches:
>> # ## Init
>> scaling_max_freq:1000000
>> cpuinfo_max_freq:1000000
>>
>> # echo 700000 > scaling_max_freq
>> scaling_max_freq:700000
>> cpuinfo_max_freq:1000000
>>
>> # echo 1 > ../boost
>> scaling_max_freq:700000
>> cpuinfo_max_freq:1200000
>>
>> # echo 800000 > scaling_max_freq
>> scaling_max_freq:800000
>> cpuinfo_max_freq:1200000
>>
>> # echo 0 > ../boost
>> scaling_max_freq:800000
>> cpuinfo_max_freq:1000000
