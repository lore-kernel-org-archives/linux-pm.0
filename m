From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Mon, 25 Apr 2016 23:58:51 -0700
Message-ID: <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com>
 <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com>
 <alpine.DEB.2.11.1604221834430.3941@nanos> <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com>
 <alpine.DEB.2.11.1604251018090.3941@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36660 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbcDZG7N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 02:59:13 -0400
In-Reply-To: <alpine.DEB.2.11.1604251018090.3941@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, Apr 25, 2016 at 1:22 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 22 Apr 2016, Lianwei Wang wrote:
>> Any way is Ok for debugging purpose. But think the kernel run on a
>> customer machine, such as PC, Mobile phone or other devices. How we
>> let the customer debug it but not recover it smartly?
>
> There is nothing smart here. Restoring the count is a bandaid and has nothing
> to do with recovery. If that WARN_ON triggers then other stuff is going to be
> more fundamentally wrong so restoring the count is the least of our worries.
>
You are still think it from a developer view. You can not let the
customer/consumer to fix such issue, right? You even can not let the
customer/consumer to wait for the fix, right?

Take the suspend for example, the suspend_prepare will call
pm_notifier_call_chain to send PM_SUSPEND_PREPARE notification. If one
of the function on the chain return NOTIFY_BAD or NOTIFY_STOP before
calling cpu_hotplug_pm_callback, then either way will cause the
cpu_hotplug_disable() not called in
cpu_hotplug_pm_callback(PM_SUSPEND_PREPARE). When the suspend is going
to call pm_notifier_call_chain(PM_POST_SUSPEND) ->
cpu_hotplug_pm_callback -> cpu_hotplug_enable() , then it is
Unbalanced...

There are other paths to cause the counter unbalanced too. But no
matter how it is unbalanced, we can detect it and recover it to normal
state.

>> Anyway, from a product perspective way, if we don't want to restore
>> the unbalanced counter to 0, then maybe a BUG_ON is more reasonable
>> than WARN_ON.
>
> Not at all. BUG_ON is the last resort if we have no other way to handle an
> issue.
Actually to the customer, you do nothing currently at all, and once it
happened then there is no way for the customer to recover it except do
a power cycle. A BUG_ON can trigger a power cycle and recover it.
>
> Thanks,
>
>         tglx
