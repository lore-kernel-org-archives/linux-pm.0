From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Fri, 21 Aug 2015 01:12:23 +0200
Message-ID: <55D65ED7.7010102@linaro.org>
References: <1440057962-13373-1-git-send-email-s.hauer@pengutronix.de> <1440057962-13373-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36165 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbbHTXMZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2015 19:12:25 -0400
Received: by pawq9 with SMTP id q9so37913439paw.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2015 16:12:25 -0700 (PDT)
In-Reply-To: <1440057962-13373-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>

On 08/20/2015 10:06 AM, Sascha Hauer wrote:
> This adds support for the Mediatek thermal controller found on MT8173
> and likely other SoCs.
> The controller is a bit special. It does not have its own ADC, instea=
d
> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> we need the physical address of the AUXADC. Also it controls a mux
> using AHB bus accesses, so we need the APMIXEDSYS physical address as=
well.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

[ ... ]

> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_ther=
mal.c
> new file mode 100644
> index 0000000..06d52ef
> --- /dev/null
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -0,0 +1,582 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.

2015 ?

> + * Author: Hanyi.Wu <hanyi.wu@mediatek.com>

Hanyi Wu ?

[ ... ]

-->

> +#define TEMP_MONINTSTS		0x010
> +#define TEMP_MONIDET0		0x014
> +#define TEMP_MONIDET1		0x018
> +#define TEMP_MONIDET2		0x01c
> +#define TEMP_H2NTHRE		0x024
> +#define TEMP_HTHRE		0x028
> +#define TEMP_CTHRE		0x02c
> +#define TEMP_OFFSETH		0x030
> +#define TEMP_OFFSETL		0x034
> +#define TEMP_MSRCTL1		0x03c
> +#define TEMP_ADCEXT		0x058
> +#define TEMP_ADCEXT1		0x05c
> +#define TEMP_ADCEXTADDR		0x06c
> +#define TEMP_ADCEXT1ADDR	0x070
> +#define TEMP_IMMD0		0x0a0
> +#define TEMP_IMMD1		0x0a4
> +#define TEMP_IMMD2		0x0a8
> +#define TEMP_PROTCTL		0x0c0
> +#define TEMP_PROTTA		0x0c4
> +#define TEMP_PROTTB		0x0c8
> +#define TEMP_PROTTC		0x0cc
> +#define TEMP_SPARE1		0x0f4
> +#define TEMP_SPARE2		0x0f8
> +#define TEMP_SPARE3		0x0fc
> +#define THERMINTST		0x404
> +#define PTPODINTST		0x408
> +#define THSTAGE0ST		0x40c
> +#define THSTAGE1ST		0x410
> +#define THSTAGE2ST		0x414
> +#define THAHBST0		0x418
> +#define THAHBST1		0x41c	/* Only for DE debug */
> +#define PTPSPARE0		0x420
> +#define PTPSPARE1		0x424
> +#define PTPSPARE2		0x428
> +#define PTPSPARE3		0x42c
> +#define THSLPEVEB		0x430
> +#define TEMP_MONINT_COLD(sp)			(BIT(0) << ((sp) * 5))
> +#define TEMP_MONINT_HOT(sp)			(BIT(1) << ((sp) * 5))
> +#define TEMP_MONINT_LOW_OFS(sp)			(BIT(2) << ((sp) * 5))
> +#define TEMP_MONINT_HIGH_OFS(sp)		(BIT(3) << ((sp) * 5))
> +#define TEMP_MONINT_HOT_TO_NORM(sp)		(BIT(4) << ((sp) * 5))
> +#define TEMP_MONINT_TIMEOUT			BIT(15)
> +#define TEMP_MONINT_IMMEDIATE_SENSE(sp)		BIT(16 + (sp))
> +#define TEMP_MONINT_FILTER_SENSE(sp)		BIT(19 + (sp))
> +#define TEMP_ADCWRITECTRL_ADC_EXTRA_WRITE	BIT(2)
> +#define TEMP_ADCWRITECTRL_ADC_EXTRA1_WRITE	BIT(3)
> +#define TEMP_PROTCTL_AVERAGE			(0 << 16)
> +#define TEMP_PROTCTL_MAXIMUM			(1 << 16)
> +#define TEMP_PROTCTL_SELECTED			(2 << 16)

<-- Not used.


   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

