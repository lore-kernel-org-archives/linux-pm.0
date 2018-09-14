From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
Date: Fri, 14 Sep 2018 18:21:03 +0200
Message-ID: <20180914162103.GA11171@redhat.com>
References: <20180913160851.18169-1-vkuznets@redhat.com>
 <4793718.OcKebjM5bH@aspire.rjw.lan>
 <87d0tg88l3.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d0tg88l3.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 09/14, Vitaly Kuznetsov wrote:
>
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> > On Thursday, September 13, 2018 6:08:51 PM CEST Vitaly Kuznetsov wrote:
> ...
> 
> >> +static int hungtask_pm_notify(struct notifier_block *self,
> >> +			      unsigned long action, void *hcpu)
> >> +{
> >> +	switch (action) {
> >> +	case PM_SUSPEND_PREPARE:
> >> +	case PM_HIBERNATION_PREPARE:
> >> +		hung_detector_suspended = true;
> >> +		break;
> >> +	case PM_POST_SUSPEND:
> >> +	case PM_POST_HIBERNATION:
> >> +		hung_detector_suspended = false;
> >> +		break;
> >> +	default:
> >> +		break;
> >> +	}
> >> +	return NOTIFY_OK;
> >> +}
> >> +
> >>  /*
> >>   * kthread which checks for tasks stuck in D state
> >>   */
> >> @@ -261,7 +282,8 @@ static int watchdog(void *dummy)
> >>  		interval = min_t(unsigned long, interval, timeout);
> >>  		t = hung_timeout_jiffies(hung_last_checked, interval);
> >
> > Since you are adding the notifier anyway, what about designing it to make
> > the thread wait on _PREPARE until the notifier kicks it again on exit
> > fron suspend/hibernation?

Well. I agree that freezable kthreads are not nice, but it seems you are
going to add another questionable interface ;)

Vitaly, could you please update the changelog to explain in details whats
going on?

Where does the caller of pm_suspend() sleep in D state? Why it sleeps more
than 120 seconds?

And. given that it takes system_transition_mutex anyway, can't it use
lock_system_sleep() which marks the caller as PF_FREEZER_SKIP (checked
in check_hung_task()) ?

I have to admit I got lost...

> We can either park the kthread (kthread_park/unpark)

No, no, please don't. Nobody outside of smpboot.c should use this (and
this interface should be reworked). Yes, there are already abused, but
please don't add new users.

Oleg.
