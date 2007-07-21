From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 10:10:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707210956320.8201-100000__32033.8274738335$1185027089$gmane$org@netrider.rowland.org>
References: <Pine.LNX.4.64.0707201540260.5166@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707201540260.5166@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 20 Jul 2007 david@lang.hm wrote:

> > How would you prevent tasks from being scheduled?  How would you
> > prevent drivers from deadlocking because in order to put their device
> > in a low-power state they need to acquire a lock which is held by a
> > user task?
> 
> you give up on the suspend becouse you have no way of getting the user 
> task to give up the lock.

Once the deadlock has occurred it's too late.  You can't give up; in 
fact you can't do anything at all.  The system has hung.

> however, kernel locks should not be held by user tasks, user tasks are not 
> expected to behave in rational ways, allowing them to compete with kernel 
> tasks for locks is a sure way to get a deadlock or indefinate stall.

What on Earth are you talking about?  "Kernel locks should not be held 
by user tasks"?  Then who _should_ hold them?  You are aware, I hope, 
that down() and mutex_lock() can be called only in process context?

> what locks are accessed this way?

Lots of them.  For example, most drivers won't want a suspend to occur
right in the middle of an I/O transfer.  To prevent this, the driver
might use a mutex.  The task doing the I/O (which will be a user task)
acquires the mutex during a transfer and the suspend routine acquires
the mutex while quiescing the device.

> >> Does it really (fundamentally) require scheduling tasks, particularly in
> >> the case that the devices have already been put in the "quiesced" state?
> >
> > I can't say for sure.  That's the way we have been doing it.  It
> > wouldn't be easy to change, because the driver would have to busy-wait
> > during delays -- which would mean it would need to use different code
> > for system-wide suspend and runtime suspend.
> 
> please define terms so that we are all on the same page

Please read Documentation/power/devices.txt.

> what do you mean by
> system-wide suspend

That's what you would call standby, suspend-to-RAM, or hibernate.  The
entire system goes to sleep.

> runtime suspend

That's when an individual device is placed in a low-power state to 
save energy while it isn't being used.  The system as a whole remains 
awake and the device will be resumed the next time it is needed for 
anything.

Alan Stern
