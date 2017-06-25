From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2]  PM / wakeirq: Convert to SRCU
Date: Sun, 25 Jun 2017 11:29:26 -0700
Message-ID: <20170625182926.GB3721@linux.vnet.ibm.com>
References: <alpine.DEB.2.20.1706241153260.1941@nanos>
 <20170624135320.GS3721@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1706251103320.1996@nanos>
 <20170625144559.GA3721@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1706251930220.2528@nanos>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1706251930220.2528@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 25, 2017 at 07:31:13PM +0200, Thomas Gleixner wrote:
> The wakeirq infrastructure uses RCU to protect the list of wakeirqs. That
> breaks the irq bus locking infrastructure, which is allows sleeping
> functions to be called so interrupt controllers behind slow busses,
> e.g. i2c, can be handled.
> 
> The wakeirq functions hold rcu_read_lock and call into irq functions, which
> in case of interrupts using the irq bus locking will trigger a
> might_sleep() splat.
> 
> Convert the wakeirq infrastructure to Sleepable RCU and unbreak it.
> 
> Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ handling")
> Reported-by: Brian Norris <briannorris@chromium.org>
> Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks good to me!

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  drivers/base/power/wakeup.c |   32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -60,6 +60,8 @@ static LIST_HEAD(wakeup_sources);
> 
>  static DECLARE_WAIT_QUEUE_HEAD(wakeup_count_wait_queue);
> 
> +DEFINE_STATIC_SRCU(wakeup_srcu);
> +
>  static struct wakeup_source deleted_ws = {
>  	.name = "deleted",
>  	.lock =  __SPIN_LOCK_UNLOCKED(deleted_ws.lock),
> @@ -198,7 +200,7 @@ void wakeup_source_remove(struct wakeup_
>  	spin_lock_irqsave(&events_lock, flags);
>  	list_del_rcu(&ws->entry);
>  	spin_unlock_irqrestore(&events_lock, flags);
> -	synchronize_rcu();
> +	synchronize_srcu(&wakeup_srcu);
>  }
>  EXPORT_SYMBOL_GPL(wakeup_source_remove);
> 
> @@ -332,12 +334,12 @@ void device_wakeup_detach_irq(struct dev
>  void device_wakeup_arm_wake_irqs(void)
>  {
>  	struct wakeup_source *ws;
> +	int srcuidx;
> 
> -	rcu_read_lock();
> +	srcuidx = srcu_read_lock(&wakeup_srcu);
>  	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
>  		dev_pm_arm_wake_irq(ws->wakeirq);
> -
> -	rcu_read_unlock();
> +	srcu_read_unlock(&wakeup_srcu, srcuidx);
>  }
> 
>  /**
> @@ -348,12 +350,12 @@ void device_wakeup_arm_wake_irqs(void)
>  void device_wakeup_disarm_wake_irqs(void)
>  {
>  	struct wakeup_source *ws;
> +	int srcuidx;
> 
> -	rcu_read_lock();
> +	srcuidx = srcu_read_lock(&wakeup_srcu);
>  	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
>  		dev_pm_disarm_wake_irq(ws->wakeirq);
> -
> -	rcu_read_unlock();
> +	srcu_read_unlock(&wakeup_srcu, srcuidx);
>  }
> 
>  /**
> @@ -804,10 +806,10 @@ EXPORT_SYMBOL_GPL(pm_wakeup_dev_event);
>  void pm_print_active_wakeup_sources(void)
>  {
>  	struct wakeup_source *ws;
> -	int active = 0;
> +	int srcuidx, active = 0;
>  	struct wakeup_source *last_activity_ws = NULL;
> 
> -	rcu_read_lock();
> +	srcuidx = srcu_read_lock(&wakeup_srcu);
>  	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>  		if (ws->active) {
>  			pr_debug("active wakeup source: %s\n", ws->name);
> @@ -823,7 +825,7 @@ void pm_print_active_wakeup_sources(void
>  	if (!active && last_activity_ws)
>  		pr_debug("last active wakeup source: %s\n",
>  			last_activity_ws->name);
> -	rcu_read_unlock();
> +	srcu_read_unlock(&wakeup_srcu, srcuidx);
>  }
>  EXPORT_SYMBOL_GPL(pm_print_active_wakeup_sources);
> 
> @@ -950,8 +952,9 @@ void pm_wakep_autosleep_enabled(bool set
>  {
>  	struct wakeup_source *ws;
>  	ktime_t now = ktime_get();
> +	int srcuidx;
> 
> -	rcu_read_lock();
> +	srcuidx = srcu_read_lock(&wakeup_srcu);
>  	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>  		spin_lock_irq(&ws->lock);
>  		if (ws->autosleep_enabled != set) {
> @@ -965,7 +968,7 @@ void pm_wakep_autosleep_enabled(bool set
>  		}
>  		spin_unlock_irq(&ws->lock);
>  	}
> -	rcu_read_unlock();
> +	srcu_read_unlock(&wakeup_srcu, srcuidx);
>  }
>  #endif /* CONFIG_PM_AUTOSLEEP */
> 
> @@ -1026,15 +1029,16 @@ static int print_wakeup_source_stats(str
>  static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
>  {
>  	struct wakeup_source *ws;
> +	int srcuidx;
> 
>  	seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>  		"expire_count\tactive_since\ttotal_time\tmax_time\t"
>  		"last_change\tprevent_suspend_time\n");
> 
> -	rcu_read_lock();
> +	srcuidx = srcu_read_lock(&wakeup_srcu);
>  	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
>  		print_wakeup_source_stats(m, ws);
> -	rcu_read_unlock();
> +	srcu_read_unlock(&wakeup_srcu, srcuidx);
> 
>  	print_wakeup_source_stats(m, &deleted_ws);
> 
> 
