Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03831E8342
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156224; cv=fail; b=cLBa3uOkqGrnloafXN0+iRkJm5oMCjxd8i2SrDMKXNDZu5TvT3/EByMnqUfZvXNrHpHUtRLm8te1PIaOrwtxocOm2Wx0/1ZkyA6B6KJbSFdUyvdbnompddYgoXKTJVG2lBjfqSjjL05kCBrrhSik+isul4z3XIRqk4b3iCm1qAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156224; c=relaxed/simple;
	bh=TSN9gL55A7Ag3raf82N9KWhH7vvMUMHmUl4Tkg6QycE=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tYFKSR9DHOKSZN8yaF6a6i6pSOipiDhFMtdGGukr8vlbrER47ykC+FJ0fr/TmkR0c4Dy920Tt88YjLL2L+uV6F8S2jio0pitM/FcnhvpyN2CT8bymSHlGhSAroVtlWK4i9wrBkBj+Lbjh5Da6j2j8JydBScuF15CEftvB+lJy/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=YKj4SlxO; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="YKj4SlxO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiyiskLCyAMIMOHIW7No6aKay1vAIDEJwqQP9SAOSJd36DvUsKRpEPUL8Quh5MaAy/pf1YKya2iC3j8oB+v31eNqWP5otpTMNGRBYUMaP1NI/tj6l6S3btS8OPb0s83uiS2Cgt3ikrersh/ioqNbf6X//+l8TDEUP+PTxAe4UhymWIbyxI2Dp0IqbQB7VC8JNipDS0oSXfaylPupajbGBG6JXN4jFvgNzrXE5XW6OYUcy/vgfpk8klT241sR1O0ZPQN85NyGnDBCs9fGm9j2ZOQ15X6V6hUj+wyUARzAsE/GtNjX0cBEgzEBk9Mwk/aDoBWqXGfkYT9CnYZBKuMxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8AIII2V2RFH35akKOekE5WKF3RXuYI2l5LTvYvTgNo=;
 b=olwBh6Sd5F6UycsOU5vNCrWyToQdjr4TTZ/gEuEyYBTW4k0Vhj8aR5A/gtc/VP0LFGW5wM5xUfAc8MLQ5xlIjBK3bfXbPRzXhxe0HOEvr9BkkqeCgFu5Vv9579ilQeOxATBIktQJTM7ZLWAIboAKe2S5MG8oedEvtatZIu6rkLsO6PQFHmSpzxoSxJzII360h2+rhSJpjEPFJ3jz40EMN6loIkKTFtRWIaWhIGVkDJQ6h7XSR8gsIWFXIOndFPdu6/I4eQZfjLQEtlb7RrzbGIDygVa6NH0PvBCMrHA4kjhvzzxqCxRPrRAHbzUSO2RhJFNBGzIicjZkVvQcRGu6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8AIII2V2RFH35akKOekE5WKF3RXuYI2l5LTvYvTgNo=;
 b=YKj4SlxOxUU9+gq8du0bsLjnjcYlaVsOMVOD4Xag2S33K+0qBB7qkNCStnhidfCWy3C2BdTul1fujCZX9pPFxpJTYJSgsr52hlcXJu7jdT08HrmaXEhGnELzRoAIfYSn7S7u10pLVj8sogqKe9+5rkT/RhJet3Hestpl4gsS6BU=
Received: from DU2PR04CA0190.eurprd04.prod.outlook.com (2603:10a6:10:28d::15)
 by DU0PR02MB8038.eurprd02.prod.outlook.com (2603:10a6:10:352::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:43:38 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:28d:cafe::d) by DU2PR04CA0190.outlook.office365.com
 (2603:10a6:10:28d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 12:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 27 Jul 2026 12:43:37 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 27 Jul
 2026 14:43:37 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Linmao Li <lilinmao@kylinos.cn>
CC: Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] power: supply: bq25630: Release battery information
 after setup
In-Reply-To: <20260727093738.2611185-1-lilinmao@kylinos.cn> (Linmao Li's
	message of "Mon, 27 Jul 2026 17:37:38 +0800")
References: <20260727093738.2611185-1-lilinmao@kylinos.cn>
User-Agent: a.out
Date: Mon, 27 Jul 2026 14:43:37 +0200
Message-ID: <pndjyqgob5y.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|DU0PR02MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 427a1506-2c09-49a1-483f-08deebdcae1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|10067099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	kTbcprTQlqKXM6V9m7HxH8TJgqsE8ZWXkLx7jTxzLeRenqmp+eBLi+3W9OoMpb+BrVcdwOTk4M370yPDCWQS3D/KyfKROdjPgPvJylm5e3YF2oN4KMsYEBeTig5W1HubgIbvkLgsTj0EtG7lyRVEeoUFbDKcol4Tv1GaqOIH6PkCdKYfALuE2lMT172DHvkN4C8GIzGdhNorM9TIY+imUEqTnPEIEM1hemntZICefh2gYqoKzEMvSMWOHD4X72OCd3Y2zURGtvI/+ttvNR77uvGlUTsELEsBH5Ao2Fzx33AuTSUZyyx8WfACuiiBCxKIA1XEvBPsSAtBU5ScFKRtKL2jx3PPFFpNX6rOeoBLnRjHXK3xRjPnhvqc6wF908vd30M/GiKBQPM7axjfvtkw2ObEvrtEAKuO8rfBW5tCcuLzDO+Wq6PUGu38Pdtl9GQcxCp4GNPouDNGuFAwWjKESK6OWV/LgEGk6z3ZZ9Bz98aD4rBZ8hoqPwhmYrfO4EZprfb0q7owQU4olfFOPdnq08NeUAg8phQdqxMLDy4FMWAKF9h+V+k5HjmxBDAxAfMObwGqRnbiSbYMGAQwmkrH16ShXSxXPDt9/1etJKhlp5UC3QVpuupPZCmjlgwhkHZYLaeEhLOHW5G2sMQBsW1tUdKqnEAX5EwjOmG/moF3vQjBLRHrWHIC7mnrW+4HXh46xB6SfHHRgg/nAN3kya4a6Q==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(22082099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WIwU4UFuBlG1DkrfKo171xvyLnJ7HWomphPBs9yIlO1yr7adBEFNqC1q0kWCPeF15rZF4bEBq4yhJcMpIFAFmncR5RYiBvpif++0lo16Ijt9QDredY0VF8j0j/wcf/iyc4rZknPZz+f0ZZ6L2SLCR+wZZpiy71i3fHIuWSvrAhOVhiR/wsNigGCBivNrky77HQv/A/k6DMyjbR2D+6B9Vvn3WaJObfV8Niu0JJNt0EmFSDHklZ23X7pSpMKX+RJaT++NS9sVLLX64qyV07jy/9TcYIVsZKEatFouC9/7s2a6Kz7nHLkDgA61sbDslvxklCuyzK9MSBDX54jRH+KoXL9AN/Nj4gYs5449DTkNxKa57/uXXFqgFGfkJ4A3zeGHz/o96zcPDRVrmPYI9tJE2aB5QXk3bIOsy0YAoFj3dKc6jcEAxOfK+OAyAqK3xI6s
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:43:37.9248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 427a1506-2c09-49a1-483f-08deebdcae1e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8038

On Mon, Jul 27, 2026 at 17:37 +0800 Linmao Li <lilinmao@kylinos.cn> wrote:

> data->batinfo is only used by bq25630_setup() to program the initial
> charge limits, but power_supply_get_battery_info() allocates it on
> psy->dev, so it stays around for the lifetime of the device. Nothing
> else in the driver uses it. Release it right after setup, as bq256xx
> and bq257xx do.
>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/power/supply/bq25630_charger.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/bq25630_charger.c b/drivers/power/supply/bq25630_charger.c
> index 165f8c67b4895..efcdb1f5bc351 100644
> --- a/drivers/power/supply/bq25630_charger.c
> +++ b/drivers/power/supply/bq25630_charger.c
> @@ -1045,10 +1045,9 @@ static int bq25630_probe(struct i2c_client *client)
>  		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
>  
>  	ret = bq25630_setup(data);
> -	if (ret)
> -		return ret;
> +	power_supply_put_battery_info(data->psy, data->batinfo);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static const struct of_device_id bq25630_of_match[] = {

The initial thought was that `batinfo` could/would be used elsewhere,
but as you point out, it's currently not. A better design is then to
move the `power_supply_get_battery_info()` into `bq25630_setup()`, in
order to scope the `get/put()`. So let's get `batinfo` there, just
before using it, and have an error/clean-up-path there as well.
