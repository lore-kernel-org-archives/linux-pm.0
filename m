From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
Date: Mon, 17 Sep 2018 23:09:58 +0200
Message-ID: <CAJZ5v0h9zPofaJCxshZgcEuBDELDKS4e4oQAn9m8KmNCdFR1eQ@mail.gmail.com>
References: <20180913160851.18169-1-vkuznets@redhat.com> <4793718.OcKebjM5bH@aspire.rjw.lan>
 <87d0tg88l3.fsf@vitty.brq.redhat.com> <20180914162103.GA11171@redhat.com>
 <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com> <20180917165518.GA25931@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917165518.GA25931@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 17, 2018 at 6:55 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 09/17, Rafael J. Wysocki wrote:
> >
> > On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > > > Since you are adding the notifier anyway, what about designing it to make
> > > > > the thread wait on _PREPARE until the notifier kicks it again on exit
> > > > > fron suspend/hibernation?
> > >
> > > Well. I agree that freezable kthreads are not nice, but it seems you are
> > > going to add another questionable interface ;)
> >
> > Why would it be questionable?
> >
> > The watchdog needs to be disarmed somehow before tasks are frozen and
> > re-armed after they have been thawed or it may report false-positives
> > on the way out.  PM notifiers can be used for that.
>
> Or watchdog() can simply use set_freezable/freezing interface we already
> have, without additional complications.
>
> Yes, this is not "before tasks are frozen", but probably should work?

Well, not really.

It is a kernel thread and therefore it is frozen after all user space
and thawed before it.

> OK, I won't argue.
>
> > > Where does the caller of pm_suspend() sleep in D state? Why it sleeps more
> > > than 120 seconds?
> >
> > It need not be sleeping for over 2 minutes, but if suspend-to-idle
> > advances the clock sufficiently, the watchdog will regard that as the
> > task sleep time.
>
> As I already said, I don't understand this magic, so you can ignore me.

Suspend-to-RAM suspends timekeeping (among other things) on the way to
system-wide suspend and resumes it on the way back to the working
state.  The time between those two events is not added to the
monotonic clock and jiffies is not updated while timekeeping is
suspended. As a result, the new jiffies value doesn't include the time
when the system is in the sleep state.  In that case the 2 minutes
interval is more than enough to cover the two system transitions (into
system-wide suspend and back) and the sleep time doesn't count.

Suspend-to-idle, OTOH, only suspends timekeeping when the last CPU
goes idle and resumes it when the first CPU is woken up.  That may
take place for multiple times in a row while the system is regarded as
suspended, due to spurious wakeups.  While the time when timekeeping
is suspended still doesn't count (the monotonic clock is not advanced
and jiffies is not updated then), the time when at least one CPU is
not idle counts.  Hence, if the system is in suspend-to-idle for a
sufficiently long time and there are sufficiently many spurious
wakeups during that period, the monotonic clock and jiffies may be
advanced by over 2 minutes while the system is regarded as suspended.

> But again, it would be nice to explain this in the changelog, I mean, how
> exactly (and why) jiffies can grow for over 2 minutes in this case.

Agreed, the changelog should explain that.

> > > And. given that it takes system_transition_mutex anyway, can't it use
> > > lock_system_sleep() which marks the caller as PF_FREEZER_SKIP (checked
> > > in check_hung_task()) ?
> >
> > Well, it could, but that would be somewhat confusing and slightly
> > abusing the flag IMO.
>
> OK, I won't insist.

OK :-)

Cheers,
Rafael
