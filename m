From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] firmware: scpi: add device power domain support using genpd
Date: Wed, 15 Jun 2016 15:05:12 +0200
Message-ID: <CAPDyKFp5GacJNq_hqhrdupN9gYNHYmE_-Z7ZV-c6BP59AaurZw@mail.gmail.com>
References: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com> <1465228439-13457-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465228439-13457-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 6 June 2016 at 17:53, Sudeep Holla <sudeep.holla@arm.com> wrote:
> This patch hooks up the support for device power domain provided by
> SCPI using the Linux generic power domain infrastructure.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

For following versions, please keep me in the loop for the entire
series. Including the cover-letter which I am unable to find.

> ---
>  drivers/firmware/Kconfig   |   8 +++
>  drivers/firmware/Makefile  |   1 +
>  drivers/firmware/scpi_pd.c | 152 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 161 insertions(+)
>  create mode 100644 drivers/firmware/scpi_pd.c
>
> Hi,
>
> Since most of the power controller drivers are place in drivers/soc/<soc_name>,
> I am not sure where to put this SCPI power domain code as it can be used
> on multiple SoC. I have placed it in drivers/firmware temporarily for
> review. Please suggest the most apt place to put this driver.

To me, I think it makes sense to put this in the suggested directory,
as it's not SoC specific code.

>
> Regards,
> Sudeep
>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 41abdc54815e..80c963c60f13 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -27,6 +27,14 @@ config ARM_SCPI_PROTOCOL
>           This protocol library provides interface for all the client drivers
>           making use of the features offered by the SCP.
>
> +config ARM_SCPI_POWER_DOMAIN
> +       tristate "SCPI power domain driver"
> +       depends on (ARM_SCPI_PROTOCOL && PM) || COMPILE_TEST
> +       select PM_GENERIC_DOMAINS_OF

I think this is better:
depends on (ARM_SCPI_PROTOCOL) || COMPILE_TEST
select PM_GENERIC_DOMAINS if PM

> +       help
> +         This enables support for the SCPI power domains which can be
> +         enabled or disabled via the SCP firmware
> +
>  config EDD
>         tristate "BIOS Enhanced Disk Drive calls determine boot disk"
>         depends on X86
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 474bada56fcd..24f7fe8e3fc3 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -3,6 +3,7 @@
>  #
>  obj-$(CONFIG_ARM_PSCI_FW)      += psci.o
>  obj-$(CONFIG_ARM_SCPI_PROTOCOL)        += arm_scpi.o
> +obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pd.o
>  obj-$(CONFIG_DMI)              += dmi_scan.o
>  obj-$(CONFIG_DMI_SYSFS)                += dmi-sysfs.o
>  obj-$(CONFIG_EDD)              += edd.o
> diff --git a/drivers/firmware/scpi_pd.c b/drivers/firmware/scpi_pd.c

Perhaps name it scpi_pm_domain.c instead as it gives a better
description of its purpose.

> new file mode 100644
> index 000000000000..fb24631d2b2e
> --- /dev/null
> +++ b/drivers/firmware/scpi_pd.c
> @@ -0,0 +1,152 @@
> +/*
> + * SCPI Generic power domain support.
> + *
> + * Copyright (C) 2016 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_domain.h>
> +#include <linux/scpi_protocol.h>
> +
> +struct scpi_pm_domain {
> +       struct generic_pm_domain genpd;
> +       struct scpi_ops *ops;
> +       u32 domain;
> +       char name[20];
> +};
> +
> +enum scpi_power_domain_state {
> +       SCPI_PD_STATE_ON = 0,
> +       SCPI_PD_STATE_OFF = 3,
> +};
> +
> +#define to_scpi_pd(gpd) container_of(gpd, struct scpi_pm_domain, genpd)
> +
> +static int scpi_pd_power(struct scpi_pm_domain *pd, bool power_on)
> +{
> +       int ret;
> +       enum scpi_power_domain_state state;
> +
> +       if (power_on)
> +               state = SCPI_PD_STATE_ON;
> +       else
> +               state = SCPI_PD_STATE_OFF;
> +
> +       ret = pd->ops->device_set_power_state(pd->domain, state);
> +       if (ret)
> +               return ret;
> +
> +       return (state == pd->ops->device_get_power_state(pd->domain));
> +}
> +
> +static int scpi_pd_power_on(struct generic_pm_domain *domain)
> +{
> +       struct scpi_pm_domain *pd = to_scpi_pd(domain);
> +
> +       return scpi_pd_power(pd, true);
> +}
> +
> +static int scpi_pd_power_off(struct generic_pm_domain *domain)
> +{
> +       struct scpi_pm_domain *pd = to_scpi_pd(domain);
> +
> +       return scpi_pd_power(pd, false);
> +}
> +
> +static int scpi_pm_domain_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct scpi_pm_domain *scpi_pd;
> +       struct genpd_onecell_data *scpi_pd_data;
> +       struct generic_pm_domain **domains;
> +       struct scpi_ops *scpi_ops;
> +       int ret, num_domains, i;
> +
> +       scpi_ops = get_scpi_ops();
> +       if (!scpi_ops)
> +               return -EPROBE_DEFER;
> +
> +       if (!np) {
> +               dev_err(dev, "device tree node not found\n");
> +               return -ENODEV;
> +       }
> +
> +       ret = of_property_read_u32(np, "num-domains", &num_domains);
> +       if (ret) {
> +               dev_err(dev, "number of domains not found\n");
> +               return -EINVAL;
> +       }
> +
> +       scpi_pd = devm_kcalloc(dev, num_domains, sizeof(*scpi_pd), GFP_KERNEL);
> +       if (!scpi_pd)
> +               return -ENOMEM;
> +
> +       scpi_pd_data = devm_kzalloc(dev, sizeof(*scpi_pd_data), GFP_KERNEL);
> +       if (!scpi_pd_data)
> +               return -ENOMEM;
> +
> +       domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
> +       if (!domains)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < num_domains; i++, scpi_pd++) {
> +               domains[i] = &scpi_pd->genpd;
> +
> +               scpi_pd->domain = i;
> +               scpi_pd->ops = scpi_ops;
> +               sprintf(scpi_pd->name, "%s.%d", np->name, i);
> +               scpi_pd->genpd.name = scpi_pd->name;
> +               scpi_pd->genpd.power_off = scpi_pd_power_off;
> +               scpi_pd->genpd.power_on = scpi_pd_power_on;
> +
> +               /*
> +                * Treat all power domains as off at boot.
> +                *
> +                * The SCP firmware itself may have switched on some domains,
> +                * but for reference counting purpose, keep it this way.
> +                */
> +               pm_genpd_init(&scpi_pd->genpd, NULL, true);
> +       }
> +
> +       scpi_pd_data->domains = domains;
> +       scpi_pd_data->num_domains = num_domains;
> +
> +       of_genpd_add_provider_onecell(np, scpi_pd_data);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id scpi_power_domain_ids[] = {
> +       { .compatible = "arm,scpi-power-domains", },
> +       { /* sentinel */ }
> +};

Actually I think you shouldn't implement this a standalone driver and
thus you can remove this compatible.

Instead, I think it's better if you let the arm_scpi driver to also
initialize the PM domain.

If you still want the PM domain code to be maintained in a separate
file, just provide a header file which declares an
"scpi_pm_domain_init()" function (and a stub when not supported),
which the arm_scpi driver should call during ->probe().

> +MODULE_DEVICE_TABLE(of, scpi_power_domain_ids);
> +
> +static struct platform_driver scpi_power_domain_driver = {
> +       .driver = {
> +               .name = "scpi_power_domain",
> +               .of_match_table = scpi_power_domain_ids,
> +       },
> +       .probe = scpi_pm_domain_probe,
> +};
> +module_platform_driver(scpi_power_domain_driver);
> +
> +MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
> +MODULE_DESCRIPTION("ARM SCPI power domain driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>

Kind regards
Uffe
