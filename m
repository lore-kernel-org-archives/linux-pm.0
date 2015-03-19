From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Skip latency measurements if timekeeping is suspended
Date: Thu, 19 Mar 2015 09:54:06 +0100
Message-ID: <CAMuHMdXc7kbvbT5-ahYi1Yex4iyYzH44WUnFT26RObxWL_3UXA@mail.gmail.com>
References: <1426695946-21705-1-git-send-email-geert+renesas@glider.be>
	<19573969.Pdd3px1nTO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36063 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbCSIyH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 04:54:07 -0400
In-Reply-To: <19573969.Pdd3px1nTO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Rafael,

On Wed, Mar 18, 2015 at 11:30 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, March 18, 2015 05:25:46 PM Geert Uytterhoeven wrote:
>> The PM Domain code uses ktime_get() to perform various latency
>> measurements.  However, if ktime_get() is called while timekeeping is
>> suspended, the following warning is printed:
>>
>>     WARNING: CPU: 0 PID: 1340 at kernel/time/timekeeping.c:576 ktime_get+0x30/0xf4()
>>
>> This happens when resuming the PM Domain that contains the clock events
>> source. Chain of operations is:
>>
>>     timekeeping_resume()
>>     {
>>         clockevents_resume()
>>             sh_cmt_clock_event_resume()
>>                 pm_genpd_syscore_poweron()
>>                     pm_genpd_sync_poweron()
>>                         genpd_power_on()
>>                             ktime_get(), but timekeeping_suspended == 1
>>         ...
>>         timekeeping_suspended = 0;
>>     }
>>
>> Skip all latency measurements if timekeeping is suspended to fix this.
>
> I don't think that this is where we should fix it.  At least using
> timekeeping_suspended outside of the timekeeping core would not be
> welcome by its maintainers.

It's a public symbol, declared in a header file ;-)

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> I'm not sure if this is needed for all latency measurements.
>> So far I only encountered it while powering-on a clock domain during
>> resume from s2ram.
>
> The problem seems to be that the clock domain is powered on in a
> syscore resume routine which happens to be called before timekeeping_resume().

The clock domain is powered on from _within_ timekeeping_resume().

> It looks like we either need to force the right ordering somehow or have a
> special variant of GENPD_DEV_TIMED_CALLBACK() for syscore suspend/resume that
> won't do the latency measurement at all (which doesn't make much sense at
> this point, because time is effectively "frozen" then).

That's an option.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
