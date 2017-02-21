From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
Date: Tue, 21 Feb 2017 18:45:13 +0000
Message-ID: <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <69ab75a1-2e04-19e2-d1ad-12ca1cfc7625@arm.com>
 <CAMuHMdWjseO3XSOH2XCbM411Aj12RpdZZbHkpfFUfej58myz5Q@mail.gmail.com>
 <445b2f49-5d15-30af-a431-1c4edcd049a4@arm.com>
 <CAMuHMdUS96tPJRqNxG6sJjvC0LN-FjCeKOm7Zg2V_qMeQ_1QSQ@mail.gmail.com>
 <81df65a9-d2f1-26df-a977-5265feba25a3@arm.com>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <94167d3a-e005-3af0-d290-a1086684d570-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 21/02/17 18:27, Sudeep Holla wrote:
> 
> 
> On 21/02/17 17:51, Sudeep Holla wrote:
>>
>>
>> On 21/02/17 17:34, Geert Uytterhoeven wrote:
> 
> [...]
> 
>>>
>>> The SoC can wake-up. It's just not guaranteed that it can wake-up using
>>> the wakeup-source configured from Linux. Which wakeup-sources are available
>>> depends on the actual PSCI implementation.  It's not specified by the PSCI
>>> specification.
>>>
>>>> Just botching whatever shallow state you can enter on a particular SoC
>>>> into standard "mem" state sounds *horrible* to me.
>>>
>>> That's more or less what /sys/power/mem_sleep does, though.
>>>
>>
>> OK, I will go through that in detail.
>>
> 
> OK, I went through the patch and the main intention is was added.
> So I will begin by summarizing my understanding:
> 
> A new suspend interface(/sys/power/mem_sleep) is added to allow the
> "mem" string in /sys/power/state to represent multiple things that can
> be selected.
> 
> Before:
> A. echo freeze > /sys/power/state ---> Enters s2idle
> B. echo mem > /sys/power/state ---> Enters s2r(a.k.a now deep mem sleep)
> 
> After:
> 1. echo freeze > /sys/power/state ---> Enters s2idle still same
> 2. echo s2idle > /sys/power/mem_sleep
>    echo mem > /sys/power/state ---> Also enter s2idle
> 3. echo deep > /sys/power/mem_sleep
>    echo mem > /sys/power/state ---> Also enter s2r(same as [B] above)
> 
> Please note I have carefully dropped standby/shallow as we will not
> support that state on ARM64 platforms(refer previous discussions for the
> same)
> 
> Now IIUC, you need 2 above. So, since this new interface allow mem to
> mean "s2idle", we need to fix the core to register default suspend_ops
> to achieve what you need. 

I take this back, you have everything you need in place, nothing needs
to be done. I just checked again. If I don't register PSCI suspend_ops,
I still get mem in /sys/power/state with s2idle in /sys/power/mem_sleep
which is exactly what we need. Again we don't support standby/shallow
state on ARM64/PSCI.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
