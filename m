Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073CC36AB61;
	Wed,  1 Jul 2026 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923121; cv=fail; b=KorzrmDJ2bTlOkt+kOzEmYLjofzg/JwT20Dhcai9lyvBR9KUJ8Ujnyp8bdcJRkILOyHc4udb6X57Icay/5ac50TABRrPNyHoeOtb7iWnKsgLpbUWLTFDP9l36cjAOL+zF2eWlezfXYSTsyuGLDemHtbDgGbO5bp3yv4sxbiv9Zc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923121; c=relaxed/simple;
	bh=kgzw3b0hqSQoO2dZVkc6W8UgikJRdypV0CO7uXdtI3c=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lz9MqVN4o+gZbQKBr2rpwXoL3RN9Jy5mMaR46W4423e5FTC/WMJbJbXOxq3lr/VBkxRGT1SbeFKALAh+QMNw2934NodlWsfWdgvLfe/IY3xu7gjWUIoss5EDJ/gyWBFodYmrdsequNzIqsX55yzc2Q8bMaCeztiAWM4QEh8UgKs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n+ezlxFi; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n+ezlxFi; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n+ezlxFi";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n+ezlxFi"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cTF0EMdDxRKa6UT56FGzhIgSnuSQsNcFZ9U9wo9oHbmZn4H5cPz65ArbvGWqx2CDnS/s3Llddc5CMkFCYCxYfg+j4s9qN6AxeL9r2PaGp62L+k6lYNW6w6B5U0n07ghx80X6le8aQgK8bZis3NrxGKai7FJI00xTZ41JsA/uiW3t8H1OV+XeNDDLFf6UIboLEtKNTO6v0V73Vsrt8ECoJtpBbZ1DCkJM+piJR54QaJa7FMmLemJfVLWp1hzmMblCfI0KTiI0tF22GUfEflLj0yGK5r64TJAtAYXiaaLD2S0lHjcBT5kV/yWPTMf50/+2C1wRhdlD+qp/V2tAp4SiVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+Fqvu3TY1O88xSjA4xtdM8M/nzRMOOXTzQvZF2MEtU=;
 b=WTM9tGLyiS2iMShFfIUXXLhSx5ivzPrP2S62nFzAn8/ThMP7TNbVthqCSyKw+ePR9+Zptkl7LDnGrkam7a0EY88AGraXJTMecYx/hSxZu5Rs0iekQjcifjQ2y0yI38LdQKfYS6AVrvxXQUuKvhGEb2XcrFuuC6Tjriz8a3nltSU0X2d05LLTqKVyPQnMtxgDR5wjhsoad/Nxgq5qB7Z69hHgJaNtIj9B5dSZr01Aw54yvQpZGQ6jmQFbiYE2vBKO4082R+X93gHuBQrr241jV4SSbtzT+BnqWsqzRBhjvx6lhXEYSafjC1NDnX5BxOKMSqJb6T5/5mi62D8jvx/wAA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+Fqvu3TY1O88xSjA4xtdM8M/nzRMOOXTzQvZF2MEtU=;
 b=n+ezlxFi3mxMDfbcDMc+DY/CO0efoD39R51GOTZRslcfD27V1Ym/m+wY1x4JEAFfxcROIbd792ievhePHpL5yUA90UJ6eAT13l+s1rOQgnPzkSUPZod+qN6s4PO8IlAoWax6tCI89FJ5AZ16+GplVkD2U8AoyFSairx+dh8nxes=
Received: from AM0P309CA0028.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::6)
 by DU0PR08MB7640.eurprd08.prod.outlook.com (2603:10a6:10:31b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 16:25:10 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::74) by AM0P309CA0028.outlook.office365.com
 (2603:10a6:20b:28f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Wed, 1
 Jul 2026 16:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Wed, 1 Jul 2026 16:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J95EpYHqaeWc4nm0oM8UnwIe7Jye5KGwoOzPFLs7Q4bpEJm4CD1fy78SeRosqVkrDcfrwBi6jDQnhfYHolqdLz5JrpXcXpGamUEVB5bij2QMKrbE2NQHXJrFS0UjpQEEGPazSGWIWdDYJ1oOzcWeOKqcy9vvKG+7fhrbZjQ0IGXDiWBBwhALLlneLaUvKX+8Uw8PtDKBqa/q76XIIuZwu0elRi7Oozs7o53ZP3AtIy1OILrDGHTiB8EsH/LrAtVl9g1qxOdPWnwuf0ewqpUU1iZ693/s9kp/3HZJXbNMdhmMr+XfkYePnYHL2Le3n3cYBnhgrNqAlS1k2/bgC+1RMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+Fqvu3TY1O88xSjA4xtdM8M/nzRMOOXTzQvZF2MEtU=;
 b=JRmX6GvxwpmsJ05RPcaf1VdIIFoR0YMDIHYf7S9jOpCkzQDByTLZiIR0fp/49aukGPqS4FAiDgJByyGBM6GZd8Yx9ru6eF+fE4bYP8nhjxO+64K5aJGnpAsVD8pmg/JeBpJxj1grXJmvEMp/0w6s+gynBveXn0rOtXd/yjS5ijvYi6a3F4QYH3aZ4z4LKh+qRd6nltiLzz/86D0UDAh7NjOBBtT8rDW7yAomRtYUJZ2mQAgcgzavvyqlBt+m0kPIomkNBFbfNpPhL0LtlwskJ5xXpihbRtGW2/Nve77KbHl0Pj6KwcYOu8dlFf6Ibg+nLovkmrwGsA1NLJGr+Oe5gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+Fqvu3TY1O88xSjA4xtdM8M/nzRMOOXTzQvZF2MEtU=;
 b=n+ezlxFi3mxMDfbcDMc+DY/CO0efoD39R51GOTZRslcfD27V1Ym/m+wY1x4JEAFfxcROIbd792ievhePHpL5yUA90UJ6eAT13l+s1rOQgnPzkSUPZod+qN6s4PO8IlAoWax6tCI89FJ5AZ16+GplVkD2U8AoyFSairx+dh8nxes=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VE1PR08MB5646.eurprd08.prod.outlook.com (2603:10a6:800:1a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 16:24:07 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 16:24:07 +0000
Message-ID: <07721a34-dae0-4575-897b-e4cb7754cf4d@arm.com>
Date: Wed, 1 Jul 2026 18:24:05 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, mario.limonciello@amd.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260623080652.3353386-1-sumitg@nvidia.com>
 <20260623080652.3353386-3-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260623080652.3353386-3-sumitg@nvidia.com>
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
	VI0PR08MB10391:EE_|VE1PR08MB5646:EE_|AMS0EPF0000019D:EE_|DU0PR08MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: ca300dd8-3f36-41c8-95a4-08ded78d5251
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|921020|3023799007|6133799003|11063799006|18002099003|22082099003|56012099006|4143699003|18092099006;
X-Microsoft-Antispam-Message-Info-Original:
 47hc/e/5ew/YIg45zMarq/c0cbye1glIHjfLvCmJeB65w5A6Urj391EWhAbDR+oqyktrJ3VIRf3VN4lrCovTlXqpy19LiRSLlGUy5EN2k3iem9B59TdM5TV5Gd3NFl9TgfM7mmbV5bPINX6Xag1hATRFgzucG7cqqtR18nQz+Eg9aA5znKkJvT65l3Bk41Y4KiZ6p6UQ7q+kwrLy9cRFA4IOVlBkv3iQNdn2v9CT3MYhYUHPWNGWT9QljDnhZQaSr+c3mCQY2dPE155EWoidXPBrYLay/3qn07L8lgsfT5GALG56SQalAD20gkHwA96YH0zXVT3oduWGjp/lwAWNyEDTStfIuIVBTjM35P1F62j5e+qcifKdq3WaSqsl1L8Z1JxiHaBn7bk60DTxHiqSYTuokKdFjqFTVkKXhnla5KXZC3mQMZzQN89/MeLIzV5sblNseiiB0iZ/xJwVUfR4cmcojlPde1IZZ7ZK/uY3hgXDMn1+kpPuV131B2lWFcXECxAuAFOTTcJY8SOUzuxMYmzqIOg/5EUvVXdh2MeTy4mhfcQs6ETwiNT6kFiRWbrKj8a6ZP7GYtUTdrd7lTDA9MBgGZ98b6G7DhSdGlDXrLr9vq7DyHltT+gH0N5zxqTg6m07D6OTUzcFcij4WHRX/3xOB6i24jRPEokBC8B5vQSRs5q/oJ+3IWn4OeRVzVZWiTGpWRI9FGw7Y+X2uVYlhA==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(921020)(3023799007)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003)(18092099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 q1/iVD1HYvMp6qPIigq/ULTfcyvN8JAMgBL7G+GGaNpK0Cr0CQBCHIOwPGE7g2jTiyiWm1CbXtXtFFUHhtLz0/sbtQchaiSQg5rfuQmfEKi1Z+nggFNYjPLC+EJX/MSENENghQYjHKp+OmLa08l5PjbixaE1X6/cOoOZuanoE4F7sislbzd88ZaEiJt3DC2jmSeDVCBy1NPBPZtbeGWcvdUHvgJpGddlbwr0yqW3mS0E5Ud4H9ObVjKAI+ryFJFWnx0otfEGwyyJs++cl8gpALzLnKnDTNf64VmYimg3HZ1MIRS8xglkTTCvuBJWLg2jHFL2I8sLvng11EEOCGNqrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5646
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5f6c3dc5-3b02-47b1-af7c-08ded78d2c8a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|7416014|376014|14060799003|35042699022|36860700016|22082099003|18002099003|18092099006|921020|13003099007|4143699003|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5PK1RI8RUx7XiX3q5UtvlstIkFiG107vCHp6kIcl5KgeZjxjipKFa0cvmUoB/noKNUyxWECg2Izb7+4FB3UeJHq6nvU3Yvg1kauwJmVRJ6X0UbcUjS/wa5Ynv1THnxoQ1eyPI4UNj4mQDqNCYGvooEnS1od3hzDlla+bgA1MsrQmD6g+xWpynmHW4GmtzVSQospliOLcdrGMOPM2TgzcZId4nt0hy3O693ETZftoQqiXh31/nNCO9AYRBaX2pbg6in4sJAgaXw0Lk84NIcrTzyfcyUAx2g7aOYljcGl1KATmrD1la3FDY9A6b3L1VSxMB4KQnyN4sY2HqfWDP+a3qvpmI3yg9wEBEsnOwRIr9LawDmd1tq+kf8AIxTDmT0X0dxq//vF4d9AB1SiFqyMhACrn6xyFBYe9DZvMwTtfOrAtTpmwQUaIif0pZDJrHyD2P4h6dpwKuJibZt9/KEplP3QqnyJrkTXieiaNSXjEa4vVZfqr4NWW5R2xrfb7iZHOHVr1x3KzP9JN+Ht7cB0yKAhQo9TIzqz4VVrM4iY6pTH+uRPY9sx5vyfmkRyrf8RgioUFId2ERftzpajMiWe70/j9oeh+mnAHZzPAq+CE/PW6YZ5DxUCsWQ43z+mbLcJ/H4d11jfgsiXtGW47B4HRtqK/7yCzApmEZhGLHMb+mwdsdeTU0hlCQSNJ6L9sR19AEKJ/CoYGGl+Pms3OwFzCrDWtQ6egtkOb7bkVmkjcKObthUoOv8QOSD6+yNMBDNS8
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(7416014)(376014)(14060799003)(35042699022)(36860700016)(22082099003)(18002099003)(18092099006)(921020)(13003099007)(4143699003)(11063799006)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZOlZ9TWXXkH1ppnDuWZtPeXFm+FIJYf/ccswTWh42+uWkpKuAUUuWjWxIk1A5qP0ds8Aqtgeqgo0g5O22Gi4M5dotfaqsFcBaoPILjVuTizll8R092wj+xXd/VLuCreegeSpwIhPcOQBZym7AHRBDfOwDurfJQjSxmCXaL4gBnNakmgUgye6jOUy3fWRcfM9v1vr8uXngPlX9uOu1KNW1uOwjvb7Nbb4rvI2l06M/2PMRQEwGpHNsbqbEp+y6Cct3kt39lSv1z9unZRyysImEii/KaPtS3y8ylQ+IkWCerza29i0BAcqZM0xrRyHa3OE5k22kgl1ci+h94h3wzSiCVVxu29TS/9JUD7dsmrbnr3+1Tj38bZS9vOh8+qfmrZN8hHC4HnbwTNvrB0k0LLUaTqckp5lYx6+q4II1+LqsWG1vfCjC4wKzIoO6XM65Q/n
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 16:25:10.3534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca300dd8-3f36-41c8-95a4-08ded78d5251
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7640


On 6/23/26 10:06, Sumit Gupta wrote:
> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
> CPPC autonomous performance selection on all CPUs at system startup.
> When autonomous mode is enabled, the hardware automatically adjusts
> CPU performance based on workload demands using Energy Performance
> Preference (EPP) hints.
>
> When the parameter is set:
> - Configure all CPUs for autonomous operation on first init
> - Use HW min/max_perf when available; otherwise initialize from caps
> - Initialize desired_perf to max_perf as a starting hint
> - Hardware controls frequency instead of the OS governor
> - EPP behavior depends on parameter value:
>    - performance (or 1):         override EPP to performance (0x0)
>    - balance_performance (or 2): override EPP to balance_performance
>                                  (0x80)
>    - default_epp (or 3):         preserve EPP value programmed by
>                                  BIOS/firmware
>
> Unset, "0"/"disabled", or an unrecognized value leaves autonomous
> selection disabled.
>
> The boot parameter is applied only during first policy initialization.
> Skip applying it on CPU hotplug to preserve runtime sysfs configuration.
>
> This relies on commit 8c83947c5dbb ("cpufreq: Use policy->min/max init as
> QoS request") so that the policy->min/max set in cppc_cpufreq_cpu_init()
> are used as the policy's QoS requests and not overridden by
> cpufreq_set_policy() during init.
>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  22 +++
>   drivers/cpufreq/cppc_cpufreq.c                | 151 +++++++++++++++++-
>   include/acpi/cppc_acpi.h                      |   1 +
>   3 files changed, 169 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..88820d34d516 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1019,6 +1019,28 @@ Kernel parameters
>   			policy to use. This governor must be registered in the
>   			kernel before the cpufreq driver probes.
>   
> +	cppc_cpufreq.auto_sel_mode=
> +			[CPU_FREQ] Enable ACPI CPPC autonomous performance
> +			selection. When enabled, hardware automatically adjusts
> +			CPU frequency on all CPUs based on workload demands.
> +			In Autonomous mode, Energy Performance Preference (EPP)
> +			hints guide hardware toward performance (0x0) or energy
> +			efficiency (0xff).
> +			Requires ACPI CPPC autonomous selection register
> +			support.
> +			Accepts:
> +			  disabled, 0:

Just a question, but would it be worth only accepting
strings ? If we want to have a thinner granularity later,
it will be harder to introduce them if there are integer values
already present.

> +				  cpufreq governors are used (auto_sel disabled)
> +			  performance, 1:
> +				  enable auto_sel + set EPP to performance (0x0)
> +			  balance_performance, 2:
> +				  enable auto_sel + set EPP to
> +				  balance_performance (0x80)
> +			  default_epp, 3:
> +				  enable auto_sel, preserve EPP value programmed
> +				  by BIOS/firmware
> +			Unset or an unrecognized value is treated as disabled.
> +
>   	cpu_init_udelay=N
>   			[X86,EARLY] Delay for N microsec between assert and de-assert
>   			of APIC INIT to start processors.  This delay occurs
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index f7a47576717a..efa673e3830c 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,55 @@
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
>   
> +/* Autonomous Selection boot parameter modes */
> +enum {
> +	AUTO_SEL_DISABLED = 0,
> +	AUTO_SEL_PERFORMANCE = 1,
> +	AUTO_SEL_BALANCE_PERFORMANCE = 2,
> +	AUTO_SEL_DEFAULT_EPP = 3,
> +};
> +
> +static int auto_sel_mode;
> +
> +static int auto_sel_mode_set(const char *val, const struct kernel_param *kp)
> +{
> +	int *mode = kp->arg;
> +
> +	*mode = AUTO_SEL_DISABLED;
> +
> +	if (sysfs_streq(val, "performance") || sysfs_streq(val, "1"))
> +		*mode = AUTO_SEL_PERFORMANCE;
> +	else if (sysfs_streq(val, "balance_performance") || sysfs_streq(val, "2"))
> +		*mode = AUTO_SEL_BALANCE_PERFORMANCE;
> +	else if (sysfs_streq(val, "default_epp") || sysfs_streq(val, "3"))
> +		*mode = AUTO_SEL_DEFAULT_EPP;
> +	else if (!sysfs_streq(val, "disabled") && !sysfs_streq(val, "0"))
> +		pr_warn("Invalid auto_sel_mode \"%s\", disable auto select\n", val);
> +
> +	return 0;
> +}
> +
> +static int auto_sel_mode_get(char *buffer, const struct kernel_param *kp)
> +{
> +	int *mode = kp->arg;
> +
> +	switch (*mode) {
> +	case AUTO_SEL_PERFORMANCE:
> +		return sysfs_emit(buffer, "performance\n");
> +	case AUTO_SEL_BALANCE_PERFORMANCE:
> +		return sysfs_emit(buffer, "balance_performance\n");
> +	case AUTO_SEL_DEFAULT_EPP:
> +		return sysfs_emit(buffer, "default_epp\n");
> +	default:
> +		return sysfs_emit(buffer, "disabled\n");
> +	}
> +}
> +
> +static const struct kernel_param_ops auto_sel_mode_ops = {
> +	.set = auto_sel_mode_set,
> +	.get = auto_sel_mode_get,
> +};
> +
>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>   static enum {
>   	FIE_UNSET = -1,
> @@ -645,7 +694,9 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	unsigned int cpu = policy->cpu;
>   	struct cppc_cpudata *cpu_data;
>   	struct cppc_perf_caps *caps;
> +	bool set_epp = true;
>   	int ret;
> +	u32 epp;
>   
>   	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
>   	if (!cpu_data) {
> @@ -715,11 +766,87 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>   	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>   
> -	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> -	if (ret) {
> -		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->highest_perf, cpu, ret);
> -		goto out;
> +	/*
> +	 * Enable autonomous mode on first init if boot param is set.
> +	 * Check last_governor to detect first init and skip if auto_sel
> +	 * is already enabled.
> +	 */
> +	if (auto_sel_mode && policy->last_governor[0] == '\0' &&
> +	    !cpu_data->perf_ctrls.auto_sel) {

If an .online() callback is introduced, does it mean that we can
remove the "policy->last_governor[0] == '\0'" check ?

Also maybe it would be worth creating a function for this
"if" block ?

Also (bis), maybe we should check that auto_sel is supported before
doing anything else.


> +		/* Init min/max_perf from caps if not already set by HW. */
> +		if (!cpu_data->perf_ctrls.min_perf)
> +			cpu_data->perf_ctrls.min_perf = caps->lowest_nonlinear_perf;
> +		if (!cpu_data->perf_ctrls.max_perf)
> +			cpu_data->perf_ctrls.max_perf = policy->boost_enabled ?
> +				caps->highest_perf : caps->nominal_perf;

Is it necessary to do that ?

- for min_perf, we are setting it to the lowest possible value

- for max_perf, we are setting it to the highest available value.
If boost is disabled and we enabled it later, I don't think max_perf is
updated accordingly, so we would limit the freq. to caps->nominal_perf

(If I m not missing something)

> +
> +		/*
> +		 * In autonomous mode desired_perf is only a hint; EPP and
> +		 * the platform drive actual selection within [min, max].
> +		 * Initialize it to max_perf so HW starts at the upper bound.
> +		 */
> +		cpu_data->perf_ctrls.desired_perf = cpu_data->perf_ctrls.max_perf;
> +
> +		policy->cur = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.desired_perf);
> +
> +		/*
> +		 * Set EPP per mode. 'default_epp' preserves the BIOS/firmware
> +		 * programmed EPP value. EPP is optional - some platforms may
> +		 * not support it.
> +		 */
> +		switch (auto_sel_mode) {
> +		case AUTO_SEL_PERFORMANCE:
> +			epp = CPPC_EPP_PERFORMANCE_PREF;
> +			break;
> +		case AUTO_SEL_BALANCE_PERFORMANCE:
> +			epp = CPPC_EPP_BALANCE_PERFORMANCE_PREF;
> +			break;
> +		default:
> +			set_epp = false;
> +			break;
> +		}
> +
> +		if (set_epp) {
> +			ret = cppc_set_epp(cpu, epp);
> +			if (ret && ret != -EOPNOTSUPP)
> +				pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
> +			else if (!ret)
> +				cpu_data->perf_ctrls.energy_perf = epp;
> +		}
> +
> +		/* Program min/max/desired into CPPC regs (non-fatal on failure). */
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret)
> +			pr_warn("set_perf failed CPU%d (%d); using HW values\n",
> +				cpu, ret);
> +
> +		ret = cppc_set_auto_sel(cpu, true);
> +		if (ret && ret != -EOPNOTSUPP)
> +			pr_warn("auto_sel CPU%d failed (%d); using OS mode\n",
> +				cpu, ret);
> +		else if (!ret)
> +			cpu_data->perf_ctrls.auto_sel = true;
> +	}
(until here)
> +
> +	if (cpu_data->perf_ctrls.auto_sel) {
> +		/* Sync policy limits from HW when autonomous mode is active */

Similar comment as above, doesn't it fall into a similar case as:
521223d8b3ec ("cpufreq: Fix initialization of min and max frequency QoS 
request")

?


> +		policy->min = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.min_perf ?:
> +					       caps->lowest_nonlinear_perf);
> +		policy->max = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.max_perf ?:
> +					       (policy->boost_enabled ?
> +						caps->highest_perf :
> +						caps->nominal_perf));
> +	} else {
> +		/* Normal mode: governors control frequency */
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret) {
> +			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> +				 caps->highest_perf, cpu, ret);
> +			goto out;
> +		}
>   	}
>   
>   	cppc_cpufreq_cpu_fie_init(policy);
> @@ -1066,10 +1193,24 @@ static int __init cppc_cpufreq_init(void)
>   
>   static void __exit cppc_cpufreq_exit(void)
>   {
> +	unsigned int cpu;
> +
> +	for_each_present_cpu(cpu)
> +		cppc_set_auto_sel(cpu, false);

I saw that this is being changed in:
[PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload

But I think it would make more sense to have this patch comes before these
patches:

  [1] ACPI: CPPC: Add ospm_nominal_perf support
      https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
  [2] cpufreq: CPPC: add autonomous mode boot parameter support
      https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/

to avoid making changes that are corrected in this last patch of the serie.

> +
>   	cpufreq_unregister_driver(&cppc_cpufreq_driver);
>   	cppc_freq_invariance_exit();
>   }
>   
> +module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444);
> +MODULE_PARM_DESC(auto_sel_mode,
> +		 "Enable CPPC autonomous performance selection at boot: "
> +		 "disabled or 0 (use cpufreq governors), "
> +		 "performance or 1 (EPP=performance), "
> +		 "balance_performance or 2 (EPP=balance_performance), "
> +		 "default_epp or 3 (preserve BIOS/firmware EPP); "
> +		 "an unrecognized value is treated as disabled");
> +
>   module_exit(cppc_cpufreq_exit);
>   MODULE_AUTHOR("Ashwin Chaugule");
>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8693890a7275..9b18fb9aab7c 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -42,6 +42,7 @@
>   #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>   
>   #define CPPC_EPP_PERFORMANCE_PREF		0x00
> +#define CPPC_EPP_BALANCE_PERFORMANCE_PREF	0x80
>   #define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
>   
>   #define CPPC_PERF_LIMITED_DESIRED_EXCURSION	BIT(0)
