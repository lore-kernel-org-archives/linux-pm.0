From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2 00/11] ARM: shmobile: r8a7740/armadillo800eva legacy PM
 domain support
Date: Tue, 30 Sep 2014 16:22:07 +0900
Message-ID: <CANqRtoS+bur8DA0+gG0Q0hL9RLsQdOLyfSUbgE_6nZ8mCST0Jg@mail.gmail.com>
References: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
	<20140930042047.GA24253@verge.net.au>
	<CAMuHMdUgP6OEt6G4VhHoDncz+17j-bDu7u_pcHM0ETmqsDKOiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUgP6OEt6G4VhHoDncz+17j-bDu7u_pcHM0ETmqsDKOiA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On Tue, Sep 30, 2014 at 4:16 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Simon,
>
> On Tue, Sep 30, 2014 at 6:20 AM, Simon Horman <horms@verge.net.au> wrote:
>> On Thu, Sep 25, 2014 at 06:15:31PM +0200, Geert Uytterhoeven wrote:
>>> This series improves PM domain support for r8a7740/armadillo800eva legacy,
>>> mimicking (parts of) the existing PM domain support for sh7372/mackerel.
>>>
>>> More specifically, they
>>>   - Add missing devices to existing PM domains,
>>>   - Add missing PM domains, hooking up devices and subdomains,
>>>
>>> Changes in v2:
>>>   - Dropped FIXMes on behavior that turned out to be expected,
>>>   - Hook up the HDMI-Link hardware block,
>>>   - Really add the A4MP and D4 PM domains, as fixes are available (see
>>>     dependencies below),
>>>   - Move special CPU domain handling from A4S to A3SM,
>>>
>>> There are a few dependencies to make resume from s2ram work:
>>>   - "[PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq re-enable on
>>>     resume",
>>>   - "[PATCH] ARM: hw_breakpoint: Trap undef instruction exceptions on wake-up",
>>>     or an alternative solution.
>>>
>>> Apart from that, I'm not aware of any regressions (except perhaps for USB,
>>> which I was unable to get working anyway).
>>
>> Hi Geert,
>>
>> what is your feeling about (me) queueing up part of all of this series now?
>
> If you (Magnus?) can live with non-working resume from s2ram for now,
> it can be queued for v3.19.

If the series as a whole introduces a known regression then I think we
should only merge the portions that work without introducing some
issue.

> I don't think I can improve on the HDMI fix without getting docs and spending
> (much) time to get HDMI working on Armadillo.

Ok, and I suspect it is quite unlikely we will receive any improved
docs for r8a7740.

> The hw_breakpoint fix has to be replaced by something better/acceptable,
> I'm working on that.

Thanks!

So what is a good way to proceed with this series I wonder?

Cheers,

/ magnus
