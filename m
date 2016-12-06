From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PM / Sleep: Print active wakeup sources when reading
 wakeup events blocked
Date: Tue, 6 Dec 2016 22:07:56 +0100
Message-ID: <8185bf38-7e70-4070-4787-8cb8555d3499@intel.com>
References: <20161205033446.GA28666@lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60643 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbcLFVH7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Dec 2016 16:07:59 -0500
In-Reply-To: <20161205033446.GA28666@lab>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: xing wei <xing.wei@linux.intel.com>
Cc: xing.wei@intel.com, toddpoynor@google.com, linux-pm@vger.kernel.org, austin.zhang@intel.com

On 12/5/2016 4:34 AM, xing wei wrote:
> If there are any wakeup events being processed, read operation on
> /sys/power/wakeup_count will be blocked, we can print the name of
> all active wakeup sources to help us find out who will block system
> enter sleep.
>
> Signed-off-by: xing wei <xing.wei@linux.intel.com>

This doesn't seem to make it to linux-pm, I'm not sure why exactly.

Can you try to send it again, please?

> ---
>   drivers/base/power/wakeup.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 62e4de2..bf9ba26 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -811,7 +811,7 @@ void pm_print_active_wakeup_sources(void)
>   	rcu_read_lock();
>   	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>   		if (ws->active) {
> -			pr_info("active wakeup source: %s\n", ws->name);
> +			pr_debug("active wakeup source: %s\n", ws->name);
>   			active = 1;
>   		} else if (!active &&
>   			   (!last_activity_ws ||
> @@ -822,7 +822,7 @@ void pm_print_active_wakeup_sources(void)
>   	}
>   
>   	if (!active && last_activity_ws)
> -		pr_info("last active wakeup source: %s\n",
> +		pr_debug("last active wakeup source: %s\n",
>   			last_activity_ws->name);
>   	rcu_read_unlock();
>   }
> @@ -905,7 +905,7 @@ bool pm_get_wakeup_count(unsigned int *count, bool block)
>   			split_counters(&cnt, &inpr);
>   			if (inpr == 0 || signal_pending(current))
>   				break;
> -
> +			pm_print_active_wakeup_sources();
>   			schedule();
>   		}
>   		finish_wait(&wakeup_count_wait_queue, &wait);


