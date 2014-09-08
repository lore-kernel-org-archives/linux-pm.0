From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/9] PM / Domains: Add generic OF-based PM domain look-up
Date: Mon, 8 Sep 2014 09:26:20 +0200
Message-ID: <CAPDyKFovLmajQORVT1Mf01J5L7O73JNDFz=gr3fXKvF5xZGCdQ@mail.gmail.com>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
	<1409838756-31963-3-git-send-email-ulf.hansson@linaro.org>
	<3075771.rIWPm62y5x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3075771.rIWPm62y5x@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.>
List-Id: linux-pm@vger.kernel.org

On 8 September 2014 00:13, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, September 04, 2014 03:52:29 PM Ulf Hansson wrote:
>> From: Tomasz Figa <t.figa@samsung.com>
>>
>> This patch introduces generic code to perform PM domain look-up using
>> device tree and automatically bind devices to their PM domains.
>>
>> Generic device tree bindings are introduced to specify PM domains of
>> devices in their device tree nodes.
>>
>> Backwards compatibility with legacy Samsung-specific PM domain bindings
>> is provided, but for now the new code is not compiled when
>> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code.
>> This will change as soon as the Exynos PM domain code gets converted to
>> use the generic framework in further patch.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> [Ulf:Added attach|detach functions, fixed review comments]
>> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> However, for this one (and consequently the rest) I need an ACK from the
> people who maintain the bindings.

These DT bindings have been discussed between Tomasz and devicetree
maintainers previously. So I think there are fine.

Also, when browsing the mail-archives, I found an ack from Rob Herrring:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/237989.html

I realize that I didn't put the DT maintainers on the to-line when
posting this patch, but just the devicetree list. I have now included
them on this reply, but maybe I should repost instead. What do you
think? Are you happy with the above ack from Rob?

Kind regards
Uffe

>
>> ---
>>  .../devicetree/bindings/power/power_domain.txt     |  49 ++++
>>  drivers/base/power/domain.c                        | 291 +++++++++++++++++++++
>>  include/linux/pm_domain.h                          |  57 ++++
>>  kernel/power/Kconfig                               |   4 +
>>  4 files changed, 401 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/power_domain.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>> new file mode 100644
>> index 0000000..98c1667
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>> @@ -0,0 +1,49 @@
>> +* Generic PM domains
>> +
>> +System on chip designs are often divided into multiple PM domains that can be
>> +used for power gating of selected IP blocks for power saving by reduced leakage
>> +current.
>> +
>> +This device tree binding can be used to bind PM domain consumer devices with
>> +their PM domains provided by PM domain providers. A PM domain provider can be
>> +represented by any node in the device tree and can provide one or more PM
>> +domains. A consumer node can refer to the provider by a phandle and a set of
>> +phandle arguments (so called PM domain specifiers) of length specified by the
>> +#power-domain-cells property in the PM domain provider node.
>> +
>> +==PM domain providers==
>> +
>> +Required properties:
>> + - #power-domain-cells : Number of cells in a PM domain specifier;
>> +   Typically 0 for nodes representing a single PM domain and 1 for nodes
>> +   providing multiple PM domains (e.g. power controllers), but can be any value
>> +   as specified by device tree binding documentation of particular provider.
>> +
>> +Example:
>> +
>> +     power: power-controller@12340000 {
>> +             compatible = "foo,power-controller";
>> +             reg = <0x12340000 0x1000>;
>> +             #power-domain-cells = <1>;
>> +     };
>> +
>> +The node above defines a power controller that is a PM domain provider and
>> +expects one cell as its phandle argument.
>> +
>> +==PM domain consumers==
>> +
>> +Required properties:
>> + - power-domains : A phandle and PM domain specifier as defined by bindings of
>> +                   the power controller specified by phandle.
>> +
>> +Example:
>> +
>> +     leaky-device@12350000 {
>> +             compatible = "foo,i-leak-current";
>> +             reg = <0x12350000 0x1000>;
>> +             power-domains = <&power 0>;
>> +     };
>> +
>> +The node above defines a typical PM domain consumer device, which is located
>> +inside a PM domain with index 0 of a power controller represented by a node
>> +with the label "power".
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index eee55c1..ed42651 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -8,6 +8,7 @@
>>
>>  #include <linux/kernel.h>
>>  #include <linux/io.h>
>> +#include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/pm_domain.h>
>>  #include <linux/pm_qos.h>
>> @@ -2189,3 +2190,293 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>>       list_add(&genpd->gpd_list_node, &gpd_list);
>>       mutex_unlock(&gpd_list_lock);
>>  }
>> +
>> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>> +/*
>> + * Device Tree based PM domain providers.
>> + *
>> + * The code below implements generic device tree based PM domain providers that
>> + * bind device tree nodes with generic PM domains registered in the system.
>> + *
>> + * Any driver that registers generic PM domains and needs to support binding of
>> + * devices to these domains is supposed to register a PM domain provider, which
>> + * maps a PM domain specifier retrieved from the device tree to a PM domain.
>> + *
>> + * Two simple mapping functions have been provided for convenience:
>> + *  - __of_genpd_xlate_simple() for 1:1 device tree node to PM domain mapping.
>> + *  - __of_genpd_xlate_onecell() for mapping of multiple PM domains per node by
>> + *    index.
>> + */
>> +
>> +/**
>> + * struct of_genpd_provider - PM domain provider registration structure
>> + * @link: Entry in global list of PM domain providers
>> + * @node: Pointer to device tree node of PM domain provider
>> + * @xlate: Provider-specific xlate callback mapping a set of specifier cells
>> + *         into a PM domain.
>> + * @data: context pointer to be passed into @xlate callback
>> + */
>> +struct of_genpd_provider {
>> +     struct list_head link;
>> +     struct device_node *node;
>> +     genpd_xlate_t xlate;
>> +     void *data;
>> +};
>> +
>> +/* List of registered PM domain providers. */
>> +static LIST_HEAD(of_genpd_providers);
>> +/* Mutex to protect the list above. */
>> +static DEFINE_MUTEX(of_genpd_mutex);
>> +
>> +/**
>> + * __of_genpd_xlate_simple() - Xlate function for direct node-domain mapping
>> + * @genpdspec: OF phandle args to map into a PM domain
>> + * @data: xlate function private data - pointer to struct generic_pm_domain
>> + *
>> + * This is a generic xlate function that can be used to model PM domains that
>> + * have their own device tree nodes. The private data of xlate function needs
>> + * to be a valid pointer to struct generic_pm_domain.
>> + */
>> +struct generic_pm_domain *__of_genpd_xlate_simple(
>> +                                     struct of_phandle_args *genpdspec,
>> +                                     void *data)
>> +{
>> +     if (genpdspec->args_count != 0)
>> +             return ERR_PTR(-EINVAL);
>> +     return data;
>> +}
>> +EXPORT_SYMBOL_GPL(__of_genpd_xlate_simple);
>> +
>> +/**
>> + * __of_genpd_xlate_onecell() - Xlate function using a single index.
>> + * @genpdspec: OF phandle args to map into a PM domain
>> + * @data: xlate function private data - pointer to struct genpd_onecell_data
>> + *
>> + * This is a generic xlate function that can be used to model simple PM domain
>> + * controllers that have one device tree node and provide multiple PM domains.
>> + * A single cell is used as an index into an array of PM domains specified in
>> + * the genpd_onecell_data struct when registering the provider.
>> + */
>> +struct generic_pm_domain *__of_genpd_xlate_onecell(
>> +                                     struct of_phandle_args *genpdspec,
>> +                                     void *data)
>> +{
>> +     struct genpd_onecell_data *genpd_data = data;
>> +     unsigned int idx = genpdspec->args[0];
>> +
>> +     if (genpdspec->args_count != 1)
>> +             return ERR_PTR(-EINVAL);
>> +
>> +     if (idx >= genpd_data->num_domains) {
>> +             pr_err("%s: invalid domain index %u\n", __func__, idx);
>> +             return ERR_PTR(-EINVAL);
>> +     }
>> +
>> +     if (!genpd_data->domains[idx])
>> +             return ERR_PTR(-ENOENT);
>> +
>> +     return genpd_data->domains[idx];
>> +}
>> +EXPORT_SYMBOL_GPL(__of_genpd_xlate_onecell);
>> +
>> +/**
>> + * __of_genpd_add_provider() - Register a PM domain provider for a node
>> + * @np: Device node pointer associated with the PM domain provider.
>> + * @xlate: Callback for decoding PM domain from phandle arguments.
>> + * @data: Context pointer for @xlate callback.
>> + */
>> +int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>> +                     void *data)
>> +{
>> +     struct of_genpd_provider *cp;
>> +
>> +     cp = kzalloc(sizeof(*cp), GFP_KERNEL);
>> +     if (!cp)
>> +             return -ENOMEM;
>> +
>> +     cp->node = of_node_get(np);
>> +     cp->data = data;
>> +     cp->xlate = xlate;
>> +
>> +     mutex_lock(&of_genpd_mutex);
>> +     list_add(&cp->link, &of_genpd_providers);
>> +     mutex_unlock(&of_genpd_mutex);
>> +     pr_debug("Added domain provider from %s\n", np->full_name);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(__of_genpd_add_provider);
>> +
>> +/**
>> + * of_genpd_del_provider() - Remove a previously registered PM domain provider
>> + * @np: Device node pointer associated with the PM domain provider
>> + */
>> +void of_genpd_del_provider(struct device_node *np)
>> +{
>> +     struct of_genpd_provider *cp;
>> +
>> +     mutex_lock(&of_genpd_mutex);
>> +     list_for_each_entry(cp, &of_genpd_providers, link) {
>> +             if (cp->node == np) {
>> +                     list_del(&cp->link);
>> +                     of_node_put(cp->node);
>> +                     kfree(cp);
>> +                     break;
>> +             }
>> +     }
>> +     mutex_unlock(&of_genpd_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>> +
>> +/**
>> + * of_genpd_get_from_provider() - Look-up PM domain
>> + * @genpdspec: OF phandle args to use for look-up
>> + *
>> + * Looks for a PM domain provider under the node specified by @genpdspec and if
>> + * found, uses xlate function of the provider to map phandle args to a PM
>> + * domain.
>> + *
>> + * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
>> + * on failure.
>> + */
>> +static struct generic_pm_domain *of_genpd_get_from_provider(
>> +                                     struct of_phandle_args *genpdspec)
>> +{
>> +     struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
>> +     struct of_genpd_provider *provider;
>> +
>> +     mutex_lock(&of_genpd_mutex);
>> +
>> +     /* Check if we have such a provider in our array */
>> +     list_for_each_entry(provider, &of_genpd_providers, link) {
>> +             if (provider->node == genpdspec->np)
>> +                     genpd = provider->xlate(genpdspec, provider->data);
>> +             if (!IS_ERR(genpd))
>> +                     break;
>> +     }
>> +
>> +     mutex_unlock(&of_genpd_mutex);
>> +
>> +     return genpd;
>> +}
>> +
>> +/**
>> + * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
>> + * @dev: Device to attach.
>> + *
>> + * Parse device's OF node to find a PM domain specifier. If such is found,
>> + * attaches the device to retrieved pm_domain ops.
>> + *
>> + * Both generic and legacy Samsung-specific DT bindings are supported to keep
>> + * backwards compatibility with existing DTBs.
>> + *
>> + * Returns 0 on successfully attached PM domain or negative error code.
>> + */
>> +int genpd_dev_pm_attach(struct device *dev)
>> +{
>> +     struct of_phandle_args pd_args;
>> +     struct generic_pm_domain *pd;
>> +     int ret;
>> +
>> +     if (!dev->of_node)
>> +             return -ENODEV;
>> +
>> +     if (dev->pm_domain)
>> +             return -EEXIST;
>> +
>> +     ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>> +                                     "#power-domain-cells", 0, &pd_args);
>> +     if (ret < 0) {
>> +             if (ret != -ENOENT)
>> +                     return ret;
>> +
>> +             /*
>> +              * Try legacy Samsung-specific bindings
>> +              * (for backwards compatibility of DT ABI)
>> +              */
>> +             pd_args.args_count = 0;
>> +             pd_args.np = of_parse_phandle(dev->of_node,
>> +                                             "samsung,power-domain", 0);
>> +             if (!pd_args.np)
>> +                     return -ENOENT;
>> +     }
>> +
>> +     pd = of_genpd_get_from_provider(&pd_args);
>> +     if (IS_ERR(pd)) {
>> +             dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>> +                     __func__, PTR_ERR(pd));
>> +             of_node_put(dev->of_node);
>> +             return PTR_ERR(pd);
>> +     }
>> +
>> +     dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>> +
>> +     while (1) {
>> +             ret = pm_genpd_add_device(pd, dev);
>> +             if (ret != -EAGAIN)
>> +                     break;
>> +             cond_resched();
>> +     }
>> +
>> +     if (ret < 0) {
>> +             dev_err(dev, "failed to add to PM domain %s: %d",
>> +                     pd->name, ret);
>> +             of_node_put(dev->of_node);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>> +
>> +/**
>> + * genpd_dev_pm_detach - Detach a device from its PM domain.
>> + * @dev: Device to attach.
>> + *
>> + * Try to locate a corresponding generic PM domain, which the device was
>> + * attached to previously. If such is found, the device is detached from it.
>> + *
>> + * Returns 0 on successfully detached PM domain or negative error code.
>> + */
>> +int genpd_dev_pm_detach(struct device *dev)
>> +{
>> +     struct generic_pm_domain *pd = NULL, *gpd;
>> +     int ret = 0;
>> +
>> +     if (!dev->pm_domain)
>> +             return -ENODEV;
>> +
>> +     mutex_lock(&gpd_list_lock);
>> +     list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
>> +             if (&gpd->domain == dev->pm_domain) {
>> +                     pd = gpd;
>> +                     break;
>> +             }
>> +     }
>> +     mutex_unlock(&gpd_list_lock);
>> +
>> +     if (!pd)
>> +             return -ENOENT;
>> +
>> +     dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>> +
>> +     while (1) {
>> +             ret = pm_genpd_remove_device(pd, dev);
>> +             if (ret != -EAGAIN)
>> +                     break;
>> +             cond_resched();
>> +     }
>> +
>> +     if (ret < 0) {
>> +             dev_err(dev, "failed to remove from PM domain %s: %d",
>> +                     pd->name, ret);
>> +             return ret;
>> +     }
>> +
>> +     /* Check if PM domain can be powered off after removing this device. */
>> +     genpd_queue_power_off_work(pd);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(genpd_dev_pm_detach);
>> +#endif
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index ebc4c76..b09eaa7 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -310,4 +310,61 @@ static inline void pm_genpd_syscore_poweron(struct device *dev)
>>       pm_genpd_syscore_switch(dev, false);
>>  }
>>
>> +/* OF PM domain providers */
>> +struct of_device_id;
>> +
>> +struct genpd_onecell_data {
>> +     struct generic_pm_domain **domains;
>> +     unsigned int num_domains;
>> +};
>> +
>> +typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
>> +                                             void *data);
>> +
>> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>> +int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>> +                     void *data);
>> +void of_genpd_del_provider(struct device_node *np);
>> +
>> +struct generic_pm_domain *__of_genpd_xlate_simple(
>> +                                     struct of_phandle_args *genpdspec,
>> +                                     void *data);
>> +struct generic_pm_domain *__of_genpd_xlate_onecell(
>> +                                     struct of_phandle_args *genpdspec,
>> +                                     void *data);
>> +
>> +int genpd_dev_pm_attach(struct device *dev);
>> +int genpd_dev_pm_detach(struct device *dev);
>> +#else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>> +static inline int __of_genpd_add_provider(struct device_node *np,
>> +                                     genpd_xlate_t xlate, void *data)
>> +{
>> +     return 0;
>> +}
>> +static inline void of_genpd_del_provider(struct device_node *np) {}
>> +
>> +#define __of_genpd_xlate_simple              NULL
>> +#define __of_genpd_xlate_onecell     NULL
>> +
>> +static inline int genpd_dev_pm_attach(struct device *dev)
>> +{
>> +     return -ENODEV;
>> +}
>> +static inline int genpd_dev_pm_detach(struct device *dev)
>> +{
>> +     return -ENODEV;
>> +}
>> +#endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>> +
>> +static inline int of_genpd_add_provider_simple(struct device_node *np,
>> +                                     struct generic_pm_domain *genpd)
>> +{
>> +     return __of_genpd_add_provider(np, __of_genpd_xlate_simple, genpd);
>> +}
>> +static inline int of_genpd_add_provider_onecell(struct device_node *np,
>> +                                     struct genpd_onecell_data *data)
>> +{
>> +     return __of_genpd_add_provider(np, __of_genpd_xlate_onecell, data);
>> +}
>> +
>>  #endif /* _LINUX_PM_DOMAIN_H */
>> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
>> index e4e4121..897619b 100644
>> --- a/kernel/power/Kconfig
>> +++ b/kernel/power/Kconfig
>> @@ -302,6 +302,10 @@ config PM_GENERIC_DOMAINS_RUNTIME
>>       def_bool y
>>       depends on PM_RUNTIME && PM_GENERIC_DOMAINS
>>
>> +config PM_GENERIC_DOMAINS_OF
>> +     def_bool y
>> +     depends on PM_GENERIC_DOMAINS && OF && !ARCH_EXYNOS
>> +
>>  config CPU_PM
>>       bool
>>       depends on SUSPEND || CPU_IDLE
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
