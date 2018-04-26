From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / Sleep: only update last time for active wakeup sources
Date: Thu, 26 Apr 2018 08:30:52 +0200
Message-ID: <CAJZ5v0i8ACi_Vw0iFKKFTn0pe6gi-YV8aACp9TyRmP3ab8wxqg@mail.gmail.com>
References: <1524699630-30573-1-git-send-email-opendmb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524699630-30573-1-git-send-email-opendmb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Berger <opendmb@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 26, 2018 at 1:40 AM, Doug Berger <opendmb@gmail.com> wrote:
> When wakelock support was added, the wakeup_source_add() function
> was updated to set the last_time value of the wakeup source. This
> has the unintended side effect of producing confusing output from
> pm_print_active_wakeup_sources() when a wakeup source is added
> prior to a sleep that is blocked by a different wakeup source.
>
> The function pm_print_active_wakeup_sources() will search for the
> most recently active wakeup source when no active source is found.
> If a wakeup source is added after a different wakeup source blocks
> the system from going to sleep it may have a later last_time value
> than the blocking source and be output as the last active wakeup
> source even if it has never actually been active.
>
> It looks to me like the change to wakeup_source_add() was made to
> prevent the wakelock garbage collection from accidentally dropping
> a wakelock during the narrow window between adding the wakelock to
> the wakelock list in wakelock_lookup_add() and the activation of
> the wakeup source in pm_wake_lock().
>
> This commit changes the behavior so that only the last_time of the
> wakeup source used by a wakelock is initialized prior to adding it
> to the wakeup source list. This preserves the meaning of the
> last_time value as the last time the wakeup source was active and
> allows a wakeup source that has never been active to have a
> last_time value of 0.
>
> Fixes: b86ff982 ("PM / Sleep: Add user space interface for manipulating wakeup sources, v3")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  drivers/base/power/wakeup.c | 1 -
>  kernel/power/wakelock.c     | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index ea01621..230160e 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -183,7 +183,6 @@ void wakeup_source_add(struct wakeup_source *ws)
>         spin_lock_init(&ws->lock);
>         timer_setup(&ws->timer, pm_wakeup_timer_fn, 0);
>         ws->active = false;
> -       ws->last_time = ktime_get();

If it is not initialized here, max_time may not be updated correctly later on.

If you don't want to initialize it to ktime_get() (to avoid the issue
you're trying to avoid), initialize it to something special and then
check for that explicitly in wakeup_source_deactivate() when computing
max_time.

>
>         spin_lock_irqsave(&events_lock, flags);
>         list_add_rcu(&ws->entry, &wakeup_sources);
> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> index dfba59b..4210152 100644
> --- a/kernel/power/wakelock.c
> +++ b/kernel/power/wakelock.c
> @@ -188,6 +188,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
>                 return ERR_PTR(-ENOMEM);
>         }
>         wl->ws.name = wl->name;
> +       wl->ws.last_time = ktime_get();
>         wakeup_source_add(&wl->ws);
>         rb_link_node(&wl->node, parent, node);
>         rb_insert_color(&wl->node, &wakelocks_tree);
> --
> 2.7.4
>
