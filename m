From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Mon, 13 Mar 2017 15:19:39 +0100
Message-ID: <CAMuHMdVfkD935iJdsmTLA4HTsqXW1M21TxJfGZTmXqSPwQqY8A@mail.gmail.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <52493231-71f4-1b62-b325-8532e63e4229@nvidia.com> <CAMuHMdUAN+PHr_GSvyMzA8N6LgzPEXhQyG_rSwFUOvc9_v7JiA@mail.gmail.com>
 <f4b3a93e-e29f-6fc6-6e7f-8c51081cbe15@nvidia.com> <CAPDyKFp20tDickB9mF1ZSRUvYBEsfATysENeMzGV9O8KXH2wig@mail.gmail.com>
 <3e88692d-613b-9c25-2554-7d399c45637a@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33047 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbdCMOTm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 10:19:42 -0400
In-Reply-To: <3e88692d-613b-9c25-2554-7d399c45637a@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>

Hi Jon,

On Mon, Mar 13, 2017 at 3:09 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
> On 13/03/17 11:45, Ulf Hansson wrote:
>> +Bj=C3=B6rn
>>
>> On 13 March 2017 at 10:37, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> Looks like there is still some interest/needs in/for this. Any thoughts
>>> on how we can move this forward?
>>
>> At the Linaro Connect last week, I was talking to Bj=C3=B6rn, Rajendra a=
nd
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
>         dev-xyz {
>                 ...
>                 power-domains =3D <&domain-a>, <&domain-b>;
>         };
>
> Then in the genpd core we do having something like ...
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e697dec9d25b..d1ae6ddf4903 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2026,6 +2026,15 @@ int genpd_dev_pm_attach(struct device *dev)
>                                                 "samsung,power-domain", 0=
);
>                 if (!pd_args.np)
>                         return -ENOENT;
> +       } else if (ret > 1) {
> +               /*
> +                * If there are more than one PM domain defined for a dev=
ice,
> +                * then these need to be manually controlled by the devic=
e
> +                * driver because the genpd core cannot bind a device wit=
h

Which device driver?
The driver for the device that belongs to multiple PM domains?
The PM domain providers?

> +                * more than one PM domain.
> +                */
> +               dev_dbg(dev, "cannot add PM domains, %d detected!\n", ret=
);
> +               return 0;
>         }
>
> Then add some new public APIs for getting and controlling the pm-domains =
...
>
> struct generic_pm_domain *pm_genpd_get(struct device *dev, char *name);
> - Use 'dev->of_node' to look-up pm-domain if populated, else uses name.
>
> struct generic_pm_domain *of_pm_genpd_get(struct device *dev, int index);
> void pm_genpd_put(struct generic_pm_domain *pd);
> int pm_genpd_power_on(struct generic_pm_domain *pd);
> int pm_genpd_power_off(struct generic_pm_domain *pd);
> - Power on/off APIs would be synchronous types
>
> Are there any potential pitfalls of the above?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
