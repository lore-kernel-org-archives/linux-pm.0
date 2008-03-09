From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Helping drivers to work without the freezer
Date: Sat, 8 Mar 2008 22:19:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803082205270.10362-100000@netrider.rowland.org>
References: <200803090155.40497.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803090155.40497.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 9 Mar 2008, Rafael J. Wysocki wrote:

> > > Well, this is what the current freezer does with respect to kernel threads,
> > > only the name of the flag is different. ;-)
> > 
> > They aren't exactly the same, although they certainly are similar.  The 
> > difference lies in what happens when a task calls set_freezable() 
> > after a system sleep has begun; its TIF_FREEZE flag doesn't immediately 
> > get set.
> 
> We can only wait for them at one point, however.  Periodic checking if there
> are no unsleepable tasks around wouldn't be very practical, IMHO.

I'm not talking about periodic checking.  The waiting is done at only 
one point, the beginning of a system sleep.  Once that check succeeds, 
we know that all unsleepable tasks will block.

("Unsleepable" isn't such a great word.  What I mean is tasks in a 
critical section that must run exclusively WRT system sleeps.)

> > Another approach would be to use something like an rwsem.  Hopefully 
> > without all the cache-line-bouncing overhead on SMP systems.
> 
> Well, to me, rwsem sounds definitely better.  Still, I think it's better to
> avoid locking it for too long, so we could use a variable protected by the
> rwsem such that if it's 'true', unsleepable tasks checking it will put
> themselves into a wait queue which will be woken up by the PM core
> during resume.

Isn't that exactly what an rwsem does?  When it is locked for writing
(your flag is "true"), tasks attempting to get a read lock will put 
themselves into a wait queue which will be woken up when the write lock 
is released (when the PM core sets the flag to "false" during resume).

In this case we could use something a little simpler than a
general-purpose rwsem, since there will never be more than one task
getting a write lock at any time -- i.e., never more than one task
carrying out a system sleep.  It's not hard to design such a simplified
rwsem in a way that exerts virtually no overhead on readers whenever no
writer is present.

Alan Stern
