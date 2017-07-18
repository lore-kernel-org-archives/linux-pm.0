From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Tue, 18 Jul 2017 13:09:48 -0700
Message-ID: <CAGAzgsqwOhTYz9D=XYkMYHBZsmajUH8HJoMOJOe3DfG8WVusRA@mail.gmail.com>
References: <20170708000303.21863-1-dbasehore@chromium.org>
 <CAJZ5v0horA+vgR3bAbEu+AiqEFJ7JyZ49nTv6FBPHRvmXOUFpQ@mail.gmail.com>
 <CAGAzgsoFugSw=UQsJmep0woGg70J3nie0-EtvtQ4Ec1NG1usOg@mail.gmail.com>
 <7467728.lI8lN4PjS8@aspire.rjw.lan> <CAGAzgsq1c3HdMJ9801uqB+7USK9mqt9xtZTbH=EYv0KDLe+8=A@mail.gmail.com>
 <CAJZ5v0jaHAExRdwwhJU9p+tDB1ESEXqgfU_DLXev0su3qZaNBA@mail.gmail.com>
 <CAGAzgsqhV=e8ZuwA7NtOX_tg+HfQfYGg6oTTTRa2bp-LBOZ54w@mail.gmail.com> <alpine.DEB.2.20.1707180838570.1945@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34838 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbdGRUJv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 16:09:51 -0400
Received: by mail-wr0-f177.google.com with SMTP id w4so43668106wrb.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 13:09:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1707180838570.1945@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>

On Mon, Jul 17, 2017 at 11:40 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 17 Jul 2017, dbasehore . wrote:
>> On Mon, Jul 17, 2017 at 6:33 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> I could make a patch to try it out. I would probably add a flag to rtc
>> timers to indicate whether it wakes the system (default true). We
>> would have to add a sync with the rtc irq and the rtc irqwork. I would
>> probably add a rtc_timer_sync function that would flush the rtc irq
>> and flush the irqwork. I would call this after the freeze_ops sync
>> function since the sci irq needs to finish before syncing with the rtc
>> irq. Also, pm_wakeup_irq seems racy with the current implementation of
>> s2idle_loop since the RTC irq could be mistakenly set as pm_wakeup_irq
>> when something else actually triggered the full wakeup. Fortunately, I
>> don't think pm_wakeup_irq is used for anything except debugging, but
>> we might change that.
>
> There is another option which you might consider. We can reserve one of the
> HPET comparators for that purpose and have a special interrupt handler for
> it. Checking the HPET for expiry from the low level code should be trivial.
>

Does that handle setting up new timers properly or does the timer sync
code still need to be written?

> Thanks,
>
>         tglx
>
>
