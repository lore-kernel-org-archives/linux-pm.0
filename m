From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Tue, 25 May 2010 14:35:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005251428090.1634-100000__24178.3282407143$1274812696$gmane$org@iolanthe.rowland.org>
References: <201005251124.58017.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005251124.58017.dmitry.torokhov@gmail.com>
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

> > Here's the scenario:
> > 
> > The system is awake, and the user presses a key. The keyboard driver
> > processes the keystroke and puts it in an input queue.  A user process
> > reads it from the event queue, thereby emptying the queue.
> > 
> > At that moment, the system decides to go into opportunistic suspend.
> > Since the input queue is empty, there's nothing to stop it.  As the
> > first step, userspace is frozen -- before the process has a chance to
> > do anything with the keystroke it just read.  As a result, the system
> > stays asleep until something else wakes it up, even though the
> > keystroke was important and should have prevented it from sleeping.
> > 
> > Suspend blockers protect against this scenario.  Here's how:
> > 
> > The user process doesn't read the input queue directly; instead it
> > does a select or poll.  When it sees there is data in the queue, it
> > first acquires a suspend blocker and then reads the data.
> > 
> > Now the system _can't_ go into opportunistic suspend, because a suspend
> > blocker is active.  The user process can do whatever it wants with the
> > keystroke.  When it is finished, it releases the suspend blocker and
> > loops back to the select/poll call.
> > 
> 
> What you describe can be done in userspace though, via a "suspend manager" 
> process. Tasks reading input events will post "busy" events to stop the 
> manager process from sending system into suspend. But this can be confined to 
> Android userspace, leaving the kernel as is (well, kernel needs to be modified 
> to not go into suspend with full queues, but that is using existing kernel 
> APIs).

I think that could be made to work.  And it might remove the need for 
the userspace suspend-blocker API, which would be an advantage.  It 
could even remove the need for the opportunistic-suspend workqueue -- 
opportunistic suspends would be initiated by the "suspend manager" 
process instead of by the kernel.

However you still have the issue of modifying the kernel drivers to 
disallow opportunistic suspend if their queues are non-empty.  Doing 
that is more or less equivalent to implementing kernel-level suspend 
blockers.  (The suspend blocker approach is slightly more efficient, 
because it will prevent a suspend from starting if a queue is 
non-empty, instead of allowing the suspend to start and then aborting 
it partway through.)

Maybe I'm missing something here...  No doubt someone will point it out 
if I am.

Alan Stern
