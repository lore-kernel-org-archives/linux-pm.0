From: Paul Mackerras <paulus@samba.org>
Subject: Re: shrinking memory for suspend?
Date: Fri, 4 May 2007 09:32:02 +1000
Message-ID: <17978.28914.736715.985306@cargo.ozlabs.ibm.com>
References: <200705031245.05454.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0705031031500.3548-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705031031500.3548-100000@iolanthe.rowland.org>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Alan Stern writes:

> > > Which is why the powermac/powerbook sleep code insists on there only
> > > being one cpu active.  I have an SMP powermac which can sleep; I use a
> > > little script to take the second cpu down before sleeping and bring it
> > > back up after waking up.
> > 
> > That's quite intrusive.  Ideally, user space processes should not notice that
> > there have been a suspend at one point.
> 
> What happens without preemption enabled when a device driver's suspend() 
> method calls schedule()?

That would be bad; don't do that. :)

In the context of the original powermac sleep code, drivers registered
a notifier for sleep which got called twice - the first time before
doing the sync, and the second time after it, with an argument to the
notifier to indicate which call this is.  Drivers are allowed to call
schedule on the first call but not on the second.

> With or without preemption enabled, what happens when a user process tries
> to do I/O to a suspended device?

If we have two calls to the driver, then the second one should happen
with only one cpu still active and preemption disabled, and that's the
call where the device hardware should actually be put into its suspend
state.

I'm not saying the original powermac code was perfect, but it does
work well for many users using powerbooks (which are all single-cpu
machines), without freezing processes.

I can see the attraction of the freezer, but there are still at least
three problems with it AFAICS:

* Working out which kernel threads should *not* be frozen is a manual,
  difficult and error-prone process
* Putting processes into an uninterruptible sleep stuffs up the load
  average
* It's intrusive in the sense that every kernel thread needs to have
  code in it to allow it to be frozen, and not all the kernel thread
  main loops have been "fixed".

Paul.
