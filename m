From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2 1/1] kernel/power/autosleep.c: check for pm_suspend() return before queueing suspend again
Date: Mon, 29 Jun 2015 22:07:52 +0200
Message-ID: <2619760.zM2C8Nu9I9@vostro.rjw.lan>
References: <1435581297-20271-1-git-send-email-nitish.a@samsung.com> <1435604054-29711-1-git-send-email-nitish.a@samsung.com> <13445304.liFVyNdj8p@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43570 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753467AbbF2Tlh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 15:41:37 -0400
In-Reply-To: <13445304.liFVyNdj8p@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nitish Ambastha <nitish.a@samsung.com>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpgs@samsung.com, nits.ambastha@gmail.com

On Monday, June 29, 2015 09:56:18 PM Rafael J. Wysocki wrote:
> On Tuesday, June 30, 2015 12:24:14 AM Nitish Ambastha wrote:
> > Prevent tight loop for suspend-resume when some
> > devices failed to suspend
> > If some devices failed to suspend, we monitor this
> > error in try_to_suspend(). pm_suspend() is already
> > an 'int' returning function, how about checking return
> > from pm_suspend() before queueing suspend again?
> > 
> > For devices which do not register for pending events,
> > this will prevent tight loop for suspend-resume in
> > suspend abort scenarios due to device suspend failures

Having said the below I'm not sure why the current code doesn't cover this
for you?

That would be the final_count == initial_count case, no?


> > 
> > Signed-off-by: Nitish Ambastha <nitish.a@samsung.com>
> > ---
> > v2: Rearranged code to make wait entry shared with
> >     existing one as suggested by Pavel Machek <pavel@ucw.cz>
> >     Corrected log level from pr_info to pr_err for failure log
> >     Added return check for hibernate()
> > 
> >  kernel/power/autosleep.c |   23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
> > index 9012ecf..1a86698 100644
> > --- a/kernel/power/autosleep.c
> > +++ b/kernel/power/autosleep.c
> > @@ -26,6 +26,7 @@ static struct wakeup_source *autosleep_ws;
> >  static void try_to_suspend(struct work_struct *work)
> >  {
> >  	unsigned int initial_count, final_count;
> > +	int error = 0;
> 
> The initial value is not needed.
> 
> >  
> >  	if (!pm_get_wakeup_count(&initial_count, true))
> >  		goto out;
> > @@ -43,22 +44,30 @@ static void try_to_suspend(struct work_struct *work)
> >  		return;
> >  	}
> >  	if (autosleep_state >= PM_SUSPEND_MAX)
> > -		hibernate();
> > +		error = hibernate();
> >  	else
> > -		pm_suspend(autosleep_state);
> > +		error = pm_suspend(autosleep_state);
> 
> I'd prefer to write that as
> 
> 	error = autosleep_state < PM_SUSPEND_MAX ?
> 		pm_suspend(autosleep_state) : hibernate();
> 
> >  
> >  	mutex_unlock(&autosleep_lock);
> >  
> > +	if (error) {
> > +		pr_err("PM: suspend returned (%d)\n", error);
> 
> There is a debug message printed for that in the device suspend code, do we
> need one more here?
> 
> > +		goto wait;
> > +	}
> > +
> >  	if (!pm_get_wakeup_count(&final_count, false))
> >  		goto out;
> >  
> > +	if (final_count != initial_count)
> > +		goto out;
> > +
> > + wait:
> >  	/*
> > -	 * If the wakeup occured for an unknown reason, wait to prevent the
> > -	 * system from trying to suspend and waking up in a tight loop.
> > +	 * If some devices failed to suspend or if the wakeup ocurred
> > +	 * for an unknown reason, wait to prevent the system from
> > +	 * trying to suspend and waking up in a tight loop.
> >  	 */
> > -	if (final_count == initial_count)
> > -		schedule_timeout_uninterruptible(HZ / 2);
> > -
> > +	schedule_timeout_uninterruptible(HZ / 2);
> >   out:
> >  	queue_up_suspend_work();
> 
> I'd arrange it this way:
> 
> 	if (error || pm_get_wakeup_count(&final_count, false)
> 	    || final_count == initial_count)
> 		schedule_timeout_uninterruptible(HZ / 2);
> 
>  out:
>   	queue_up_suspend_work();
> >  }
> > 
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
