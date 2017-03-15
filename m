From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Wed, 15 Mar 2017 08:57:56 +0000
Message-ID: <03e7f4d0-0c1b-edbb-3e24-83faf4b3a12b@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <52493231-71f4-1b62-b325-8532e63e4229@nvidia.com>
 <CAMuHMdUAN+PHr_GSvyMzA8N6LgzPEXhQyG_rSwFUOvc9_v7JiA@mail.gmail.com>
 <f4b3a93e-e29f-6fc6-6e7f-8c51081cbe15@nvidia.com>
 <CAPDyKFp20tDickB9mF1ZSRUvYBEsfATysENeMzGV9O8KXH2wig@mail.gmail.com>
 <3e88692d-613b-9c25-2554-7d399c45637a@nvidia.com>
 <CAPDyKFp6wWZghMuCV5iL=zA=u+m22ibtzB95ktzOPJjfRLi1eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFp6wWZghMuCV5iL=zA=u+m22ibtzB95ktzOPJjfRLi1eg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


On 13/03/17 14:42, Ulf Hansson wrote:
> On 13 March 2017 at 15:09, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> Hi Ulf,
>>
>> On 13/03/17 11:45, Ulf Hansson wrote:
>>> +Björn
>>>
>>> On 13 March 2017 at 10:37, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>> Hi Rafael, Kevin, Ulf,
>>>>
>>>> Looks like there is still some interest/needs in/for this. Any thoughts
>>>> on how we can move this forward?
>>>
>>> At the Linaro Connect last week, I was talking to Björn, Rajendra and
>>> Stephen more about these related issues.
>>>
>>> It definitely seems like we need to progress with this somehow,
>>> meaning we need a solution for being able to associate a device with
>>> more than one PM domain. In that context, I don't think genpd based on
>>> its current design, is a good fit to solve the problem.
>>>
>>> Instead I think we need something entirely new (perhaps some code can
>>> be borrowed from genpd), which is more similar to the clock/regulator
>>> framework. In other words, what you also were suggesting in a earlier
>>> reply.
>>> In this way, the driver/subsystem gains full flexibility of managing
>>> its device's PM domains, which seems like the best future-proof
>>> solution.
>>
>> I agree, I think that that would give us the most flexibility to handle
>> whatever scenario. However, I was thinking that we could still use the
>> genpd core to register pm-domains with and control. My thought was to
>> allow devices to have a bindings with multiple pm-domains ...
>>
>>         dev-xyz {
>>                 ...
>>                 power-domains = <&domain-a>, <&domain-b>;
>>         };
> 
> This could work. However, let's involve DT maintainers to make sure we
> get their input to this. Perhaps they prefer a different approach.

No problem. I should point out the above is for the #power-domain-cells
= <0> case.

>>
>> Then in the genpd core we do having something like ...
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index e697dec9d25b..d1ae6ddf4903 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2026,6 +2026,15 @@ int genpd_dev_pm_attach(struct device *dev)
>>                                                 "samsung,power-domain", 0);
>>                 if (!pd_args.np)
>>                         return -ENOENT;
>> +       } else if (ret > 1) {
>> +               /*
>> +                * If there are more than one PM domain defined for a device,
>> +                * then these need to be manually controlled by the device
>> +                * driver because the genpd core cannot bind a device with
>> +                * more than one PM domain.
>> +                */
>> +               dev_dbg(dev, "cannot add PM domains, %d detected!\n", ret);
>> +               return 0;
>>         }
>>
>> Then add some new public APIs for getting and controlling the pm-domains ...
>>
>> struct generic_pm_domain *pm_genpd_get(struct device *dev, char *name);
>> - Use 'dev->of_node' to look-up pm-domain if populated, else uses name.
>>
>> struct generic_pm_domain *of_pm_genpd_get(struct device *dev, int index);
>> void pm_genpd_put(struct generic_pm_domain *pd);
>> int pm_genpd_power_on(struct generic_pm_domain *pd);
>> int pm_genpd_power_off(struct generic_pm_domain *pd);
>> - Power on/off APIs would be synchronous types
>>
>> Are there any potential pitfalls of the above?
> 
> So if I understand correctly, you would like to extend genpd with some
> new APIs. It's worth a try, however my main worries are these:
> 
> 1) These new API must not be allowed to be abused.
> I have seen that before as when people try to handle some corner
> cases, I don't want to that to happen again. To avoid that, perhaps we
> should continue the re-structuring and thus move structures/datas that
> are currently public, to be internal to genpd. To get a clean
> interface.

OK, fair enough. Any in particular you are concerned about?

> 2) I wouldn't be surprised if we run into some tricky corner cases, as
> we get a mixture of devices handled by runtime PM and in some other
> cases via new APIs. Perhaps that can be sorted out!?

Right that is a concern, however, I think that in the long-term we would
be better off with the power-domains being controlled by the same
underlying code as opposed to something different.

Cheers
Jon

-- 
nvpublic
