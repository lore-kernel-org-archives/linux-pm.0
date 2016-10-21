From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 3/4] soc: ti: Add ti_sci_pm_domains driver
Date: Fri, 21 Oct 2016 12:00:00 -0700
Message-ID: <7h4m45plxr.fsf@baylibre.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
        <20161019203347.17893-4-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161019203347.17893-4-d-gerlach-l0cyMroinI0@public.gmane.org> (Dave Gerlach's message
        of "Wed, 19 Oct 2016 15:33:46 -0500")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> writes:

> Introduce a ti_sci_pm_domains driver to act as a generic pm domain provider
> to allow each device to attach and associate it's ti-sci-id so that it can
> be controlled through the TI SCI protocol.
>
> This driver implements a simple genpd where each device node has
> a phandle to the power domain node and also must provide an index which
> represents the ID to be passed with TI SCI representing the device using a
> ti,sci-id property. Through this interface the genpd dev_ops start and
> stop hooks will use TI SCI to turn on and off each device as determined
> by pm_runtime usage.
>
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---
>  MAINTAINERS                        |   1 +
>  arch/arm/mach-keystone/Kconfig     |   1 +
>  drivers/soc/ti/Kconfig             |  12 +++
>  drivers/soc/ti/Makefile            |   1 +
>  drivers/soc/ti/ti_sci_pm_domains.c | 198 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 213 insertions(+)
>  create mode 100644 drivers/soc/ti/ti_sci_pm_domains.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d894873c2bff..3eaac5ede847 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11894,6 +11894,7 @@ F:	drivers/firmware/ti_sci*
>  F:	include/linux/soc/ti/ti_sci_protocol.h
>  F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>  F:	include/dt-bindings/genpd/k2g.h
> +F:	drivers/soc/ti/ti_sci_pm_domains.c
>  
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:	Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
> index 24bd64dabdfc..18d49465cafb 100644
> --- a/arch/arm/mach-keystone/Kconfig
> +++ b/arch/arm/mach-keystone/Kconfig
> @@ -9,6 +9,7 @@ config ARCH_KEYSTONE
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select ZONE_DMA if ARM_LPAE
>  	select PINCTRL
> +	select PM_GENERIC_DOMAINS if PM
>  	help
>  	  Support for boards based on the Texas Instruments Keystone family of
>  	  SoCs.
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 3557c5e32a93..39e152abe6b9 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -38,4 +38,16 @@ config WKUP_M3_IPC
>  	  to communicate and use the Wakeup M3 for PM features like suspend
>  	  resume and boots it using wkup_m3_rproc driver.
>  
> +config TI_SCI_PM_DOMAINS
> +	tristate "TI SCI PM Domains Driver"
> +	depends on TI_SCI_PROTOCOL
> +	depends on PM_GENERIC_DOMAINS
> +	help
> +	  Generic power domain implementation for TI device implementing
> +	  the TI SCI protocol.
> +
> +	  To compile this as a module, choose M here. The module will be
> +	  called ti_sci_pm_domains. Note this is needed early in boot before
> +	  rootfs may be available.
> +
>  endif # SOC_TI
> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
> index 48ff3a79634f..7d572736c86e 100644
> --- a/drivers/soc/ti/Makefile
> +++ b/drivers/soc/ti/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_QMSS)	+= knav_qmss.o
>  knav_qmss-y := knav_qmss_queue.o knav_qmss_acc.o
>  obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
>  obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
> +obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
> diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
> new file mode 100644
> index 000000000000..ec76215d64c7
> --- /dev/null
> +++ b/drivers/soc/ti/ti_sci_pm_domains.c
> @@ -0,0 +1,198 @@
> +/*
> + * TI SCI Generic Power Domain Driver
> + *
> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
> + *	J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> + *	Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/slab.h>
> +#include <linux/soc/ti/ti_sci_protocol.h>
> +
> +/**
> + * struct ti_sci_genpd_dev_data: holds data needed for every device attached
> + *				 to this genpd
> + * @idx: index of the device that identifies it with the system
> + *	 control processor.
> + */
> +struct ti_sci_genpd_dev_data {
> +	int idx;
> +};

If you use #power-domain-cells = <1>, you can drop this...

> +/**
> + * struct ti_sci_pm_domain: TI specific data needed for power domain
> + * @ti_sci: handle to TI SCI protocol driver that provides ops to
> + *	    communicate with system control processor.
> + * @dev: pointer to dev for the driver for devm allocs
> + * @pd: generic_pm_domain for use with the genpd framework
> + */
> +struct ti_sci_pm_domain {
> +	const struct ti_sci_handle *ti_sci;
> +	struct device *dev;
> +	struct generic_pm_domain pd;
> +};

and add and 'idx' field to this which is populated on attach.

Thank you shouldn't need PATCH 1/4 which adds the new 'void * data'.

Otherwise, the driver looks pretty straight forward.

BTW, what is the the status of the TI-SCI protocol drivers themselves?
This can't be merged until that is or this won't even compile.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
