From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
Date: Mon, 17 Sep 2018 18:55:18 +0200
Message-ID: <20180917165518.GA25931@redhat.com>
References: <20180913160851.18169-1-vkuznets@redhat.com>
 <4793718.OcKebjM5bH@aspire.rjw.lan>
 <87d0tg88l3.fsf@vitty.brq.redhat.com>
 <20180914162103.GA11171@redhat.com>
 <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 09/17, Rafael J. Wysocki wrote:
>
> On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > > Since you are adding the notifier anyway, what about designing it to make
> > > > the thread wait on _PREPARE until the notifier kicks it again on exit
> > > > fron suspend/hibernation?
> >
> > Well. I agree that freezable kthreads are not nice, but it seems you are
> > going to add another questionable interface ;)
>
> Why would it be questionable?
>
> The watchdog needs to be disarmed somehow before tasks are frozen and
> re-armed after they have been thawed or it may report false-positives
> on the way out.  PM notifiers can be used for that.

Or watchdog() can simply use set_freezable/freezing interface we already
have, without additional complications.

Yes, this is not "before tasks are frozen", but probably should work?

OK, I won't argue.

> > Where does the caller of pm_suspend() sleep in D state? Why it sleeps more
> > than 120 seconds?
>
> It need not be sleeping for over 2 minutes, but if suspend-to-idle
> advances the clock sufficiently, the watchdog will regard that as the
> task sleep time.

As I already said, I don't understand this magic, so you can ignore me.

But again, it would be nice to explain this in the changelog, I mean, how
exactly (and why) jiffies can grow for over 2 minutes in this case.

> > And. given that it takes system_transition_mutex anyway, can't it use
> > lock_system_sleep() which marks the caller as PF_FREEZER_SKIP (checked
> > in check_hung_task()) ?
>
> Well, it could, but that would be somewhat confusing and slightly
> abusing the flag IMO.

OK, I won't insist.

Oleg.
