Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012085.outbound.protection.outlook.com [52.103.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057EA3E1215;
	Mon, 27 Apr 2026 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310050; cv=fail; b=hEAEEjb+0xhhqdTT6UGl8YkRuG07B9/hFxAdcb/5kwkZpinwlf+8AX8Fb9GjemSoUv7GY6PlA8nBt652BOF9N+/Ox7jNvMlbEAOqgk+TZiBlVWvNTeiu+IYzkQVRHagYZlegYh+DfPnqcAGdBiaLVzOMoIXFn7NRVGPj3xY+WtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310050; c=relaxed/simple;
	bh=rPlsXsLJmemjkM+lztuSoNYmdSZRU0YRAl0MHlFHlnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r+oloiRSFxi9LwubVMfvcmhXA3bX3DKpTtEAVs5XyCIX9zOVq162BS46/LCahrG48tapyKBSB43FKGJY592UI3HM/BgwqCWE6SUEVdUN4A7CBZmg2x9qslwkJikQjzwWANCUiKvh7YyLraoFSd/tp/qjPIFkhAJX5keBYmDTLFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=b+zy4chC; arc=fail smtp.client-ip=52.103.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="b+zy4chC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldfguIrQbVDXFsw5l8ozALc3en5YNIHnPcVsM+LuYjM7D+EzYsQrSFZWvPpu7QW0MDoVZzWtsB2G2sHrwb6f4kXGE59Lfe1ts3XtZFhCeKIPKs4nNYi2RYDTkr70CtxxGEN58e77f+5bpt9Acgr8j1tvysU1UfsXQEbF9RK6fthXqa7lvdWfaSUNVVYS7H9kXx3cfOQ+Bl3XKZyyXj/oe/PCBGobKvd2Smzhu7za4rL/7iF/6NisxereX1mXP9BR5PDMEAmBCT7cL3jeKUx+8w7j+4P8tw7i2DNOwwkY/cCe3TuKBEThFqh28GNtlusl5KBNXDsrZbpFrAeI2DKWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8fxxsHABf9FjMAykeHravNkjM6uUDzlq032qCCvkSE=;
 b=O7ciK74xw5CZTtqJKvGpWCbxYn65EoKxROLeKbS9JAfhBpypJDLPknzS0c2yXHd4cON6E2sCZm7SPtIoVDRUiXx/8A6XVdBIHoFtWr0SKAIHNCne4te0HiHW6y7bG+rpYfu1AK+qfqAqaHqjt5tkZV8pV8cB+jko6Q23H5PhjRXvMrr3ql9U6GuFdqXU7ommr57zyM/4DuoexeNVlWzPBXVtptsJ1wyarGs6ij5J9SSUmmKmalsGzZAicVzZeiRHMHEEmXNxXnkgjbQ7BBbvs1dRZKKdQSiHHCxLDCaKUOmdCWWqZn9xvK8fXaws1feomhtNRz5G+dXbN4CKH0oT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8fxxsHABf9FjMAykeHravNkjM6uUDzlq032qCCvkSE=;
 b=b+zy4chCdkfsHTXsClRDM78cAmEGgUxHcSlBHUq1XfzamHD5ozZsnb8K5GX+Lm0bhpaYD2nqeeAtXZSsJjWT/mWX0HNvgWqZZdYHgEJxhsZszE5UKKfbdUkU7yugZZEA0PLzcHse5x2wZ9SO8ejoH4RWWWgbGWisEd/fvky7NSe9+2/iQ9JmJHaC9lK+oQXPiZtm7u9FV6e/Uyf70YJkfDInfxAgSkT9cuw5+jI0ONxzyb3iNezVpun1bFZ7BQd+lUh06L4Gb+9GkJ9p5SH0Z6utf1Vpmurp7e9wv6zY7x8srEPHrD1OygYDBtiJxvB0LfBS9q6ix2dYBvU6Xcs3BQ==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by BN5PR19MB8816.namprd19.prod.outlook.com
 (2603:10b6:408:2ac::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 17:14:01 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 17:14:01 +0000
Date: Mon, 27 Apr 2026 12:13:57 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	xsf@rock-chips.com, sre@kernel.org, simona@ffwll.ch,
	airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, jesszhan0024@gmail.com,
	neil.armstrong@linaro.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: rockchip: Add Anbernic RG Vita-Pro
Message-ID:
 <PH0PR19MB997338E09EB1F271D6FC8F35C7A5362@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-7-macroalpha82@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427170914.5062-7-macroalpha82@gmail.com>
X-ClientProxiedBy: SA9PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:806:24::28) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ae-ZVTaTzR3EoTMO@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|BN5PR19MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: db90d974-2d09-490d-48ba-08dea4806065
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|461199028|5072599009|37011999003|10092599007|25031999004|23021999003|8060799015|41001999006|6090799003|15080799012|19110799012|53005399003|41105399003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cfeLS+sDhTGzqajUzh1EVmrvgh5glpjTNts9I+xjDLVQngP7RzNs0wWfUXo7?=
 =?us-ascii?Q?SX0xE8gCp4vQLcctRPjJ8TUc5+jr2YRMDkC2u8Gjo12zKpDJl4R9nGxf1fFJ?=
 =?us-ascii?Q?91Q/Bir/YH6kX6ejwcGrn69ahsNlHxnHs5O+TnA2n0NFBxxH7PWQ7kOJljFj?=
 =?us-ascii?Q?XWjc5zL9EMOfaGHi8UAlInTUBOsHhFECaM7CLtDbFrPHZ2KbqYDPQRJ5we5z?=
 =?us-ascii?Q?iMgJFxUZzqqIpzgXlOb+lTCx1/sK+8M+jgX5K7ggXkdvmZ0NCd9EgjDbh0zn?=
 =?us-ascii?Q?9Bo2rLcjqhmqsdYsSvwnhBdfdbLrK1oOgH1htViwNheFX5AYNvd99KTjSv1p?=
 =?us-ascii?Q?1uupLpcp/E3yATBdDEYWocBcbHT1t9UN2Mw31jr59Z6DmgUEQ3NXak9oGEHs?=
 =?us-ascii?Q?duAVBmRe/ip0DBO/3847mJEiF5wwRMeL+KOKmgMe+yf3lDOHFvGKxKFmzaax?=
 =?us-ascii?Q?adtm3HpBk14mTvmCcj9PGJiZ75OLlw8TZ1itt6IXniCebVKVhsnLYx9oCEDP?=
 =?us-ascii?Q?nJePCDz+NblcsEX12cR+lPhoSPT8FQTFkqhps27Ufm58KVxMHcZcoU2J/6lt?=
 =?us-ascii?Q?dwzuce5kcB9n378z8/YLVZjavK2jhJnwE0k+rnOXWZjcocSAywI1V9Z2xz55?=
 =?us-ascii?Q?lD4SMsVTNQqyTasuRgNnJOJQB3UESJWtIPFFhAOjltaFJnkTH3iEKmLRZTdM?=
 =?us-ascii?Q?mQymDv8qvPTkqkCOBEgyoXA/ro4aDSWbBJckbcC1CWuwzc7+VQznznDivnuA?=
 =?us-ascii?Q?sSfBlfRODdJcnOZVY0iNANhWm85lT9PipWuLY2xC6wouGq6pQr/7dIfUFyKK?=
 =?us-ascii?Q?Wa9bJlFN0YVLrEXa4DkXc3M8u5Xrcazz4LqehBsYMv5B44hai2tpYFAQJ+ho?=
 =?us-ascii?Q?6EDpXPz4sB4ualehOSpHjEPf3Y2AK87OojxGEfYkWy0BoJwf2SW95gClxtCu?=
 =?us-ascii?Q?lgfBOr37rcPffjPyo9hp+93eI+tAkfQ0tHCxYbmTedupwO9Z0AZqn0I8GWeR?=
 =?us-ascii?Q?0S3FcbXaJjMpPecdKtsDJcA57lpD1qW2kOrrKq1K+mOlZhF6SrnICIRlxlfz?=
 =?us-ascii?Q?X5jpftGdlikNqjamMTzkSWC+1sDgG+v6yY0qyqUu6HRDTcqa2Qfifob6mg9s?=
 =?us-ascii?Q?6lbWJqbBPSIr?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZMs+whPSRHphXCHwIwMeQ+PPzs9T1Gv0QSC75ARMGFh3YWbttEyT8m2qYEsn?=
 =?us-ascii?Q?FQztD7SKM3axHZvt6iMv09+Ui/+bGm/Q4r0CnxOqQQdPvHg3Q2AWXMLM6AQM?=
 =?us-ascii?Q?qeUGl2LBQiUN+UxpuQiYFEvWYoBVdLcoz8X6Drdvi8IzZgMr9tSHCwfuFtIe?=
 =?us-ascii?Q?IhEtdAcboBJd/Gdec7b+dFHGJW8A+VcNM6jVAfi/3KRhRBKfAGSyO3DfWrsQ?=
 =?us-ascii?Q?fSoaycj8Ed7tb0vtbW6Pru73YYoLt0Lh3nRJut5asnFZ5ze9fce6kzMe9SY1?=
 =?us-ascii?Q?eWujqv11NKV3CsR5Hfq9RZk+SZ7h981/IQrEbfJkunjAhvk+3nymotC/DaWH?=
 =?us-ascii?Q?WtEHuI6P+A2Xcl8buhfmpmf0tHhauVyR+gyKGPTeC4yhViEyvjH4GpKV4X6O?=
 =?us-ascii?Q?OBzyjlYfUOECrvi+UHl97tYdX1+PjqMzmfkcKlZOV50rKp5xESIK8N3bbqHy?=
 =?us-ascii?Q?uDhWK2PKN6DrCjiTcLVaTR+cuYZmnvHvAfntIzjorLVaizOiIHKcjNP2D+CO?=
 =?us-ascii?Q?HzYanzpfeCBccpmg6ifPRsdZ/CoLGjRhnSp1e81s3j/GRk/Lplu7DWyQgcWI?=
 =?us-ascii?Q?plQ4FLr+vMNBym48x6WIvJcMqELCkmxJUzVzgfjeot0FXWq9B8tqnSkCqyVJ?=
 =?us-ascii?Q?t6WCLQVm54rmHE80KmmxMtTXs4f7e4IHXJWcFociPh1b3xWAEUdI02VurW1U?=
 =?us-ascii?Q?siy3Y40Wh1FV3LGcwLX2NX/UtTLH1GfG0BW+upyFJN+VuM7+Kuy9ey8+K0QK?=
 =?us-ascii?Q?vq6J7UGftcp1bnuabKBLh1P5cFX9x+Ualhdg8YKTOiaz84eVUdwehGfXdY8O?=
 =?us-ascii?Q?nMQIADH5n21Ql3Ku6raP9cSZSXdH4F5O/EpOsH/HAApfxUVmmD2E8gdDp47F?=
 =?us-ascii?Q?WaFywW65LXmp+gjhEzPHhH2O0vByBKIS0ThzaJJztyd+nFGinGF1kh9zpUkh?=
 =?us-ascii?Q?N/yNi1AoIrlrV8DAyhtDCalHB4PVIUMXeO6DvCxfQAshf5mGohcg5kqgDNTR?=
 =?us-ascii?Q?1WKQDaRKEQMEk9828EF28oTmqTa3uGqLzPvzatOY1bhDMhaq6ncaSxM7pW4N?=
 =?us-ascii?Q?7tI+HSw7L9/xGLiWo6RgvCqL59etMgU99WtnANnnXr+NGbdraRorPvCCrrdn?=
 =?us-ascii?Q?bj0swCJ5/YBZeUnIm2uFHYEYASLG5pfw/i01xpUrqR1soVL+NN/AHZdYR0Yb?=
 =?us-ascii?Q?MMnKolB/DqWY+O9SSxryEavYUK60KxmSzmUqkGjvv+Qto+sJnUDAB4R42F+M?=
 =?us-ascii?Q?uBWnUhGvaVR4cgthIoHyIXQHAMIZAS5T7QSqO/GnezFDRkSUaDTn69zAWJZ+?=
 =?us-ascii?Q?jjwOJRfl6rxOoEcMsgO160EkEpc3XbOqRMyDkqnRXa5KPdYgm7n1TsmbtlTs?=
 =?us-ascii?Q?WHPb7aZdtas3+5Z+rouzXygF4kREzrDuUWdOWq/3o33rcg0eng=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: db90d974-2d09-490d-48ba-08dea4806065
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:14:01.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR19MB8816

On Mon, Apr 27, 2026 at 12:09:14PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add device tree for the Anbernic RG Vita-Pro, based on the Rockchip
> RK3576. All hardware is currently working except for the accelerometer,
> the touchscreen, the battery monitor, and DisplayPort over USB-C. PWM
> is also missing currently, and as a result the LEDs and panel backlight
> are currently controlled via GPIO but will be changed to PWM once
> supported.
> 
> The Anbernic RG Vita-Pro includes the following hardware:
>  - A 1080x1920 DSI display with touch.
>  - 21 buttons.
>  - 2 Analog joysticks controlled via userspace.
>  - 3 LEDs.
>  - 64GB eMMC, 2 SDMMC slots.
>  - RTL8852BE WiFi/Bluetooth combo
>  - 1 USB 3.0 USB-C port in OTG mode.
>  - 3.5mm headphone jack with play button support.
>  - 5000mAH battery
> 
> The following hardware has incomplete driver support and is not yet
> working:
>  - An Invensense icm42607p accelerometer.
>  - A Cellwise cw221x battery monitor.
>  - A Synaptics i2c touchscreen.
>  - DisplayPort over USB-C alt-mode.
>  - PWM controller.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |    3 +
>  .../rockchip/rk3576-anbernic-rg-vita-pro.dts  | 1317 +++++++++++++++++
>  2 files changed, 1320 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index cb55c6b70d0e..78c3778eaf4e 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -165,6 +165,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-100ask-dshanpi-a1.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-anbernic-rg-vita-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5-v1.2-wifibt.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-evb1-v10.dtb
> @@ -215,6 +216,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-coolpi-4b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-gameforce-ace.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-indiedroid-nova.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-indiedroid-nova-tower.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-indiedroid-nova-test.dtb

Please disregard this. I just noticed some of my local branch leaked into
my commit. I'll do a V2 with these removed once I get feedback on the
rest of the series.

Thank you.

>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-khadas-edge2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts b/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
> new file mode 100644
> index 000000000000..9dcf3f5a12d1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
> @@ -0,0 +1,1317 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2026 Chris Morgan <macromorgan@hotmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include <dt-bindings/usb/pd.h>
> +
> +#include "rk3576.dtsi"
> +
> +/ {
> +	model = "Anbernic RG Vita Pro";
> +	chassis-type = "handset";
> +	compatible = "anbernic,rg-vita-pro", "rockchip,rk3576";
> +
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +		mmc2 = &sdio;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:1500000n8";
> +	};
> +
> +	adc_keys_home: adc-keys-home {
> +		compatible = "adc-keys";
> +		io-channel-names = "buttons";
> +		io-channels = <&saradc 1>;
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <60>;
> +
> +		button-home {
> +			label = "HOME";
> +			linux,code = <BTN_MODE>;
> +			press-threshold-microvolt = <1750>;
> +		};
> +	};
> +
> +	adc_keys_play: adc-keys-play {
> +		compatible = "adc-keys";
> +		io-channel-names = "buttons";
> +		io-channels = <&saradc 3>;
> +		keyup-threshold-microvolt = <1300000>;
> +		poll-interval = <60>;
> +
> +		button-play {
> +			label = "PLAY";
> +			linux,code = <KEY_PLAYPAUSE>;
> +			press-threshold-microvolt = <1750>;
> +		};
> +	};
> +
> +	/*
> +	 * Values from BSP, except for internal resistance which was set
> +	 * to 80 micro ohms which is more likely 80000 micro ohms.
> +	 */
> +	battery: battery {
> +		compatible = "simple-battery";
> +		charge-full-design-microamp-hours = <8000000>;
> +		charge-term-current-microamp = <300000>;
> +		constant-charge-current-max-microamp = <10000000>;
> +		constant-charge-voltage-max-microvolt = <4350000>;
> +		factory-internal-resistance-micro-ohms = <80000>;
> +		precharge-current-microamp = <180000>;
> +		precharge-upper-limit-microvolt = <3600000>;
> +		voltage-max-design-microvolt = <4350000>;
> +		voltage-min-design-microvolt = <3000000>;
> +	};
> +
> +	hp_amp: audio-amplifier {
> +		compatible = "simple-audio-amplifier";
> +		enable-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&hp_amp_enable_h>;
> +		pinctrl-names = "default";
> +		sound-name-prefix = "Headphone Amp";
> +	};
> +
> +	/*
> +	 * LEDs and Backlights can be controlled as a PWM, but PWM
> +	 * driver is not yet available.
> +	 */
> +	gpio_backlight: backlight {
> +		compatible = "gpio-backlight";
> +		gpios = <&gpio2 RK_PC4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&led_backlight_h>;
> +		pinctrl-names = "default";
> +	};
> +
> +	gpio_leds: leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&led_amber_h>, <&led_green_h>, <&led_red_h>;
> +		pinctrl-names = "default";
> +
> +		charging-led {
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_CHARGING;
> +			gpios = <&gpio3 RK_PA4 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		full-led {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		bat-low-led {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_ALARM;
> +			gpios = <&gpio3 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio_keys_control: gpio-keys-control {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&gamepad_keys_l>;
> +		pinctrl-names = "default";
> +
> +		button-a {
> +			gpios = <&gpio3 RK_PB6 GPIO_ACTIVE_LOW>;
> +			label = "EAST";
> +			linux,code = <BTN_EAST>;
> +		};
> +
> +		button-b {
> +			gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +			label = "SOUTH";
> +			linux,code = <BTN_SOUTH>;
> +		};
> +
> +		button-down {
> +			gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_LOW>;
> +			label = "DPAD-DOWN";
> +			linux,code = <BTN_DPAD_DOWN>;
> +		};
> +
> +		button-l1 {
> +			gpios = <&gpio3 RK_PD7 GPIO_ACTIVE_LOW>;
> +			label = "TL";
> +			linux,code = <BTN_TL>;
> +		};
> +
> +		button-l2 {
> +			gpios = <&gpio3 RK_PC1 GPIO_ACTIVE_LOW>;
> +			label = "TL2";
> +			linux,code = <BTN_TL2>;
> +		};
> +
> +		button-left {
> +			gpios = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
> +			label = "DPAD-LEFT";
> +			linux,code = <BTN_DPAD_LEFT>;
> +		};
> +
> +		button-menu {
> +			gpios = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
> +			label = "HOME";
> +			linux,code = <KEY_HOME>;
> +		};
> +
> +		button-right {
> +			gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_LOW>;
> +			label = "DPAD-RIGHT";
> +			linux,code = <BTN_DPAD_RIGHT>;
> +		};
> +
> +		button-r1 {
> +			gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_LOW>;
> +			label = "T2";
> +			linux,code = <BTN_TR>;
> +		};
> +
> +		button-r2 {
> +			gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_LOW>;
> +			label = "TR2";
> +			linux,code = <BTN_TR2>;
> +		};
> +
> +		button-select {
> +			gpios = <&gpio3 RK_PD6 GPIO_ACTIVE_LOW>;
> +			label = "SELECT";
> +			linux,code = <BTN_SELECT>;
> +		};
> +
> +		button-start {
> +			gpios = <&gpio3 RK_PD3 GPIO_ACTIVE_LOW>;
> +			label = "START";
> +			linux,code = <BTN_START>;
> +		};
> +
> +		button-thumbl {
> +			gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
> +			label = "THUMBL";
> +			linux,code = <BTN_THUMBL>;
> +		};
> +
> +		button-thumbr {
> +			gpios = <&gpio3 RK_PC4 GPIO_ACTIVE_LOW>;
> +			label = "THUMBR";
> +			linux,code = <BTN_THUMBR>;
> +		};
> +
> +		button-up {
> +			gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +			label = "DPAD-UP";
> +			linux,code = <BTN_DPAD_UP>;
> +		};
> +
> +		button-x {
> +			gpios = <&gpio3 RK_PB4 GPIO_ACTIVE_LOW>;
> +			label = "NORTH";
> +			linux,code = <BTN_NORTH>;
> +		};
> +
> +		button-y {
> +			gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_LOW>;
> +			label = "WEST";
> +			linux,code = <BTN_WEST>;
> +		};
> +	};
> +
> +	gpio_keys_volume: gpio-keys-volume {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +		pinctrl-0 = <&vol_keys_l>;
> +		pinctrl-names = "default";
> +
> +		vol-down-key {
> +			gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_LOW>;
> +			label = "VOLUMEDOWN";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +		};
> +
> +		vol-up-key {
> +			gpios = <&gpio3 RK_PD2 GPIO_ACTIVE_LOW>;
> +			label = "VOLUMEUP";
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +	};
> +
> +	hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "c";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	rfkill {
> +		compatible = "rfkill-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_en_h>;
> +		radio-type = "wlan";
> +		shutdown-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	sound: sound {
> +		compatible = "simple-audio-card";
> +		pinctrl-0 = <&hp_det>;
> +		pinctrl-names = "default";
> +		simple-audio-card,aux-devs = <&aw87391_pa_l>, <&aw87391_pa_r>,
> +					     <&hp_amp>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,hp-det-gpios = <&gpio4 RK_PA4 GPIO_ACTIVE_HIGH>;
> +		simple-audio-card,mclk-fs = <256>;
> +		simple-audio-card,name = "rockchip,es8388-codec";
> +		simple-audio-card,pin-switches = "Headphones", "Internal Speakers";
> +		simple-audio-card,routing =
> +			"LINPUT1", "Mic Jack",
> +			"LINPUT2", "Mic Jack",
> +			"RINPUT1", "Onboard Microphone",
> +			"RINPUT2", "Onboard Microphone",
> +			"Headphones", "Headphone Amp OUTL",
> +			"Headphones", "Headphone Amp OUTR",
> +			"Headphone Amp INL", "LOUT1",
> +			"Headphone Amp INR", "ROUT1",
> +			"Internal Speakers", "Left Amp OUT",
> +			"Internal Speakers", "Right Amp OUT",
> +			"Left Amp IN", "LOUT2",
> +			"Right Amp IN", "ROUT2";
> +		simple-audio-card,widgets =
> +			"Microphone", "Mic Jack",
> +			"Microphone", "Onboard Microphone",
> +			"Headphone", "Headphones",
> +			"Speaker", "Internal Speakers";
> +		status = "okay";
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&es8388>;
> +			system-clock-frequency = <12288000>;
> +		};
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai1>;
> +		};
> +	};
> +
> +	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <1100000>;
> +		regulator-min-microvolt = <1100000>;
> +		regulator-name = "vcc_1v1_nldo_s3";
> +		vin-supply = <&vcc_3v8_sys>;
> +	};
> +
> +	vcc_2v0_pldo_s3: regulator-vcc-2v0-pldo-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <2000000>;
> +		regulator-min-microvolt = <2000000>;
> +		regulator-name = "vcc_2v0_pldo_s3";
> +		vin-supply = <&vcc_3v8_sys>;
> +	};
> +
> +	vcc_3v8_sys: regulator-vcc-3v8-sys {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <3800000>;
> +		regulator-min-microvolt = <3800000>;
> +		regulator-name = "vcc_3v8_sys";
> +	};
> +
> +	vcc3v3_sd_s0: regulator-vcc3v3-sd-s0 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&vcc_3v3_sd_s0_h>;
> +		pinctrl-names = "default";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "vcc3v3_sd_s0";
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vcc_sdio: regulator-vcc-sdio {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vcc_sdio";
> +		gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&vcc_sdio_h>;
> +		pinctrl-names = "default";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <1800000>;
> +		states = <1800000 0>, <3300000 1>;
> +	};
> +
> +	vcc_wifi: regulator-vcc-wifi {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_wifi";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&vcc_wifi_h>;
> +		pinctrl-names = "default";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-state-mem {
> +			regulator-on-in-suspend;
> +		};
> +	};
> +
> +	vdd_lcd: regulator-vdd-lcd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_lcd";
> +		regulator-always-on;
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&vdd_lcd_h>;
> +		pinctrl-names = "default";
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&combphy0_ps {
> +	status = "okay";
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_big_s0>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_big_s0>;
> +};
> +
> +&cpu_b2 {
> +	cpu-supply = <&vdd_cpu_big_s0>;
> +};
> +
> +&cpu_b3 {
> +	cpu-supply = <&vdd_cpu_big_s0>;
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&dsi {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	panel: panel@0 {
> +		compatible = "anbernic,panel-vita-pro";
> +		reg = <0>;
> +		backlight = <&gpio_backlight>;
> +		enable-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcd_enable>, <&lcd_rst>;
> +		reset-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
> +		rotation = <270>;
> +		vdd-supply = <&vdd_lcd>;
> +
> +		port {
> +			mipi_in_panel: endpoint {
> +				remote-endpoint = <&mipi_out_panel>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsi_in {
> +	dsi_in_vp1: endpoint {
> +		remote-endpoint = <&vp1_out_dsi>;
> +	};
> +};
> +
> +&dsi_out {
> +	mipi_out_panel: endpoint {
> +		remote-endpoint = <&mipi_in_panel>;
> +	};
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu_s0>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	status = "okay";
> +};
> +
> +&hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi>;
> +	};
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
> +&hdptxphy {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-0 = <&i2c0m1_xfer>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	/* synaptics,dsx-i2c touchscreen at 0x70 */
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	pmic@23 {
> +		compatible = "rockchip,rk806";
> +		reg = <0x23>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA6 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_pins
> +			     &rk806_dvs1_null
> +			     &rk806_dvs2_null
> +			     &rk806_dvs3_null>;
> +		system-power-controller;
> +		vcc1-supply = <&vcc_3v8_sys>;
> +		vcc2-supply = <&vcc_3v8_sys>;
> +		vcc3-supply = <&vcc_3v8_sys>;
> +		vcc4-supply = <&vcc_3v8_sys>;
> +		vcc5-supply = <&vcc_3v8_sys>;
> +		vcc6-supply = <&vcc_3v8_sys>;
> +		vcc7-supply = <&vcc_3v8_sys>;
> +		vcc8-supply = <&vcc_3v8_sys>;
> +		vcc9-supply = <&vcc_3v8_sys>;
> +		vcc10-supply = <&vcc_3v8_sys>;
> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> +		vcc12-supply = <&vcc_3v8_sys>;
> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> +		vcca-supply = <&vcc_3v8_sys>;
> +
> +		rk806_dvs1_null: dvs1-null-pins {
> +			pins = "gpio_pwrctrl1";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs1_pwrdn: dvs1-pwrdn-pins {
> +			pins = "gpio_pwrctrl1";
> +			function = "pin_fun2";
> +		};
> +
> +		rk806_dvs1_rst: dvs1-rst-pins {
> +			pins = "gpio_pwrctrl1";
> +			function = "pin_fun3";
> +		};
> +
> +		rk806_dvs1_slp: dvs1-slp-pins {
> +			pins = "gpio_pwrctrl1";
> +			function = "pin_fun1";
> +		};
> +
> +		rk806_dvs2_dvs: dvs2-dvs-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun4";
> +		};
> +
> +		rk806_dvs2_gpio: dvs2-gpio-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun5";
> +		};
> +
> +		rk806_dvs2_null: dvs2-null-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs2_pwrdn: dvs2-pwrdn-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun2";
> +		};
> +
> +		rk806_dvs2_rst: dvs2-rst-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun3";
> +		};
> +
> +		rk806_dvs2_slp: dvs2-slp-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun1";
> +		};
> +
> +		rk806_dvs3_dvs: dvs3-dvs-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun4";
> +		};
> +
> +		rk806_dvs3_gpio: dvs3-gpio-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun5";
> +		};
> +
> +		rk806_dvs3_null: dvs3-null-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs3_pwrdn: dvs3-pwrdn-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun2";
> +		};
> +
> +		rk806_dvs3_rst: dvs3-rst-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun3";
> +		};
> +
> +		rk806_dvs3_slp: dvs3-slp-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun1";
> +		};
> +
> +		regulators {
> +			vdd_cpu_big_s0: dcdc-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-enable-ramp-delay = <400>;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-name = "vdd_cpu_big_s0";
> +				regulator-ramp-delay = <12500>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu_s0: dcdc-reg2 {
> +				regulator-boot-on;
> +				regulator-enable-ramp-delay = <400>;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-name = "vdd_npu_s0";
> +				regulator-ramp-delay = <12500>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_lit_s0: dcdc-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-name = "vdd_cpu_lit_s0";
> +				regulator-ramp-delay = <12500>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vcc_3v3_s3: dcdc-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc_3v3_s3";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vdd_gpu_s0: dcdc-reg5 {
> +				regulator-boot-on;
> +				regulator-enable-ramp-delay = <400>;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdd_gpu_s0";
> +				regulator-ramp-delay = <12500>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <850000>;
> +				};
> +			};
> +
> +			vddq_ddr_s0: dcdc-reg6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vddq_ddr_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_logic_s0: dcdc-reg7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <800000>;
> +				regulator-name = "vdd_logic_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_s3: dcdc-reg8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_1v8_s3";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd2_ddr_s3: dcdc-reg9 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vdd2_ddr_s3";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_ddr_s0: dcdc-reg10 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-name = "vdd_ddr_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca_1v8_s0: pldo-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcca_1v8_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pldo2_s0: pldo-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcca1v8_pldo2_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_1v2_s0: pldo-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-name = "vdda_1v2_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca_3v3_s0: pldo-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcca_3v3_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd_s0: pldo-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vccio_sd_s0";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pldo6_s3: pldo-reg6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcca1v8_pldo6_s3";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd_0v75_s3: nldo-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "vdd_0v75_s3";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vdda_ddr_pll_s0: nldo-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-name = "vdda_ddr_pll_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v75_hdmi_s0: nldo-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "vdda0v75_hdmi_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v85_s0: nldo-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-name = "vdda_0v85_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v75_s0: nldo-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "vdda_0v75_s0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	/* inv,icm42607 IMU at 0x68 */
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +
> +	es8388: audio-codec@10 {
> +		compatible = "everest,es8388", "everest,es8328";
> +		reg = <0x10>;
> +		assigned-clock-rates = <12288000>;
> +		assigned-clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
> +		AVDD-supply = <&vcca_3v3_s0>;
> +		clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
> +		DVDD-supply = <&vcc_3v3_s3>;
> +		HPVDD-supply = <&vcca_3v3_s0>;
> +		pinctrl-0 = <&sai1m0_mclk>;
> +		pinctrl-names = "default";
> +		PVDD-supply = <&vcc_3v3_s3>;
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	aw87391_pa_l: audio-codec@58 {
> +		compatible = "anbernic,rgds-amp", "awinic,aw87391";
> +		reg = <0x58>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "Left Amp";
> +	};
> +
> +	aw87391_pa_r: audio-codec@5b {
> +		compatible = "anbernic,rgds-amp", "awinic,aw87391";
> +		reg = <0x5b>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "Right Amp";
> +	};
> +};
> +
> +&i2c6 {
> +	pinctrl-0 = <&i2c6m3_xfer>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	sgm41542: charger@3b {
> +		compatible = "sgmicro,sgm41542";
> +		reg = <0x3b>;
> +		input-current-limit-microamp = <3000000>;
> +		input-voltage-limit-microvolt = <4500000>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PD2 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-0 = <&charger_irq>;
> +		pinctrl-names = "default";
> +		monitored-battery = <&battery>;
> +		status = "okay";
> +
> +		regulators {
> +			vbus5v0_typec: otg-vbus {
> +				regulator-name = "vbus5v0_typec";
> +				regulator-max-microvolt = <5000000>;
> +				regulator-min-microvolt = <5000000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +
> +	/* Unused iSmartWare SW2001 encryption device at 0x3c */
> +
> +	husb311: typec-portc@4e {
> +		compatible = "hynetek,husb311", "richtek,rt1711h";
> +		reg = <0x4e>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PD1 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-0 = <&usbc_int>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +		vbus-supply = <&vbus5v0_typec>;
> +
> +		connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			op-sink-microwatt = <10000000>;
> +			power-role = "dual";
> +			try-power-role  = "sink";
> +
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_FIXED(9000, 2000, PDO_FIXED_USB_COMM)>;
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +
> +			altmodes {
> +				displayport {
> +					svid = /bits/ 16 <0xff01>;
> +					vdo = <0xffffffff>;
> +				};
> +			};
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					usbc0_hs_ep: endpoint {
> +						remote-endpoint = <&usb_drd0_hs_ep>;
> +					};
> +				};
> +				port@1 {
> +					reg = <1>;
> +					usbc0_ss_ep: endpoint {
> +						remote-endpoint = <&usb_drd0_ss_ep>;
> +					};
> +				};
> +				port@2 {
> +					reg = <2>;
> +					usbc0_dp_ep: endpoint {
> +						remote-endpoint = <&usbdp_phy_ep>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "hym8563";
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		wakeup-source;
> +	};
> +
> +	/* cellwise,cw221X battery manager at 0x64 */
> +};
> +
> +&mipidcphy {
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_perstn>;
> +	reset-gpios = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc_wifi>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	audio {
> +		hp_amp_enable_h: hp-amp-enable {
> +			rockchip,pins = <0 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		hp_det: hp-det {
> +			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	bluetooth {
> +		bt_reset_gpio: bt-reset-pin {
> +			rockchip,pins = <2 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_wake_gpio: bt-wake-pin {
> +			rockchip,pins = <2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_wake_host_irq: bt-wake-host-irq {
> +			rockchip,pins = <2 RK_PC1 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	charger {
> +		charger_irq: charger-irq {
> +			rockchip,pins = <0 RK_PD2 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	display {
> +		lcd_enable: lcd-enable {
> +			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		lcd_rst: lcd-rst {
> +			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		vol_keys_l: vol-keys_l {
> +			rockchip,pins =
> +				<3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PD2 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		gamepad_keys_l: gamepad-keys-l {
> +			rockchip,pins =
> +				<3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PB3 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>,
> +				<3 RK_PD7 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		led_amber_h: led-amber-h {
> +			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		led_backlight_h: led-backlight-h {
> +			rockchip,pins = <2 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		led_green_h: led-green-h {
> +			rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		led_red_h: led-red-h {
> +			rockchip,pins = <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie {
> +		pcie0_perstn: pcie0-perstn {
> +			rockchip,pins = <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	regulator {
> +		vcc_3v3_sd_s0_h: vcc-3v3-sd-s0-h {
> +			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		vcc_sdio_h: vcc-sdio-h {
> +			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		vcc_wifi_h: vcc-wifi-h {
> +			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		vdd_lcd_h: vdd-lcd-h {
> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	rtc {
> +		hym8563_int: hym8563-int {
> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	touch {
> +		touch_int: touch-int {
> +			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	usb {
> +		usbc_int: usbc-int {
> +			rockchip,pins = <0 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		usbc0_sbu1: usbc0-sbu1 {
> +			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		usbc0_sbu2: usbc0-sbu2 {
> +			rockchip,pins = <4 RK_PB7 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +
> +	wifi {
> +		wifi_en_h: wifi-en-h {
> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&sai1 {
> +	pinctrl-0 = <&sai1m0_lrck
> +		     &sai1m0_sclk
> +		     &sai1m0_sdi0
> +		     &sai1m0_sdo0>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&sai6 {
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcca1v8_pldo2_s0>;
> +	status = "okay";
> +};
> +
> +&sdio {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <150000000>;
> +	no-mmc;
> +	no-sdio;
> +	pinctrl-0 = <&sdmmc1m0_bus4>, <&sdmmc1m0_clk>,
> +		    <&sdmmc1m0_cmd>, <&sdmmc1m0_det>;
> +	pinctrl-names = "default";
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_sd_s0>;
> +	vqmmc-supply = <&vcc_sdio>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	full-pwr-cycle-in-suspend;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <150000000>;
> +	no-sdio;
> +	no-mmc;
> +	pinctrl-0 = <&sdmmc0_bus4>, <&sdmmc0_clk>,
> +		    <&sdmmc0_cmd>, <&sdmmc0_det>;
> +	pinctrl-names = "default";
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_sd_s0>;
> +	vqmmc-supply = <&vccio_sd_s0>;
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	num-cs = <1>;
> +	pinctrl-0 = <&spi1m2_pins>, <&spi1m2_csn0>;
> +	status = "okay";
> +
> +	/* SPI controlled MCU for joystick and joystick LEDs. */
> +};
> +
> +&vop {
> +	status = "okay";
> +};
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi_in_vp0>;
> +	};
> +};
> +
> +&vp1 {
> +	vp1_out_dsi: endpoint@ROCKCHIP_VOP2_EP_MIPI0 {
> +		reg = <ROCKCHIP_VOP2_EP_MIPI0>;
> +		remote-endpoint = <&dsi_in_vp1>;
> +	};
> +};
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart6 {
> +	pinctrl-0 = <&uart6m1_xfer>, <&uart6m1_ctsn>, <&uart6m1_rtsn>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "realtek,rtl8822cs-bt";
> +		device-wake-gpios = <&gpio2 RK_PB6 GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&bt_reset_gpio>, <&bt_wake_gpio>, <&bt_wake_host_irq>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&usbdp_phy {
> +	mode-switch;
> +	orientation-switch;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usbc0_sbu1 &usbc0_sbu2>;
> +	sbu1-dc-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +	sbu2-dc-gpios = <&gpio4 RK_PB7 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	port {
> +		usbdp_phy_ep: endpoint {
> +			remote-endpoint = <&usbc0_dp_ep>;
> +		};
> +	};
> +};
> +
> +&usb_drd0_dwc3 {
> +	usb-role-switch;
> +	dr_mode = "otg";
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			usb_drd0_hs_ep: endpoint {
> +				remote-endpoint = <&usbc0_hs_ep>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			usb_drd0_ss_ep: endpoint {
> +				remote-endpoint = <&usbc0_ss_ep>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.43.0
> 
