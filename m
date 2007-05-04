From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: shrinking memory for suspend?
Date: Fri, 4 May 2007 11:05:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705041057350.3417-100000@iolanthe.rowland.org>
References: <17978.28914.736715.985306@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <17978.28914.736715.985306@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mackerras <paulus@samba.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 May 2007, Paul Mackerras wrote:

> > What happens without preemption enabled when a device driver's suspend() 
> > method calls schedule()?
> 
> That would be bad; don't do that. :)
> 
> In the context of the original powermac sleep code, drivers registered
> a notifier for sleep which got called twice - the first time before
> doing the sync, and the second time after it, with an argument to the
> notifier to indicate which call this is.  Drivers are allowed to call
> schedule on the first call but not on the second.

But the generic non-PPC core merely calls a suspend() method with
interrupts enabled.  And drivers may use the same code for runtime power
management as well.  As such it cannot afford to spin during a delay; it
must sleep.

> > With or without preemption enabled, what happens when a user process tries
> > to do I/O to a suspended device?
> 
> If we have two calls to the driver, then the second one should happen
> with only one cpu still active and preemption disabled, and that's the
> call where the device hardware should actually be put into its suspend
> state.
> 
> I'm not saying the original powermac code was perfect, but it does
> work well for many users using powerbooks (which are all single-cpu
> machines), without freezing processes.

If you think in terms of suspend-to-RAM as just being one super-big
runtime suspend of every device, you may find it an appealing point of
view.  (From some of the things he has said, this seems to be how Linus
thinks of it.)  Since runtime PM doesn't involve freezing processes, you
can conclude that neither should STR.

On the other hand, runtime suspend generally involves wake-on-demand, 
including demands for I/O from userspace.  Should STR behave the same way?

Alan Stern
