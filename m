From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
Date: Wed, 22 Feb 2017 15:57:11 +0100
Message-ID: <CAJZ5v0ihFCe0phwKQHDnPETkfPgKDiWw27GOs8jVv1hyahJ+DQ@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
 <20170221174844.GE8605@leverpostej> <CAMuHMdW8JAYrgvWxi8c_ZLtsUWBYFGZ=V7pu2p+cO=NdwLas2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdW8JAYrgvWxi8c_ZLtsUWBYFGZ=V7pu2p+cO=NdwLas2w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 22, 2017 at 3:05 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Hi Mark,
>
> On Tue, Feb 21, 2017 at 6:48 PM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> On Mon, Feb 20, 2017 at 09:33:27PM +0100, Geert Uytterhoeven wrote:
>>> @@ -440,12 +442,14 @@ static int psci_system_suspend_valid(suspend_state_t state)
>>>  static int psci_system_suspend_enter(suspend_state_t state)
>>>  {
>>>       switch (state) {
>>> +     case PM_SUSPEND_MEM:
>>> +             if (!psci_system_suspend_is_power_down ||
>>> +                 !wakeup_source_available())
>>> +                     return cpu_suspend(0, psci_system_suspend);
>>> +             /* fall through */
>>
>> I don't believe that this is the correct place to handle this.
>>
>> The wakeup_source_available() check *might* be ok, though even with that
>> I'd rather we rejected the request rather than trying to fall back to a
>> PSCI_CPU_SUSPEND. Otherwise we have a potential silent power regression.
>
> If we reject the request here, I think the PM core has to be modified to
> try again using a shallower state. Note that it would be better to reject
> the state in the .valid() callback instead of in .enter().
>
> You also have to consider this is dynamic not static.
> I.e. the availability of other wake-up sources may change at runtime (cfr.
> the "wakeup" files in sysfs). Currently pm_sleep_states[] (which controls
> which states are available) is initialized from suspend_set_ops(), and not
> changed later.
>
> Perhaps pm_sleep_states[] should be updated every time the wakeup_sources
> list is changed?

No, the definitions of sleep states *are* static.  They have to be, or
user space won't know what sleep state it is asking for.

And, as I said in my last reply to Sudeep, the list of possible wakeup
devices for the given state is part of that definition.  The sysfs
"wakeup" interface is on top of that, not the other way around (which
seems seems to be what you would want).

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
