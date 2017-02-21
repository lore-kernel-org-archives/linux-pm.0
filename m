From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
Date: Tue, 21 Feb 2017 17:32:50 +0100
Message-ID: <CAMuHMdVmu4AYZ6MZHd79N2-2gELR6s3oZ46UnEszCfLvHymY1w@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <20170221110712.GB5021@amd> <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36636 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752992AbdBUQcw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 11:32:52 -0500
In-Reply-To: <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Sudeep,

On Tue, Feb 21, 2017 at 12:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 21/02/17 11:07, Pavel Machek wrote:
>>> Enable support for "shallow" suspend mode, also known as "Standby" or
>>> "Power-On Suspend".
>>>
>>> As secondary CPU cores are taken offline, "shallow" suspend mode saves
>>> slightly more power than "s2idle", but less than "deep" suspend mode.
>>> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>>> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>>> an optional API in PSCI v1.0.
>>
>> If system supports "shallow" suspend, why does not PSCI implement it?
>
> Yes it can, and IIUC it already does on this platform with CPU_SUSPEND.
> All it now needs is just to use existing "freeze" suspend mode in Linux.

How can Linux know if using "deep" suspend will allow to wake-up the system
according to configured wake-up sources, or not?

Note that "it will not, ever" is an accepted answer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
