From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
 from being lost
Date: Mon, 28 Jun 2010 10:16:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006281006360.1977-100000__29077.6328104132$1277734703$gmane$org@iolanthe.rowland.org>
References: <201006280159.10885.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006280159.10885.rjw@sisk.pl>
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

On Mon, 28 Jun 2010, Rafael J. Wysocki wrote:

> > > +bool pm_get_wakeup_count(unsigned long *count)
> > > +{
> > > +	bool ret;
> > > +
> > > +	spin_lock_irq(&events_lock);
> > > +	if (capable(CAP_SYS_ADMIN))
> > > +		events_check_enabled = false;
> > > +
> > > +	if (events_in_progress) {
> > > +		DEFINE_WAIT(wait);
> > > +
> > > +		do {
> > > +			prepare_to_wait(&events_wait_queue, &wait,
> > > +					TASK_INTERRUPTIBLE);
> > > +			if (!events_in_progress)
> > > +				break;
> > > +			spin_unlock_irq(&events_lock);
> > > +
> > > +			schedule();
> > > +
> > > +			spin_lock_irq(&events_lock);
> > > +		} while (!signal_pending(current));
> > > +		finish_wait(&events_wait_queue, &wait);
> > > +	}
> > > +	*count = event_count;
> > > +	ret = !events_in_progress;
> > > +	spin_unlock_irq(&events_lock);
> > > +	return ret;
> > > +}
> > 
> > Here's a thought.  Presumably pm_relax() will end up getting called a 
> > lot more often than pm_get_wakeup_count().  Instead of using a wait 
> > queue, you could make pm_get_wakeup_count() poll at 100-ms intervals.  
> > The total overhead would be smaller.
> 
> For that I'd need a separate kernel thread or a work item that would reschedule
> itself periodically, because pm_get_wakeup_count() is only called via
> /sys/power/wakeup_count.  It would complicate things quite a bit which I'm not
> sure is worth it at this point.

What?  All I'm saying is that the do-while loop above should be
replaced by a loop that sleeps for 100 ms instead of waiting on a
wait_queue.  That is:

	while (events_in_progress) {
		if (signal_pending(current))
			break;
		spin_unlock_irq(&events_lock);

		schedule_timeout_interruptible(msecs_to_jiffies(100));

		spin_lock_irq(&events_lock);
	}

And of course, get rid of events_wait_queue.

Alan Stern
