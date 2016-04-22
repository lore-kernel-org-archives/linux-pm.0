From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Fri, 22 Apr 2016 14:58:26 -0700
Message-ID: <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com>
 <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com>
 <alpine.DEB.2.11.1604221834430.3941@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35726 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbcDVV6r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 17:58:47 -0400
In-Reply-To: <alpine.DEB.2.11.1604221834430.3941@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, Apr 22, 2016 at 9:37 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 22 Apr 2016, Lianwei Wang wrote:
>
>> On Thu, Apr 21, 2016 at 3:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Wed, Apr 20, 2016 at 09:56:07PM -0700, Lianwei Wang wrote:
>> >> Currently it just print a warning message but did not
>> >> reset cpu_hotplug_disabled when the enable/disable is
>> >> unbalanced. The unbalanced enable/disable will lead
>> >> the cpu hotplug work abnormally.
>> >>
>> >> Reset it to 0 when an unablanced enable detected.
>> >
>> > How can this happen in the first place?
>>
>> That's is my question too, and why we check it with WARN_ON here?
>> Obviously it is possible to happened because the
>> cpu_hotplug_disable/enable are both kernel API and any driver can call
>> it. A unbalanced check is a good way to handle it.
>>
>> The actually problem here is that what we do in case it happened? Just
>> give a warning or do some error handling and recover it back? This's
>> my focus..
>
> Actually we do nothing if it happens. We just emit a warning and that's good
> enough because the machine is still accessible and therefor debugable. It just
> renders cpu hotplug useless, but that's not a fundamental problem. If you look
> at the checks we do with preempt count, where we actually restore the counter
> that's a different issue. If we would not do that we simply would break the
> machine completely and end up in an endless storm of warnings. Different
> story, but that hotplug thing is just not in that class of problems.
>
> Thanks,
>
>         tglx

Any way is Ok for debugging purpose. But think the kernel run on a
customer machine, such as PC, Mobile phone or other devices. How we
let the customer debug it but not recover it smartly?

If it happened then the cpu hotplug is not useless but may work in a
wrong way. E.g. the cpu_hotplug_disabled now is -1 after the last call
of cpu_hotplug_enable, then it is actually DISABLED but not enabled,
and the following  call of cpu_hotplug_disable is actually enable but
not disable. There is no way for the customer or end user to recover
it except do a power cycle and reboot.

Anyway, from a product perspective way, if we don't want to restore
the unbalanced counter to 0, then maybe a BUG_ON is more reasonable
than WARN_ON.
