From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v1 11/16] rtc: mediatek: move the declaration into a
 globally visible header file
Date: Fri, 23 Mar 2018 10:57:40 +0100
Message-ID: <20180323095740.GD3417@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
 <53afbe8172fb1afd809ce9ba1afeda924b9ea705.1521794177.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53afbe8172fb1afd809ce9ba1afeda924b9ea705.1521794177.git.sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 23/03/2018 at 17:15:08 +0800, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> This is in preparation for allowing other drivers can share the
> declaration, so move the declaration into a globally visible header file.
> 
> Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/rtc/rtc-mt6397.c   | 53 +---------------------------------
>  include/linux/rtc/mt6397.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++

This should go in include/linux/mfd/

>  2 files changed, 73 insertions(+), 52 deletions(-)
>  create mode 100644 include/linux/rtc/mt6397.h
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index d133d1f..015609d 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -19,63 +19,12 @@
>  #include <linux/of_platform.h>
>  #include <linux/regmap.h>
>  #include <linux/rtc.h>
> -#include <linux/jiffies.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/io.h>
>  #include <linux/mfd/mt6397/core.h>
> -
> -#define RTC_BBPU		0x0000
> -#define RTC_BBPU_CBUSY		BIT(6)
> -
> -#define RTC_WRTGR		0x003c
> -
> -#define RTC_IRQ_STA		0x0002
> -#define RTC_IRQ_STA_AL		BIT(0)
> -#define RTC_IRQ_STA_LP		BIT(3)
> -
> -#define RTC_IRQ_EN		0x0004
> -#define RTC_IRQ_EN_AL		BIT(0)
> -#define RTC_IRQ_EN_ONESHOT	BIT(2)
> -#define RTC_IRQ_EN_LP		BIT(3)
> -#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
> -
> -#define RTC_AL_MASK		0x0008
> -#define RTC_AL_MASK_DOW		BIT(4)
> -
> -#define RTC_TC_SEC		0x000a
> -/* Min, Hour, Dom... register offset to RTC_TC_SEC */
> -#define RTC_OFFSET_SEC		0
> -#define RTC_OFFSET_MIN		1
> -#define RTC_OFFSET_HOUR		2
> -#define RTC_OFFSET_DOM		3
> -#define RTC_OFFSET_DOW		4
> -#define RTC_OFFSET_MTH		5
> -#define RTC_OFFSET_YEAR		6
> -#define RTC_OFFSET_COUNT	7
> -
> -#define RTC_AL_SEC		0x0018
> -
> -#define RTC_PDN2		0x002e
> -#define RTC_PDN2_PWRON_ALARM	BIT(4)
> -
> -#define RTC_MIN_YEAR		1968
> -#define RTC_BASE_YEAR		1900
> -#define RTC_NUM_YEARS		128
> -#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
> -
> -#define MTK_RTC_POLL_DELAY_US	10
> -#define MTK_RTC_POLL_TIMEOUT	(jiffies_to_usecs(HZ))
> -
> -struct mt6397_rtc {
> -	struct device		*dev;
> -	struct rtc_device	*rtc_dev;
> -	struct mutex		lock;
> -	struct regmap		*regmap;
> -	int			irq;
> -	u32			addr_base;
> -};
> +#include <linux/rtc/mt6397.h>
>  
>  static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
>  {
> diff --git a/include/linux/rtc/mt6397.h b/include/linux/rtc/mt6397.h
> new file mode 100644
> index 0000000..4b19f51
> --- /dev/null
> +++ b/include/linux/rtc/mt6397.h
> @@ -0,0 +1,72 @@
> +

Unnecessary empty line

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2014-2018 MediaTek Inc.
> + *
> + * Author: Tianping.Fang <tianping.fang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> + *	   Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> + */
> +
> +#ifndef _LINUX_RTC_MT6397_H_
> +#define _LINUX_RTC_MT6397_H_
> +
> +#include <linux/jiffies.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +
> +#define RTC_BBPU		0x0000
> +#define RTC_BBPU_CBUSY		BIT(6)
> +
> +#define RTC_WRTGR		0x003c
> +
> +#define RTC_IRQ_STA		0x0002
> +#define RTC_IRQ_STA_AL		BIT(0)
> +#define RTC_IRQ_STA_LP		BIT(3)
> +
> +#define RTC_IRQ_EN		0x0004
> +#define RTC_IRQ_EN_AL		BIT(0)
> +#define RTC_IRQ_EN_ONESHOT	BIT(2)
> +#define RTC_IRQ_EN_LP		BIT(3)
> +#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
> +
> +#define RTC_AL_MASK		0x0008
> +#define RTC_AL_MASK_DOW		BIT(4)
> +
> +#define RTC_TC_SEC		0x000a
> +/* Min, Hour, Dom... register offset to RTC_TC_SEC */
> +#define RTC_OFFSET_SEC		0
> +#define RTC_OFFSET_MIN		1
> +#define RTC_OFFSET_HOUR		2
> +#define RTC_OFFSET_DOM		3
> +#define RTC_OFFSET_DOW		4
> +#define RTC_OFFSET_MTH		5
> +#define RTC_OFFSET_YEAR		6
> +#define RTC_OFFSET_COUNT	7
> +
> +#define RTC_AL_SEC		0x0018
> +
> +#define RTC_PDN2		0x002e
> +#define RTC_PDN2_PWRON_ALARM	BIT(4)
> +
> +#define RTC_MIN_YEAR		1968
> +#define RTC_BASE_YEAR		1900
> +#define RTC_NUM_YEARS		128
> +#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
> +
> +#define MTK_RTC_POLL_DELAY_US	10
> +#define MTK_RTC_POLL_TIMEOUT	(jiffies_to_usecs(HZ))
> +
> +struct mt6397_rtc {
> +	struct device		*dev;
> +	struct rtc_device	*rtc_dev;
> +
> +	/* protect registers accessing */
> +	struct mutex		lock;
> +	struct regmap		*regmap;
> +	int			irq;
> +	u32			addr_base;
> +};
> +
> +#endif /* _LINUX_RTC_MT6397_H_ */
> +
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
