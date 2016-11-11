From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Fri, 11 Nov 2016 22:40:50 +0100
Message-ID: <CAJZ5v0ipnv_prvGg9LWZk0xz=RA8E84nR3Lq3cqcCpoyCJjxag@mail.gmail.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
 <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
 <20161110184910.GA135921@google.com> <20161110204911.GK27724@atomide.com>
 <20161110213038.GA108490@google.com> <20161111164753.GD7138@atomide.com> <20161111194041.GA111624@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161111194041.GA111624@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 11, 2016 at 8:40 PM, Brian Norris <briannorris@chromium.org> wrote:
> On Fri, Nov 11, 2016 at 08:47:54AM -0800, Tony Lindgren wrote:
>> But sounds like the threaded IRQ is not your concern and you mostly
>
> Right, threaded is OK for this; it's not performance critical. It just
> highlighted the fact that its completion is not synchronized with
> anything.
>
>> care about getting the right time for the wake up interrupt.
>
> Not "time", per se, but blame. But that blame is timing related: if it
> comes after the system finished resuming, then it's useless, since
> user-space won't know to come back and check later.
>
>> The wakeup interrupt controller knows something happened earlier,
>> so maybe it could report that time if queried somehow?
>
> Sort of. We have /sys/power/pm_wakeup_irq already. But it's really less
> useful to get IRQ-level stats for this, than to get device info. AFAICT,
> there's no machine-readable association between IRQs and devices; the
> best you can get is by parsing the names in /proc/interrupts.
>
> Or, if we really want to say that's sufficient, then maybe we should
> kill all the device-level wakeup stats in sysfs... (Is that what the
> flamewar was all about? I hope I'm not poking the hornet's nest.)

Do you mean the wakeup_* attributes in <device>/power/ ?

If so, then they are in there, because they were asked for by people
at the time they were introduced (I can't recall exactly who wanted
them, though), but if they are not useful to anyone after all (and I
guess that this is the case), they can just go away as far as I'm
concerned.

Thanks,
Rafael
