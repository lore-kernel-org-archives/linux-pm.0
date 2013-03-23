From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 11/14] thermal: mvebu: Add support for Marvell Dove
 SoC family
Date: Sat, 23 Mar 2013 12:26:05 +0100
Message-ID: <514D914D.3010105@gmail.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com> <1363991114-4225-12-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:55292 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab3CWL0J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Mar 2013 07:26:09 -0400
Received: by mail-ee0-f54.google.com with SMTP id c41so2660138eek.41
        for <linux-pm@vger.kernel.org>; Sat, 23 Mar 2013 04:26:08 -0700 (PDT)
In-Reply-To: <1363991114-4225-12-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

On 03/22/2013 11:25 PM, Ezequiel Garcia wrote:
> With the infrastructure added in mvebu-thermal to support multiple SoC
> families, it is now possible to add support for Dove SoC.
> This patch adds such support taking the implementation from the
> dove-thermal driver, and then removing it.
>
> Signed-off-by: Ezequiel Garcia<ezequiel.garcia@free-electrons.com>
> ---
>   .../devicetree/bindings/thermal/dove-thermal.txt   |   18 --
>   .../devicetree/bindings/thermal/mvebu-thermal.txt  |    8 +
>   drivers/thermal/Kconfig                            |    8 -
>   drivers/thermal/Makefile                           |    1 -
>   drivers/thermal/dove_thermal.c                     |  210 --------------------
>   drivers/thermal/mvebu_thermal.c                    |   74 +++++++
>   6 files changed, 82 insertions(+), 237 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/thermal/dove-thermal.txt
>   delete mode 100644 drivers/thermal/dove_thermal.c
>

[...]

> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
> deleted file mode 100644
> index ddd73a5..0000000
> --- a/drivers/thermal/dove_thermal.c
> +++ /dev/null
> @@ -1,210 +0,0 @@
> -/*
> - * Dove thermal sensor driver
> - *
> - * Copyright (C) 2013 Andrew Lunn<andrew@lunn.ch>
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - */
> -#include<linux/device.h>
> -#include<linux/err.h>
> -#include<linux/io.h>
> -#include<linux/kernel.h>
> -#include<linux/of.h>
> -#include<linux/module.h>
> -#include<linux/platform_device.h>
> -#include<linux/thermal.h>
> -
> -#define DOVE_THERMAL_TEMP_OFFSET	1
> -#define DOVE_THERMAL_TEMP_MASK		0x1FF

[...]

> diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> index 56c58b1..2f37b3e 100644
> --- a/drivers/thermal/mvebu_thermal.c
> +++ b/drivers/thermal/mvebu_thermal.c
> @@ -2,6 +2,7 @@
>    * Marvell EBU thermal sensor driver
>    *
>    * Copyright (C) 2013 Marvell
> + * Copyright (C) 2013 Andrew Lunn<andrew@lunn.ch>
>    * Copyright (C) 2012 Nobuhiro Iwamatsu<iwamatsu@nigauri.org>
>    *
>    * This software is licensed under the terms of the GNU General Public
> @@ -38,6 +39,14 @@
>   #define PMU_TDC0_REF_CAL_CNT_MASK	(0x1ff<<  PMU_TDC0_REF_CAL_CNT_OFFS)
>   #define PMU_TDC0_OTF_CAL_MASK		(0x1<<  30)
>   #define PMU_TDC0_START_CAL_MASK		(0x1<<  25)
> +#define PMU_TDC0_AVG_NUM_OFFS		25
> +#define PMU_TDC0_AVG_NUM_MASK		(0x7<<  PMU_TDC0_AVG_NUM_OFFS)
> +#define PMU_TDC0_SEL_VCAL_OFFS		5
> +#define PMU_TDC0_SEL_VCAL_MASK		(0x3<<  PMU_TDC0_SEL_VCAL_OFFS)
> +
> +/* Dove Thermal Diode Control 1 Register */
> +#define PMU_TEMP_DIOD_CTRL1_REG		0x04
> +#define PMU_TDC1_TEMP_VALID_MASK	(0x1<<  10)

Ezequiel,

maybe Dove thermal isn't that compatible with the others as you thought.

Have a look at DOVE_THERMAL_TEMP_OFFSET above, it is 1 while MVEBU_THERMAL_TEMP_OFFSET
is 10. I've tested your patches on Dove and they break thermal. You either need
a dove_get_temp() that uses correct DOVE_THERMAL_TEMP_OFFSET or have it stored
within mvebu_thermal_ops and use it in mvebu_get_temp().

Sebastian
