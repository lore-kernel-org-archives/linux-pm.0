From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Wed, 15 Mar 2017 09:03:26 +0000
Message-ID: <3827826f-72b6-d5f8-eca0-5a3a8cfe32d0@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <52493231-71f4-1b62-b325-8532e63e4229@nvidia.com>
 <CAMuHMdUAN+PHr_GSvyMzA8N6LgzPEXhQyG_rSwFUOvc9_v7JiA@mail.gmail.com>
 <f4b3a93e-e29f-6fc6-6e7f-8c51081cbe15@nvidia.com>
 <CAPDyKFp20tDickB9mF1ZSRUvYBEsfATysENeMzGV9O8KXH2wig@mail.gmail.com>
 <3e88692d-613b-9c25-2554-7d399c45637a@nvidia.com>
 <e91820bc-1f6c-54c2-842e-f226307a8a62@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e91820bc-1f6c-54c2-842e-f226307a8a62@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rajendra,

On 15/03/17 03:47, Nayak, Rajendra wrote:
> Hey Jon,
> 
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
>>     dev-xyz {
>>         ...
>>         power-domains = <&domain-a>, <&domain-b>;
>>     };
>>
>> Then in the genpd core we do having something like ...
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index e697dec9d25b..d1ae6ddf4903 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2026,6 +2026,15 @@ int genpd_dev_pm_attach(struct device *dev)
>>                                                
>> "samsung,power-domain", 0);
>>                 if (!pd_args.np)
>>                         return -ENOENT;
>> +       } else if (ret > 1) {
>> +               /*
>> +                * If there are more than one PM domain defined for a
>> device,
>> +                * then these need to be manually controlled by the
>> device
>> +                * driver because the genpd core cannot bind a device
>> with
>> +                * more than one PM domain.
>> +                */
>> +               dev_dbg(dev, "cannot add PM domains, %d detected!\n",
>> ret);
>> +               return 0;
>>         }
>>
>> Then add some new public APIs for getting and controlling the
>> pm-domains ...
>>
>> struct generic_pm_domain *pm_genpd_get(struct device *dev, char *name);
>> - Use 'dev->of_node' to look-up pm-domain if populated, else uses name.
>>
>> struct generic_pm_domain *of_pm_genpd_get(struct device *dev, int index);
>> void pm_genpd_put(struct generic_pm_domain *pd);
>> int pm_genpd_power_on(struct generic_pm_domain *pd);
>> int pm_genpd_power_off(struct generic_pm_domain *pd);
>> - Power on/off APIs would be synchronous types
> 
> These would also need some kind of usecounting I guess, since genpd
> otherwise relies on runtime PM to do the usecounting.

Yes exactly.

> This overall seems like a reasonable approach to solve the problem we
> have. While we discussed this approach at connect, we thought it would
> be a good idea to bring out some RFC on these lines to get the
> discussion going. Do you think you would be able to work on some quick
> RFC around these lines, else if you think you would be busy in the near
> term I can help with hacking up the changes as well.

Yes I plan too. I will let you know if I get side tracked on something else.

Cheers!
Jon

-- 
nvpublic
