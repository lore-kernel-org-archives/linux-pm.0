From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 18:12:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005261759100.1328-100000__32524.6769040406$1274916761$gmane$org@iolanthe.rowland.org>
References: <201005262351.59626.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005262351.59626.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010, Rafael J. Wysocki wrote:

> > The reason is simple: When a user process initiates an opportunistic 
> > suspend, you make it wait in an interruptible sleep until all the 
> > kernel suspend blockers are released.  No polling.  If another user 
> > thread decides in the meantime that it needs to block the suspend, it 
> > sends a signal to the power manager process.
> > 
> > In fact, other threads should signal the power manager process whenever 
> > they want to block or unblock suspends.  That way the power manager 
> > process can spend all its time sleeping, without doing any polling.
> 
> I still see an issue here.  Namely, if the power manager is in user space and
> it's signaled to suspend, it has to ask the kernel to do that, presumably by
> writing something to a sysfs file.  Then, if the kernel blocks the suspend, the
> power manager waits until the block is released.  Now, it should go back and
> check if user space still doesn't block suspend and if so, wait until the block
> is released and start over.  With all suspend blockers in the kernel this
> looping behavior is avoidable.

I must be missing something.  In Arve's patch 1/8, if the system is in
opportunistic suspend, and a wakeup event occurs but no suspend
blockers get enabled by the handler, what causes the system to go back
into suspend after the event is handled?  Isn't that a loop of some
sort?

And even if it isn't, so what?  What's wrong with looping behavior?  
Especially a loop that's as short as this one and spends almost all of
its time sleeping.  Think how much harder it would be to write programs
if you weren't allowed to use any loops.  :-)

Alan Stern
