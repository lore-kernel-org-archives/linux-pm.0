From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Update documentation to reflect the current
 code flow
Date: Tue, 20 May 2014 09:53:45 +0200
Message-ID: <CAPDyKFqaF9_YCuo6=6hO2m3E=AhFdA7pTAdnem1FFH_9Fa=b0w@mail.gmail.com>
References: <1820626.RvqOqaKi2q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1820626.RvqOqaKi2q@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On 16 May 2014 13:44, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The runtime PM documentation in runtime_pm.txt has not been updated
> after some changes to the system suspend and resume core code, so
> update it to reflect the current code flow.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good!

Reviewed-by: Ulf Hansson <ulf.hansson@gmail.com>

> ---
>
> This is independent of the "do not resume runtime-suspended devices" series.
>
> Thanks!
>
> ---
>  Documentation/power/runtime_pm.txt |   18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> Index: linux-pm/Documentation/power/runtime_pm.txt
> ===================================================================
> --- linux-pm.orig/Documentation/power/runtime_pm.txt
> +++ linux-pm/Documentation/power/runtime_pm.txt
> @@ -665,15 +665,17 @@ The PM core does its best to reduce the
>  the runtime PM and system suspend/resume (and hibernation) callbacks by carrying
>  out the following operations:
>
> -  * During system suspend it calls pm_runtime_get_noresume() and
> -    pm_runtime_barrier() for every device right before executing the
> -    subsystem-level .suspend() callback for it.  In addition to that it calls
> -    __pm_runtime_disable() with 'false' as the second argument for every device
> -    right before executing the subsystem-level .suspend_late() callback for it.
> +  * During system suspend pm_runtime_get_noresume() is called for every device
> +    right before executing the subsystem-level .prepare() callback for it and
> +    pm_runtime_barrier() is called for every device right before executing the
> +    subsystem-level .suspend() callback for it.  In addition to that the PM core
> +    calls  __pm_runtime_disable() with 'false' as the second argument for every
> +    device right before executing the subsystem-level .suspend_late() callback
> +    for it.
>
> -  * During system resume it calls pm_runtime_enable() and pm_runtime_put()
> -    for every device right after executing the subsystem-level .resume_early()
> -    callback and right after executing the subsystem-level .resume() callback
> +  * During system resume pm_runtime_enable() and pm_runtime_put() are called for
> +    every device right after executing the subsystem-level .resume_early()
> +    callback and right after executing the subsystem-level .complete() callback
>      for it, respectively.
>
>  7. Generic subsystem callbacks
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
