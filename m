From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Need lockdep help
Date: Mon, 3 Dec 2007 10:08:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712031000480.3630-100000__14211.3321031959$1196694731$gmane$org@iolanthe.rowland.org>
References: <20071203103630.GB2429@ff.dom.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071203103630.GB2429@ff.dom.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 Dec 2007, Jarek Poplawski wrote:

> > System sleep start:
> > 		down_read(notifier-chain rwsem);
> > 		call the notifier routine
> > 			down_write(&system_sleep_in_progress_rwsem);
> > 		up_read(notifier-chain rwsem);
> > 
> > System sleep end:
> > 		down_read(notifier-chain rwsem);
> > 		call the notifier routine
> > 			up_write(&system_sleep_in_progress_rwsem);
> > 		up_read(notifier-chain rwsem);
> > 
> > This creates a lockdep violation; each rwsem in turn is locked while 
> > the other is being held.  However the only way this could lead to 
> > deadlock would be if there was already a bug in the system Power 
> > Management code (overlapping notifications).
> 
> Actually, IMHO, there is no reason for any lockdep violation:
> 
> thread #1: has down_read(A); waits for #2 to down_write(B)
> thread #2: has down_write(B); never waits for #1 to down_read(A)
> 
> So, deadlock isn't possible here. If lockdep reports something else it
> should be fixed (and you'd be right to omit lockdep until this is
> done).

I think the reasoning goes the way Arjan described.  Suppose in between
#1 and #2 there is thread #3 trying to do down_write(A) and waiting for
#1.  Then thread #2 doesn't have to wait for #1 directly, but it would
have to wait for #3.

In my case the simplest answer appears to be the replace the rwsem
with something slightly more complicated (a mutex plus a boolean flag 
-- the loss of concurrency won't matter much since it isn't on a hot 
path).

Thanks for the comment.

Alan Stern
