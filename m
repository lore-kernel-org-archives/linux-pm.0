From: Nitish Ambastha <nits.ambastha@gmail.com>
Subject: Re: [PATCHv2 1/1] kernel/power/autosleep.c: check for pm_suspend()
 return before queueing suspend again
Date: Wed, 1 Jul 2015 00:52:43 +0530
Message-ID: <CAHWDpXg=t9R1zZgfVb+M41pxifVOEhCvMB=EBw=C0pWTe19+ZQ@mail.gmail.com>
References: <1435581297-20271-1-git-send-email-nitish.a@samsung.com>
	<1435604054-29711-1-git-send-email-nitish.a@samsung.com>
	<13445304.liFVyNdj8p@vostro.rjw.lan>
	<2619760.zM2C8Nu9I9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36455 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbbF3TWo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 15:22:44 -0400
In-Reply-To: <2619760.zM2C8Nu9I9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Nitish Ambastha <nitish.a@samsung.com>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpgs@samsung.com

Hi Rafael

Thanks for your feedback

On Tue, Jun 30, 2015 at 1:37 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, June 29, 2015 09:56:18 PM Rafael J. Wysocki wrote:
>> On Tuesday, June 30, 2015 12:24:14 AM Nitish Ambastha wrote:
>> > Prevent tight loop for suspend-resume when some
>> > devices failed to suspend
>> > If some devices failed to suspend, we monitor this
>> > error in try_to_suspend(). pm_suspend() is already
>> > an 'int' returning function, how about checking return
>> > from pm_suspend() before queueing suspend again?
>> >
>> > For devices which do not register for pending events,
>> > this will prevent tight loop for suspend-resume in
>> > suspend abort scenarios due to device suspend failures
>
> Having said the below I'm not sure why the current code doesn't cover this
> for you?
>
> That would be the final_count == initial_count case, no?
>
Agree, this should cover most of the cases, however there are some
cases where final_count may not match initial_count here

A couple of such scenario I came across is
1) when tasks are restarted again due to suspend failure, sometimes
battery kernel thread acquires lock for battery monitoring resulting
in either pm_get_wakeup_count() returning false or increment in
final_count from initial_count
2) In some platforms, power transitions are carried from User space
(power manager), these power-manager tries to hold some wake lock
after being restarted on resume

It seems to me that we can identify the error in suspend through
return values earlier and may not need to go ahead and check
final_count to catch the same later

>
>> >
>> > Signed-off-by: Nitish Ambastha <nitish.a@samsung.com>
>> > ---
>> > v2: Rearranged code to make wait entry shared with
>> >     existing one as suggested by Pavel Machek <pavel@ucw.cz>
>> >     Corrected log level from pr_info to pr_err for failure log
>> >     Added return check for hibernate()
>> >
>> >  kernel/power/autosleep.c |   23 ++++++++++++++++-------
>> >  1 file changed, 16 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
>> > index 9012ecf..1a86698 100644
>> > --- a/kernel/power/autosleep.c
>> > +++ b/kernel/power/autosleep.c
>> > @@ -26,6 +26,7 @@ static struct wakeup_source *autosleep_ws;
>> >  static void try_to_suspend(struct work_struct *work)
>> >  {
>> >     unsigned int initial_count, final_count;
>> > +   int error = 0;
>>
>> The initial value is not needed.
>>
>> >
>> >     if (!pm_get_wakeup_count(&initial_count, true))
>> >             goto out;
>> > @@ -43,22 +44,30 @@ static void try_to_suspend(struct work_struct *work)
>> >             return;
>> >     }
>> >     if (autosleep_state >= PM_SUSPEND_MAX)
>> > -           hibernate();
>> > +           error = hibernate();
>> >     else
>> > -           pm_suspend(autosleep_state);
>> > +           error = pm_suspend(autosleep_state);
>>
>> I'd prefer to write that as
>>
>>       error = autosleep_state < PM_SUSPEND_MAX ?
>>               pm_suspend(autosleep_state) : hibernate();
>>
>> >
>> >     mutex_unlock(&autosleep_lock);
>> >
>> > +   if (error) {
>> > +           pr_err("PM: suspend returned (%d)\n", error);
>>
>> There is a debug message printed for that in the device suspend code, do we
>> need one more here?
>>
>> > +           goto wait;
>> > +   }
>> > +
>> >     if (!pm_get_wakeup_count(&final_count, false))
>> >             goto out;
>> >
>> > +   if (final_count != initial_count)
>> > +           goto out;
>> > +
>> > + wait:
>> >     /*
>> > -    * If the wakeup occured for an unknown reason, wait to prevent the
>> > -    * system from trying to suspend and waking up in a tight loop.
>> > +    * If some devices failed to suspend or if the wakeup ocurred
>> > +    * for an unknown reason, wait to prevent the system from
>> > +    * trying to suspend and waking up in a tight loop.
>> >      */
>> > -   if (final_count == initial_count)
>> > -           schedule_timeout_uninterruptible(HZ / 2);
>> > -
>> > +   schedule_timeout_uninterruptible(HZ / 2);
>> >   out:
>> >     queue_up_suspend_work();
>>
>> I'd arrange it this way:
>>
>>       if (error || pm_get_wakeup_count(&final_count, false)
>>           || final_count == initial_count)
>>               schedule_timeout_uninterruptible(HZ / 2);
>>
>>  out:
>>       queue_up_suspend_work();
>> >  }
>> >
>>
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
