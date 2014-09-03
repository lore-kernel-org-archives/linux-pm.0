From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/9] PM / Domains: Add generic OF-based power domain look-up
Date: Wed, 3 Sep 2014 13:24:25 +0200
Message-ID: <CAPDyKFp=-y3upzR9sSVek6__KuYAOsoL_rb98+rE25h9cKc99w@mail.gmail.com>
References: <1409215142-8218-1-git-send-email-ulf.hansson@linaro.org>
	<1409215142-8218-3-git-send-email-ulf.hansson@linaro.org>
	<CAMuHMdWJ3kPE8=OAc=YV5iD=zDUaGMn6GH60g3dZzKLYLiJnww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:48217 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbaICLY1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 07:24:27 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so1055348lbj.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 04:24:25 -0700 (PDT)
In-Reply-To: <CAMuHMdWJ3kPE8=OAc=YV5iD=zDUaGMn6GH60g3dZzKLYLiJnww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.>

On 2 September 2014 20:28, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf, Tomasz,
>
> On Thu, Aug 28, 2014 at 10:38 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> From: Tomasz Figa <t.figa@samsung.com>
>>
>> This patch introduces generic code to perform power domain look-up using
>
> Should "power domain" be replaced by "PM domain" here (and everywhere else
> in this patch), too, cfr. Rafael's earlier comment?

Hi Geert,

Thanks for reviewing!

I changed some of the other patches according to Rafael's earlier
comment, but decided to keep this as is. The reason is that in
drivers/base/power/domain.c there are already a mix between using
"power domain" and "PM domain", thus I couldn't decide which way to
go.

I have no strong opinion of what terminology we use, I am happy to
change this patch. Since I anyway will be sending new version, I will
update to "PM domain".

>
>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>> @@ -0,0 +1,51 @@
>> +* Generic power domains
>> +
>> +System on chip designs are often divided into multiple power domains that
>> +can be used for power gating of selected IP blocks for power saving by
>> +reduced leakage current.
>> +
>> +This device tree binding can be used to bind power domain consumer devices
>> +with their power domains provided by power domain providers. A power domain
>> +provider can be represented by any node in the device tree and can provide
>> +one or more power domains. A consumer node can refer to the provider by
>> +a phandle and a set of phandle arguments (so called power domain specifier)
>
> specifiers
>
>> +of length specified by #power-domain-cells property in the power domain
>
> the #power-domain-cells property
>
>> +provider node.
>> +
>> +==Power domain providers==
>> +
>> +Required properties:
>> + - #power-domain-cells : Number of cells in a power domain specifier;
>> +   Typically 0 for nodes representing a single power domain and 1 for nodes
>> +   providing multiple power domains (e.g. power controllers), but can be
>> +   any value as specified by device tree binding documentation of particular
>> +   provider.
>> +
>> +Example:
>> +
>> +       power: power-controller@12340000 {
>> +               compatible = "foo,power-controller";
>> +               reg = <0x12340000 0x1000>;
>> +               #power-domain-cells = <1>;
>> +       };
>> +
>> +The node above defines a power controller that is a power domain provider
>> +and expects one cell as its phandle argument.
>> +
>> +==Power domain consumers==
>> +
>> +Required properties:
>> + - power-domains : A phandle and power domain specifier as defined by bindings
>> +                   of power controller specified by phandle.
>
> the power controller
>
>> +
>> +Example:
>> +
>> +       leaky-device@12350000 {
>> +               compatible = "foo,i-leak-current";
>> +               reg = <0x12350000 0x1000>;
>> +               power-domains = <&power 0>;
>> +       };
>> +
>> +The node above defines a typical power domain consumer device, which is located
>> +inside power domain with index 0 of power controller represented by node with
>
> the power domain ... the power controller ... the node
>
>> +label "power".
>
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>
>> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>> +/*
>> + * Device Tree based power domain providers.
>> + *
>> + * The code below implements generic device tree based power domain providers
>> + * that bind device tree nodes with generic power domains registered in the
>> + * system.
>> + *
>> + * Any driver that registers generic power domains and need to support binding
>
> needs
>
>> + * of devices to these domains is supposed to register a power domain provider,
>> + * which maps a power domain specifier retrieved from device tree to a power
>
> the device tree
>
>> +/**
>> + * of_genpd_xlate_onecell() - Xlate function for providers using single index.
>
> a single index
>
>> + * @genpdspec: OF phandle args to map into a power domain
>> + * @data: xlate function private data - pointer to struct genpd_onecell_data
>> + *
>> + * This is a generic xlate function that can be used to model simple power
>> + * domain controllers that have one device tree node and provide multiple
>> + * power domains. A single cell is used as an index to an array of power
>
> an index into
>
>> + * domains specified in genpd_onecell_data struct when registering the
>
> the genpd_onecell_data struct
>
>> + * provider.
>> + */
>> +struct generic_pm_domain *of_genpd_xlate_onecell(
>> +                                       struct of_phandle_args *genpdspec,
>> +                                       void *data)
>> +{
>> +       struct genpd_onecell_data *genpd_data = data;
>> +       unsigned int idx = genpdspec->args[0];
>> +
>> +       if (genpdspec->args_count != 1)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (idx >= genpd_data->domain_num) {
>> +               pr_err("%s: invalid domain index %d\n", __func__, idx);
>
> %u for unsigned int idx
>
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       return genpd_data->domains[idx];
>
> This assumes ->domains[] is a contiguous array.
>
> I'd add a NULL check here, to translate NULL to ERR_PTR(-Esomething),
> so it can support sparse power domain spaces.
> E.g. indexed by the "bit_shift" value of struct rmobile_pm_domain, which
> is the actual bit number to use to power up/down an R-Mobile domain.
> Different members of the R-Mobile family have different numbers of
> domains, and use more or less bits in the same power up/down registers.
> This would be similar to the sparse clock-indices handling in
> renesas,cpg-mstp-clocks.
>

OK, will do!

>> +}
>> +EXPORT_SYMBOL_GPL(of_genpd_xlate_onecell);
>> +
>> +/**
>> + * of_genpd_add_provider() - Register a domain provider for a node
>> + * @np: Device node pointer associated with domain provider.
>
> the domain provider
>
>> +/**
>> + * of_genpd_del_provider() - Remove a previously registered domain provider
>> + * @np: Device node pointer associated with domain provider
>
> the domain provider
>
>> +/**
>> + * of_genpd_get_from_provider() - Look-up power domain
>> + * @genpdspec: OF phandle args to use for look-up
>> + *
>> + * Looks for domain provider under node specified by @genpdspec and if found
>
> a domain provider ... under the node
>
>> + * uses xlate function of the provider to map phandle args to a power domain.
>
>> +/**
>> + * genpd_dev_pm_attach - Attach a device to it's power domain using DT.
>
> its
>
>> + * @dev: Device to attach.
>
>> +/**
>> + * genpd_dev_pm_detach - Detach a device from it's power domain.
>
> its
>
>> + * @dev: Device to attach.
>> + *
>> + * Try to locate a corresponding generic power domain, which the device
>> + * then previously were attached to. If found the device is detached from
>
> "was attached to previously"?
>
>> + * the power domain.
>
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 7c1d252..5989758 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -310,4 +310,50 @@ static inline void pm_genpd_syscore_poweron(struct device *dev)
>>         pm_genpd_syscore_switch(dev, false);
>>  }
>>
>> +/* OF power domain providers */
>> +struct of_device_id;
>> +
>> +struct genpd_onecell_data {
>> +       struct generic_pm_domain **domains;
>> +       unsigned int domain_num;
>
> This is the number of domains: "num_domains"?

OK, that describes it better.

>
>> +};
>> +
>> +typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
>> +                                                  void *data);
>> +
>> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>> +int of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>> +                         void *data);
>> +void of_genpd_del_provider(struct device_node *np);
>> +
>> +struct generic_pm_domain *of_genpd_xlate_simple(
>> +                                       struct of_phandle_args *genpdspec,
>> +                                       void *data);
>> +struct generic_pm_domain *of_genpd_xlate_onecell(
>> +                                       struct of_phandle_args *genpdspec,
>> +                                       void *data);
>> +
>> +int genpd_dev_pm_attach(struct device *dev);
>> +int genpd_dev_pm_detach(struct device *dev);
>> +#else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>> +static inline int of_genpd_add_provider(struct device_node *np,
>> +                                       genpd_xlate_t xlate, void *data)
>> +{
>> +       return 0;
>> +}
>> +static inline void of_genpd_del_provider(struct device_node *np) {}
>> +
>> +#define of_genpd_xlate_simple          NULL
>> +#define of_genpd_xlate_onecell         NULL
>> +
>> +static inline int genpd_dev_pm_attach(struct device *dev)
>> +{
>> +       return -ENODEV;
>> +}
>> +static inline int genpd_dev_pm_detach(struct device *dev)
>> +{
>> +       return -ENODEV;
>> +}
>> +#endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>
> As of_genpd_add_provider() provides no compile-time type-checking for
> "void *data", I propose to prepend a double underscore to
> of_genpd_add_provider(), and to the xlate helpers of_genpd_xlate_simple()
> and of_genpd_xlate_onecell(), and provide type-checking wrappers:
>

Good idea, I will give it a try in next version.

> static inline int of_genpd_add_provider_simple(struct device_node *np,
>                                                struct generic_pm_domain *genpd)
> {
>         return __of_genpd_add_provider(np, __of_genpd_xlate_simple, genpd);
> }
> static inline int of_genpd_add_provider_onecell(struct device_node *np,
>                                                 struct genpd_onecell_data *data)
> {
>         return __of_genpd_add_provider(np, __of_genpd_xlate_onecell, data);
> }
>

Thanks for all the grammar/English corrections as well. Will update.

Kind regards
Uffe
