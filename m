From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Mon, 13 Mar 2017 15:38:20 +0100
Message-ID: <CAMuHMdU9uEaRuqkGFcrJqVCBa0KLiDgZmV1twqF5+tQVj4Ukkg@mail.gmail.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <52493231-71f4-1b62-b325-8532e63e4229@nvidia.com> <CAMuHMdUAN+PHr_GSvyMzA8N6LgzPEXhQyG_rSwFUOvc9_v7JiA@mail.gmail.com>
 <f4b3a93e-e29f-6fc6-6e7f-8c51081cbe15@nvidia.com> <CAPDyKFp20tDickB9mF1ZSRUvYBEsfATysENeMzGV9O8KXH2wig@mail.gmail.com>
 <3e88692d-613b-9c25-2554-7d399c45637a@nvidia.com> <CAMuHMdVfkD935iJdsmTLA4HTsqXW1M21TxJfGZTmXqSPwQqY8A@mail.gmail.com>
 <161ee6b9-7a76-c7b4-3cb4-06259fef4898@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <161ee6b9-7a76-c7b4-3cb4-06259fef4898-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Jon,

On Mon, Mar 13, 2017 at 3:27 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> On 13/03/17 14:19, Geert Uytterhoeven wrote:
>> On Mon, Mar 13, 2017 at 3:09 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote=
:
>>> On 13/03/17 11:45, Ulf Hansson wrote:
>>>> +Bj=C3=B6rn
>>>>
>>>> On 13 March 2017 at 10:37, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>>> Looks like there is still some interest/needs in/for this. Any though=
ts
>>>>> on how we can move this forward?
>>>>
>>>> At the Linaro Connect last week, I was talking to Bj=C3=B6rn, Rajendra=
 and
>>>> Stephen more about these related issues.
>>>>
>>>> It definitely seems like we need to progress with this somehow,
>>>> meaning we need a solution for being able to associate a device with
>>>> more than one PM domain. In that context, I don't think genpd based on
>>>> its current design, is a good fit to solve the problem.
>>>>
>>>> Instead I think we need something entirely new (perhaps some code can
>>>> be borrowed from genpd), which is more similar to the clock/regulator
>>>> framework. In other words, what you also were suggesting in a earlier
>>>> reply.
>>>> In this way, the driver/subsystem gains full flexibility of managing
>>>> its device's PM domains, which seems like the best future-proof
>>>> solution.
>>>
>>> I agree, I think that that would give us the most flexibility to handle
>>> whatever scenario. However, I was thinking that we could still use the
>>> genpd core to register pm-domains with and control. My thought was to
>>> allow devices to have a bindings with multiple pm-domains ...
>>>
>>>         dev-xyz {
>>>                 ...
>>>                 power-domains =3D <&domain-a>, <&domain-b>;
>>>         };
>>>
>>> Then in the genpd core we do having something like ...
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index e697dec9d25b..d1ae6ddf4903 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -2026,6 +2026,15 @@ int genpd_dev_pm_attach(struct device *dev)
>>>                                                 "samsung,power-domain",=
 0);
>>>                 if (!pd_args.np)
>>>                         return -ENOENT;
>>> +       } else if (ret > 1) {
>>> +               /*
>>> +                * If there are more than one PM domain defined for a d=
evice,
>>> +                * then these need to be manually controlled by the dev=
ice
>>> +                * driver because the genpd core cannot bind a device w=
ith
>>
>> Which device driver?
>> The driver for the device that belongs to multiple PM domains?
>
> Yes, exactly. So maybe I would need to say ... "manually controlled by
> the driver for *this* device ..."

That looks a bit cumbersome to me.

Power (and clock) domains are platform features.  Any IP core may show up
in a new SoC, and suddenly have become part of one or more PM Domains.
Having to handle that in each individual driver will cause lots of churn.
Especially as the multiple PM Domains a device may belong to may be
fairly orthogonal to each other.

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
