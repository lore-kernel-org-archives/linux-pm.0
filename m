Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C45385519;
	Mon, 28 Sep 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598104; cv=fail; b=de7Ili+5bx+WZzzXzALsqiDMYlDNbLZ2dM1qIO7/jY3O80vempdUS6xfKyRN8oLMmQ9DRIrmOY6kjCEBFZ7JOxrln2arYjLB1v2fCYGUAaTrFK+fHLobkoWN+IojaMSCVmeYYKZa/ipL01EOTD8Fo5SKusvtsw4hhcfiBvtlqHU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598104; c=relaxed/simple;
	bh=xMRM6VYKG8Xa4vND6uiQ02TPtvpul9mm7uXR6QHhWDM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bvPzKH9qKCE+0ZLBNdFo3tXS407gIvl24vk2CwvDu4tKjQeYKv17UDvycfJC3glC8iN202eLJL/F8WH9++vNFySdKjjCjHCpp6ccnZBIppvyu4EBAL5oTUIGbzNEUsFgtGWncV9jtwG3ZQIjW7p2M7LEAVojiloQD0yQ6gqCKFU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rT7MBNUd; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rT7MBNUd; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rT7MBNUd";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rT7MBNUd"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UuwQsABr6dNTO3dWIPH/B8zAv8wla7N+7bdanDg7Hp1RMNXSpUDK8Qfn9BXpsqD0VU6JKi1T4cWYu1z3DhZYkKfXnKoyXtl6fI+Agp6vK3k3VTm/HfgXXbc/vxfprOCTuwHXzwGd+RS647SyPRQ9p40a8kQROkiliYWzBWXZAiIzeMqqvun/+x4vYSsQvPrQ4ShuYiL/ex5lZfuItQSmm/mbCjJT911A8fiO0a2xm3Mr/cKFZ0+WSxtpUPIinWQljgyOP90gHthoQ5rW0ThRXI9I8wzhJsWqiXWueV1Q4dbp9ig0q7WqcyoKvGDlAnA9WEW3pBeUsJ/Ke8TyOEC8dQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4Fx1DieM9vaix/jHR+fUaUcF7Yd3se+xf2iIg3Qq6g=;
 b=V3hzNJ8gc8c2+BfS6UiqGW05xfCCR5xV7nRqmJOf/hd6+aaAXqpy1nDr668uYNSkHjACKkk2gLbwKt9PwiWaOce0VXby//eVAvJ6kuRSvRMfX2kUc1Vgzs74S4sJ/RpO3eabaYDDcISotURuk/GtklPTCagl/e1iVpXHy/QjSheahXVcnpWrOtPtn/VDe2cFeeiIjm8HCtjSSo9bbL6B5Q6huZ1ROsRCFrhxTPGXyfwEjc2ULHioQutNnQujbCKP/sgz+lgp3ypYWV/Hv4GbmnV4X9ZfqMswbJWYnFlcO2f43CTTzRzqd7m/h6dvHH+Kf62+hN7hwb9i5Qzt2txS3w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Fx1DieM9vaix/jHR+fUaUcF7Yd3se+xf2iIg3Qq6g=;
 b=rT7MBNUdZT8F64bLzpP8S8oKcopuQDyYaD44Se6uLEr5ojHNsofRxgUrrIql5qArUI4rqWEosNW7tCn3JXoSVt0FaUY0Fm6x2zuT/mUlqAnObwPW/tZY7lLgL18rbNn8iV+A59KxTAdmsWTSBeygsNpjBPv8eA4Te4nm5zXdQH0=
Received: from PAZP264CA0017.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:21::22)
 by DU0PR08MB7591.eurprd08.prod.outlook.com (2603:10a6:10:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 12:21:33 +0000
Received: from ZR1PEPF0000E6B9.eurprd07.prod.outlook.com
 (2603:10a6:102:21:cafe::4b) by PAZP264CA0017.outlook.office365.com
 (2603:10a6:102:21::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 12:21:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 28 Sep 2026 12:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzF2cCrBcrrXdOlAoSLsw2bm/7edbaeI5XD51eCuXJsDiPffOgDm1WVUGLTCM6SXfJwpkaW6cBbpDprHJ/PhwWldLAqclbXZdtKotIBteTzzxzrMkmw3J1VFn53SWmHrGj4Oe6i8oHOoGdVnXarvSS1V9wwH/ZgE/PXtACO/5+t+6OBA22IWSndHXcQhXo80ClMNGjZlQu/i1jshbSiAqUJbSIsWuQczqhWub8Oi0mYubFdjKvvw/ZIgNfGOW/ThfteC3UOKeph7UcI5tKTNCoutAqmOpvtlfN8IJ86+KR4cXju0ClA8/f8SvGLaqvvavcXjo0NRNgK5EKWWyXeOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4Fx1DieM9vaix/jHR+fUaUcF7Yd3se+xf2iIg3Qq6g=;
 b=m6cZHEl61xMyszrW7jM7SD6m5W9SmfXL5oeu7pbguycbXbWmwH0YwIXfBMopsBKbBRGnag7OMJpcAWPZnwyS31kKVR64c2jQH7HF9tFvXDZ9zZFAMVV/XdUX2xX6YNGpL12PSy7J5+gYsaNLS6NeFAIyRqewPLWwt4sN2QTMjTJ2xfVV8fZ+Fz7p3leDJPweIiBf5rZrvargcWGjgRGHCdVk/mdzyKwVzI1Q5W6VdN9b9xv4hYMCbPmAk8wmNfl1puTfSazsuwiMjqboKuGq6ncjnNusLDQztlLpfdRdXNesjmIQTiGkHYlUNioRmBrCHya6xiKLlhUMUDZs4HTIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Fx1DieM9vaix/jHR+fUaUcF7Yd3se+xf2iIg3Qq6g=;
 b=rT7MBNUdZT8F64bLzpP8S8oKcopuQDyYaD44Se6uLEr5ojHNsofRxgUrrIql5qArUI4rqWEosNW7tCn3JXoSVt0FaUY0Fm6x2zuT/mUlqAnObwPW/tZY7lLgL18rbNn8iV+A59KxTAdmsWTSBeygsNpjBPv8eA4Te4nm5zXdQH0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DBBPR08MB6201.eurprd08.prod.outlook.com (2603:10a6:10:20a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 12:20:58 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 12:20:58 +0000
Message-ID: <06075035-5cdd-4e88-ac80-2379f0db4fe9@arm.com>
Date: Mon, 28 Sep 2026 14:20:56 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, christian.loehle@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260916103820.1760297-1-sumitg@nvidia.com>
 <20260916103820.1760297-2-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260916103820.1760297-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DBBPR08MB6201:EE_|ZR1PEPF0000E6B9:EE_|DU0PR08MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7523ea-6ee7-4f38-2491-08df1d5b0770
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 NIDCNbvCr3qcWht12WbIZno4G9XjMjd9t4lW8EdCtEEli++91si+6ugWtIRr5/+1BDx+f6uMBpJ6PJWuYFpH9mLTHnmeHOSymIJo5+ERE+BrbmLSQUw+E2nu6mqviZ/+QgYjRpxYl3ul1XUa1KzOEjD8IjE0U0bTJC4z56yTeSse8vDEbq0P97z/lDgMx6SLa3J9HOQp3xeu8nUON/LfQ1bc0tjUj6KYZDjcKBqpI8uqW5wlAHj5rkVCXU+Jln8NbiHqY8OujmSaInYqfM9mdOy+WXSedrMuxmKiF7FOsMusZBq2DMKzfz0FypNpFc1Oo8BQwaZSy4X17I5Fk976WsKSoPG/2ROv1VVtlKvqD+sxvZyF6iz77C+aqCYqajbDg6Fgh9fq5XGI4yeXv2+mIzNG96sc+i+g9aaGiIw480zALv7bqrixHVugPMH1yLws/RZmIGrvzlbf++Nr2IjdGKgRL38BeKJCIVHrIEWXFvLNY/iJFiMf3Udtkh5ejbvLIgGhOw++PoAyMHokgR59KSStUjsvoZBTEqKakBHm34TwzCwaKpeLJWZTQm++MKL2ovYTfuw332ltwtrmpvX9DpoKUQHGfruKzJcT7FpK/f/USi5fUFWyM5ECxJbiNZJLY28sCdqEcgI9UQcPUaFizAslrAx2qI39npAXt2HEESivbQ3Z/b5hUvhz+KDAFgngLyaNubV9Y8Ec2xMAONxJqQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 T9ELtGRsxEg+zmw3EdZWNDeM38kXTolRc/cH9bwndD3EjLU8+z2OOGmUooeI+kKwIQtfXshHQWZSaoMcrq5L49BMHHVQvgGZxn2l96AlDngYbIoDiWdeyDshQjvUjTtMbg1/ZnTb3afjrGceCW4mCFBgfdeIo3zgGFxkzu2Crhp24mCVtRPeLv0eG2FB8voYQLIUXb12iyyKyQMjRJ4mk9P/zx0NdC2hDvBLi0QpP171GGiQbdfrN56T1mNWrUCBLTxaalIwbE+KJ31h+ouo4A/tybQsqw9b2nUgj/4EPEBlKItDnWyS8REMnW0MEwUqlfp0cwOcxXZTW+v+UcoaKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6201
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E6B9.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	148f4fbc-2245-4956-583a-08df1d5af382
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|14060799003|35042699022|7416014|376014|1800799024|82310400026|921020|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bYmA4BUqDLxAKPLOHRViwoMKEWt3d9hx1p0lck+6cleekofF4FOHcPBr/k2e5jbzOMYNwrIjqqFbWmvBg6SyrCLXCTSXBuMv7wuVoFc6sfaxgoWOqS1cfYZSPuhkGFlB7/ODmxyd1pioLsTBxt9uxFySuJS+0gNYMTmxANKTuxes3V1pIqbEkCZibBBhP3fwdPVBddPr2Cm2GNwbvQvttENtjGjrh6dJNNXyk8v/U5lLxshOsxqMDppzYQTK4pKQbX9UWSMh6tpR5lZG3NLqc+NQkRJKqrZhsjlfI/q5FYL4C2V3ByY0kdrlp5iBskbMGe2gTFbht+SCQvIjmxXTyUAVgtc4OHi7xXDuMVjQKkdX2VrNUzjxfXFjY0s+QjTtQPsn/Kt1ByeVJT3NPicmNUPTFfI+J2HkdjXc1JLV1j4tCbptk0ADJI1Dx8bYxwgeDpetLYF8G4Ymb/7No3JXEtGCTx+RVehjHGXvLnnYJyCt5Fsb1xO79EHL3I3oHXl+BFSAEmj8/2nn53FCcsKVre9ojwm134KfRs7SuahRYnxOAWKFx35yxPbB2SFo3tpyc+4RBJtaF/wUjlk9PFSC61fZJv2w4D6gU1ditQgo8ujE3Vi08KCaxUhcqtT06CGn7ZtIR+gdY/3lpnm6Ebo0GktXSaBKJqQX764hmBe/K5FraANFjw+iRnPGChOQcRIfunJZLZ6YnjtQhPHu6GEu8O9pz/DldC+m7xJlywyxbozuF3fcRCLQRgv7CqGVE158
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(14060799003)(35042699022)(7416014)(376014)(1800799024)(82310400026)(921020)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EacagvAqhcTe06BITT4lFNo5IEicWJDbee8PgliH8D9bHUoLlDrHRWg4fp2p7dZF86fLPqNPIiqkoF+Me6I08OcBACEaIzJWTN/0Z1v3K6jrNNWgitgcRa8H4tOTD+eXP3s4hJiq1MysDTbKkGJDXtYhdAbjX8NHju5MKfjKSCzyrv1z1l5lp4X8+M//L6swvi8i1dmuMuNEhZMKEIk+O+CU23Ki0i7G3qFo2faDBhWnErAVaZvcs4iEWiUgYgHJDU6AxBd5GjHLD7BZ5kgfklPMaykHKbLS7K9nHZ2BUATcZhtkexEfuMHkGJyUkSo7glBy4rXnwHy7J40DTqU7QBYpC1/pQ6dsf3oxvNVht98FvpQFy7yPmCY6RuCkoV1YcCW/vurOr4PB5HPctIbDKLChKjOus56X5Orj5SJ60IfNGxLxxQH0vm4bkrSZ4ZxY
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:21:31.2206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7523ea-6ee7-4f38-2491-08df1d5b0770
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6B9.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7591


On 9/16/26 12:38, Sumit Gupta wrote:
> Without online()/offline() callbacks, the cpufreq core calls exit() when
> a policy's last online CPU goes down. That drops the driver's per-policy
> data, which init() rebuilds when a CPU comes back.
>
> Add lightweight online()/offline() callbacks so the core instead keeps
> the policy live and reuses the driver's cpu_data across CPU hotplug.
> init() then runs once instead of on every hotplug, making CPU hotplug
> faster.
>
> The driver can now save what the OS set in offline() and put it back in
> online(). A later patch in this series uses this to preserve the OSPM-set
> registers.
>
> Move what init() and exit() did on hotplug into the new callbacks:
>
>    - offline() requests the lowest desired performance and stops the
>      frequency invariance updates, as exit() did.
>    - online() re-enables CPPC and restores the performance controls, as
>      the platform may have reset them. Failures are logged, not returned,
>      as the core would free the policy. It also restarts the frequency
>      invariance updates with a new counter snapshot, as init() did, so
>      that no sample spans the offline window.
>
> The restore in online() uses cppc_set_perf(), which writes MIN before
> MAX. Each write takes effect on its own unless the registers are accessed
> through PCC. If the saved MIN is above the MAX the platform currently has,
> restoring it would leave MIN above MAX until the MAX write lands, so raise
> MAX first.
>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 130 ++++++++++++++++++++++++++++++++-
>   1 file changed, 126 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index f767898ebfb5..37ead7f6c179 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -184,12 +184,10 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>   }
>   
>   /*
> - * We free all the resources on policy's removal and not on CPU removal as the
> + * We free the resources for the whole policy and not per CPU as the
>    * irq-work are per-cpu and the hotplug core takes care of flushing the pending
>    * irq-works (hint: smpcfd_dying_cpu()) on CPU hotplug. Even if the kthread-work
>    * fires on another CPU after the concerned CPU is removed, it won't harm.
> - *
> - * We just need to make sure to remove them all on policy->exit().
>    */
>   static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>   {
> @@ -199,7 +197,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>   	if (fie_disabled)
>   		return;
>   
> -	/* policy->cpus will be empty here, use related_cpus instead */
> +	/* policy->cpus excludes the offline CPUs, use related_cpus */
>   	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
>   
>   	for_each_cpu(cpu, policy->related_cpus) {
> @@ -754,6 +752,128 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>   	cppc_cpufreq_put_cpu_data(policy);
>   }
>   
> +/*
> + * Prepare the restore in online() so that the platform never sees MIN above
> + * MAX.
> + *
> + * cppc_set_perf() writes MIN before MAX, and each write takes effect on its
> + * own unless the registers are accessed through PCC, which delivers them in
> + * one transaction. If the MIN being restored is above the MAX currently
> + * programmed, the CPU sits with MIN above MAX until the MAX write lands, so
> + * raise MAX first. Restoring a lower MAX needs no preparation. Both values
> + * come from the policy limits, which keep MIN below MAX, so the MIN written
> + * first is never above the MAX that follows it.
> + */
> +static int
> +cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
> +				  const struct cppc_perf_ctrls *target)
> +{

Maybe this logic could be moved to cppc_set_perf().
Indeed this driver should not need to know the order in which
the cppc registers will be written.


> +	struct cppc_perf_ctrls cur = {}, prep = {};
> +	int ret;
> +
> +	ret = cppc_get_perf(cpu, &cur);
> +	if (ret)
> +		return ret;
> +
> +	if (!cur.max_perf || target->min_perf <= cur.max_perf)
> +		return 0;
> +
> +	prep.desired_perf = target->desired_perf;
> +	prep.min_perf = 0;	/* Zero leaves MIN unchanged. */
> +	prep.max_perf = target->max_perf;
> +
> +	return cppc_set_perf(cpu, &prep);
> +}
> +
> +/*
> + * Run when the policy's first CPU comes back online, the counterpart of
> + * offline().
> + *
> + * The platform may have disabled CPPC and reset the performance controls
> + * (desired, min and max performance) while the CPU was offline, so re-enable
> + * CPPC and reprogram them.
> + *
> + * Report failures without returning them, or the core would free the policy and
> + * leave the CPU without cpufreq. A failed write to the performance controls is
> + * not fatal, as the governor's next request programs them again. A failed CPPC
> + * enable stops the restore, as the writes that follow may not reach the
> + * platform.
> + */
> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	ret = cppc_set_enable(cpu, true);
> +	if (ret && ret != -EOPNOTSUPP) {
> +		pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
> +		goto out_fie;
> +	}
> +
> +	/*
> +	 * Recompute min/max from the policy, clamp desired_perf into range, and
> +	 * reprogram the performance controls.
> +	 */
> +	cppc_cpufreq_update_perf_limits(cpu_data, policy);
> +
> +	cpu_data->perf_ctrls.desired_perf =
> +		clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
> +			cpu_data->perf_ctrls.min_perf,
> +			cpu_data->perf_ctrls.max_perf);
> +
> +	ret = cppc_cpufreq_prepare_perf_restore(cpu, &cpu_data->perf_ctrls);
> +	if (ret)
> +		pr_debug("Failed to prepare perf restore on CPU%u (%d)\n",
> +			 cpu, ret);
> +
> +	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +	if (ret)
> +		pr_debug("Failed to restore perf controls on CPU%u (%d)\n",
> +			 cpu, ret);
> +
> +out_fie:
> +	/* Restart what offline() stopped, with a new counter snapshot. */
> +	cppc_cpufreq_cpu_fie_init(policy);
> +
> +	return 0;
> +}
> +
> +/*
> + * Run when the policy's last online CPU goes down, undoing what online() did.
> + * Defining offline() is what makes the core keep the policy alive instead of
> + * tearing it down.
> + */
> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	/*
> +	 * Stop the frequency invariance updates and cancel the pending work, so
> +	 * that no sample spans the offline window. online() restarts them with
> +	 * a new counter snapshot.
> +	 */
> +	cppc_cpufreq_cpu_fie_exit(policy);
> +
> +	/*
> +	 * Request the lowest desired performance while the policy has no online
> +	 * CPU. Zeroing MIN and MAX makes cppc_set_perf() leave them unchanged.
> +	 */
> +	perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
If min_perf is unchanged, we won't actually request the lowest_perf.
The firmware will clamp it with the previous value right ?
> +	perf_ctrls.min_perf = 0;
> +	perf_ctrls.max_perf = 0;
> +
> +	ret = cppc_set_perf(cpu, &perf_ctrls);
> +	if (ret)
> +		pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
> +			 cpu_data->perf_caps.lowest_perf, cpu, ret);
> +
> +	return 0;
> +}
> +
>   static inline u64 get_delta(u64 t1, u64 t0)
>   {
>   	if (t1 > t0 || t0 > ~(u32)0)
> @@ -1047,6 +1167,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>   	.fast_switch = cppc_cpufreq_fast_switch,
>   	.init = cppc_cpufreq_cpu_init,
>   	.exit = cppc_cpufreq_cpu_exit,
> +	.online = cppc_cpufreq_cpu_online,
> +	.offline = cppc_cpufreq_cpu_offline,
>   	.set_boost = cppc_cpufreq_set_boost,
>   	.attr = cppc_cpufreq_attr,
>   	.name = "cppc_cpufreq",
