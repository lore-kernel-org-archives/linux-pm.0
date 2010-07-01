From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [update] Re: [PATCH] PM: Make it possible to avoid
 wakeup events from being lost
Date: Thu, 1 Jul 2010 09:58:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007010953060.1596-100000__13893.7839343727$1277993039$gmane$org@iolanthe.rowland.org>
References: <201007010152.03869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007010152.03869.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Florian Mickler <florian@mickler.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 1 Jul 2010, Rafael J. Wysocki wrote:

> I invented a slightly different version in the meantime, which is appended
> as a patch on top of the original one (I don't want to modify the original
> patch, since it's been reviewed already by several people and went to my
> linux-next branch).

>  /**
> - * pm_wakeup_work_fn - Deferred closing of a wakeup event.
> + * pm_wakeup_timer_fn - Deferred closing of a wakeup event.
>   *
>   * Execute pm_relax() for a wakeup event detected in the past and free the
>   * work item object used for queuing up the work.
>   */
> -static void pm_wakeup_work_fn(struct work_struct *work)
> +static void pm_wakeup_timer_fn(unsigned long data)
>  {
> -	struct delayed_work *dwork = to_delayed_work(work);
> +	unsigned long flags;
>  
> -	pm_relax();
> -	kfree(dwork);
> +	spin_lock_irqsave(&events_lock, flags);
> +	if (events_timer_expires && time_after(jiffies, events_timer_expires)) {

Should be time_after_eq.

> +		events_in_progress -= delayed_count;
> +		event_count += delayed_count;
> +		delayed_count = 0;
> +		events_timer_expires = 0;
> +	}
> +	spin_unlock_irqrestore(&events_lock, flags);
>  }
>  
>  /**
> @@ -132,19 +145,31 @@ static void pm_wakeup_work_fn(struct wor
>  void pm_wakeup_event(struct device *dev, unsigned int msec)
>  {
>  	unsigned long flags;
> -	struct delayed_work *dwork;
> -
> -	dwork = msec ? kzalloc(sizeof(*dwork), GFP_ATOMIC) : NULL;
>  
>  	spin_lock_irqsave(&events_lock, flags);
>  	if (dev)
>  		dev->power.wakeup_count++;
>  
> -	if (dwork) {
> -		INIT_DELAYED_WORK(dwork, pm_wakeup_work_fn);
> -		schedule_delayed_work(dwork, msecs_to_jiffies(msec));
> +	if (msec) {
> +		ktime_t kt;
> +		struct timespec ts;
> +		unsigned long expires;
> +
> +		kt = ktime_get();
> +		kt = ktime_add_ns(kt, msec * NSEC_PER_MSEC);
> +		ts = ktime_to_timespec(kt);
> +		expires = timespec_to_jiffies(&ts);

Is this somehow better than jiffies + msecs_to_jiffies(msec)?

> +		if (!expires)
> +			expires = 1;
> +
> +		if (!events_timer_expires
> +		    || time_after(expires, events_timer_expires)) {
> +			mod_timer(&events_timer, expires);
> +			events_timer_expires = expires;
> +		}
>  
>  		events_in_progress++;
> +		delayed_count++;
>  	} else {
>  		event_count++;
>  	}

Alan Stern
