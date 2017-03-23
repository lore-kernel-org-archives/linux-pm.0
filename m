From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH V11 6/6] thermal: bcm2835: add thermal driver for bcm2835 SoC
Date: Fri, 24 Mar 2017 01:53:44 +0900
Message-ID: <CABMQnVJx10e2qm0N=C_vxU9WAQGUJ3ZyAUgrK7WQZoxm9+P0wg@mail.gmail.com>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com> <1489356665-3175-7-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35319 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756387AbdCWQyV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 12:54:21 -0400
Received: by mail-io0-f193.google.com with SMTP id f103so162236ioi.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 09:54:20 -0700 (PDT)
In-Reply-To: <1489356665-3175-7-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi, Stefan.

2017-03-13 7:11 GMT+09:00 Stefan Wahren <stefan.wahren@i2se.com>:
> Add basic thermal driver for bcm2835 SoC.
>
> This driver currently make sure that tsense HW block is set up
> correctly.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/thermal/Kconfig           |    8 +
>  drivers/thermal/Makefile          |    1 +
>  drivers/thermal/bcm2835_thermal.c |  315 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 324 insertions(+)
>  create mode 100644 drivers/thermal/bcm2835_thermal.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 776b343..3bd2406 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -453,4 +453,12 @@ config ZX2967_THERMAL
>           the primitive temperature sensor embedded in zx2967 SoCs.
>           This sensor generates the real time die temperature.
>
> +config BCM2835_THERMAL
> +       tristate "Thermal sensors on bcm2835 SoC"
> +       depends on ARCH_BCM2835 || COMPILE_TEST
> +       depends on HAS_IOMEM
> +       depends on THERMAL_OF
> +       help
> +         Support for thermal sensors on Broadcom bcm2835 SoCs.
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 7adae20..f23cde0 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -58,3 +58,4 @@ obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)      += mtk_thermal.o
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)      += thermal-generic-adc.o
>  obj-$(CONFIG_ZX2967_THERMAL)   += zx2967_thermal.o
> +obj-$(CONFIG_BCM2835_THERMAL)  += bcm2835_thermal.o
> diff --git a/drivers/thermal/bcm2835_thermal.c b/drivers/thermal/bcm2835_thermal.c
> new file mode 100644
> index 0000000..a9768f1
> --- /dev/null
> +++ b/drivers/thermal/bcm2835_thermal.c

<snip>

> +static struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
> +       .get_temp = bcm2835_thermal_get_temp,
> +};
> +
> +static const struct of_device_id bcm2835_thermal_of_match_table[];

bcm2835_thermal_of_match_table has been defined twice.
I think that it is better to define bcm2835_thermal_of_match_table below
or move bcm2835_thermal_probe to bottom.

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
