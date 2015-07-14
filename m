From: Nitish Ambastha <nits.ambastha@gmail.com>
Subject: Re: [PATCHv3 1/1] kernel/power/autosleep.c: check for pm_suspend()
 return before queueing suspend again
Date: Tue, 14 Jul 2015 09:34:08 +0530
Message-ID: <CAHWDpXj+AjD3F+8RvRFePXCXRKq=WBh0MKy-39B2emjG+Qamxw@mail.gmail.com>
References: <1435604054-29711-1-git-send-email-nitish.a@samsung.com>
	<1436818082-24087-1-git-send-email-nitish.a@samsung.com>
	<1834201.LA0RYhhP7u@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35714 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbbGNEEJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 00:04:09 -0400
In-Reply-To: <1834201.LA0RYhhP7u@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Nitish Ambastha <nitish.a@samsung.com>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpgs@samsung.com

On Tue, Jul 14, 2015 at 5:13 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, July 14, 2015 01:38:02 AM Nitish Ambastha wrote:
>> Prevent tight loop for suspend-resume when some
>> devices failed to suspend
>
> This *still* doesn't explain what problem you're *really* trying to address.
>
> Even if a driver returns an error code from one of its suspend callbacks,
> you should get final_count == initial_count in the final check and we'll
> schedule the timeout.
>
> So there is a failure scenarion you're trying to address where that check is
> not sufficient, but you're not saying what the scenario is.
>
As I mentioned earlier, if some driver failed to suspend, and during
resume if *somebody* called pm_stay_awake() or pm_wakeup_event()
meantime, and then pm_relax(), final_count and initial_count will not
be the same in try_to_suspend(). We observed this behavior with
battery monitor thread on being restarted

In these scenarios, it will be considered a *valid wakeup* event and
it will try to queue suspend immediately, though the actual reason of
resume was driver returning error code.
For such scenarios, event count may not always be safe way to identify.

> Quite frankly, it seems to me that you're trying to hide a spurious wakeup.
>
>
>> If some devices failed to suspend, we monitor this
>> error in try_to_suspend(). pm_suspend() is already
>> an 'int' returning function, how about checking return
>> from pm_suspend() before queueing suspend again?
>>
>> For devices which do not register for pending events,
>> this will prevent tight loop for suspend-resume in
>> suspend abort scenarios due to device suspend failures
>>
>> Signed-off-by: Nitish Ambastha <nitish.a@samsung.com>
>> ---
>> v2: Rearranged code to make wait entry shared with
>>     existing one as suggested by Pavel Machek <pavel@ucw.cz>
>>     Corrected log level from pr_info to pr_err for failure log
>>     Added return check for hibernate()
>>
>> v3: Restructured code as suggested by Rafael J Wysocki <rjw@rjwysocki.net>
>>
>>  kernel/power/autosleep.c |   20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
>> index 9012ecf..e458d0c 100644
>> --- a/kernel/power/autosleep.c
>> +++ b/kernel/power/autosleep.c
>> @@ -26,6 +26,7 @@ static struct wakeup_source *autosleep_ws;
>>  static void try_to_suspend(struct work_struct *work)
>>  {
>>       unsigned int initial_count, final_count;
>> +     int error;
>>
>>       if (!pm_get_wakeup_count(&initial_count, true))
>>               goto out;
>> @@ -42,23 +43,20 @@ static void try_to_suspend(struct work_struct *work)
>>               mutex_unlock(&autosleep_lock);
>>               return;
>>       }
>> -     if (autosleep_state >= PM_SUSPEND_MAX)
>> -             hibernate();
>> -     else
>> -             pm_suspend(autosleep_state);
>>
>> -     mutex_unlock(&autosleep_lock);
>> +     error = autosleep_state < PM_SUSPEND_MAX ?
>> +             pm_suspend(autosleep_state) : hibernate();
>>
>> -     if (!pm_get_wakeup_count(&final_count, false))
>> -             goto out;
>> +     mutex_unlock(&autosleep_lock);
>>
>>       /*
>> -      * If the wakeup occured for an unknown reason, wait to prevent the
>> -      * system from trying to suspend and waking up in a tight loop.
>> +      * If some devices failed to suspend or if the wakeup ocurred
>> +      * for an unknown reason, wait to prevent the system from
>> +      * trying to suspend and waking up in a tight loop.
>>        */
>> -     if (final_count == initial_count)
>> +     if (error || (pm_get_wakeup_count(&final_count, false)
>> +             && (final_count == initial_count)))
>>               schedule_timeout_uninterruptible(HZ / 2);
>> -
>>   out:
>>       queue_up_suspend_work();
>>  }
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
