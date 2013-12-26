From: Alan Stern <stern@rowland.harvard.edu>
Subject: No freezing of kernel threads (was: Re: [GIT PULL] libata fixes for
 v3.13-rc5)
Date: Wed, 25 Dec 2013 22:29:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1312252211550.15064-100000@netrider.rowland.org>
References: <1667032.A7Knz5cBng@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1667032.A7Knz5cBng@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

n Wed, 25 Dec 2013, Rafael J. Wysocki wrote:

> > Is this discussed in more detail somewhere (an email thread, for
> > example)?
> 
> This one, more or less: https://lkml.org/lkml/2013/12/13/402

Thanks.  As I understand it (correct me if this is wrong), the problem
is that some subsystems wait for a freezable work queue or kthread to
carry out some job, and they do this as part of their resume pathway.  
Obviously this leads to deadlock.

One possible answer is to fix the subsystems -- make them not do that
any more.  Easier said than done, I suppose.  In any case, this is a
class of errors that is not easily detectable at the moment (could
lockdep be taught to recognize it?).

But I don't see how swinging to the other extreme (i.e., making no
kernel threads or work queues freezable) really solves anything.  
Those things are freezable for real reasons; they do stuff that must
not happen while the system is in the middle of a sleep transition.

Thus...  If a subsystem's resume pathway depends on something happening 
which must not happen during a sleep transition, then something is 
fundamentally broken.

Perhaps the problem could be solved by a finer-grained approach.  For
example, maybe some of these work queues or kthreads need to be frozen
only while the system is suspending, so they can safely be thawed when
the resume begins.  Would that fix the problem that began this 
discussion?

I know that in the case of khubd, we really do want it to remain frozen 
throughout the entire sleep transition.

Alan Stern
