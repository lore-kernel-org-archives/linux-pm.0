From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 1/4] cpufreq: pxa: use generic platdev driver for device-tree
Date: Wed, 19 Oct 2016 22:06:10 +0200
Message-ID: <87bmyg3xzh.fsf@belgarion.home>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
        <1476561450-28407-2-git-send-email-robert.jarzmik@free.fr>
        <20161018113835.GB11471@vireshk-i7> <87r37d4qlw.fsf@belgarion.home>
        <20161019135208.GG11471@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161019135208.GG11471@vireshk-i7> (Viresh Kumar's message of
        "Wed, 19 Oct 2016 19:22:08 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

>> >> +	{ .compatible = "marvell,pxa250", },
>> >> +	{ .compatible = "marvell,pxa270", },
>> >>  
>> >>  	{ .compatible = "samsung,exynos3250", },
>> >>  	{ .compatible = "samsung,exynos4210", },
>> >
>> > Isn't there a race between cpufreq-dt and the platform driver to
>> > register first ?
>> Ah, could you be more specific about the race you're talking of ?
>> 
>> My understanding was that cpufreq-dt-platdev does create the device, and
>> cpufreq-dt is a driver for it, so there is no race but a direct relationship
>> AFAIU.
>
> I mean that both the driver may try to register to the cpufreq core if
> they are both compiled in a single image.
Euh I still don't follow you. The only driver that can register to the cpufreq
core is cpufreq-dt.

Now the only case I see is that there are 2 cpufreq-dt platform_device created
from cpufreq-dt-platdev. Given that there is only 1 call to
platform_device_register_data() in it, I don't see how it is possible.

Now if you are worried that 2 cpufreq-dt devices are created, ie. 1 for pxa25x
and one for pxa27x:
 - this looks impossible given the cpufreq_dt_platdev_init() code
 - no device-tree will ever be compatible with both of them, even if a single
   kernel binary will be compatible with both of them

Tell me if this is the information you're looking for.

Cheers.

-- 
Robert
