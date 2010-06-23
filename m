From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update] Re: [RFC][PATCH] PM: Avoid losing wakeup
	events during suspend
Date: Thu, 24 Jun 2010 00:17:58 +0200
Message-ID: <201006240017.58665.rjw__34046.7045469724$1277331629$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006231038510.1617-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006231038510.1617-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 23, 2010, Alan Stern wrote:
> On Wed, 23 Jun 2010, Rafael J. Wysocki wrote:
> 
> > > Didn't we agree that timeouts would be needed for Wake-on-LAN?
> > 
> > Yes, we did, but in the WoL case the timeout will have to be used by the user
> > space rather than the kernel IMO.
> 
> The kernel will still have to specify some small initial timeout.  Just 
> long enough for userspace to realize what has happened and start its 
> own critical section.
> 
> > It would make sense to add a timeout argument to pm_wakeup_event() that would
> > make the system stay in the working state long enough for the driver wakeup
> > code to start in the PCIe case.  I think pm_wakeup_event() mght just increment
> > events_in_progress and the timer might simply decrement it.
> 
> Hmm.  I was thinking about a similar problem with the USB hub driver.
> 
> Maybe a better answer for this particular issue is to change the
> workqueue code.  Don't allow a work thread to enter the freezer until
> its queue is empty.  Then you wouldn't need a timeout.
> 
> > So, maybe it's just better to have pm_wakeup_event(dev, timeout) that will
> > increment events_in_progress and set up a timer and pm_wakeup_commit(dev) that
> > will delete the timer, decrement events_in_progress and increment event_count
> > (unless the timer has already expired before).
> > 
> > That would cost us a (one more) timer in struct dev_pm_info, but it would
> > allow us to cover all of the cases identified so far.  So, if a wakeup event is
> > handled within one functional unit that both detects it and delivers it to
> > user space, it would call pm_wakeup_event(dev, 0) (ie. infinite timeout) at the
> > beginning and then pm_wakeup_commit(dev) when it's done with the event.
> > If a wakeup event it's just detected by one piece of code and is going to
> > be handled by another, the first one could call pm_wakeup_event(dev, tm) and
> > allow the other one to call pm_wakeup_commit(dev) when it's done.  However,
> > calling pm_wakeup_commit(dev) is not mandatory, so the second piece of code
> > (eg. a PCI driver) doesn't really need to do anything in the simplest case.
> 
> You have to handle the case where pm_wakeup_commit() gets called after
> the timer expires (it should do nothing).

Yup.

> And what happens if the device gets a second wakeup event before the timer
> for the first one expires?

Good question.  I don't have an answer to it at the moment, but it seems to
arise from using a single timer for all events.

It looks like it's simpler to make pm_wakeup_event() allocate a timer for each
event and make the timer function remove it.  That would cause suspend to
be blocked until the timer expires without a way to cancel it earlier, though.

> dev_pm_info would need to store a count of pending events.

I'm not sure if that helps.  It would if both events were going to be handled
in the same way, but I'm not sure if we can safely assume this.

> In fact, this gets even worse.  What if the second event causes you to
> move the timeout forward, but then you get a commit for the second
> event before the original timer would have expired?  It's not clear 
> that timeouts and early commit work well together.

I think they generally do, but there are problems here, as you noted.

> You could consider changing some of the new function names.  Instead of 
> "wakeup" (which implies that the system was asleep previously) use 
> "awake" (which implies that you want to prevent the system from going 
> to sleep, as in "stay awake").

A wakeup event may be defined as an event that would cause the system to wakeup
if it were is a sleep state, so I think the name of pm_wakeup_event() is fine.
The other names might be better.

Rafael
