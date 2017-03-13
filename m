From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/5] soc: ti: Add ti_sci_pm_domains driver
Date: Mon, 13 Mar 2017 09:21:19 +0100
Message-ID: <CAPDyKFovk5EroNRe7_+221-P745vVj1=Uzz-LDiGaXYiSV8tjg@mail.gmail.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com> <1488882154-21485-5-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488882154-21485-5-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 7 March 2017 at 11:22, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> wrote:
> Introduce a ti_sci_pm_domains driver to act as a generic pm domain
> provider to allow each device to attach and associate it's ti-sci-id so
> that it can be controlled through the TI SCI protocol.
>
> This driver implements a simple genpd where each device node has a
> phandle to the power domain node and also must provide an index which
> represents the ID to be passed with TI SCI representing the device using
> a single phandle cell. The driver manually parses the phandle to get the
> cell value. Through this interface the genpd dev_ops start and stop
> hooks will use TI SCI to turn on and off each device as determined by
> pm_runtime usage.
>
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>

Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> ---
> v3->v4:
>  Parse phandle directly instead of reading ti,sci-id property per device.
>
>  MAINTAINERS                        |   1 +
>  arch/arm/mach-keystone/Kconfig     |   1 +
>  drivers/soc/ti/Kconfig             |  12 +++
>  drivers/soc/ti/Makefile            |   1 +
>  drivers/soc/ti/ti_sci_pm_domains.c | 202 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 217 insertions(+)
>  create mode 100644 drivers/soc/ti/ti_sci_pm_domains.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aaf96a9b4cd4..5cce85ade551 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12385,6 +12385,7 @@ F:      drivers/firmware/ti_sci*
>  F:     include/linux/soc/ti/ti_sci_protocol.h
>  F:     Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>  F:     include/dt-bindings/genpd/k2g.h
> +F:     drivers/soc/ti/ti_sci_pm_domains.c
>
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:     Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
> index 554357035f30..db122356b410 100644
> --- a/arch/arm/mach-keystone/Kconfig
> +++ b/arch/arm/mach-keystone/Kconfig
> @@ -10,6 +10,7 @@ config ARCH_KEYSTONE
>         select ARCH_SUPPORTS_BIG_ENDIAN
>         select ZONE_DMA if ARM_LPAE
>         select PINCTRL
> +       select PM_GENERIC_DOMAINS if PM
>         help
>           Support for boards based on the Texas Instruments Keystone family of
>           SoCs.
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 3557c5e32a93..39e152abe6b9 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -38,4 +38,16 @@ config WKUP_M3_IPC
>           to communicate and use the Wakeup M3 for PM features like suspend
>           resume and boots it using wkup_m3_rproc driver.
>
> +config TI_SCI_PM_DOMAINS
> +       tristate "TI SCI PM Domains Driver"
> +       depends on TI_SCI_PROTOCOL
> +       depends on PM_GENERIC_DOMAINS
> +       help
> +         Generic power domain implementation for TI device implementing
> +         the TI SCI protocol.
> +
> +         To compile this as a module, choose M here. The module will be
> +         called ti_sci_pm_domains. Note this is needed early in boot before
> +         rootfs may be available.
> +
>  endif # SOC_TI
> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
> index 48ff3a79634f..7d572736c86e 100644
> --- a/drivers/soc/ti/Makefile
> +++ b/drivers/soc/ti/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_QMSS)   += knav_qmss.o
>  knav_qmss-y := knav_qmss_queue.o knav_qmss_acc.o
>  obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)   += knav_dma.o
>  obj-$(CONFIG_WKUP_M3_IPC)              += wkup_m3_ipc.o
> +obj-$(CONFIG_TI_SCI_PM_DOMAINS)                += ti_sci_pm_domains.o
> diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
> new file mode 100644
> index 000000000000..b0b283810e72
> --- /dev/null
> +++ b/drivers/soc/ti/ti_sci_pm_domains.c
> @@ -0,0 +1,202 @@
> +/*
> + * TI SCI Generic Power Domain Driver
> + *
> + * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
> + *     J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> + *     Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
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
> + *                              to this genpd
> + * @idx: index of the device that identifies it with the system
> + *      control processor.
> + */
> +struct ti_sci_genpd_dev_data {
> +       int idx;
> +};
> +
> +/**
> + * struct ti_sci_pm_domain: TI specific data needed for power domain
> + * @ti_sci: handle to TI SCI protocol driver that provides ops to
> + *         communicate with system control processor.
> + * @dev: pointer to dev for the driver for devm allocs
> + * @pd: generic_pm_domain for use with the genpd framework
> + */
> +struct ti_sci_pm_domain {
> +       const struct ti_sci_handle *ti_sci;
> +       struct device *dev;
> +       struct generic_pm_domain pd;
> +};
> +
> +#define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
> +
> +/**
> + * ti_sci_dev_id(): get prepopulated ti_sci id from struct dev
> + * @dev: pointer to device associated with this genpd
> + *
> + * Returns device_id stored from ti,sci_id property
> + */
> +static int ti_sci_dev_id(struct device *dev)
> +{
> +       struct generic_pm_domain_data *genpd_data = dev_gpd_data(dev);
> +       struct ti_sci_genpd_dev_data *sci_dev_data = genpd_data->data;
> +
> +       return sci_dev_data->idx;
> +}
> +
> +/**
> + * ti_sci_dev_to_sci_handle(): get pointer to ti_sci_handle
> + * @dev: pointer to device associated with this genpd
> + *
> + * Returns ti_sci_handle to be used to communicate with system
> + *        control processor.
> + */
> +static const struct ti_sci_handle *ti_sci_dev_to_sci_handle(struct device *dev)
> +{
> +       struct generic_pm_domain *pd = pd_to_genpd(dev->pm_domain);
> +       struct ti_sci_pm_domain *ti_sci_genpd = genpd_to_ti_sci_pd(pd);
> +
> +       return ti_sci_genpd->ti_sci;
> +}
> +
> +/**
> + * ti_sci_dev_start(): genpd device start hook called to turn device on
> + * @dev: pointer to device associated with this genpd to be powered on
> + */
> +static int ti_sci_dev_start(struct device *dev)
> +{
> +       const struct ti_sci_handle *ti_sci = ti_sci_dev_to_sci_handle(dev);
> +       int idx = ti_sci_dev_id(dev);
> +
> +       return ti_sci->ops.dev_ops.get_device(ti_sci, idx);
> +}
> +
> +/**
> + * ti_sci_dev_stop(): genpd device stop hook called to turn device off
> + * @dev: pointer to device associated with this genpd to be powered off
> + */
> +static int ti_sci_dev_stop(struct device *dev)
> +{
> +       const struct ti_sci_handle *ti_sci = ti_sci_dev_to_sci_handle(dev);
> +       int idx = ti_sci_dev_id(dev);
> +
> +       return ti_sci->ops.dev_ops.put_device(ti_sci, idx);
> +}
> +
> +static int ti_sci_pd_attach_dev(struct generic_pm_domain *domain,
> +                               struct device *dev)
> +{
> +       struct device_node *np = dev->of_node;
> +       struct of_phandle_args pd_args;
> +       struct ti_sci_pm_domain *ti_sci_genpd = genpd_to_ti_sci_pd(domain);
> +       const struct ti_sci_handle *ti_sci = ti_sci_genpd->ti_sci;
> +       struct ti_sci_genpd_dev_data *sci_dev_data;
> +       struct generic_pm_domain_data *genpd_data;
> +       int idx, ret = 0;
> +
> +       ret = of_parse_phandle_with_args(np, "power-domains",
> +                                        "#power-domain-cells", 0, &pd_args);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (pd_args.args_count != 1)
> +               return -EINVAL;
> +
> +       idx = pd_args.args[0];
> +
> +       /*
> +        * Check the validity of the requested idx, if the index is not valid
> +        * the PMMC will return a NAK here and we will not allocate it.
> +        */
> +       ret = ti_sci->ops.dev_ops.is_valid(ti_sci, idx);
> +       if (ret)
> +               return -EINVAL;
> +
> +       sci_dev_data = kzalloc(sizeof(*sci_dev_data), GFP_KERNEL);
> +       if (!sci_dev_data)
> +               return -ENOMEM;
> +
> +       sci_dev_data->idx = idx;
> +
> +       genpd_data = dev_gpd_data(dev);
> +       genpd_data->data = sci_dev_data;
> +
> +       return 0;
> +}
> +
> +static void ti_sci_pd_detach_dev(struct generic_pm_domain *domain,
> +                                struct device *dev)
> +{
> +       struct generic_pm_domain_data *genpd_data = dev_gpd_data(dev);
> +       struct ti_sci_genpd_dev_data *sci_dev_data = genpd_data->data;
> +
> +       kfree(sci_dev_data);
> +       genpd_data->data = NULL;
> +}
> +
> +static const struct of_device_id ti_sci_pm_domain_matches[] = {
> +       { .compatible = "ti,sci-pm-domain", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, ti_sci_pm_domain_matches);
> +
> +static int ti_sci_pm_domain_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct ti_sci_pm_domain *ti_sci_pd;
> +       int ret;
> +
> +       ti_sci_pd = devm_kzalloc(dev, sizeof(*ti_sci_pd), GFP_KERNEL);
> +       if (!ti_sci_pd)
> +               return -ENOMEM;
> +
> +       ti_sci_pd->ti_sci = devm_ti_sci_get_handle(dev);
> +       if (IS_ERR(ti_sci_pd->ti_sci))
> +               return PTR_ERR(ti_sci_pd->ti_sci);
> +
> +       ti_sci_pd->dev = dev;
> +
> +       ti_sci_pd->pd.attach_dev = ti_sci_pd_attach_dev;
> +       ti_sci_pd->pd.detach_dev = ti_sci_pd_detach_dev;
> +
> +       ti_sci_pd->pd.dev_ops.start = ti_sci_dev_start;
> +       ti_sci_pd->pd.dev_ops.stop = ti_sci_dev_stop;
> +
> +       pm_genpd_init(&ti_sci_pd->pd, NULL, true);
> +
> +       ret = of_genpd_add_provider_simple(np, &ti_sci_pd->pd);
> +
> +       return ret;
> +}
> +
> +static struct platform_driver ti_sci_pm_domains_driver = {
> +       .probe = ti_sci_pm_domain_probe,
> +       .driver = {
> +               .name = "ti_sci_pm_domains",
> +               .of_match_table = ti_sci_pm_domain_matches,
> +       },
> +};
> +module_platform_driver(ti_sci_pm_domains_driver);
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("TI System Control Interface (SCI) Power Domain driver");
> +MODULE_AUTHOR("Dave Gerlach");
> --
> 2.11.0
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
