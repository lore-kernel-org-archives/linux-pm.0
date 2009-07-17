From: Nathan Lynch <ntl@pobox.com>
Subject: Re: [patch 2/2] sched: fix nr_uninterruptible accounting
 of frozen tasks really
Date: Fri, 17 Jul 2009 15:54:25 -0500
Message-ID: <1247864065.17553.28.camel__32578.9826958955$1247864353$gmane$org@localhost.localdomain>
References: <20090717121545.489258927@linutronix.de>
	<20090717122103.225652146@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090717122103.225652146@linutronix.de>
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
Cc: Peter Zijlstra <peterz@infradead.org>, containers@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Fri, 2009-07-17 at 12:25 +0000, Thomas Gleixner wrote:
> commit e3c8ca8336 (sched: do not count frozen tasks toward load) broke
> the nr_uninterruptible accounting on freeze/thaw. On freeze the task
> is excluded from accounting with a check for (task->flags &
> PF_FROZEN), but that flag is cleared before the task is thawed. So
> while we prevent that the freezing task with state
> TASK_UNINTERRUPTIBLE is accounted to nr_uninterruptible we decrement
> nr_uninterruptible on thaw.
> 
> Use a separate flag which is handled by the freezing task itself. Set
> it before calling the scheduler with TASK_UNINTERRUPTIBLE state and
> clear it after we return from frozen state.

Thanks for the fix, and sorry for the regression.  I'll test this early
next week but I don't anticipate any problems for the use case the
original patch was addressing.
