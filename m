From: Nitish Ambastha <nits.ambastha@gmail.com>
Subject: Re: [PATCHv3 1/1] kernel/power/autosleep.c: check for pm_suspend()
 return before queueing suspend again
Date: Tue, 14 Jul 2015 01:54:20 +0530
Message-ID: <CAHWDpXgnJdBK2ntrPUZeZbjd8tbTxOKnaT_PQf7NuLLcpJ0Z_g@mail.gmail.com>
References: <1435604054-29711-1-git-send-email-nitish.a@samsung.com>
	<1436818082-24087-1-git-send-email-nitish.a@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:32880 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbbGMUYU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 16:24:20 -0400
In-Reply-To: <1436818082-24087-1-git-send-email-nitish.a@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nitish Ambastha <nitish.a@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpgs@samsung.com

I have uploaded a new patch as per comments

Since some drivers failed to suspend, and is/are not registered to
wakeup sources fwk, we cannot keep trying suspend based on wakeup
event count. It looks valid to me to wait before queuing another
suspend request tightly

Please let me know if this is reasonable?

On Tue, Jul 14, 2015 at 1:38 AM, Nitish Ambastha <nitish.a@samsung.com> wrote:
> Prevent tight loop for suspend-resume when some
> devices failed to suspend
> If some devices failed to suspend, we monitor this
> error in try_to_suspend(). pm_suspend() is already
> an 'int' returning function, how about checking return
> from pm_suspend() before queueing suspend again?
>
> For devices which do not register for pending events,
> this will prevent tight loop for suspend-resume in
> suspend abort scenarios due to device suspend failures
>
> Signed-off-by: Nitish Ambastha <nitish.a@samsung.com>
> ---
> v2: Rearranged code to make wait entry shared with
>     existing one as suggested by Pavel Machek <pavel@ucw.cz>
>     Corrected log level from pr_info to pr_err for failure log
>     Added return check for hibernate()
>
> v3: Restructured code as suggested by Rafael J Wysocki <rjw@rjwysocki.net>
>
>  kernel/power/autosleep.c |   20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
> index 9012ecf..e458d0c 100644
> --- a/kernel/power/autosleep.c
> +++ b/kernel/power/autosleep.c
> @@ -26,6 +26,7 @@ static struct wakeup_source *autosleep_ws;
>  static void try_to_suspend(struct work_struct *work)
>  {
>         unsigned int initial_count, final_count;
> +       int error;
>
>         if (!pm_get_wakeup_count(&initial_count, true))
>                 goto out;
> @@ -42,23 +43,20 @@ static void try_to_suspend(struct work_struct *work)
>                 mutex_unlock(&autosleep_lock);
>                 return;
>         }
> -       if (autosleep_state >= PM_SUSPEND_MAX)
> -               hibernate();
> -       else
> -               pm_suspend(autosleep_state);
>
> -       mutex_unlock(&autosleep_lock);
> +       error = autosleep_state < PM_SUSPEND_MAX ?
> +               pm_suspend(autosleep_state) : hibernate();
>
> -       if (!pm_get_wakeup_count(&final_count, false))
> -               goto out;
> +       mutex_unlock(&autosleep_lock);
>
>         /*
> -        * If the wakeup occured for an unknown reason, wait to prevent the
> -        * system from trying to suspend and waking up in a tight loop.
> +        * If some devices failed to suspend or if the wakeup ocurred
> +        * for an unknown reason, wait to prevent the system from
> +        * trying to suspend and waking up in a tight loop.
>          */
> -       if (final_count == initial_count)
> +       if (error || (pm_get_wakeup_count(&final_count, false)
> +               && (final_count == initial_count)))
>                 schedule_timeout_uninterruptible(HZ / 2);
> -
>   out:
>         queue_up_suspend_work();
>  }
> --
> 1.7.9.5
>
