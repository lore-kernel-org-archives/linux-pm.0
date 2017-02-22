From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
Date: Wed, 22 Feb 2017 14:47:39 +0100
Message-ID: <CAMuHMdU0fTtEXN9k477e3S-UUMNhd=U4_r0VOcyA1TGEgA5rmA@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <20170221110712.GB5021@amd> <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
 <CAMuHMdVmu4AYZ6MZHd79N2-2gELR6s3oZ46UnEszCfLvHymY1w@mail.gmail.com> <3caf0f3f-76e5-cb1e-7c0f-87ed5e1c2b86@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <3caf0f3f-76e5-cb1e-7c0f-87ed5e1c2b86@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On Tue, Feb 21, 2017 at 6:22 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 21/02/17 16:32, Geert Uytterhoeven wrote:
>> On Tue, Feb 21, 2017 at 12:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> On 21/02/17 11:07, Pavel Machek wrote:
>>>>> Enable support for "shallow" suspend mode, also known as "Standby" or
>>>>> "Power-On Suspend".
>>>>>
>>>>> As secondary CPU cores are taken offline, "shallow" suspend mode saves
>>>>> slightly more power than "s2idle", but less than "deep" suspend mode.
>>>>> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>>>>> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>>>>> an optional API in PSCI v1.0.
>>>>
>>>> If system supports "shallow" suspend, why does not PSCI implement it?
>>>
>>> Yes it can, and IIUC it already does on this platform with CPU_SUSPEND.
>>> All it now needs is just to use existing "freeze" suspend mode in Linux.
>>
>> How can Linux know if using "deep" suspend will allow to wake-up the system
>> according to configured wake-up sources, or not?
>
> I am not sure if we have such selective configuration of wakeup source
> implemented in Linux.
>
> ACPI specification has some provisions where each device can state if it
> can specify device state in each system sleeping state that can wake the
> system.
>
> DT has no mechanism today to express this relations. I had brought up
> this discussion in plumbers(2015). Refer slide 7 in [0]
>
> And the way you are trying to do that is not correct IMO especially
> making it just PSCI specific.
>
>> Note that "it will not, ever" is an accepted answer.
>
> IIUC, it's not implemented today. I can't talk about future ;), but your

Good, so there's no need for the DT property, and drivers/firmware/psci.c
should aways call do_cpu_idle() instead of PSCI SYSTEM_SUSPEND if any
other wake-up sources are configured?

That follows the principle of least surprise: it doesn't leave the user with
a system that won't wake up the way he configured it to wake up.

> proposal is horrible hack.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
