From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update 2 fix] PM: Introduce core framework
 for run-time PM of I/O devices
Date: Thu, 18 Jun 2009 14:17:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906181336500.1445-100000__15799.5606460192$1245349461$gmane$org@netrider.rowland.org>
References: <200906180107.34764.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906180107.34764.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thu, 18 Jun 2009, Rafael J. Wysocki wrote:

> Not only then.  The dev->power.depth counter was meant to be a "disable
> everything" one, because there are situations in which we don't want even
> resume to run (probe, release, system-wide suspend, hibernation, resume from
> a system sleep state, possibly others).
> 
> That said, I overlooked some problems related to it.  So, I think to disable
> the runtime PM of given device, it will be necessary to run a synchronous
> runtime resume with taking a ref to block suspend.

There should also be an async version, which increases depth while
submitting a resume request.

In fact, maybe it would be best if pm_request_resume always increments
depth (unless it fails for some other reason) and __pm_runtime_resume
increments depth whenever called synchronously.  And likewise for the
suspend paths.

> > Instead of a costly device_for_each_child(), would it be better to
> > maintain a counter with the number of unsuspended children?
> 
> Hmm.  How exactly are we going to count them?  The only way I see at the moment
> would be to increase this number by one when running pm_runtime_init() for a
> new child.  Seems doable.

That's right.  You also have to decrement the number when an
unsuspended child device is removed, obviously.  The one thing to
watch out for is what happens if a device is removed while its
runtime_resume callback is running.  :-)

> > > +	spin_lock(&dev->power.lock);
> > 
> > Should be spin_lock_irq().  Same in other places.
> 
> OK, I wasn't sure about that.

The reasoning isn't complicated.  If a spinlock can be taken by an
interrupt handler (or any other code that might run in interrupt
context) then you have the possibility of a deadlock as follows:

	spin_lock(&lock);
	<Interrupt occurs>
		irq_handler() {
			spin_lock(&lock);

The handler can't acquire the lock because it is already in use, and
it can't be released until the handler returns.

As a result, if a spinlock is ever taken within an interrupt handler
then it always has to be acquired with interrupts disabled.
Similarly, if it is never taken within an interrupt handler but it is
taken within a bottom-half routine, then it always has to be acquired
with bottom halves disabled.

> From the functionality point of view, nothing wrong happens if runtime suspend
> fails as long as an error code is returned and the caller has to be prepared
> for a failure anyway.  Moreover, we never know why the resume is carried out,
> so it's not clear whether it will be valid to carry out the suspend after that.

Your first point certainly is correct.  As for the second point, if
whoever did the resume doesn't want the device suspended again, he
should have incremented depth.  So making the suspend wait until the
resume is finished and then failing because the depth is positive
would be a valid approach.

However there's no use worrying about this until we have some real
examples.

> > > +		spin_unlock(&dev->parent->power.lock);
> > > +
> > > +		/* The device's parent is not active.  Resume it and repeat. */
> > > +		error = __pm_runtime_resume(dev->parent, false);
> > > +		if (error)
> > > +			return error;
> > 
> > Need to reset error to -EINVAL.
> 
> Why -EINVAL?

We have lost the context because of email trimming.  Briefly, when you
jump back to "repeat:", the code there expects error to have been
initialized to -EINVAL.  Some of the pathways will return error
unchanged, expecting it to have that value.

Alternatively, you could have those pathways set error and then you
wouldn't have to initialize it.  Either way.


> > The equivalent code in USB does this automatically.  The
> > runtime-disable routine does a resume if the depth value was
> > originally 0,
> 
> Yes, we should do that in general.
> 
> > and the runtime-enable routine queues a delayed autosuspend request if the
> > final depth value is 0.
> 
> I don't like this.

I guess this a question of how you view things.  My view has been that
whever depth (or pm_usage_cnt in the USB code) is 0, it means neither
the driver nor anyone else has any reason to keep the device at full
power.  By definition, since that's what depth is -- a count of the
reasons for not suspending.

There might be some obscure other reason, but in general depth going
to 0 means a delayed autosuspend request should be queued.

Which reminds me... Something to think about: In an async call to
__pm_runtime_suspend, if the runtime_suspend callback returns -EBUSY
then perhaps your code should automatically requeue a new delayed
autosuspend request.  Which implies, of course, that the autosuspend
delay has to be stored in the dev_pm_info structure.  This isn't a bad
thing, since exposing the value in sysfs gives userspace a consistent
way to set the delay.

Alan Stern
