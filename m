From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
Date: Wed, 18 Jun 2014 19:23:47 +0200
Message-ID: <53A1CB23.5090307@collabora.com>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com> <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com> <539F4D44.3070309@wwwdotorg.org> <53A03186.3040703@collabora.com> <53A069B6.6070902@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53A069B6.6070902-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 06/17/2014 06:15 PM, Stephen Warren wrote:
> On 06/17/2014 06:16 AM, Tomeu Vizoso wrote:
>> On 06/16/2014 10:02 PM, Stephen Warren wrote:
>>> On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
>>>> +#ifdef CONFIG_TEGRA124_EMC
>>>> +int tegra124_emc_reserve_bandwidth(unsigned int consumer, unsigned
>>>> long rate);
>>>> +void tegra124_emc_set_floor(unsigned long freq);
>>>> +void tegra124_emc_set_ceiling(unsigned long freq);
>>>> +#else
>>>> +int tegra124_emc_reserve_bandwidth(unsigned int consumer, unsigned
>>>> long rate)
>>>> +{ return -ENODEV; }
>>>> +void tegra124_emc_set_floor(unsigned long freq)
>>>> +{ return; }
>>>> +void tegra124_emc_set_ceiling(unsigned long freq)
>>>> +{ return; }
>>>> +#endif
>>>
>>> I'll repeat what I said off-list so that we can have the whole
>>> conversation on the list:
>>>
>>> That looks like a custom Tegra-specific API. I think it'd be much better
>>> to integrate this into the common clock framework as a standard clock
>>> constraints API. There are other use-cases for clock constraints besides
>>> EMC scaling (e.g. some in audio on Tegra, and I'm sure many on other
>>> SoCs too).
>>
>> Yes, I wrote a bit in the cover letter about our requirements and how
>> they map to the CCF. Could you please comment on that?
>
> My comments remain the same. I believe this is something that belongs in
> the clock driver, or at the least, some API that takes a struct clock as
> its parameter, so that drivers can use the existing DT clock lookup
> mechanism.

Ok, let me put this strawman here to see if I have gotten close to what 
you have in mind:

* add per-client accounting (Rabin's patches referenced before)

* add clk_set_floor, to be used by cpufreq, load stats, etc.

* add clk_set_ceiling, to be used by battery drivers, thermal, etc.

* an EMC driver would collect bandwidth and latency requests from 
consumers and call clk_set_floor on the EMC clock.

* the EMC driver would also register for rate change notifications in 
the EMC clock and would update the latency allowance registers at that 
point.

How does it sound?

Regards,

Tomeu
