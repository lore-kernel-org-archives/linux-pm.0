Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE93AAF77;
	Wed, 29 Jul 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785359242; cv=fail; b=lz5Wa2pPyuYvB8oMZvl3dOLfq95HnYNHNEO0lUFajpNYL0hgt8koO0BTw+5H7jNayoqL27KsfVFg2CqB+XvktMttGIlTHZhyM4uoqDc/hTPKiKNW79oKJJHUeGTItUoPkzaxySoOGtb5ZBHfbBz6YBojIIztvWn3kTPsbZNaMlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785359242; c=relaxed/simple;
	bh=PV55q4x8rXkcXCkSqBl/yFSSDB6/N49jdgxo0Oi8yzU=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BaWvOqXrAdNEKHgqAFzmvlv8CsmiEgqG46u2zlt+Rmu7VI4DvGr9/cD1L0ZcOLQ04MbTp6J6C0oH2qCSaMPil9A+zqBmvErl8DgRPn59WPrDMkvnMjlKXQzmVBSIZoxkZ1dUJtQW4sBQmLKRek2A0/N4Xg40H/eacfJw4ZJcGpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=A129et1f; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="A129et1f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9OAI5AN3PZdslQ6Ba7j0wCtvEM+KEXVCXwoRSEWOSCslUDJJKyyviENeS1DoWFWNv9ShoiMH0DseL3cEYTsO2CPSnoukk5DKVbiU9g30q0Jk79X90I5dUr6qgt8lCgy2zWHOVfoKvcr7IWHYuUd0keUTfzJVS1r1yjYaolnP00+57LF8t90b+Bx8iB8WjfHbPlPj5A8hmOojMTQ+VRgiMr7uwVFNx3JS7jmwy/6pnsj+zU1fC6CdKaCHzFFKayWNqTz20uyphwVkxMH+rVQx2AtnSTHcWD85fIVcV5l+wiXeRj7+KBe8XVHSEtyZhpigOHRGTcWl/1W4iNLOw2XjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1agpDQKTCUFjv8ey/ex4NOAMLaFAe+rlJSIncjRFbew=;
 b=JC2i6nhQL9sC0yNhBGMxcQlSNrXA7zGZ924aR6Y4f/nHXJggmbuzpujbczYhLNGolggi0x8kMOvdTVU9KtXyO09CYZHxUeyaCn3W6lMom28EGxPuqfl1S4FJMGyw2r2RzlJzAeIdKyyC6zWWuZsKP2XN7m/TkLppiRxG+TYhhF8ay+bFsaYcZW/w0EIGTecrWX91Ou66PMZqBDDOxeJi57hRg+sDBagYVpH2z4TNpr/blDTASg/aviFOOu+SLmWiCKPLlXEhJ7yAKg++kA32g4tFkSsGbFCdJB8uXrLadutfSosGCUz68nh0itRyGxWl57uoDVAUTmUkCoSrJGbEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1agpDQKTCUFjv8ey/ex4NOAMLaFAe+rlJSIncjRFbew=;
 b=A129et1f0BbLiOuJNrjPROS3uN0f58aqRJ3bI8IbccPyiWaUtIV7pZQ2T0oOsdjHuPsEkp6PShBb54e03Cvqd7NbNdlT5rAVm1Z8twngLm8C32H2HbTgbu3tiM6/LuwrFx4YIe60y0gyIhJkW6S7UiasDmfzcDr7KtyN/gMeP9A=
Received: from DU7P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::31)
 by GV1PR02MB8355.eurprd02.prod.outlook.com (2603:10a6:150:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 21:07:16 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:552:cafe::94) by DU7P189CA0017.outlook.office365.com
 (2603:10a6:10:552::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 21:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 29 Jul 2026 21:07:16 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 29 Jul
 2026 23:07:16 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Linmao Li <lilinmao@kylinos.cn>
CC: Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] power: supply: bq25630: Scope battery
 information to bq25630_setup()
In-Reply-To: <20260728024558.3611522-2-lilinmao@kylinos.cn> (Linmao Li's
	message of "Tue, 28 Jul 2026 10:45:57 +0800")
References: <20260728024558.3611522-1-lilinmao@kylinos.cn>
	<20260728024558.3611522-2-lilinmao@kylinos.cn>
User-Agent: a.out
Date: Wed, 29 Jul 2026 23:07:15 +0200
Message-ID: <pnd8q6t33p8.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|GV1PR02MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a586457-bc38-4c7f-c2bc-08deedb55ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|13003099007|56012099006|10067099003|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FcR8726JVwGUp+zuULkDzfBw/cmfnUtvxlm2hbSR3QjodkyMXt8DrQaxROxfzQ9jdWxql9MOyiiWXjUxnJSUQIEb1TyrELUF8iC+gaIiedUM2dZRpYuTshyIL+pS0OYqKNPI2fygENi4vFDAUh4e0KmbIl1a6Znbiqz1SD5CEOWMRcoYoOmd26ipLOOEb/0HMuFzRh6vdXCZA5NooR4+7uJT3Zr7mVK4zdvbMWOkxzRNAr7GtLBnJ17+MggeFgkKkyrmFgqCsWRFIx7z2+4BMIoJfO/oRiBo811WcutNJ5qqjRHxjEjZGe5fGaRkrTI4QTqc1h4lxioRa2H4IopkUX1v1GmptTYrYlfWbV43XnhIQ4zvGTrumrSEQkbT57anFVvOnGpvkeJ7ckcrqam5xWOkEXumx3U9UDEr112MuH3UYhr7eQ1UrtJyj/C06+6+Kx+1i0J1dma2as1VCx6NLGdn9kKg7rvskXQdj1k7uY5CnaqUCwDAS9tfHNsjm+zAF3L4+RNFWws31efaw93BvUX0ifGL1lVCr1RPIrez+8KPIClR8EXW50V+YPcO81idy3wdi3Ui9OCcuY9Kn9XHyCkhUJWestp9E4YWNoP8DXrJlQglaS8/VWbSNI34F4vZEhxnka/LfxiDIC+I7l/ulkJM0kCYtPRP8nkR34Jj7kkDZojO8fnWrY9mWYrnLw7HO1b7b8xHiD9ENCWg5PwZTg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(13003099007)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qjrQ9qSmXIzSLnb+GIya9jnSBB/4XZc+rczn79Nojrpl1+OE01divRZkDo15R32VcuwWiBIRxFSs3hZRyFmZm5KCj1FiMH5qKROVTfW+SQzCd0cogVMuf63mc+lb/ZPziwBp6N80Iny5LlTt0rUKYVquJOMnI5yvV1ULymRS6Aapn8TCpfg9t1gTazfuULkCrEt7hEnueyfkjMhLFZJyivvP4Vhh1j2DwY8JRP7tLfmdADTkSUhmPsAyIJphGNIpX0PP1CmmtiLP9ZdTqF5++kd9nDsD25lYLDaB3dQ0Lpg+K6MupDWd0kjVofiuPxq6+0jYV+8hZTkF6DSrueTUFSt474MLl8D0z47d3FvVAMrtT7NmuCAzoyvpE0c7mn/4FZi8FsrSC/rJAWyYYnqPnpsycofRg6Nf6gbZvpzeIgPcPvAzqcH9DOGf/gpF145U
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 21:07:16.5659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a586457-bc38-4c7f-c2bc-08deedb55ea8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8355

On Tue, Jul 28, 2026 at 10:45 +0800 Linmao Li <lilinmao@kylinos.cn> wrote:

> data->batinfo is only used by bq25630_setup() to program the initial
> charge limits, but power_supply_get_battery_info() allocates it on
> psy->dev, so it stays around for the lifetime of the device. Nothing
> else in the driver uses it.
>
> Get the battery information in bq25630_setup(), just before it is read,
> and release it on every path out of that function. The driver data no
> longer has to carry the pointer.
>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Much better! However, `git` complains:

  $ git am /path/to/patch
  error: cannot convert from y to UTF-8
  fatal: could not parse patch

LKML also warns about this [1]. I was able to force UTF-8 and workaround
this though... You might want check your setup.

> ---
>  drivers/power/supply/bq25630_charger.c | 47 ++++++++++++++------------
>  1 file changed, 25 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/power/supply/bq25630_charger.c b/drivers/power/supply/bq25630_charger.c
> index 165f8c67b489..9b5f524505d3 100644
> --- a/drivers/power/supply/bq25630_charger.c
> +++ b/drivers/power/supply/bq25630_charger.c
> @@ -356,7 +356,6 @@ struct bq25630_data {
>  	struct regmap_field *regfields[BQ25630_REGF_MAX];
>  
>  	struct power_supply *psy;
> -	struct power_supply_battery_info *batinfo;
>  
>  	/* State status from IRQs. */
>  	u8 statregs[BQ25630_NR_STAT_REGS];
> @@ -668,6 +667,7 @@ static int bq25630_reset(struct bq25630_data *data)
>  
>  static int bq25630_setup(struct bq25630_data *data)
>  {
> +	struct power_supply_battery_info *batinfo;
>  	int ret;
>  
>  	ret = bq25630_reset(data);
> @@ -684,69 +684,77 @@ static int bq25630_setup(struct bq25630_data *data)
>  		return ret;
>  	}
>  
> +	ret = power_supply_get_battery_info(data->psy, &batinfo);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not get battery info\n");
> +

`dev_err_probe()` shouldn't be used here. Yes, it is _currently_ only
used from `probe()`, but that shouldn't be an assumption/"policy".
Better to let caller decide on that. I understand that it was just a
pure copy-paste from `probe()`, but we should change it do `dev_error()`
to match the rest of this function.

[...]

[1] https://lore.kernel.org/lkml/20260728024558.3611522-2-lilinmao@kylinos.cn/
