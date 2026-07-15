Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023105.outbound.protection.outlook.com [40.107.159.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA23E5ED4;
	Wed, 15 Jul 2026 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106382; cv=fail; b=IiixvdwGbZwU4PGnp7VjQwGJW0jUGT3Zyh5LSvi6r+94aW+yKbGFcLcLEqErcR4Z0eV7RYT5lA+xXBsDxqRz0WrZYnxQ3qXO8TT95GoDh1fYtm9u+zvzHyjumIi8K6H3AROscIUZ+B0i+/pl/0QgPAg3m7ituUgvw7b75p9lz30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106382; c=relaxed/simple;
	bh=xPc1XDeT/jTpsYBPfjagl3u8ipj4aijzUaJ89salKyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XwlG8tBsLPXA023p36PJTTAlN1PJNySddwWiNSp3empsHaeGsXzhNvo90bXMLTKB1fMw2/GVxpj1ee0bKPGoG0ByATR32ELxWadiOy0iJGKlyyiAU96w+Bbmbzhf7eAp0HxQbF4r2zfrGvjp1iutu7ZUBngn0ycvS+TY4H/GkFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=VZMJ962w; arc=fail smtp.client-ip=40.107.159.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="VZMJ962w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sye7Z4xfbZ/f+bglYJyIXFiKlocoAVWf7xOQjVqddFWlKBiXseLnov6SMpqRvnd4E9ZuxLANbFhi76AqEisGQnTKrJJRObkDuZMpiqGhLU6pktwmZvfOhO1La1EGlQqGSIjutssQxfw6lpuTxeeU3k4RS56Bwwpf5e1iwILylYbjA2CYZG6Q9uScM+pl3cJZvHI1Ow7jRfi3x0qkjM+nOmSL586BU7gLbJsK/a7Z5vLCoguLP7AQ+iTTpzbgjQcY6sVeEyGzFINX6wOteUUi48PFswOp7Emtr1Q+zpf9v72eQE8Yf0HusKuic91BReynt+jEOgq9NsI1IhTAbTW0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4jIKTS2vGol5HgodB5nA8th5ZHEAxg2pONte3uyDWw=;
 b=qJjnprBsYbv/i4v9qrl/iN/xzxKl1t1VnNFZHDdssMWvfmuD8J51UCKADsea01PX+KcxSE+mw66ICMdMwWfeBlQv9FjLqwwhbZQtCNrt82u3RNe/VdK8yEsftlnK10kLzCYy9SyruE8HA6/SSU4yFlh9HTqp749QX5VbNuviJFQKnM1xAVBBQvnY7vWGRsL+0MFNu7DX02zSCpYCXJL/7a3tNZRWLyEkHLH0C2cRnOiYc2I0iwhZK2oJFR4Mpy58qx2PIJY4c2HI2BRMbNEr/F07n1I27xzk90UNzXU5WMkqeTHj0dqbxB5Xl9a/JJZ7D3ceYFohL5yZD+rHpJ2t6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4jIKTS2vGol5HgodB5nA8th5ZHEAxg2pONte3uyDWw=;
 b=VZMJ962w4HAdvssFAwPTsUlKCqCJfRoEGFk4MzCUrzqWme2GkEop3fpo54mEx+rnQqtFE2bcCsR07lMbM48NaF6A7zGI6sIRs/lSA5oygfycSO6JUQZWtmvHx0pm03Qo7hF0XLwwl0DS7AMenVmu55ZdOA2RwSPtNEa945gE9CQ7Hsh1/adQ97+YnVu2o4PB+HC2WILHNnrAOq1O6tJ787DUCkJfTYVEzD6bGTjU1aVm8qp8SVdL8Hz87tMFwJUbmpe/5eqOFSNXvAPNqq63CJBdDSGKRAhQuo0hdVLpiPFs2oATzhYqMw5PDnitgJ89ahSRMUVlWsfH5lwkndwXRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GVXPR10MB5813.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 09:06:09 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:06:09 +0000
Message-ID: <5a000235-5e17-4d54-8bbe-42fda0b59db0@kontron.de>
Date: Wed, 15 Jul 2026 11:06:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] thermal/drivers/imx: Add calibration offset
 support
To: Haoning.CHENG@cn.bosch.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
 <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-3-d54d8690e16e@cn.bosch.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-3-d54d8690e16e@cn.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0329.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::12) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GVXPR10MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f78b40-51d3-49eb-c60a-08dee2504f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	vSUYK2/8YuBu3NNXJkgBGvk0nLdVNMm0i4JchrvXwyLEcC+jVM/58tbpDkEc1QoGqqTRfZGQikqogP6tasrkHd65SJ5asR1MScNlYLsYrl+dtdkEinyXdmqQs9VnMEoI5AI20/uSUDpGxmmn5Wrvc4fsWyNgV0Q/YCPDYN/FTv4vt4jGX8EJdR1lac0UJyNyolfl6sj7sfah/rmlpQtlC/pLM1OUm5w0WiAUeQYprRyCSi8q2wmnvh2fie2cULOwmOSdKw5PdJfgQbV/x2wYsDZErGSRfvGf1kLl2vwnqO1B7iUQDRK/t4Zj94TJz+Eli7DiyIw+F3tX0WUcM9pJKCGssFEyglwJxBU436ILYpUdhNRwotog+hQrHLZEk/Uw7bZ483zrPLt3lrTVZuxQYlfmJXpunugotFCz7pPZiHja4IQfzwax2ZrfqDFWrmxDWPkbglQYljKghIUX98UEg0HbPQKuedD+C/AKM8uUaXtFmC8Pn78ICfFlpJ34jjo5E2p5Jbi3KBP7flEwW8IWVNJQxsqJ8tStN+yMLp8rVxeE0I0/Zk8PjdUrY5fZWmh5QxcB8OGpBZYOHANCeAfOsGi4zbAEYvAe8AjP+wIbVlkCSaHe5bbETUhLBQ70kJwcQAzX3UaRnd3q6CMVuvfv+3A2kEdtcC3HkvS2IZyrgHwttdNdy10boO1VLcpePn6hwQ/poWvCp20ypWOeFi8oXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0w5RHVrS0hBWTZsQll5YzB1eE1ROTlFeVZzT2JpdjNMSVBaVTVLTjR1T29Q?=
 =?utf-8?B?WUNLMnozTGpRKytlMWJKdTNkelh3RjR6NHdKSnI0M0NiZ1dJbWNHSUNyN2FD?=
 =?utf-8?B?aS9uVXVMTzdOa2pINEd5N25WdTVxaHRLc2laWXBIUlFwOUt4M3U0MHJRTExv?=
 =?utf-8?B?SE9yMEZFQXZhZDc5WExGbmJTWC8wajhHZWNucm1lYWxjQ3crV205TG5jalJo?=
 =?utf-8?B?UzF3UElmRll3cGMxNUZCVDM1Q2VNNVNnZ0xkWktrVDZoUWJCMndZd0Z2dWZX?=
 =?utf-8?B?Tlh5WGVLaGNRZ3Vva2NvNXg4VmVBczN2U1hEblV6NGFYRDhvOXU4VTBpRm9K?=
 =?utf-8?B?cXJncnVoOHNpOVNUM3FGbUk0NXNybTgyQjBldDBqT3lVSkgySXlVUjdMbjd6?=
 =?utf-8?B?R09GUU53RmN5cTduN2ZjQzVqV1Z6cUR1b091dmNMWmgxQ0lvLy9NckdpVksv?=
 =?utf-8?B?VmpEUmdkRC8wSnBSVEJPYm1sNkF3eXk5cURxdGwwTkRRcmVVbVJ6azlmbGsx?=
 =?utf-8?B?UFB2THo3cmppUTVWdm84U2hoQ1p2RVJvQzU5bmZLcThnc1FaQ2JHV1pKTUlO?=
 =?utf-8?B?SFNwSEhYNm1WRWJFQzN2MUZHcS9PVytUbC9kWmhXZG0xTERFN01aM285a0dF?=
 =?utf-8?B?MGg5eUJVM3VzS1ZUbjFuSFJkR25IWFR4dmJ4MDZFdkc4Zy9ocEs0WTJmbEd3?=
 =?utf-8?B?VzRFcC92a0ZCRzNBWE5CSmRVNS9SK04xMER2MDdVOHE4Uko5SjRyZ1hmaElN?=
 =?utf-8?B?MmNseFUvVkgxdW1TdnVQUVp3NjExbXNkd2tMYkhacXpZOHQ1R3U0ZnowUk1s?=
 =?utf-8?B?MGltc1lOVUJNVGpvZjZ2dzNnb0J6WXJ5bkowSlZ4KzFBRnh3TitLK3ZLVENG?=
 =?utf-8?B?ZFFOWU5hRnlWcUtFRy9neHp4V1hLaHpIRmdYWEo2bTIrZkRpWk5paHJya1FO?=
 =?utf-8?B?WkhKUXhMTUE0VlVXUnVWbytITGRGTjBDQWJ6MFBxZjVmb1J6dnpYR0s5SG1i?=
 =?utf-8?B?cDJ1cnF4OVlPQUVuVWhjQTJmdWNpSjJCc21wVFFiT2ZtMW4zaUVQOFRNdWh3?=
 =?utf-8?B?cnhjcUpnVjRwTG1XLzhRWmVqbzBjWXlldzA4WnIwTmJmMUdiT0xUY2MyU1dF?=
 =?utf-8?B?YktwdWozcjNqWlJCdmxjM0RuUWk3YVlNbW1UNlhPaFh1ZFl2OG1JczRjbHZj?=
 =?utf-8?B?bDhxRVZTRjhLbXA2c25BOEVZMm96MGdNSE95VHZySThmaVlaZzhJT1plZHBV?=
 =?utf-8?B?a09KZTNOTjJlQ3RPdXhHS1hwblZ6TUtRaTlIOFpWeVNvNzlKallwM3pnV2FQ?=
 =?utf-8?B?SmV1Rmora0ZQUnBEVWpVTUJ2MGVleHRYalYyYVg0K3lSZ0lSVzVKSFRkZjZT?=
 =?utf-8?B?L2o3YStPUVozSCtGNG1TTDBCMVhxbzhucG9nQ3c4WVQ0b1ZveWVNc2xaWC9R?=
 =?utf-8?B?MFlpMG40Y3BlbEE0bzNkcEJIUW5VYXNIZFRqallGTnpwM0k5enV5ZHlSSDZt?=
 =?utf-8?B?U3lacFRwZ0RkWXFuei8zQzVKRUk5MFcvU0dlbHFReUZySlBYWnE1cmU5Wk1O?=
 =?utf-8?B?RCtMQjhtekZtdFJWdy90MWxMV2JrdGlJY0lLUklIM05Uc0lRNkcxLzhFRFgy?=
 =?utf-8?B?TS8wVW5RSVFCeHY5Vm9MZWpaenh5SnRWYTlNaC9mbnBJaVh0cmwrY3M2bzRq?=
 =?utf-8?B?cVN5ZnZDZE1FMGRyL0N2WW5lNEJXWGFleE1VY05TK1ltdzU0QzdTdkR2Vkd1?=
 =?utf-8?B?ZGNybXNwWG5BY2NHTVlPVFFjZUV6SU54RXUvb3NZOTFUL0FSSlNkRkJjUFRB?=
 =?utf-8?B?Z0cxUlBlNW9ZYnZJeHdyOCs4bFBmU3U2RkQybmk2TUV0TkFvb2YrdkVNVHV6?=
 =?utf-8?B?TjAxOU9nRTlrdVB2M0c3UENWREdJQkpzWXR3cTM1MDlqT1I1Z1RhR0QxT1lT?=
 =?utf-8?B?dm5HaW5VYStvK09ZOFRLZDd5TW5jKytmRHNrV0oyZWNmQmhRaFQwekw1TXJp?=
 =?utf-8?B?Rm8yR3dnU0RYcTFTZndMWkNyQzBrOFZOZWNrT3U1QXgwNzI0d1RkR3JiREdV?=
 =?utf-8?B?WVBlY0h4NFYzZk56cVZ3K1dTbU9aclFDUUxvcmM4WFMrcVc0b1pYcFhFRUlS?=
 =?utf-8?B?Mmc4TWlXMHE5ZjRFTXpHWFF1Vm5nUHUwSnAxc3p4S3o4MlJOMm4wTlVnKzFS?=
 =?utf-8?B?ZmM4ZVJEQTFESjRkYnk3cjhLVFk2WnBOQnZsUnNvdEh1azNrU2VNSkpqM1lX?=
 =?utf-8?B?T21CR2FkNFBtQmtieENNZWxTd3k0cDJrOEwxZGlTT09DL1BzQ1NWdlNmaGRk?=
 =?utf-8?B?U0wweTFrOGxvOXVGYVZlamtTc043LzU0UVVlU3A2T0Fuek0rRWp0Y0ViUU9I?=
 =?utf-8?Q?cMwOtXc3AbcYwMkU=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f78b40-51d3-49eb-c60a-08dee2504f5b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:06:09.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aISbe6fgV3obn47Ob3nFMiByO5VI5yocLA7ozz6y0MODR4iEjHjOagAUyy4BT5mTwHpofl1JZW1Yh/oD3mQDcE+Np8tz4OuzPW5qP1Xi4C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5813

On 14.07.26 12:28, Haoning CHENG via B4 Relay wrote:
> From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
> 
> Some boards need a small per-design correction to align the reported CPU
> temperature with board-level measurements. Read the optional
> fsl,temp-calibration-offset-millicelsius property from DT and apply it
> uniformly to the i.MX6/6SX/7D calibration formulas.
> 

Sorry to chime in so late. I just want to understand what this
calibration offset is about. Why would there be a need of a
board-specific offset? The sensor is in the SoC and if you add a
board-specific offset, you no longer measure the SoC core temperature,
right?

How would you determine the offset in the first place? How would I know
what fsl,temp-calibration-offset-millicelsius should be set to? I could
put a sensor on the SoC case and use the delta as offset, but then I
would just account for the thermal resistance of the casing and not
measure the SoC core temperature anymore, right?

Maybe I'm just missing something obvious here, so if anyone could
enlighten me that would be appreciated.

Thanks!

> The offset is applied symmetrically at two points to ensure the thermal
> framework sees calibrated temperatures while hardware thresholds remain
> correctly positioned:
> 
> 1. In imx_set_alarm_temp() and imx_set_panic_temp(): the temperature
>    threshold is *subtracted* by the offset before being converted to a
>    hardware register value. This shifts the hardware IRQ trigger to the
>    physical temperature that corresponds to the intended threshold.
> 
> 2. In imx_get_temp(): after computing physical temperature from the
>    hardware register, the offset is *added* back. The thermal framework
>    always sees the calibrated temperature.
> 
> For example, if DT sets offset = +3000 m°C (board reads 3°C too low)
> and the passive trip is 95°C:
> 
>   imx_set_alarm_temp(95000):
>     alarm_temp = 95000 - 3000 = 92000
>     → hardware register programmed for 92°C physical
> 
>   Hardware IRQ fires at 92°C physical
> 
>   imx_get_temp():
>     reads hardware, computes 92°C physical
>     *temp = 92000 + 3000 = 95000
>     → thermal framework sees 95°C → correct trip
> 
> When the property is not present, the offset defaults to 0, preserving
> the current behavior.
> 
> Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
> ---
>  drivers/thermal/imx_thermal.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 7f7d1116b9d6..d471acc16bce 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -85,6 +85,10 @@ enum imx_thermal_trip {
>  #define TEMPMON_IMX6SX			2
>  #define TEMPMON_IMX7D			3
>  
> +/* Calibration offset limits (±20 °C in millicelsius) */
> +#define IMX_TEMP_CALIB_OFFSET_MIN	(-20000)
> +#define IMX_TEMP_CALIB_OFFSET_MAX	20000
> +
>  struct thermal_soc_data {
>  	u32 version;
>  
> @@ -207,6 +211,7 @@ struct imx_thermal_data {
>  	struct regmap *tempmon;
>  	u32 c1, c2; /* See formula in imx_init_calib() */
>  	int temp_max;
> +	s32 calibration_offset;
>  	int alarm_temp;
>  	int last_temp;
>  	bool irq_enabled;
> @@ -223,6 +228,7 @@ static void imx_set_panic_temp(struct imx_thermal_data *data,
>  	struct regmap *map = data->tempmon;
>  	int critical_value;
>  
> +	panic_temp -= data->calibration_offset;
>  	critical_value = (data->c2 - panic_temp) / data->c1;
>  
>  	regmap_write(map, soc_data->panic_alarm_ctrl + REG_CLR,
> @@ -239,6 +245,7 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
>  	int alarm_value;
>  
>  	data->alarm_temp = alarm_temp;
> +	alarm_temp -= data->calibration_offset;
>  
>  	if (data->socdata->version == TEMPMON_IMX7D) {
>  		if (alarm_temp >= 0)
> @@ -283,6 +290,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
>  		*temp = (n_meas - data->c1 + 25) * 1000;
>  	else
>  		*temp = data->c2 - n_meas * data->c1;
> +	*temp += data->calibration_offset;
>  
>  	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
>  	if (data->socdata->version == TEMPMON_IMX6Q) {
> @@ -635,6 +643,25 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, data);
>  
> +	if (of_property_present(dev->of_node,
> +				"fsl,temp-calibration-offset-millicelsius")) {
> +		ret = of_property_read_s32(dev->of_node,
> +					   "fsl,temp-calibration-offset-millicelsius",
> +					   &data->calibration_offset);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to read calibration offset\n");
> +
> +		if (data->calibration_offset < IMX_TEMP_CALIB_OFFSET_MIN ||
> +		    data->calibration_offset > IMX_TEMP_CALIB_OFFSET_MAX)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "calibration offset %d millicelsius out of range\n",
> +					     data->calibration_offset);
> +
> +		dev_dbg(dev, "calibration offset: %d millicelsius\n",
> +			data->calibration_offset);
> +	}
> +
>  	if (of_property_present(dev->of_node, "nvmem-cells")) {
>  		ret = imx_init_from_nvmem_cells(pdev);
>  		if (ret)
> 

