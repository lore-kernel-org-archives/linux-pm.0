Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010063.outbound.protection.outlook.com [52.101.84.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E94195A1;
	Wed, 29 Jul 2026 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785359254; cv=fail; b=h1AzVsXIoUckNxaNQkbXTx5vXp201oad4g6yP5qVFn0lqdneJGPqDqqS2uBjhaiyqIoGbIUgY864eW9yRJK0AY/X4AzKW7NkoUuXywUkq4Dnu97lhGMmXoOBvLG19L55E5MAdD4jiSAd99fiIpDcqTJSNB+Cs9zzepytINQ0ZWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785359254; c=relaxed/simple;
	bh=fD5T6Hwnv/7/ZlGN3dXtPuzYnF4OL4cQj/iar08eCRQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z5AGkKQkGuI1gKHqtEJmeAfDyewBCTud9G6PGWt8jSLYeLJv+TUkxbEt1YZOFQaNdJEVmQh6eXfYMleCQiGm4dZImUqcHSd14pW0xAKDJ7ynN4uenmlilgILRV/gA4pwbgA99/mKTDiPzLLcUklwVEvz4XaKXAvIb69sNwziuN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=O3kChzgA; arc=fail smtp.client-ip=52.101.84.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="O3kChzgA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssN8Nt14hPS01dxERIpYEuBaD7UOIah/+B18Bh0jFvnDJvlCFJVRxA5334PFJu6APbXV2UKt+6X9VVvKw/JcnFcUCnZPrhyC49fV8ERgHcur3HHRErHYWzBXPOknqst2KsIQQI+uxpzfPBzJkit26D5WYZd8c1sRG5bda2mSFX2IymvIWf3nMVqr6DyWCcz3qYdunKa2BprFerXchd56oZVH7XSm9OlyXUgHCdXf47yPrPDQpzGV75wM7Mfa2DvYNHQI2aVRCSo1/9Ip1zisqOg+vwW7QIVXoiB6EA8Inz2F01ul1sVwwfkNTbpOQJ+V4xc8ZE6pbnW7rEX1c15KgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD5T6Hwnv/7/ZlGN3dXtPuzYnF4OL4cQj/iar08eCRQ=;
 b=PM9A0eUkuLqIZoi+UUNcIKD+vtxmUG1MreppB3ZJnDZ8re2CXLF/wBnMhF0UJhdn3TK9X7XtaDBwfKbbd5Y+XOQe+PH/AX6T3+FzbUTe01BlNwJjxpr/5zv0PTDQZ9lpmPbOqoAcfUTaSIYRLqLexMryHGR1M8BRKRq3fy4zE+K4PSEcSga7gAxYrb1yS7/OwuBMXe6Mbd2NLW9YSlkl9RPzg0i5gTgAE++h884GqS1xHSD6NvlvVHO+ftIi6uAb5pS0H62dSoCJZrwMC2tMp3Z5hN+QrkV6d9Sw3T4gMH5w2s1Ma12zPHVij7J8jJL9o2/KlTt1RdLVsXS7Y5VJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD5T6Hwnv/7/ZlGN3dXtPuzYnF4OL4cQj/iar08eCRQ=;
 b=O3kChzgArO139Ozppjq77AAngDgmOlFvBM914kbFIfgX0N8N8u/2RKbEb6imFGbNTxX8febaohgm8xi9ZX/B5DoU10Elb2C2qmphUXDIj8zuDPujG4dhRCqTNTh9TjxbVSGxkLty5jP5z9cOIi65QDoA2067qSsM+9MUXD57f0U=
Received: from DU7P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::23)
 by PA6PR02MB10615.eurprd02.prod.outlook.com (2603:10a6:102:3cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 21:07:28 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:552:cafe::9c) by DU7P189CA0026.outlook.office365.com
 (2603:10a6:10:552::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 21:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 29 Jul 2026 21:07:28 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 29 Jul
 2026 23:07:28 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Linmao Li <lilinmao@kylinos.cn>
CC: Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] power: supply: bq25630: Initialize hardware
 before exposing the power supply
In-Reply-To: <20260728024558.3611522-3-lilinmao@kylinos.cn> (Linmao Li's
	message of "Tue, 28 Jul 2026 10:45:58 +0800")
References: <20260728024558.3611522-1-lilinmao@kylinos.cn>
	<20260728024558.3611522-3-lilinmao@kylinos.cn>
User-Agent: a.out
Date: Wed, 29 Jul 2026 23:07:27 +0200
Message-ID: <pnd4ihh33ow.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|PA6PR02MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: 2017fc3b-b0a6-468e-5baa-08deedb565b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|20046099003|22082099003|18002099003|4143699003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	3PhtTrCmRa350V7GjCoTdRxliHSE9lA1TD5/g2eDODTc+UU6XwGT2qX3BJoxdCZ3nrkReSwHwbB/oG0WWfG6Chs7UA6fqYUoU9HmBeRYejmB1dbko5hL/5TFRx/jqWbi5StgQovfZsYJNigigX2sarPErGnCDVEnnjBT6py0NnW2MzTVLW4WG6Rm86VPaig3VDd6Gjm10Wwapi00yfOWgeY4QY8ltMkuCWhycDX1JXMHsuj/ZB/vIvOfxextKPKUFFKvnza1Rqg9tD1J/MXIJlzqxO0FqbW/dqSt53IcVJU/2JSEyWiGhL2AuNPH4IpGlhESJ+e7asdxjdGqYLDHT+ChiTSIboqoKsfrVXNP9uZuRHUHmcBXJ+sno+wwgq1PZ2tiHm4NFPGsPXaEpTUAFAJ2WYMsodFfUfBBSTeL2QSqWPKaVkaSIbPUk0u039YxuIX4dNfb4E11gBMcjtdMBwJ3P+jr8ZUPEBiTIHYk/DG+gT2/xpND6ZslbVySL+IMfGpFlHfWKRPi1fqPdg6cTrJJbsVLlwJknMI60NqL6KzaGwXezvddSS4Lam6AorApPrqOHqaPiHx+qoOxZfq6BNn2F6bjYbACcRHjQ3i2GS7ffVTjMc/q3y26e+U09ypignvbrdJQkeJWqdsglxLVD1dP6uAy9YFa+hkkXL7CEvBtnS8j91bMFh3wmjFTD/6fPetH2EZH9j/hyvurXaUuoA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(20046099003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ds+zFEuIO8AKF8vFM8k1MLaSdahMaMiKR/TfzURnopplKlcYur1gwajweuKtm+UCm/oDR/s/9kppZQHppPGwUt95oGGKOLDlZAXogOTzGQ0UB9gBf+BDM+Esm7Y5xRc3zL+q01eBDDj878hiAGITJvfTC5iQhqJqOGepanql7rzNPouZ9BfdhHSMzBiscAaYO/Ar1Ltj9ttBYBJ9NoKIqUu1gfDCsRdbYA2txV98m5voSlrNUn9lVPx/lKAqnh3Qeqfuc43Lw7jmfmCi6K97z58ggnRATQ4hMSbfuMVJminHHpHI6X50rU0pzOBJkhqSOlJm63BDc3v0E0ixQo1WbC0Vxnk7OwyA203vAw4jjILrELkviLK7+4ZMP0fx37DXmfAlBI5928Od+J6AJQy17OQRWTxt0uzYZf+Xevajc8H0waA5QcUtSxCbwDF769HG
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 21:07:28.4004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2017fc3b-b0a6-468e-5baa-08deedb565b6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10615

On Tue, Jul 28, 2026 at 10:45 +0800 Linmao Li <lilinmao@kylinos.cn> wrote:

> bq25630_setup() resets the device, disables the watchdog and programs
> the charge limits from the battery information. It runs at the end of
> bq25630_probe(), that is after the power supply has been registered, so
> the device is already exposed to the system while the hardware still
> holds its power-on defaults.
>
> power_supply_desc::init runs during registration, after the driver data
> and the fwnode are available and before the device is added. Use it for
> bq25630_setup() and drop the explicit call from bq25630_probe().
>
> The callback is passed the power supply, so take the driver data from it
> and use it for the battery information as well: data->psy is only
> assigned once devm_power_supply_register() returns, which is after the
> callback has run.
>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Looks good to me!

Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>

[...]

