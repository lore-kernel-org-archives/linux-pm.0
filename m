From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2 00/11] ARM: shmobile: r8a7740/armadillo800eva legacy PM
 domain support
Date: Tue, 30 Sep 2014 16:32:38 +0900
Message-ID: <CANqRtoS0XgyuMBxU3CcVyQNg=r=MuA_OfJEDJbVsq-m9EHF9UA@mail.gmail.com>
References: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
	<20140930042047.GA24253@verge.net.au>
	<CAMuHMdUgP6OEt6G4VhHoDncz+17j-bDu7u_pcHM0ETmqsDKOiA@mail.gmail.com>
	<CANqRtoS+bur8DA0+gG0Q0hL9RLsQdOLyfSUbgE_6nZ8mCST0Jg@mail.gmail.com>
	<CAMuHMdXP9tFX9FZnH_dR86DkKbP_YZcWAF-hF48BtVfGYRTsFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXP9tFX9FZnH_dR86DkKbP_YZcWAF-hF48BtVfGYRTsFw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On Tue, Sep 30, 2014 at 4:28 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Tue, Sep 30, 2014 at 9:22 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>>>> There are a few dependencies to make resume from s2ram work:
>>>>>   - "[PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq re-enable on
>>>>>     resume",
>>>>>   - "[PATCH] ARM: hw_breakpoint: Trap undef instruction exceptions on wake-up",
>>>>>     or an alternative solution.
>>>>>
>>>>> Apart from that, I'm not aware of any regressions (except perhaps for USB,
>>>>> which I was unable to get working anyway).
>>>>
>>>> Hi Geert,
>>>>
>>>> what is your feeling about (me) queueing up part of all of this series now?
>>>
>>> If you (Magnus?) can live with non-working resume from s2ram for now,
>>> it can be queued for v3.19.
>>
>> If the series as a whole introduces a known regression then I think we
>> should only merge the portions that work without introducing some
>> issue.
>>
>>> I don't think I can improve on the HDMI fix without getting docs and spending
>>> (much) time to get HDMI working on Armadillo.
>>
>> Ok, and I suspect it is quite unlikely we will receive any improved
>> docs for r8a7740.
>
> So I will resubmit the HDMI fix.
>
>>> The hw_breakpoint fix has to be replaced by something better/acceptable,
>>> I'm working on that.
>>
>> Thanks!
>>
>> So what is a good way to proceed with this series I wonder?
>
> There are two options:
>   1. Drop the two patches that introduce the D4 and A4MP PM domains,
>   2. Amend the patches that introduce the D4 and A4MP PM domains to
>      comment out the entries in the table in pm-r8a7740.c, like was done in
>      the first submission.
>
> Both will cause conflicts when applying the successive patches.
>
> If you don't care about bisectability, you can implement option 2 as a
> separate change, after applying the whole series.

Thanks for leading the way! From my side I don't have any special
feeling, so why don't you and Simon decide?

If it was up to me only then I think option #1 that simply reduces the
feature set seems rather natural, but perhaps it requires a lot of
rework of the patches. If we go with option #1 we can always
incrementally add D4 and A4MP later I assume.

Cheers,

/ magnus
