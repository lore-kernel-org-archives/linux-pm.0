From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [update] Re: [PATCH] PM: Make it possible to avoid
 wakeup events from being lost
Date: Wed, 30 Jun 2010 15:58:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006301535450.1707-100000__29450.2663113692$1277927964$gmane$org@iolanthe.rowland.org>
References: <201006302127.37432.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006302127.37432.rjw@sisk.pl>
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

On Wed, 30 Jun 2010, Rafael J. Wysocki wrote:

> > Since there's no longer any way to cancel a call to pm_wakeup_event()  
> > or close the "no suspend" period early, there is no need to use
> > dynamically-allocated delayed_work structures.  You can make do with a
> > single static timer; always keep it set to expire at the latest time
> > passed to pm_wakeup_event().
> 
> The decremenations of events_in_progress wouldn't be balanced with
> incrementations this way.  Or do you have any clever way of dealing with
> that in mind?

Keep track of the current expiration time in a static variable called
wakeup_timeout, and use 0 to indicate there is no timeout.

In pm_wakeup_event() (everything protected by the spinlock):

	unsigned long new_timeout = jiffies + msecs_to_jiffies(msecs);
	if (new_timeout == 0)
		new_timeout = 1;

	++event_count;
	if (!wakeup_timeout || time_after(new_timeout, wakeup_timeout)) {
		if (!wakeup_timeout)
			++events_in_progress;
		wakeup_timeout = new_timeout;
		mod_timer(&wakeup_timer, wakeup_timeout);
	}

In the timer routine:

	if (wakeup_timeout && time_before_eq(wakeup_timeout, jiffies)) {
		--events_in_progres;
		wakeup_timeout = 0;
	}

Alan Stern
