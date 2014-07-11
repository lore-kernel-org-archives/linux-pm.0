From: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
Date: Fri, 11 Jul 2014 17:14:10 +0300
Message-ID: <53BFF132.3020700@nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>	<1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com> <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 11/07/14 07:35, Viresh Kumar wrote:
> Hi Tuomas,
>
> On 11 July 2014 03:12, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> Add a new cpufreq driver for Tegra124. Instead of using the PLLX as
>> the CPU clocksource, switch immediately to the DFLL. It allows the use
>> of higher clock rates, and will automatically scale the CPU voltage as
>> well. We also rely on the DFLL driver to determine the CPU clock
>> frequencies that the chip supports, so that we can directly build a
>> cpufreq table with the OPP library helper dev_pm_opp_init_cpufreq_table.
>>
>> This driver is a completely independent of the old cpufreq driver
>> (tegra-cpufreq), which is only used on Tegra20.
>>
>> Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> Please reuse cpufreq-cpu0 instead of adding a new driver. Similar
> is being adopted by all platforms now: krait, mvebu, etc..
>

Sure, I can do the CPU clock parent change first and then instantiate 
the cpufreq-cpu0 driver, like highbank-cpufreq. That'll depend on the 
patch 'cpufreq: cpu0: OPPs can be populated at runtime' from your 
'Extend support beyond CPU0' series though, any idea when that patch 
will land in?


-- 
nvpublic
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
