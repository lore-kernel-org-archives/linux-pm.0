From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
Date: Tue, 21 Feb 2017 17:22:14 +0000
Message-ID: <3caf0f3f-76e5-cb1e-7c0f-87ed5e1c2b86@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <20170221110712.GB5021@amd> <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
 <CAMuHMdVmu4AYZ6MZHd79N2-2gELR6s3oZ46UnEszCfLvHymY1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVmu4AYZ6MZHd79N2-2gELR6s3oZ46UnEszCfLvHymY1w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 21/02/17 16:32, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Tue, Feb 21, 2017 at 12:14 PM, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 21/02/17 11:07, Pavel Machek wrote:
>>>> Enable support for "shallow" suspend mode, also known as "Standby" or
>>>> "Power-On Suspend".
>>>>
>>>> As secondary CPU cores are taken offline, "shallow" suspend mode saves
>>>> slightly more power than "s2idle", but less than "deep" suspend mode.
>>>> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>>>> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>>>> an optional API in PSCI v1.0.
>>>
>>> If system supports "shallow" suspend, why does not PSCI implement it?
>>
>> Yes it can, and IIUC it already does on this platform with CPU_SUSPEND.
>> All it now needs is just to use existing "freeze" suspend mode in Linux.
> 
> How can Linux know if using "deep" suspend will allow to wake-up the system
> according to configured wake-up sources, or not?
>

I am not sure if we have such selective configuration of wakeup source
implemented in Linux.

ACPI specification has some provisions where each device can state if it
can specify device state in each system sleeping state that can wake the
system.

DT has no mechanism today to express this relations. I had brought up
this discussion in plumbers(2015). Refer slide 7 in [0]

And the way you are trying to do that is not correct IMO especially
making it just PSCI specific.

> Note that "it will not, ever" is an accepted answer.
>

IIUC, it's not implemented today. I can't talk about future ;), but your
proposal is horrible hack.

-- 
Regards,
Sudeep

[0]
https://linuxplumbersconf.org/2015/ocw//system/presentations/3051/original/wakeup_config.pdf
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
