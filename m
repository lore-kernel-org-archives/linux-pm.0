From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
Date: Fri, 21 Sep 2018 15:15:40 +0200
Message-ID: <CAJZ5v0jumjrJN2YgeuXK9eZ-JM2Vv73SFoH_71qZxyax24C+-Q@mail.gmail.com>
References: <20180913160851.18169-1-vkuznets@redhat.com> <4793718.OcKebjM5bH@aspire.rjw.lan>
 <87d0tg88l3.fsf@vitty.brq.redhat.com> <20180914162103.GA11171@redhat.com>
 <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com>
 <20180917165518.GA25931@redhat.com> <87d0t70zdn.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87d0t70zdn.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 21, 2018 at 3:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 09/17, Rafael J. Wysocki wrote:
> >>
> >> On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >> >
> >> > > > Since you are adding the notifier anyway, what about designing it to make
> >> > > > the thread wait on _PREPARE until the notifier kicks it again on exit
> >> > > > fron suspend/hibernation?
> >> >
> >> > Well. I agree that freezable kthreads are not nice, but it seems you are
> >> > going to add another questionable interface ;)
> >>
> >> Why would it be questionable?
> >>
> >> The watchdog needs to be disarmed somehow before tasks are frozen and
> >> re-armed after they have been thawed or it may report false-positives
> >> on the way out.  PM notifiers can be used for that.
> >
> > Or watchdog() can simply use set_freezable/freezing interface we already
> > have, without additional complications.
> >
> > Yes, this is not "before tasks are frozen", but probably should work?
> >
> > OK, I won't argue.
>
> I was hoping you and Rafael will come to an agreement but the discussion
> just died ... so where do we stand on this? I see the following options:
>
> 1) The v1 patch is good, no freezing/disabling/parking required.

This would work IMO, but it also is somewhat wasteful to run this
thread when "suspended", because it doesn't do anything then.

Maybe you could simply force "timeout" to be zero for the "suspension"
time?  That should effectively make the thread sleep then, right?

Thanks,
Rafael
