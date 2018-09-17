From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
Date: Mon, 17 Sep 2018 10:25:44 +0200
Message-ID: <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com>
References: <20180913160851.18169-1-vkuznets@redhat.com> <4793718.OcKebjM5bH@aspire.rjw.lan>
 <87d0tg88l3.fsf@vitty.brq.redhat.com> <20180914162103.GA11171@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180914162103.GA11171@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 09/14, Vitaly Kuznetsov wrote:
> >
> > "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> >
> > > On Thursday, September 13, 2018 6:08:51 PM CEST Vitaly Kuznetsov wrote:
> > ...
> >
> > >> +static int hungtask_pm_notify(struct notifier_block *self,
> > >> +                        unsigned long action, void *hcpu)
> > >> +{
> > >> +  switch (action) {
> > >> +  case PM_SUSPEND_PREPARE:
> > >> +  case PM_HIBERNATION_PREPARE:
> > >> +          hung_detector_suspended = true;
> > >> +          break;
> > >> +  case PM_POST_SUSPEND:
> > >> +  case PM_POST_HIBERNATION:
> > >> +          hung_detector_suspended = false;
> > >> +          break;
> > >> +  default:
> > >> +          break;
> > >> +  }
> > >> +  return NOTIFY_OK;
> > >> +}
> > >> +
> > >>  /*
> > >>   * kthread which checks for tasks stuck in D state
> > >>   */
> > >> @@ -261,7 +282,8 @@ static int watchdog(void *dummy)
> > >>            interval = min_t(unsigned long, interval, timeout);
> > >>            t = hung_timeout_jiffies(hung_last_checked, interval);
> > >
> > > Since you are adding the notifier anyway, what about designing it to make
> > > the thread wait on _PREPARE until the notifier kicks it again on exit
> > > fron suspend/hibernation?
>
> Well. I agree that freezable kthreads are not nice, but it seems you are
> going to add another questionable interface ;)

Why would it be questionable?

The watchdog needs to be disarmed somehow before tasks are frozen and
re-armed after they have been thawed or it may report false-positives
on the way out.  PM notifiers can be used for that.

Or do you mean that the synchronization between it and the freezer
that's already there should be sufficient?

> Vitaly, could you please update the changelog to explain in details whats
> going on?
>
> Where does the caller of pm_suspend() sleep in D state? Why it sleeps more
> than 120 seconds?

It need not be sleeping for over 2 minutes, but if suspend-to-idle
advances the clock sufficiently, the watchdog will regard that as the
task sleep time.

> And. given that it takes system_transition_mutex anyway, can't it use
> lock_system_sleep() which marks the caller as PF_FREEZER_SKIP (checked
> in check_hung_task()) ?

Well, it could, but that would be somewhat confusing and slightly
abusing the flag IMO.

Also, if the watchdog is stopped before the task freezing kicks in and
restarted after they have been all thawed, it will not have to
synchronize with the freezer any more I suppose?

Cheers,
Rafael
