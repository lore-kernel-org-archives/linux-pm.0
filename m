From: "Nayak, Rajendra" <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Wed, 15 Mar 2017 09:17:04 +0530
Message-ID: <e91820bc-1f6c-54c2-842e-f226307a8a62@codeaurora.org>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <52493231-71f4-1b62-b325-8532e63e4229@nvidia.com>
 <CAMuHMdUAN+PHr_GSvyMzA8N6LgzPEXhQyG_rSwFUOvc9_v7JiA@mail.gmail.com>
 <f4b3a93e-e29f-6fc6-6e7f-8c51081cbe15@nvidia.com>
 <CAPDyKFp20tDickB9mF1ZSRUvYBEsfATysENeMzGV9O8KXH2wig@mail.gmail.com>
 <3e88692d-613b-9c25-2554-7d399c45637a@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3e88692d-613b-9c25-2554-7d399c45637a-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hey Jon,

>>> Looks like there is still some interest/needs in/for this. Any thoughts
>>> on how we can move this forward?
>>
>> At the Linaro Connect last week, I was talking to Björn, Rajendra and
>> Stephen more about these related issues.
>>
>> It definitely seems like we need to progress with this somehow,
>> meaning we need a solution for being able to associate a device with
>> more than one PM domain. In that context, I don't think genpd based on
>> its current design, is a good fit to solve the problem.
>>
>> Instead I think we need something entirely new (perhaps some code can
>> be borrowed from genpd), which is more similar to the clock/regulator
>> framework. In other words, what you also were suggesting in a earlier
>> reply.
>> In this way, the driver/subsystem gains full flexibility of managing
>> its device's PM domains, which seems like the best future-proof
>> solution.
>
> I agree, I think that that would give us the most flexibility to handle
> whatever scenario. However, I was thinking that we could still use the
> genpd core to register pm-domains with and control. My thought was to
> allow devices to have a bindings with multiple pm-domains ...
>
> 	dev-xyz {
> 		...
> 		power-domains = <&domain-a>, <&domain-b>;
> 	};
>
> Then in the genpd core we do having something like ...
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e697dec9d25b..d1ae6ddf4903 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2026,6 +2026,15 @@ int genpd_dev_pm_attach(struct device *dev)
>                                                 "samsung,power-domain", 0);
>                 if (!pd_args.np)
>                         return -ENOENT;
> +       } else if (ret > 1) {
> +               /*
> +                * If there are more than one PM domain defined for a device,
> +                * then these need to be manually controlled by the device
> +                * driver because the genpd core cannot bind a device with
> +                * more than one PM domain.
> +                */
> +               dev_dbg(dev, "cannot add PM domains, %d detected!\n", ret);
> +               return 0;
>         }
>
> Then add some new public APIs for getting and controlling the pm-domains ...
>
> struct generic_pm_domain *pm_genpd_get(struct device *dev, char *name);
> - Use 'dev->of_node' to look-up pm-domain if populated, else uses name.
>
> struct generic_pm_domain *of_pm_genpd_get(struct device *dev, int index);
> void pm_genpd_put(struct generic_pm_domain *pd);
> int pm_genpd_power_on(struct generic_pm_domain *pd);
> int pm_genpd_power_off(struct generic_pm_domain *pd);
> - Power on/off APIs would be synchronous types

These would also need some kind of usecounting I guess, since genpd
otherwise relies on runtime PM to do the usecounting.

This overall seems like a reasonable approach to solve the problem we
have. While we discussed this approach at connect, we thought it would
be a good idea to bring out some RFC on these lines to get the
discussion going. Do you think you would be able to work on some quick 
RFC around these lines, else if you think you would be busy in the near 
term I can help with hacking up the changes as well.

regards,
Rajendra

>
> Are there any potential pitfalls of the above?
>
> Cheers
> Jon
>
