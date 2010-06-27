From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
 from being lost
Date: Sun, 27 Jun 2010 11:50:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006271142190.3772-100000__33669.6030026816$1277653875$gmane$org@netrider.rowland.org>
References: <201006261514.13491.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006261514.13491.rjw@sisk.pl>
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

On Sat, 26 Jun 2010, Rafael J. Wysocki wrote:

> +void pm_relax(void)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&events_lock, flags);
> +	if (events_in_progress) {
> +		event_count++;
> +		if (!--events_in_progress)
> +			wake_up_all(&events_wait_queue);
> +	}
> +	spin_unlock_irqrestore(&events_lock, flags);
> +}

> +bool pm_get_wakeup_count(unsigned long *count)
> +{
> +	bool ret;
> +
> +	spin_lock_irq(&events_lock);
> +	if (capable(CAP_SYS_ADMIN))
> +		events_check_enabled = false;
> +
> +	if (events_in_progress) {
> +		DEFINE_WAIT(wait);
> +
> +		do {
> +			prepare_to_wait(&events_wait_queue, &wait,
> +					TASK_INTERRUPTIBLE);
> +			if (!events_in_progress)
> +				break;
> +			spin_unlock_irq(&events_lock);
> +
> +			schedule();
> +
> +			spin_lock_irq(&events_lock);
> +		} while (!signal_pending(current));
> +		finish_wait(&events_wait_queue, &wait);
> +	}
> +	*count = event_count;
> +	ret = !events_in_progress;
> +	spin_unlock_irq(&events_lock);
> +	return ret;
> +}

Here's a thought.  Presumably pm_relax() will end up getting called a 
lot more often than pm_get_wakeup_count().  Instead of using a wait 
queue, you could make pm_get_wakeup_count() poll at 100-ms intervals.  
The total overhead would be smaller.

Here's another thought.  If event_count and events_in_progress were 
atomic_t then the new spinlock wouldn't be needed at all.  (But you 
would need an appropriate pair of memory barriers, to guarantee that 
when a writer decrements events_in_progress to 0 and increments 
event_count, a reader won't see events_in_progress == 0 without also 
seeing the incremented event_count.)  Overall, this may not be a
significant improvement.

Alan Stern
