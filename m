From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v2 1/4] cpufreq: pxa: use generic platdev driver for device-tree
Date: Fri, 21 Oct 2016 17:17:49 +0200
Message-ID: <87insl3f4y.fsf@belgarion.home>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
        <1476561450-28407-2-git-send-email-robert.jarzmik@free.fr>
        <20161018113835.GB11471@vireshk-i7> <87r37d4qlw.fsf@belgarion.home>
        <20161019135208.GG11471@vireshk-i7> <87bmyg3xzh.fsf@belgarion.home>
        <20161020033435.GD11766@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161020033435.GD11766@vireshk-i7> (Viresh Kumar's message of
        "Thu, 20 Oct 2016 09:04:35 +0530")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On 19-10-16, 22:06, Robert Jarzmik wrote:
>> Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>> 
>> >> >> +	{ .compatible = "marvell,pxa250", },
>> >> >> +	{ .compatible = "marvell,pxa270", },
>> >> >>  
>> >> >>  	{ .compatible = "samsung,exynos3250", },
>> >> >>  	{ .compatible = "samsung,exynos4210", },
>> >> >
>> >> > Isn't there a race between cpufreq-dt and the platform driver to
>> >> > register first ?
>> >> Ah, could you be more specific about the race you're talking of ?
>> >> 
>> >> My understanding was that cpufreq-dt-platdev does create the device, and
>> >> cpufreq-dt is a driver for it, so there is no race but a direct relationship
>> >> AFAIU.
>> >
>> > I mean that both the driver may try to register to the cpufreq core if
>> > they are both compiled in a single image.
>> Euh I still don't follow you. The only driver that can register to the cpufreq
>> core is cpufreq-dt.
>
> I was wondering on what will happen if both cpufreq-dt and your pxa2xx-cpufreq
> driver are present in the same kernel image. In that case the init routines of
> both of them will try to call cpufreq_register_driver().
Right.

In my case, cpufreq-dt comes first, and wins.
pxa_cpu_init() calls cpufreq_register_driver() and returns -EEXIST.

Cheers.

-- 
Robert
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
