From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Helping drivers to work without the freezer
Date: Sat, 8 Mar 2008 22:56:20 +0100
Message-ID: <200803082256.20912.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803081127430.18951-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803081127430.18951-100000@netrider.rowland.org>
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
> This idea just occurred to me.  It may or may not end up being useful, 
> and I don't have any specific applications in mind yet.
> 
> System sleeps are supposed to be transparent to userspace.  An I/O 
> request submitted just before the sleep starts should be blocked until 
> after the system wakes up.
> 
> Without the freezer to do this blocking for them, drivers will have to 
> do it themselves.  So when a driver is about to carry out an I/O 
> operation, it has to insure that the operation is mutually exclusive 
> with sleeping.
> 
> One way to do this is by a private mutex, which would protect both the
> block of code doing the I/O and the suspend routine.  One for each
> device; that's a lot of new mutexes.
> 
> My idea is instead to have the PM core provide a new pair of routines
> for use by drivers.  Something like "thread_not_sleepable()" and 
> "thread_sleepable()".  
> 
> The first routine would be called by a driver before starting to do
> I/O, while no locks are held.  If a sleep transition had already
> started, the routine would block until the sleep was over.  Otherwise,
> the thread would be marked with a NOT_SLEEPABLE flag until the second
> routine was called.  When the PM core wanted to start a system sleep
> it would have to check whether any threads were marked NOT_SLEEPABLE,
> and wait until none of them were.
> 
> This could make drivers a little simpler.  It would mean less code to
> modify, and it would remove one entry from the messy I/O vs. unbind vs.
> suspend synchronization problem.
> 
> Comments?

Well, this is what the current freezer does with respect to kernel threads,
only the name of the flag is different. ;-)

You basically need something very similar to the current freezer in order
to implement the "PM core would have to check whether any threads were marked
NOT_SLEEPABLE, and wait until none of them were" functionality.

Thanks,
Rafael
