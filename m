From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Fri, 29 Apr 2016 14:47:22 -0700
Message-ID: <CAJFUiJgSDwtpXWPcGu704=5tggOntmyfk=muOtDLRcSUJQc8Rg@mail.gmail.com>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com>
 <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com>
 <alpine.DEB.2.11.1604221834430.3941@nanos> <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com>
 <alpine.DEB.2.11.1604251018090.3941@nanos> <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com>
 <alpine.DEB.2.11.1604271216400.3941@nanos> <CAJFUiJir_zvQDXub=1zwPKJoZm_AnWNpGXuSUiCeHAEwEEUCMQ@mail.gmail.com>
 <alpine.DEB.2.11.1604280813570.3941@nanos> <CAJFUiJgUDSYE+6MG3riVyFjhhqckeY_3nEqer52tkUOy_yBeOw@mail.gmail.com>
 <alpine.DEB.2.11.1604290240560.3718@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1604290240560.3718@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 28, 2016 at 5:44 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 28 Apr 2016, Lianwei Wang wrote:
>> On Wed, Apr 27, 2016 at 11:15 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Wed, 27 Apr 2016, Lianwei Wang wrote:
>> >> Yes. In our project, there is a kernel driver which register a pm
>> >> notifier. On some conditions this pm notifier will return an error and
>> >> abort the suspend process. The counter will be unbalanced in case it
>> >> happened.
>> >
>> > So what? You wreckaged your driver, so you fix it and be done with it.
>>
>> Do you mean no pm_notifier callback can return an error or NOTIFY_BAD
>> to abort the suspend process?
>>
>> It's not the driver issue. The driver return an error to abort the
>> suspend process on purpose. Why do you think it is not allowed to
>> return an error to abort suspend?
>>
>> The issue is very clear as described below.
>> 1. How the issue happened?
>> One of the pm notifier return error to abort suspend before
>> cpu_hotplug_disable() is called on PM_SUSPEND_PREPARE.
>>
>> 2. What's the result?
>> CPU hotplug work in a wrong way, or it doesn't work anymore. No way to
>> recover it.
>>
>> 3. The root cause is that there is no any handling for the unbalanced
>> cpu_hotplug_disable/enable calling. This patch add a protection for
>> such issue.
>
> Wrong. This is the symptom. The root cause is in #1. Therefor you are trying
> to fix the symptom and not the root cause
>
I don't understand why you keep saying that the issue is in the pm
notifier callback. As I told you, the pm notifier return an error(or
NOTIFY_BAD) on purpose to abort the suspend process. This is work as
design. Any driver can abort the suspend process if it is not ready to
suspend.

I know your maintainers are busy but it is not hard for you to
understand it. If you did not look at the suspend code for a long time
then you can look at it now.

Below are some examples to return error to abort the suspend on
PM_SUSPEND_PREPARE pm notifier.
http://lxr.free-electrons.com/source/arch/x86/power/cpu.c#L290
http://lxr.free-electrons.com/source/arch/s390/kernel/suspend.c#L164
http://lxr.free-electrons.com/source/drivers/s390/cio/css.c#L840
http://lxr.free-electrons.com/source/drivers/devfreq/exynos/exynos5_bus.c#L202

>> Anything not clear?
>
> No.
>
> I completely understand that you are tyring to put the cart before the horse.
No. Your understanding is wrong.
>
> Thanks,
>
>         tglx
