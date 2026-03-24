Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B13EC2FB;
	Tue, 24 Mar 2026 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352475; cv=fail; b=k6wb4ySidB6oLaqcayyPDtWbMPzuianN2KcAHbeFXbB7Xw3nmy3dBbkmbPLAVvF43RgroYJbHVxp2idokHwInKmzj3wxIBCX4bWiWoPPT16tRxXHvxIcJcyUH1QlsQU1U40QDOZdFlee/nAqfrGtFLmFtdWip39c4mgb/tmtntU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352475; c=relaxed/simple;
	bh=ItZ5q+f+VwCnCaOH8Marh0pqMcBH7rPoUKAfszZt+Aw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tqF1EO+lM5OjDfsrxGJwzeO0nxkrg0A7qxx1oojMCKFZ3VHE0JIVyN723nilWA8UA0B63LYiSgQ19gRxEMj3XOBy1YZ/3wZ2kUySOue7hV1zT7nYaSJ49EtJXQwzyEm9mLGG4CN8ldESNZTgiP93J809n6KvDjgop9n67z7zEZM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rxs5HKJc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rxs5HKJc; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rxs5HKJc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rxs5HKJc"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=b23TcmusWKyJtsQ1dxdUf7OJqkYzkSGiFrHzuev0zyX62AdVJwt7BlDNj5jWRuBMfnyvX8q64Gpfa2bESVK8LP5jaQ60G2EzcEU0+8u57A6sxBMRF3jSJkvU9Qb5KbZoAr9GNO+2Pbz+ue3w/dsNzrgGp/x/2PLyXzZfrxNV5TUsJmEYUa6KT/PmrWKOzHelE9eG4t6hyFA/uIG6DMCS1cLaB2wnJAzOmE5qRqvkoy+9oLWM3IdKAwnxtD3wj2FqOjp0Sk2n8Q7yg8XydmpIJHeSRYLfmYKnECvviXPsUeDfhktdPrmKfDyOLQnu63oOMVX8RZ5xrHS+rgXV+BKWbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlSjShPnpfpcEUABLhdTAZYSKB5EK/VJ/KmDVuNEhRg=;
 b=E5oKswtDtWm5rxxDsmXEPb3f6ycYUvTScoNebOdSBKp8010a02sevA5ed5+CEJyLXrJqqcqvH2kWFLJfgNO+0owaK3So2p752gk+U/KM6PCZVkeMdg0lT8RevMjwhrFUdOLo44LJAhC2KcctWhBsC2ZoMon+c5fIwgHNKgRcBXoVeqXOQhD1bkyLOwQZGkhPhPkafa4s0QA5rz3E0EcIhRpeYqFcZamlXOBCucm8cQ/FpUB7Ve3Smdl49sI4YcRgl7P8t6vAuT/WUj9tkNCtJ7fcoPuuQe0S2v2RuI0oztJ5yLR42j+UvatoTjUGDGht5e6ekOrB8E3cpXUlfhxnOQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlSjShPnpfpcEUABLhdTAZYSKB5EK/VJ/KmDVuNEhRg=;
 b=rxs5HKJcYgVdkQz2VjkV/V8VE/UmCfPnvKI/RzRnfXuGkrL2Lrb+HfQ7e7Bd8rMsP0bbOqPmpaIRfWfkBsKeAGVqVBTkhfcU06SrB56CoAMJzhGbcKW6+GrJ19A6Uyug69n/mnE0xqO8xLJ22+e1KvrXaJzXzj2KbedjB12kh6c=
Received: from DB3PR08CA0032.eurprd08.prod.outlook.com (2603:10a6:8::45) by
 DU0PR08MB8163.eurprd08.prod.outlook.com (2603:10a6:10:3ee::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Tue, 24 Mar 2026 11:41:08 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::58) by DB3PR08CA0032.outlook.office365.com
 (2603:10a6:8::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 11:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via
 Frontend Transport; Tue, 24 Mar 2026 11:41:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLMyV3tpj3e+0FBnk0M2DDrHaY/wiyvugKAF2wIo/UuAas7sHFHFMJW4hi8mWKNf6v2z2qhve8FVBMeBbNNKCPgyCmYtjv0Sz5wC2UoD7P/H2kRRfjo3nKmieXYSQGlOw02c403rZWjNg1ehCcMFE0Nd4yP8LotAXBUP5RHD/uN863PIshmJn7tW85BvTbCdyAwvPUg64LTxjjhJri7b2k1ma7tP/mXNrMkUlh+GzZXu/NZwq1vrDaN6fgiMvNywTf89UAOc9w+Og93n0mevvh8IlIyqHfloAtBCgP3C2FxaIYF4ytM5yyS5bveFBI4BwctBzqsW4AEZgZE7lH/8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlSjShPnpfpcEUABLhdTAZYSKB5EK/VJ/KmDVuNEhRg=;
 b=YqKLJVO2CqMtbyWjVBckOCLB0e4i11xy1IHU2xK5glh5D+ozc+sLuLRZjJ+E2XXrPJP3bGFR1khRxpt0hXAVNyzF9sprtUbSx2IAIhgjzvWQrebXEoeRRuiacL7HaKr8gb/ydKcsbXEJemyqgcWtvtZNi3ojdUs7Q7sbxxCh8QcuUVL5w7sRUdsSYhJRVjImFTF2hCGVC9p0ZDvPI5SRc5CPNxfEXXUgKSbAk2SArSIaOMNGCjfjT0LpcYOmZ4/vwLvOjAlLZn2l8E3oPMUqakBrTTKAcw5W55i/w+4gCUqBMDwFVUTs/xTO6G6Sspe+mekUOHn81UjFkDadgMLGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlSjShPnpfpcEUABLhdTAZYSKB5EK/VJ/KmDVuNEhRg=;
 b=rxs5HKJcYgVdkQz2VjkV/V8VE/UmCfPnvKI/RzRnfXuGkrL2Lrb+HfQ7e7Bd8rMsP0bbOqPmpaIRfWfkBsKeAGVqVBTkhfcU06SrB56CoAMJzhGbcKW6+GrJ19A6Uyug69n/mnE0xqO8xLJ22+e1KvrXaJzXzj2KbedjB12kh6c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DB9PR08MB8339.eurprd08.prod.outlook.com (2603:10a6:10:3dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 11:40:03 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 11:40:03 +0000
Message-ID: <ab06e8d6-d430-483b-a2a4-9e7d197aa6b6@arm.com>
Date: Tue, 24 Mar 2026 12:40:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] cpufreq: Set policy->min and max as real QoS
 constraints
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-4-pierre.gondois@arm.com>
 <ukxdxr3xv7x6pqnwwafxgvhvfh5n7w67y3zwunhnk7b45tz3t6@d6ehl4vqac6t>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ukxdxr3xv7x6pqnwwafxgvhvfh5n7w67y3zwunhnk7b45tz3t6@d6ehl4vqac6t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0007.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DB9PR08MB8339:EE_|DU6PEPF0000952A:EE_|DU0PR08MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: dee8d9d8-3163-4eeb-6d3e-08de899a3dba
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 1U67S2QaQ229/PmfjlBbtlAqMzydMRc3TdGpD56rh6jLJQ1MNXOGJxaCwGcl+XRRp1Oiqqome97QdoSkiVUvaAwiFhHsJ+vVdRIJlIllDdc0kdgH5U+gnRbBt+ZfB0Psq50amjyygJFiEu4oe/RqoK1aCiLfLMnBEgkpo+hkmFx/+vUxENSOiTrz/y+tz/tNsbZXxdDXr5V5JTuyP+1W5RD26ornn4ed7BJHnX7lF9nN1lXIv37VMr7wW3YLhrwwTxhloik7VYxcR998ZVzglhgcFlHtCLBa5DnGWkCP0q7Pxznneqza8OnGKsQj3N/TXgX0O4aoqM7U35VHFVBPxCr6IMEYFd+LtfzLCvDGfaj6SkiCCT/IyHODwmyvRisfvWPZtgG798BTTNXWk728vMvPjIvmwkmROxUJ6hdMnBUe3xyhVNx88iQYMhLGLLOsnIniWO0r0ZkQoYAagRQwSWomIBlfGTFmJx01729y0hvMhjNEf8nqn0hW+zhmwT1+i3OMw5Kwq7jSNy7RSIL4sFUL+2gQ5Q1sSICMRg3aswDKuvVQTrY0UTQe1yAblAK0+QZ3/yhqiD+7WKThGn1azpXYMZSSlGEydPYMdN7wIVerTBk2UM/qQUbN77avbMLB+PBioh7bA4UrcRMx+0887YsE6jNtfZOH+vNipc4HJFjWtmUm5xZBuzGzF/IFHq/H
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 pt6h9cA51x99Y5xMcaIIexwrTunlJRg/yQnJbaXFfqXakq0aJcHgQFoZBHiN442VDNBZyNezQxsBawJwvWbULrvWjsd2H2CouPh4jTs1caY5bUYG2udMUqRmTxlTQ8EOKTyBHqNThuPm10dLofmOXCxZP7LzKR6eL5PWAE1d+NAowrglodlJFtaPGtwq3XHZC/pKpauFEHYHZM3NDLz2Zju5Z6VcVVmfxmnu04xrdmfbxud8vjYjLmPRxq/trYS9KeKmyjARt1zOtVne4+VVDSTOMXCzwMx96c+25w28SzaIb3CPsoya9KJ32diEd/AN3EwaJ/Wo0fghB/3zYyyydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8339
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6dc00b51-7d71-4648-2fff-08de899a16c0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|35042699022|376014|1800799024|82310400026|7416014|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NaZOlPkwHHf/5w+RS+XSZ+RDwwKvzObf5maMSiy+Esz+26TyGw5YVj2ZUkE9RRs6M7ET4yE3kUJ/3PO/m5T1Vbl3xwxD8//H+DLtO9xxMYSXlu+sJBpnhmYmgTcTbmcnk/i02er/q3iUR4DZOL+Uq7jG1Q1NICYiD7/A8OigMIKNcyq8CPViDAT4K+/MrFYx1kUAkrmshTkaaRCxcUkOlD9f0cOpogHe1AZUF2Dop28g09Wr4poMkT0U2X10gNwn146P77gYKYRa6RwuKksi36CtW+/Zv2tbM75itT/yQvIELW4ulMKoPixtayVyWH7B2ggoTXsE/SPikRUyjQFh67p//Jm96fsfQHCfpJQZhCrKuwZLkehrS2Au0cNRxWtcmtJ8VxjAr0mO76G34CMFsvZQXKdIhtk1ejpDYk/+UcZkzlGFBYlQw+owIWcuCX074vMkTgrxle1Zl+q5Baoxzb48/IwxITMOQSH+siRZC9DjTuFe84ypWRPyjVDlcAE2HkqcpRiKQsFtkHPi/0SGpTlnkyr9ymBFs9EDkMRhNj+k/c1yj4IwpSHSRvBHBZ88UhWC/pjlGgpy/rxFbb+wq7m1V1UgjbbwOZh4G/Q6PkWmmK+rkleMvbNB3vmjIPw5hC2WHnsn3ohl1+b0E+xu+sh/vPNJk+HlO4oRUNilXYNOvf409trjbtmVb+yLUDQMvCRfjyYM8MSJc4jhfo+KSPVLBUpJ6vjZevdPIWTMqDc=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(35042699022)(376014)(1800799024)(82310400026)(7416014)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O/jyzX8kamrA2trwZ6HGUE1G+eCnAnnV5npxGnav1kiLoxi/s2RMSn1o/rKbCaC1KVp/f/kMrJSg+mZfRKVDif2NDb10wGgbfliShWvUK3e85XHHIORYK0h9YkUOaFGY1ESC6RKeJoDr961Nr66xKvbG+TooSJr0DUE394+2N+nOXAfi78tBFqUSsWp8xFIjQKTfLJqEVR7Wm0d5rRKvL6y/2OBHnDb7tdDeK8SQ1x/QNbOsKfwW11Z2F16Rvq4DbU225oN6tYZb+kANkoYqA7afmVxwh5ypN9Wj5Q+hkOnHyJag39nOzgihJP9CRQG1OsibLU9dtpH65SGpaZQ0/pjSJ4jj3Lg+0cG7S0Uf2lqyWfZFN+IHMAJsVN6SzEeuko8zA7lvuQAIKV7wzXYPB21GvW0EMWeqWKTk2UVFQ4qU3Cq6RwUUSOMNfuHy53zy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 11:41:08.5819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dee8d9d8-3163-4eeb-6d3e-08de899a3dba
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8163


On 3/20/26 11:14, Viresh Kumar wrote:
> On 17-03-26, 11:17, Pierre Gondois wrote:
>> cpufreq_set_policy() will ultimately override the policy min/max
>> values written in the .init() callback through:
>> cpufreq_policy_online()
>> \-cpufreq_init_policy()
>>    \-cpufreq_set_policy()
>>      \-/* Set policy->min/max */
>> Thus the policy min/max values provided are only temporary.
> I am not comfortable with this patch to be honest. policy->min/max are used at
> so many places that it is really difficult to make sure if this patch will break
> something or not.
>
> For example:
>
> cpufreq_set_policy()
>   cpufreq_driver->verify()
>    cpufreq_frequency_table_verify()
>
> This uses min/max before it is set by the path you mentioned.
>
> I would suggest dropping this change, or most of it and doing only what is
> really required for this series.
>
Being able to set the min/max_freq_req from the driver might be
something that is needed, cf:
https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/

It would also allow to have a common way to set policy->min/max values
as they are set to the the cpuinfo.min/max_freq.

On the other hand I agree that I didn't test all the possible paths
for this change, so this is a bit audacious.


What about adding the following to have the values set for all drivers:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c

index 70814c567243b..3a1e5f58a301f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1530,6 +1530,9 @@ static int cpufreq_policy_online(struct 
cpufreq_policy *policy,
                                 CPUFREQ_CREATE_POLICY, policy);
         }

+       policy->max = policy->cpuinfo.max_freq;
+       policy->min = policy->cpuinfo.min_freq;
+
         if (cpufreq_driver->get && has_target()) {
                 policy->cur = cpufreq_driver->get(policy->cpu);
                 if (!policy->cur) {

