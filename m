From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Tue, 25 May 2010 11:24:56 -0700
Message-ID: <201005251124.58017.dmitry.torokhov__38968.8874864534$1274811994$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.1005251359580.1634-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005251359580.1634-100000@iolanthe.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 May 2010 11:08:03 am Alan Stern wrote:
> On Tue, 25 May 2010, Dmitry Torokhov wrote:
> > > > I don't see a big difference between 2 and 3. You can use suspend
> > > > blockers to handle either.
> > > 
> > > You can, but they aren't necessary.  If 2 were the only reason for
> > > suspend blockers, I would say they shouldn't be merged.
> > > 
> > > Whereas 3, on the other hand, can _not_ be handled by any existing
> > > mechanism.  3 is perhaps the most important reason for using suspend
> > > blockers.
> > 
> > I do not see why 3 has to be implemented using suspend blockers either.
> > If you are concerned that event gets stuck somewhere in the stack make
> > sure that devices in the stack do not suspend while their queue is not
> > empty. This way if you try opportunistic suspend it will keep failing
> > until you drained all important queues.
> 
> Here's the scenario:
> 
> The system is awake, and the user presses a key. The keyboard driver
> processes the keystroke and puts it in an input queue.  A user process
> reads it from the event queue, thereby emptying the queue.
> 
> At that moment, the system decides to go into opportunistic suspend.
> Since the input queue is empty, there's nothing to stop it.  As the
> first step, userspace is frozen -- before the process has a chance to
> do anything with the keystroke it just read.  As a result, the system
> stays asleep until something else wakes it up, even though the
> keystroke was important and should have prevented it from sleeping.
> 
> Suspend blockers protect against this scenario.  Here's how:
> 
> The user process doesn't read the input queue directly; instead it
> does a select or poll.  When it sees there is data in the queue, it
> first acquires a suspend blocker and then reads the data.
> 
> Now the system _can't_ go into opportunistic suspend, because a suspend
> blocker is active.  The user process can do whatever it wants with the
> keystroke.  When it is finished, it releases the suspend blocker and
> loops back to the select/poll call.
> 

What you describe can be done in userspace though, via a "suspend manager" 
process. Tasks reading input events will post "busy" events to stop the 
manager process from sending system into suspend. But this can be confined to 
Android userspace, leaving the kernel as is (well, kernel needs to be modified 
to not go into suspend with full queues, but that is using existing kernel 
APIs).

-- 
Dmitry
