From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Fri, 11 Nov 2016 01:06:09 +0100
Message-ID: <CAJZ5v0gAFmsZ3_YSG1VBzi=K-GTn+SnUj3K3mJ5Su1gCpiB3jQ@mail.gmail.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
 <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com> <20161110184910.GA135921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161110184910.GA135921@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 7:49 PM, Brian Norris <briannorris@chromium.org> wrote:
> On Thu, Nov 10, 2016 at 10:13:55AM -0800, Dmitry Torokhov wrote:
>> On Thu, Nov 10, 2016 at 10:07 AM, Brian Norris <briannorris@chromium.org> wrote:
>> > It's important that user space can figure out what device woke the
>> > system from suspend -- e.g., for debugging, or for implementing
>> > conditional wake behavior. Dedicated wakeup IRQs don't currently do
>> > that.
>> >
>> > Let's report the event (pm_wakeup_event()) and also allow drivers to
>> > synchronize with these events in their resume path (hence, disable_irq()
>> > instead of disable_irq_nosync()).
>>
>> Hmm, dev_pm_disable_wake_irq() is called from
>> rpm_suspend()/rpm_resume() that take dev->power.lock spinlock and
>> disable interrupts. Dropping _nosync() feels dangerous.
>
> Indeed. So how do you suggest we get sane wakeup reports? Every device
> or bus that's going to use the dedicated wake APIs has to
> synchronize_irq() [1] in their resume() routine? Seems like an odd
> implementation detail to have to remember (and therefore most drivers
> will get it wrong).
>
> Brian
>
> [1] Or maybe at least create a helper API that will extract the
> dedicated wake IRQ number and do the synchronize_irq() for us, so
> drivers don't have to stash this separately (or poke at
> dev->power.wakeirq->irq) for no good reason.

Well, in the first place, can anyone please refresh my memory on why
it is necessary to call dev_pm_disable_wake_irq() under power.lock?

Thanks,
Rafael
