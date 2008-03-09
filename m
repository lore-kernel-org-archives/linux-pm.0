From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Helping drivers to work without the freezer
Date: Sun, 9 Mar 2008 01:55:39 +0100
Message-ID: <200803090155.40497.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803081736040.31118-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803081736040.31118-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 8 of March 2008, Alan Stern wrote:
> On Sat, 8 Mar 2008, Rafael J. Wysocki wrote:
> 
> > > My idea is instead to have the PM core provide a new pair of routines
> > > for use by drivers.  Something like "thread_not_sleepable()" and 
> > > "thread_sleepable()".  
> > > 
> > > The first routine would be called by a driver before starting to do
> > > I/O, while no locks are held.  If a sleep transition had already
> > > started, the routine would block until the sleep was over.  Otherwise,
> > > the thread would be marked with a NOT_SLEEPABLE flag until the second
> > > routine was called.  When the PM core wanted to start a system sleep
> > > it would have to check whether any threads were marked NOT_SLEEPABLE,
> > > and wait until none of them were.
> > > 
> > > This could make drivers a little simpler.  It would mean less code to
> > > modify, and it would remove one entry from the messy I/O vs. unbind vs.
> > > suspend synchronization problem.
> > > 
> > > Comments?
> > 
> > Well, this is what the current freezer does with respect to kernel threads,
> > only the name of the flag is different. ;-)
> 
> They aren't exactly the same, although they certainly are similar.  The 
> difference lies in what happens when a task calls set_freezable() 
> after a system sleep has begun; its TIF_FREEZE flag doesn't immediately 
> get set.

We can only wait for them at one point, however.  Periodic checking if there
are no unsleepable tasks around wouldn't be very practical, IMHO.

> Also, the current freezer doesn't offer a clear_freezable() routine.

Oh, it would be easy to add one. :-)

> > You basically need something very similar to the current freezer in order
> > to implement the "PM core would have to check whether any threads were marked
> > NOT_SLEEPABLE, and wait until none of them were" functionality.
> 
> Another approach would be to use something like an rwsem.  Hopefully 
> without all the cache-line-bouncing overhead on SMP systems.

Well, to me, rwsem sounds definitely better.  Still, I think it's better to
avoid locking it for too long, so we could use a variable protected by the
rwsem such that if it's 'true', unsleepable tasks checking it will put
themselves into a wait queue which will be woken up by the PM core
during resume.

Thanks,
Rafael
