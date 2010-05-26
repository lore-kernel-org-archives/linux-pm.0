From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 09:59:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005260946430.1961-100000__28018.929428845$1274882494$gmane$org@iolanthe.rowland.org>
References: <20100525225544.GA5331@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100525225544.GA5331@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 May 2010, Dmitry Torokhov wrote:

> > How is that not polling? If the user is holding down a key, the keypad
> > driver has to block suspend, and user space will try to suspend again
> > and again and again...
> > 
> 
> If your userpsace is that stupid - sure. However, you can:
> 
> 1. Notify the suspend manager process that he rest of your userspace is
> busy handling keystrokes so that it does not try to suspend while there
> are events pending.
> 
> 2. Wait a tiny bit after last application notified you that it finished
> processing events.

This is more complicated than necessary.  Arve is wrong; my suggested 
design does not require polling.

The reason is simple: When a user process initiates an opportunistic 
suspend, you make it wait in an interruptible sleep until all the 
kernel suspend blockers are released.  No polling.  If another user 
thread decides in the meantime that it needs to block the suspend, it 
sends a signal to the power manager process.

In fact, other threads should signal the power manager process whenever 
they want to block or unblock suspends.  That way the power manager 
process can spend all its time sleeping, without doing any polling.

> So basically the difference is that with in-kernel suspend blockers,
> there is a tiny window where we haven't started the suspend yet but are
> about to the driver has a chance to prevent entire system from starting
> sleep.
> 
> Without the blocker we may start suspending and will stop midcycle. We
> may be even better off in the end since we could leave some devices
> still powered down after aborting system-wide suspend.

That's not so easy.  The design of the PM core requires that when the 
system wakes up from suspend (or from an aborted suspend attempt), all 
devices should go to full-power-on.  This is explained in section 6 of
Documentation/power/runtime_pm.txt.

The decision over whether to use kernel-space suspend blockers vs. 
aborting suspends when queues are non-empty comes down to a tradeoff:

	Suspend blockers involve a little more code (to create,
	destroy, enable, and disable them) plus a little extra
	runtime overhead each time an event occurs.  (Some people
	may object to this extra overhead, although so far nobody
	in this discussion has done so.)

	Suspend blockers eliminate the extra overhead involved in
	starting suspends that are just going to be aborted.

	Suspend blockers offer extra debugging and accountability
	(the user can find out which subsystems are responsible for
	keeping the system awake).

Which way you think the tradeoff should go is a subjective decision.  I 
think that kernel suspend blockers are acceptable.

Alan Stern
