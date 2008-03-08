From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Helping drivers to work without the freezer
Date: Sat, 8 Mar 2008 17:57:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803081736040.31118-100000@netrider.rowland.org>
References: <200803082256.20912.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803082256.20912.rjw@sisk.pl>
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

On Sat, 8 Mar 2008, Rafael J. Wysocki wrote:

> > My idea is instead to have the PM core provide a new pair of routines
> > for use by drivers.  Something like "thread_not_sleepable()" and 
> > "thread_sleepable()".  
> > 
> > The first routine would be called by a driver before starting to do
> > I/O, while no locks are held.  If a sleep transition had already
> > started, the routine would block until the sleep was over.  Otherwise,
> > the thread would be marked with a NOT_SLEEPABLE flag until the second
> > routine was called.  When the PM core wanted to start a system sleep
> > it would have to check whether any threads were marked NOT_SLEEPABLE,
> > and wait until none of them were.
> > 
> > This could make drivers a little simpler.  It would mean less code to
> > modify, and it would remove one entry from the messy I/O vs. unbind vs.
> > suspend synchronization problem.
> > 
> > Comments?
> 
> Well, this is what the current freezer does with respect to kernel threads,
> only the name of the flag is different. ;-)

They aren't exactly the same, although they certainly are similar.  The 
difference lies in what happens when a task calls set_freezable() 
after a system sleep has begun; its TIF_FREEZE flag doesn't immediately 
get set.

Also, the current freezer doesn't offer a clear_freezable() routine.

> You basically need something very similar to the current freezer in order
> to implement the "PM core would have to check whether any threads were marked
> NOT_SLEEPABLE, and wait until none of them were" functionality.

Another approach would be to use something like an rwsem.  Hopefully 
without all the cache-line-bouncing overhead on SMP systems.

Alan Stern
