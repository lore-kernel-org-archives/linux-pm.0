From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Need lockdep help
Date: Sun, 2 Dec 2007 12:04:11 -0800
Message-ID: <20071202120411.2aac7720@laptopd505.fenrus.org>
References: <Pine.LNX.4.44L0.0712021430140.4185-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Ingo Molnar <mingo@elte.hu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2 Dec 2007 14:45:32 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> Ingo:
> 
> I ran into a lockdep reporting issue just now with some new code
> under development.  I think it's a false positive; the question is
> how best to deal with it.
> 
> Here's the situation.  The new code runs during a system sleep (i.e., 
> suspend or hibernation).  Certain activities have to be deferred
> during a system sleep, so I defined an rwsem:
> system_sleep_in_progress_rwsem.
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
> an rwsem (to prevent the chain from being modified while it is in
> use). The resulting actions look like this:
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

or.. modifications to the notifier chain while all this is happening
(remember: rwsems are fair, once a writer shows up, all readers wait)


-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
