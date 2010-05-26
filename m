From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Thu, 27 May 2010 00:47:19 +0200
Message-ID: <201005270047.19167.rjw__21655.1321711906$1274917566$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005261759100.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005261759100.1328-100000@iolanthe.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Tejun Heo <tj@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 27 May 2010, Alan Stern wrote:
> On Wed, 26 May 2010, Rafael J. Wysocki wrote:
> 
> > > The reason is simple: When a user process initiates an opportunistic 
> > > suspend, you make it wait in an interruptible sleep until all the 
> > > kernel suspend blockers are released.  No polling.  If another user 
> > > thread decides in the meantime that it needs to block the suspend, it 
> > > sends a signal to the power manager process.
> > > 
> > > In fact, other threads should signal the power manager process whenever 
> > > they want to block or unblock suspends.  That way the power manager 
> > > process can spend all its time sleeping, without doing any polling.
> > 
> > I still see an issue here.  Namely, if the power manager is in user space and
> > it's signaled to suspend, it has to ask the kernel to do that, presumably by
> > writing something to a sysfs file.  Then, if the kernel blocks the suspend, the
> > power manager waits until the block is released.  Now, it should go back and
> > check if user space still doesn't block suspend and if so, wait until the block
> > is released and start over.  With all suspend blockers in the kernel this
> > looping behavior is avoidable.
> 
> I must be missing something.  In Arve's patch 1/8, if the system is in
> opportunistic suspend, and a wakeup event occurs but no suspend
> blockers get enabled by the handler, what causes the system to go back
> into suspend after the event is handled?  Isn't that a loop of some
> sort?

Well, yes it is.

Rafael
