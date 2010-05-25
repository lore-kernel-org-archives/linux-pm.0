From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Tue, 25 May 2010 16:00:50 -0700
Message-ID: <87fx1fio2l.fsf__30805.741195991$1274828604$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1005251359580.1634-100000@iolanthe.rowland.org>
	<201005252147.22358.rjw@sisk.pl>
	<20100525195300.GA4455@core.coreip.homeip.net>
	<201005252221.55888.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005252221.55888.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue\, 25 May 2010 22\:21\:55 +0200")
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

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday 25 May 2010, Dmitry Torokhov wrote:
>> On Tue, May 25, 2010 at 09:47:22PM +0200, Rafael J. Wysocki wrote:
>> > On Tuesday 25 May 2010, Dmitry Torokhov wrote:
>> > > On Tuesday 25 May 2010 11:08:03 am Alan Stern wrote:
>> > > > On Tue, 25 May 2010, Dmitry Torokhov wrote:
>> > > > > > > I don't see a big difference between 2 and 3. You can use suspend
>> > > > > > > blockers to handle either.
>> > > > > > 
>> > > > > > You can, but they aren't necessary.  If 2 were the only reason for
>> > > > > > suspend blockers, I would say they shouldn't be merged.
>> > > > > > 
>> > > > > > Whereas 3, on the other hand, can _not_ be handled by any existing
>> > > > > > mechanism.  3 is perhaps the most important reason for using suspend
>> > > > > > blockers.
>> > > > > 
>> > > > > I do not see why 3 has to be implemented using suspend blockers either.
>> > > > > If you are concerned that event gets stuck somewhere in the stack make
>> > > > > sure that devices in the stack do not suspend while their queue is not
>> > > > > empty. This way if you try opportunistic suspend it will keep failing
>> > > > > until you drained all important queues.
>> > > > 
>> > > > Here's the scenario:
>> > > > 
>> > > > The system is awake, and the user presses a key. The keyboard driver
>> > > > processes the keystroke and puts it in an input queue.  A user process
>> > > > reads it from the event queue, thereby emptying the queue.
>> > > > 
>> > > > At that moment, the system decides to go into opportunistic suspend.
>> > > > Since the input queue is empty, there's nothing to stop it.  As the
>> > > > first step, userspace is frozen -- before the process has a chance to
>> > > > do anything with the keystroke it just read.  As a result, the system
>> > > > stays asleep until something else wakes it up, even though the
>> > > > keystroke was important and should have prevented it from sleeping.
>> > > > 
>> > > > Suspend blockers protect against this scenario.  Here's how:
>> > > > 
>> > > > The user process doesn't read the input queue directly; instead it
>> > > > does a select or poll.  When it sees there is data in the queue, it
>> > > > first acquires a suspend blocker and then reads the data.
>> > > > 
>> > > > Now the system _can't_ go into opportunistic suspend, because a suspend
>> > > > blocker is active.  The user process can do whatever it wants with the
>> > > > keystroke.  When it is finished, it releases the suspend blocker and
>> > > > loops back to the select/poll call.
>> > > > 
>> > > 
>> > > What you describe can be done in userspace though, via a "suspend manager" 
>> > > process. Tasks reading input events will post "busy" events to stop the 
>> > > manager process from sending system into suspend. But this can be confined to 
>> > > Android userspace, leaving the kernel as is (well, kernel needs to be modified 
>> > > to not go into suspend with full queues, but that is using existing kernel 
>> > > APIs).
>> > 
>> > For that to work, you'd have to make the user space suspend manager prevent
>> > key-reading processes from emptying the queue before it orders the kernel to
>> > put the system to sleep.  Otherwise it still is possible that the queue will be
>> > emptied right at the moment it writes to /sys/power/state and the scenario
>> > described by Alan is going to happen.
>> >
>> 
>> You do exactly the same as what Alan done, but in userspace - poll, post
>> "busy" event to suspend manager, read, process, retract "busy".
>> Basically you still have the suspend blocker, but it is confined to your
>> userspace.
>
> OK, now the question is why this is actually better.

A couple things come to mind...

1. Fixes problems for *all* kernel users, not just Android.

The kernel changes (refuse to suspend) would be done in a way that
would fix problems in the traditional suspend path as well as the
opportunistic suspend path, thus benefiting everyone.

2. Keep policy out of the kernel

A userspace suspend manager could implement _policy_ decisions in a
platform specific way, rather than having policy hard-coded into the
kernel.

Keeping the policy/governor in userspace would also allow various
governor techniques to be experimented with (polling/timeout
intervals, etc.) without having to patch the kernel.

Kevin
