From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PM: Convert timers to use timer_setup()
Date: Tue, 17 Oct 2017 01:53:28 +0200
Message-ID: <da183173-0b50-9363-3880-cbb64812ecdf@intel.com>
References: <20171016232055.GA100369@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:16080 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932519AbdJPXxc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Oct 2017 19:53:32 -0400
In-Reply-To: <20171016232055.GA100369@beast>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/17/2017 1:20 AM, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly. Removes test of .data field, since
> that will be going away.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>   drivers/base/power/runtime.c |  7 +++----
>   drivers/base/power/wakeup.c  | 11 +++++------
>   2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 7bcf80fa9ada..1cea431c0adf 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -894,9 +894,9 @@ static void pm_runtime_work(struct work_struct *work)
>    *
>    * Check if the time is right and queue a suspend request.
>    */
> -static void pm_suspend_timer_fn(unsigned long data)
> +static void pm_suspend_timer_fn(struct timer_list *t)
>   {
> -	struct device *dev = (struct device *)data;
> +	struct device *dev = from_timer(dev, t, power.suspend_timer);
>   	unsigned long flags;
>   	unsigned long expires;
>   
> @@ -1499,8 +1499,7 @@ void pm_runtime_init(struct device *dev)
>   	INIT_WORK(&dev->power.work, pm_runtime_work);
>   
>   	dev->power.timer_expires = 0;
> -	setup_timer(&dev->power.suspend_timer, pm_suspend_timer_fn,
> -			(unsigned long)dev);
> +	timer_setup(&dev->power.suspend_timer, pm_suspend_timer_fn, 0);
>   
>   	init_waitqueue_head(&dev->power.wait_queue);
>   }
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index cdd6f256da59..680ee1d36ac9 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -54,7 +54,7 @@ static unsigned int saved_count;
>   
>   static DEFINE_SPINLOCK(events_lock);
>   
> -static void pm_wakeup_timer_fn(unsigned long data);
> +static void pm_wakeup_timer_fn(struct timer_list *t);
>   
>   static LIST_HEAD(wakeup_sources);
>   
> @@ -176,7 +176,7 @@ void wakeup_source_add(struct wakeup_source *ws)
>   		return;
>   
>   	spin_lock_init(&ws->lock);
> -	setup_timer(&ws->timer, pm_wakeup_timer_fn, (unsigned long)ws);
> +	timer_setup(&ws->timer, pm_wakeup_timer_fn, 0);
>   	ws->active = false;
>   	ws->last_time = ktime_get();
>   
> @@ -481,8 +481,7 @@ static bool wakeup_source_not_registered(struct wakeup_source *ws)
>   	 * Use timer struct to check if the given source is initialized
>   	 * by wakeup_source_add.
>   	 */
> -	return ws->timer.function != pm_wakeup_timer_fn ||
> -		   ws->timer.data != (unsigned long)ws;
> +	return ws->timer.function != (TIMER_FUNC_TYPE)pm_wakeup_timer_fn;
>   }
>   
>   /*
> @@ -724,9 +723,9 @@ EXPORT_SYMBOL_GPL(pm_relax);
>    * in @data if it is currently active and its timer has not been canceled and
>    * the expiration time of the timer is not in future.
>    */
> -static void pm_wakeup_timer_fn(unsigned long data)
> +static void pm_wakeup_timer_fn(struct timer_list *t)
>   {
> -	struct wakeup_source *ws = (struct wakeup_source *)data;
> +	struct wakeup_source *ws = from_timer(ws, t, timer);
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&ws->lock, flags);
