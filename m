From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Platform-specific suspend/resume code in drivers
Date: Fri, 10 Jun 2016 15:39:16 +0200
Message-ID: <CAMuHMdUCGamgurk+oocuvbXW_UOnoGLx+2=8Gez0s5-gowoAWA@mail.gmail.com>
References: <57588D80.4010502@free.fr> <Pine.LNX.4.44L0.1606091054140.1697-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34879 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcFJNjS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 09:39:18 -0400
Received: by mail-io0-f180.google.com with SMTP id o127so19628935iod.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2016 06:39:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1606091054140.1697-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mason <slash.tmp@free.fr>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>, Mark Rutland <mark.rutland@arm.com>

Hi Alan,

On Thu, Jun 9, 2016 at 5:05 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 8 Jun 2016, Mason wrote:
>> On 08/06/2016 19:45, Alan Stern wrote:
>> > On Wed, 8 Jun 2016, Mason wrote:
>> >> On 07/06/2016 17:06, Alan Stern wrote:
>> >>> On Tue, 7 Jun 2016, Mason wrote:
>> >>>> Another point of confusion for me is this: drivers are supposed to
>> >>>> be shared among platforms, right? So my platform-specific suspend
>> >>>> code should be enabled only if my platform is detected at run-time?
>> >>>
>> >>> Is your device platform-specific?  If it is then the driver is also
>> >>> platform-specific, and so no part of the driver will be called at
>> >>> runtime unless your platform is detected.
>> >>
>> >> Specifically, my platform uses
>> >> drivers/net/ethernet/aurora/nb8800.c  => 3 entries in of_match_table.
>> >> drivers/tty/serial/8250/8250_core.c (CONFIG_SERIAL_8250_RT288X variant)
>> >>
>> >> and also the XHCI USB3 driver, and AHCI SATA driver, wouldn't I need to
>> >> save the context for these too?
>> >
>> > Those drivers should already take care of their own contexts.  Is
>> > there anything platform-specific you need to do in addition?
>>
>> Take the eth driver, for example:
>>
>>   http://lxr.free-electrons.com/source/drivers/net/ethernet/aurora/nb8800.c
>>
>> It doesn't have any suspend/resume callbacks.
>>
>> Would that make the suspend request fail?
>
> There are plenty of drivers that don't have suspend/resume callbacks.
> (Fewer than there used to be, fortunately.)  They don't make suspend
> fail; rather, the PM core just skips over them when carrying out a
> suspend.
>
> Of course, if a driver needs suspend support but doesn't include it,
> then it's quite likely the driver will not work properly after the
> system has been resumed.  But that's not a platform-specific issue.

It may be. The same device may be present on different SoCs. On some
SoCs, the device may be part of a power area, on others not.
When running on the former SoC, the driver needs to save/restore registers,
while this is not needed (but harmless, except for a small time impact)
on the latter SoC.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
