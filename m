From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [patch 2/2] sched: fix nr_uninterruptible accounting
 of frozen tasks really
Date: Sat, 18 Jul 2009 08:26:58 +1000
Message-ID: <4A60FAB2.6030906__11920.277917716$1247869871$gmane$org@crca.org.au>
References: <20090717121545.489258927@linutronix.de>
	<20090717122103.225652146@linutronix.de>
	<1247833910.15751.61.camel@twins>
	<alpine.LFD.2.00.0907171441020.11571@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0907171441020.11571@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, containers@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org, Nathan Lynch <ntl@pobox.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi.

Thomas Gleixner wrote:
> On Fri, 17 Jul 2009, Peter Zijlstra wrote:
> 
>> On Fri, 2009-07-17 at 12:25 +0000, Thomas Gleixner wrote:
>>> plain text document attachment (freezer-fix-accounting-for-real.patch)
>>> commit e3c8ca8336 (sched: do not count frozen tasks toward load) broke
>>> the nr_uninterruptible accounting on freeze/thaw. On freeze the task
>>> is excluded from accounting with a check for (task->flags &
>>> PF_FROZEN), but that flag is cleared before the task is thawed. So
>>> while we prevent that the freezing task with state
>>> TASK_UNINTERRUPTIBLE is accounted to nr_uninterruptible we decrement
>>> nr_uninterruptible on thaw.
>>>
>>> Use a separate flag which is handled by the freezing task itself. Set
>>> it before calling the scheduler with TASK_UNINTERRUPTIBLE state and
>>> clear it after we return from frozen state.
>> Right, so I'm wondering why we don't fully revert e3c8ca8336 to begin
>> with.
> 
> Fine with me, but it seems that the cgroup folks have some luser space
> stuff looking at proc/loadavg which goes berserk when loadavg
> increases rapidly due to freezing. OTOH that stuff seems to be
> oblivious to the fact that the commit in question brings loadavg
> irreversibly to 0 when you do enough freeze/thaw cycles.

That's right. I don't remember the exact details (it's been ages since
this was first reported to me), but sendmail (IIRC) was looking at the
load average and stopping delivery until it dropped sufficiently.

Historically, my solution has been to save and restore the load average
values (on the theory that hibernation should be transparent to
userspace), but I dropped that in favour of this approach.

Regards,

Nigel
