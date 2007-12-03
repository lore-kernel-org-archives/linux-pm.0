From: Jarek Poplawski <jarkao2@o2.pl>
Subject: Re: Need lockdep help
Date: Mon, 3 Dec 2007 11:36:30 +0100
Message-ID: <20071203103630.GB2429__2917.89037078178$1196697460$gmane$org@ff.dom.local>
References: <Pine.LNX.4.44L0.0712021430140.4185-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0712021430140.4185-100000@netrider.rowland.org>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02-12-2007 20:45, Alan Stern wrote:
> Ingo:
> 
> I ran into a lockdep reporting issue just now with some new code under 
> development.  I think it's a false positive; the question is how best 
> to deal with it.
> 
> Here's the situation.  The new code runs during a system sleep (i.e., 
> suspend or hibernation).  Certain activities have to be deferred during 
> a system sleep, so I defined an rwsem: system_sleep_in_progress_rwsem.
> 
> Subroutines carrying out these activities acquire a read lock on the
> rwsem, so normally they proceed with no hindrance.  During a sleep
> transition, I acquire a write lock -- this is done via a PM-notifier
> callout routine.  That is, during a PM_HIBERNATION_PREPARE or
> PM_SUSPEND_PREPARE notification the routine does down_write(), and
> during a PM_POST_HIBERNATION or PM_POST_SUSPEND notification the
> routine does up_write().
> 
> The problem is that the notifier chain itself is under the control of 
> an rwsem (to prevent the chain from being modified while it is in use).  
> The resulting actions look like this:
> 
> System sleep start:
> 		down_read(notifier-chain rwsem);
> 		call the notifier routine
> 			down_write(&system_sleep_in_progress_rwsem);
> 		up_read(notifier-chain rwsem);
> 
> System sleep end:
> 		down_read(notifier-chain rwsem);
> 		call the notifier routine
> 			up_write(&system_sleep_in_progress_rwsem);
> 		up_read(notifier-chain rwsem);
> 
> This creates a lockdep violation; each rwsem in turn is locked while 
> the other is being held.  However the only way this could lead to 
> deadlock would be if there was already a bug in the system Power 
> Management code (overlapping notifications).

Actually, IMHO, there is no reason for any lockdep violation:

thread #1: has down_read(A); waits for #2 to down_write(B)
thread #2: has down_write(B); never waits for #1 to down_read(A)

So, deadlock isn't possible here. If lockdep reports something else it
should be fixed (and you'd be right to omit lockdep until this is
done).

Regards,
Jarek P.

PS: Peter Zijlstra added to CC
