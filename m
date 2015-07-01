From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] PM / Sleep: Use workqueue for user space wakeup sources
 garbage collector
Date: Wed, 1 Jul 2015 12:51:47 +0900
Message-ID: <CAJKOXPcENx5_uHQTzEnUg6nJgpeqqR8+Ra7JxFaB-Jk_b9vF2g@mail.gmail.com>
References: <1435718938-19088-1-git-send-email-cleaneye.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f43.google.com ([209.85.216.43]:40562 "EHLO
	mail-vn0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbbGADvs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 23:51:48 -0400
In-Reply-To: <1435718938-19088-1-git-send-email-cleaneye.kim@lge.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: SungEun Kim <cleaneye.kim@lge.com>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

2015-07-01 11:48 GMT+09:00 SungEun Kim <cleaneye.kim@lge.com>:
> From: "cleaeye.kim" <cleaneye.kim@lge.com>
>
> The synchronous synchronize_rcu in wakeup_source_remove makes user process
> which writes to /sys/kernel/wake_unlock blocked sometimes.
>
> For example, when android eventhub tries to release wakelock,
> this blocking process can occur, and eventhub can't get input event
> for a while.
>
> Using workqueue instead of direct function call at pm_wake_unlock
> can prevent this unnecessary delay of an user space process.
>
> Signed-off-by: cleaeye.kim <cleaneye.kim@lge.com>

Hi,

You send this patch for third time, without changelog and any
versioning. The signed-off and from fields look incorrect (no real
name?). What is more important I have doubts that it even compiles
(see below).

Could you follow the Documentation/SubmittingPatches?


> ---
>  kernel/power/wakelock.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> index 019069c..ea10baa 100644
> --- a/kernel/power/wakelock.c
> +++ b/kernel/power/wakelock.c
> @@ -17,6 +17,7 @@
>  #include <linux/list.h>
>  #include <linux/rbtree.h>
>  #include <linux/slab.h>
> +#include <linux/workqueue.h>
>
>  #include "power.h"
>
> @@ -96,7 +97,7 @@ static inline void wakelocks_lru_most_recent(struct wakelock *wl)
>         list_move(&wl->lru, &wakelocks_lru_list);
>  }
>
> -static void wakelocks_gc(void)
> +static void wakelocks_gc(struct work_struct *work)
>  {
>         struct wakelock *wl, *aux;
>         ktime_t now;
> @@ -105,6 +106,7 @@ static void wakelocks_gc(void)
>                 return;
>
>         now = ktime_get();
> +       mutex_lock(&wakelocks_lock);
>         list_for_each_entry_safe_reverse(wl, aux, &wakelocks_lru_list, lru) {
>                 u64 idle_time_ns;
>                 bool active;
> @@ -126,12 +128,15 @@ static void wakelocks_gc(void)
>                         decrement_wakelocks_number();
>                 }
>         }
> +       mutex_unlock(&wakelocks_lock);
>         wakelocks_gc_count = 0;
>  }
> +
> +static DECLARE_WORK(wakelock_work, wakelocks_gc);
>  #else /* !CONFIG_PM_WAKELOCKS_GC */
>  static inline void wakelocks_lru_add(struct wakelock *wl) {}
>  static inline void wakelocks_lru_most_recent(struct wakelock *wl) {}
> -static inline void wakelocks_gc(void) {}
> +static void wakelocks_gc(struct worksturct) {}

worksturct? Does it compile?

Best regards,
Krzysztof
