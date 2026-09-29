Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D9501F4A;
	Tue, 29 Sep 2026 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698462; cv=fail; b=Cl9c3gDjSQ/SLxRAi+eZvWEOCc4y9rfNe1AIxH3Y6ewhbVsEO7nQxuUAd8+wW/2usKbrSR5VBEsLHLcrIrTK68fko0bEDFU50Vl3bGLQw4tpexpELJyVojv5BgCchRo5KaYPmviQuaCLDfhU6g5BThly8GcNtFtqxIv3uIAfov0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698462; c=relaxed/simple;
	bh=lb3uJLtcCaNsuHWT4ERHvC6184Ec2LCU6YUr6s05EjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cNNbg7Ei8D+u6didb9BPTxW9TguffI0e1b7DBeWRUjxbJA0sd+31/XvF18sv8tNcRheCgAWvIyY7liglZ3d3ZHio8zJND5brcKQVUz2o0f3CTXN/V+Ex3O6XYD5Qolz48T7Fw5FCbzZ4aFDgGOz1k88xkFkYmafFg3I41cuhMpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=dMqQRrKA; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=ax35d6l2; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="dMqQRrKA";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="ax35d6l2"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TBffJr486747;
	Tue, 29 Sep 2026 11:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CSKBmLCnTpzF+m92JuL2LJvMoQOc6EITiQJFwt1GR
	Ck=; b=dMqQRrKAaneW9dyOUIbRYeCofoeNS4muOAwfAVpZm1eEze4HQ+0qltq6y
	O5byM1zJ5VmYdwtLMOmnsy1tP5/Apyw2RotR0AKF3/w//LIKHlgSThOuay+7Fseo
	8sSn69I5EeA7EIrJ1lBoa6FdN9DnODk5TaD/Nmt/7Oo+6dS76ZDWQCnf3HUhmhGW
	BPcLHryoQzax6GPTzfrQztD1MKQRdfZr/zHSGim8Ho/MTJpIel8K9n2x3vVZI8DE
	Nh2zZTgavmQ11PgiQfHk1+CnTVvkNyiE7tcLhl/DkLC5jPk+m4H209pdErEiZkWm
	Qpw4QNi1F8apSAnDRuraBbUMNgQwQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h0cpc1ryg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:14:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEv0ylAo1tcM6ThtNtygbS6uoAFYFeCn0YVXZR+7yPsSxOsCJlQ0tTWXH3PL77nWKBXmquup9GomRnVz/3vHZWNN2Ra26ZzWjKog1646SZcV7EfAYAZiV+Lj7LNWWFSZ03RhyePhXHpBlzz3EUtgPRSaH3uxVM3VKxlVDI1HSkfvIWcGdAA0DiC9e8OpdMCuxbldf2m+ytEJ6korz0L/f515UFzbK0Vp3bz4U0qbgsdMk2yF6g8RBikSzlE2eu5X5v5osc8JkYEuDMod+JwwqNbKVtrUohSf9K01wU02uFs+Xw44IrgG8ArduQgfTNzFIMKvgYTv75MQ+tfpLp2QmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSKBmLCnTpzF+m92JuL2LJvMoQOc6EITiQJFwt1GRCk=;
 b=uF78s2pgQ4BmOLIYZhXzNmrdvdMTVvrQaFFH9InmK9fZlBzIwmIYspr0eeAtLBmiIQbVvpwbWUPs/uBpx7L8lxT1e5Xz5oHG6zwzuogWxW4C7HcPbHiXKm16f6ycXQ0tafuiV8XzyVYaFrk3dEwOrEZpOgVudUK7NQC33EfhZPI68LNq6F95UT9/2I2YPVyyVXByWQXwrmdBJbVQFEwTNb5lLwnG6Skh6pI/IORGOfbOiy4pHYWYeAMJMcm25TYov39WdkKlcSoZxYwxtf6srUedeZCuAwenE9REp2LdZgGyJqDi8hoH5kyw7zygei6SVIJq/NlnXhmT/TkIffy43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSKBmLCnTpzF+m92JuL2LJvMoQOc6EITiQJFwt1GRCk=;
 b=ax35d6l2/jvWBOdTG8w/L1ldBBh4IQBbVA/sk9Tmk+qjxaxEPWwVUENguxAafEcLdOwjS0AEZk9JOVo9ah1S8+R7CNb/zbCxEUwLGBgnGp/1sYJFG9Fmm04H5R90Xx1hM9BKakyeD3lpwvHLh73vRsbgHx6bzGIxE2CYvoMkI3Q=
Received: from PH8PR22CA0014.namprd22.prod.outlook.com (2603:10b6:510:2d1::29)
 by MN2PR10MB4143.namprd10.prod.outlook.com (2603:10b6:208:1dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 16:14:04 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::3a) by PH8PR22CA0014.outlook.office365.com
 (2603:10b6:510:2d1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 16:14:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Tue, 29 Sep 2026 16:14:04 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 11:13:38 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 11:13:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 11:13:38 -0500
Received: from [10.249.37.61] ([10.249.37.61])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68TGDcCd1325912;
	Tue, 29 Sep 2026 11:13:38 -0500
Message-ID: <1c4ec15a-ec4d-4db5-8015-e71790a7de04@ti.com>
Date: Tue, 29 Sep 2026 11:13:37 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] power: supply: bq27xxx: detect bq27541 behind bq27411
 compatible
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        David Heidelberg
	<david@ixit.cz>
CC: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>,
        <linux-pm@vger.kernel.org>, <sre@kernel.org>,
        <konrad.dybcio@oss.qualcomm.com>, <krzk@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260928-master-v4-1-052c73ec1767@gmail.com>
 <20260927220026.hxwnm6mbfs7s7swu@pali>
 <a926e8c8-2a05-4760-9c71-a713d991985a@ixit.cz>
 <20260927223125.wd77mdgiyiii2nrd@pali>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260927223125.wd77mdgiyiii2nrd@pali>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|MN2PR10MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e630728-5d51-4283-ad86-08df1e44ae59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|10067099003|56012099006|5023799004|4143699003|6133799003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gJnRaNTnDEJPrYkuZhU9hAtLiV1UTd+lH3h8NGgAVLAzraOjKlkHoKKBzM0Tes3K0vGCkLWArmRw3iAbjBJYqppP0f1VunP4yWoyeHq4xMEpJWdzKZAA3WuDtUJdkGJJVKhRmwSXzf7WvuqpuiUzfhAF29eeB68I/XDJzdT1kSMq+cMxKgjq6pAbX5VtTdHNOMKN7putveG+0Xs/NRCp2xHALC0Yhl15Xy713wFThi1yuqv8XiHRzTiCOHdXKO/bHQIWyiyllKXbnbB7VNU+jXHYq0c7gvxfD7w9cuYR5EkNFOOtN4DONQuOlkzUu/BWBa3wlfZ7JEIcG++13TsbQKBovgb12ZUb+52gKcXsheSecORfsTNgq94CtzlML3rq9E9WM7orXj2ECpthiPS+wc61/UJFQpwRcEZsMAL0iN/CKc+Dl9EhGLw07VujvUtOYQDYJiH8rI1mUr1UW2o1wMYXfKt02R7SeII1fcz6hyZvhmbZrlmRTtTA62PLRfzgwOVvNZo6v8ul3UoX1i5JXtM2V5Y4CDbyiG2wEP/8vZheq68ofp8LpyXzNK8h5iRni6o+fF/qRDfhvJFM+cvNhvNatSlFcJigRJZevkfdYDaEWTJejUxX+LDkw3ntcqe9WWtwFit3/jn4sbn2OAB58syFGd9EiuxEw2kDa0Uh3o0=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(5023799004)(4143699003)(6133799003)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iPc3SG2LTJHHdBQlK8HRoHfEKsqm2vgMQnPgyuHijCwdZAWJIgz5Hne3lyexfvfOaou2DbmrJ81oHF4+uGJbd0ySq2m7+fdHbxw91EZb9crKKjj2mqMfFXoziOOJP8ReVdPlP3pwU4MJhTzQCB7w2Rxe8MNPjHMhuNlWLioWxa5x3psxbiDe6vR+xcSSUBxD0psMSWm/5vzfB5x1vNZCaE6cGpM27SB5b0Pch+mIW/mCSiV427aMAdeU8Ty7t3kV3yo1+NnKQbCx9t+O7uZ4obaj3NW3lGN0dxYvih04Sbe6u2KThbF8yoCMKt38/7DxNFCLAKD68OePAr1AXtZIu1XC43nuP4f7sxtOh6Od6papEU5ylUz0ViipnUYTt81QiBzEAhGI41/kav8lcFpBTtGr8h2J8N3SK5c4iCwLkUuOQFtlijMTZ6dI/IUMIzkG
X-Exchange-RoutingPolicyChecked:
	OXXQT1tL/O5ynNQ880mM9qdH2yRn2aMSF0atzvDMIbbcn50qS2ITYx3TJEwIxfE7k2vTbF9NDLiHWMRdeUBe+7QLanWkCgQ4rGUmHc2gXyClxSIfZmLhQHtgp/EncUavVh55iV/aLuQq76rfy6I74bVU+6B5JcBGB+NmWBQrZH4nNNAPlxVFEa7g7uBiCIfeDHHT2KKNnkEX+zVzBZpejhvFYctM8s8ENWviMV5nWojgV/w0MFFlRRGVkcbr8/9NyBAaRGt+prjMsFuJg4NKIAbQMK3RkLXG87o6dSeC4B5kAOPy6KVTvk/0C34CWLIHDmL/wDIXHtbcuel1vGmZNA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:14:04.0275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e630728-5d51-4283-ad86-08df1e44ae59
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4143
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NCBTYWx0ZWRfXym7zYZpcOojc
 3DMnUdtl/snAuJh0t8VKYpAjzp8+rqv5UW+G5DOgHW5DvrhorO2MCww5iMQ3H75ueFqMW6tWvYR
 EQuqRPmtd77M8nTzJbPczQWwcMGcF6s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NCBTYWx0ZWRfX6YvaCarIF6xi
 2vsU28FUd11UpC/BvLcfrnTGstgdXPZfhJXBGj4/RyYa3E+nhSY8xbGysZrl9pAwIkz1mmBljvl
 KWhZOOvFs16gGmzjIN/P26jAWFZiSnb+43EtZP7Zr7Aa5UBXMDoKgqnhsd1bJa3dqtHIkKn2BM/
 P0GfByxr0rpK/6kAW2mwsLqcxeGGFO/YHLrP9xAdfzbPsid6bJ/hgM0WM5mjHHtPQN//1XeiTEi
 NxhomvmUVvfq0gtlM14YhvGbjF5AME7i84bfPboBTNbGLhP4+i6tjcprk/lc567E1l1H3Fxkt9x
 6PD1Mf6IkNxqXH/1eL7w/vXHY/cwRa389B+3vy0O4GPvDNiqYMr4kbKps23+EF61+n80UZguEMU
 UhsxyohcCJtkFWko9W6P2Jlv7qI7G21BgeREXZn/BXy9oY5vrYBEqpR6QLFyZz1b+DDXacVf+BZ
 4Gh3MmC2+EU97iViqvw==
X-Authority-Analysis: v=2.4 cv=Y4xtIReN c=1 sm=1 tr=0 ts=6abbe3d2 cx=c_pps
 a=mOz+rD6hbbSUvRiPFvEd3g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=9AdMxfjQAAAA:20
 a=pGLkceISAAAA:8 a=EodyCerCC3FGwB3IvM4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bn7x_FpfJtc3yKQXRW3z:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: wuqdWyl9ab3vjOdx198OqBa-Y57VM2uX
X-Proofpoint-ORIG-GUID: wuqdWyl9ab3vjOdx198OqBa-Y57VM2uX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290064

On 9/27/26 5:31 PM, Pali Rohár wrote:
> On Monday 28 September 2026 00:13:43 David Heidelberg wrote:
>> On 28/09/2026 00:00, Pali Rohár wrote:
>>> On Monday 28 September 2026 00:17:17 Rinat Muhamedgaliev via B4 Relay wrote:
>>>> From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
>>>>
>>>> OnePlus 6 and 6T replacement battery packs may contain either a bq27411 or a bq27541 fuel gauge at I2C address 0x55. The device tree currently identifies the gauge as bq27411, but a bq27541 uses a different register map and then reports invalid battery values.
>>>>
>>>> Read the DeviceType control subcommand when probing a bq27411. Keep the existing profile for DeviceType 0x0421, but select the bq27541 profile for DeviceType 0x0541. This retains the established DT ABI and supports replacement packs without introducing a generic compatible.
>>>
>>> Hello! I have not read the previous versions of the patch or its
>>> discussion. But I have two points which could useful for future.
>>>
>>> In a past I was solving similar problem (there are more possible
>>> endpoint types in DT and hardcoding any of them cause replugging
>>> issues). And the solution was to "improve" bootloader to load the DTB
>>> file (from the storage) and then on-the-fly in RAM modify it to contains
>>> current configuration of endpoint device. This allowed to boot new
>>> kernel, and also old kernel without any modification of kernel or DTB
>>> file. So it retained the established DT ABI for kernel too.
>>
>> I think the patch here has two aspects here.
>>
>> 1st is verification on which chip it does run, which is something we don't
>> need discuss. This should be there forever. If nothing else, if different
>> chip than declared one is detected, the driver should report big warning.
>> This was missing.
> 
> My suggestion (but only for new things / drivers to prevent any
> compatibility issues) is to report / return fatal probe errors when
> verification fails.
> 
>> 2nd part is more tricky - having generic device-tree compatibles is
>> something opposite what DT trying to achieve. Here it's more like "a
>> workaround". The driver already loaded, using right i2c addr, it can easily
>> switch the device version and it saves us a lot of troubles people have
>> today (mostly for existing deployments).
> 
> Here we are trying to mix two opposite things: static device-tree with
> non-static hotpluggable / repluggable hardware. Similar problem has any
> hotpluggable bus (PCIe, USB, SDIO, ...) which needs to be described in
> device-tree (because bus itself static and burn into the chipset itself)
> but endpoint nodes on the bus in DT are non-static.
> 

There might be a solution already in the I2C framework as part of
the auto detection callback [0]. A lot of the later BQ27xxx devices
have the DEVICE_TYPE register at this same offset. Although auto
detection doesn't help with getting this driver module loaded in
the first place..

>> We'll try to do some proper autodetection at bootloader level later
>> (together with camera focus coil detection, which is provided by two vendors
>> on different i2c addresses).
> 
> This is what I saw more times... because it solved problem of "generic DT"
> and "hacks in kernel drivers" by completely hiding the problem from
> kernel and DT files point of view.
> 
>>>
>>> If there are more requests for these replugging support in bq27xxx, what
>>> about improving the whole bq27xxx driver to do autodetection of any
>>> plugged battery and take any explicit device tree identifier as a
>>> generic? If I remember correctly, it is not possible detect the whole
>>> type, but at least something is possible. This could solve this problem
>>> too, but would require some larger rewrite of driver. And it would make
>>> sense only if there are more requests for such functionality. I agree
>>> that it would probably do not make sense for one device.
>>
>> By DT principles we shouldn't introduce any generic compatibles.
> 
> Yes. That is balancing between principles, real HW and how it is already
> used by kernel drivers. I do not have any opinion for this as it looks
> like that every solution would have some gaps or issues.
> 
> Sometimes the easiest (in a way of writing the code) solution is better
> even if it does not fully match the design or principles.
> 
>> David
>>
>>>
>>> I'm not opposing the change, I'm just writing ideas for future, maybe
>>> they could be useful for some future decisions...
>>>
>>>> Tested on OnePlus 6T (fajita) with DeviceType 0x0541: voltage, state of charge, and temperature were reported correctly. Testing on hardware with DeviceType 0x0421 would be appreciated.
>>>>
>>>> Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
>>>> ---
>>>> OnePlus 6 and 6T replacement battery packs can contain either a bq27411 or a
>>>> bq27541 fuel gauge. The latter requires a different register map and produces
>>>> invalid battery readings when interpreted as a bq27411.
>>>>
>>>> v4 drops the proposed generic DT compatible and DTS changes. The I2C driver
>>>> instead reads DeviceType while probing the existing bq27411 compatible, and
>>>> selects the bq27541 profile if the device reports 0x0541.
>>>>
>>>> The bq27541 path was tested on a OnePlus 6T. Testing on an OnePlus 6 or 6T
>>>> whose fuel gauge reports DeviceType 0x0421 (bq27411) would be appreciated.
>>>>
>>>> Changes in v4:
>>>> - Drop the generic compatible and binding update.
>>>> - Keep the established OnePlus DTS unchanged.
>>>> - Detect bq27541 from DeviceType in the bq27411 probe path.
>>>> - Send as a new thread.
>>>> ---
>>>>    drivers/power/supply/bq27xxx_battery_i2c.c | 37 ++++++++++++++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>>>> index 94b00bb89c17..732164423423 100644
>>>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>>>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>>>> @@ -16,6 +16,11 @@
>>>>    static DEFINE_IDR(battery_id);
>>>>    static DEFINE_MUTEX(battery_mutex);
>>>> +#define BQ27XXX_REG_CTRL		0x00
>>>> +#define BQ27XXX_DEVICE_TYPE		0x0001
>>>> +#define BQ27411_DEVICE_TYPE		0x0421
>>>> +#define BQ27541_DEVICE_TYPE		0x0541
>>>> +
>>>>    static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
>>>>    {
>>>>    	struct bq27xxx_device_info *di = data;
>>>> @@ -136,6 +141,32 @@ static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
>>>>    	return 0;
>>>>    }
>>>> +static int bq27xxx_battery_i2c_check_device_type(struct bq27xxx_device_info *di)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = di->bus.write(di, BQ27XXX_REG_CTRL, BQ27XXX_DEVICE_TYPE,
>>>> +			    false);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = di->bus.read(di, BQ27XXX_REG_CTRL, false);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	switch (ret) {
>>>> +	case BQ27411_DEVICE_TYPE:
>>>> +		return 0;
>>>> +	case BQ27541_DEVICE_TYPE:
>>>> +		dev_warn(di->dev, "detected bq27541 instead of bq27411\n");
>>>> +		di->chip = BQ27541;
>>>> +		return 0;
>>>> +	default:
>>>> +		dev_err(di->dev, "unsupported device type 0x%04x\n", ret);
>>>> +		return -ENODEV;
>>>> +	}
>>>> +}
>>>> +
>>>>    static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>>>>    				     const struct i2c_device_id *id)
>>>>    {
>>>> @@ -169,6 +200,12 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>>>>    	di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
>>>>    	di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
>>>> +	if (di->chip == BQ27411) {

Why only this one device? Feels very specific to your exact usecase.
If you add all the devices supported by this driver which have the
DEVICE_TYPE register, it might end up being easier to list the devices
to *not* check.

But maybe going though that many datasheets is asking too much, for
now this is still a good starting point and more device checks can
always be added on later.

Andrew

[0] https://github.com/torvalds/linux/blob/master/include/linux/i2c.h#L299

>>>> +		ret = bq27xxx_battery_i2c_check_device_type(di);
>>>> +		if (ret)
>>>> +			goto err_failed;
>>>> +	}
>>>> +
>>>>    	ret = bq27xxx_battery_setup(di);
>>>>    	if (ret)
>>>>    		goto err_failed;
>>>>
>>>> ---
>>>> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
>>>> change-id: 20260927-master-bd0afd9696ef
>>>>
>>>> Best regards,
>>>> --
>>>> Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
>>>>
>>>>
>>

