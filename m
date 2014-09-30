From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 00/11] ARM: shmobile: r8a7740/armadillo800eva legacy PM
 domain support
Date: Tue, 30 Sep 2014 09:28:40 +0200
Message-ID: <CAMuHMdXP9tFX9FZnH_dR86DkKbP_YZcWAF-hF48BtVfGYRTsFw@mail.gmail.com>
References: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
	<20140930042047.GA24253@verge.net.au>
	<CAMuHMdUgP6OEt6G4VhHoDncz+17j-bDu7u_pcHM0ETmqsDKOiA@mail.gmail.com>
	<CANqRtoS+bur8DA0+gG0Q0hL9RLsQdOLyfSUbgE_6nZ8mCST0Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:42630 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaI3H2m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 03:28:42 -0400
In-Reply-To: <CANqRtoS+bur8DA0+gG0Q0hL9RLsQdOLyfSUbgE_6nZ8mCST0Jg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Magnus,

On Tue, Sep 30, 2014 at 9:22 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>>> There are a few dependencies to make resume from s2ram work:
>>>>   - "[PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq re-enable on
>>>>     resume",
>>>>   - "[PATCH] ARM: hw_breakpoint: Trap undef instruction exceptions on wake-up",
>>>>     or an alternative solution.
>>>>
>>>> Apart from that, I'm not aware of any regressions (except perhaps for USB,
>>>> which I was unable to get working anyway).
>>>
>>> Hi Geert,
>>>
>>> what is your feeling about (me) queueing up part of all of this series now?
>>
>> If you (Magnus?) can live with non-working resume from s2ram for now,
>> it can be queued for v3.19.
>
> If the series as a whole introduces a known regression then I think we
> should only merge the portions that work without introducing some
> issue.
>
>> I don't think I can improve on the HDMI fix without getting docs and spending
>> (much) time to get HDMI working on Armadillo.
>
> Ok, and I suspect it is quite unlikely we will receive any improved
> docs for r8a7740.

So I will resubmit the HDMI fix.

>> The hw_breakpoint fix has to be replaced by something better/acceptable,
>> I'm working on that.
>
> Thanks!
>
> So what is a good way to proceed with this series I wonder?

There are two options:
  1. Drop the two patches that introduce the D4 and A4MP PM domains,
  2. Amend the patches that introduce the D4 and A4MP PM domains to
     comment out the entries in the table in pm-r8a7740.c, like was done in
     the first submission.

Both will cause conflicts when applying the successive patches.

If you don't care about bisectability, you can implement option 2 as a
separate change, after applying the whole series.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
