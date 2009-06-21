From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update 3] PM: Introduce core framework for
	run-time PM of I/O devices
Date: Sun, 21 Jun 2009 14:46:25 +0200
Message-ID: <200906211446.26019.rjw__14769.778159871$1245588428$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906202142110.20502-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906202142110.20502-100000@netrider.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sunday 21 June 2009, Alan Stern wrote:
> On Sun, 21 Jun 2009, Rafael J. Wysocki wrote:
> 
> > > 	pm_request_suspend should run very quickly, since it will be
> > > 	called after every I/O operation.  Likewise, pm_request_resume
> > > 	should run very quickly if the status is RPM_ACTIVE or 
> > > 	RPM_IDLE.
> > 
> > Hmm.  pm_request_suspend() is really short, so it should be fast.
> > pm_request_resume() is a bit more complicated, though (it takes two spinlocks,
> > increases an atomic counter, possibly twice, and queues up a work item, also
> > in the RPM_IDLE case).
> 
> Hmm, maybe that's a good reason for not trying to handle the parent
> from within pm_request_resume().  :-)
>
> Or maybe the routine should be optimized for the RPM_ACTIVE and 
> RPM_IDLE cases, where it doesn't have to do much anyway.

Yes, I think that's the way to go.

> > > 	In order to prevent autosuspends from occurring while I/O is
> > > 	in progress, the pm_request_resume call should increment the
> > > 	usage counter (if it had to queue the request) and the 
> > > 	pm_request_suspend call should decrement it (maybe after
> > > 	waiting for the delay).
> > 
> > I don't want like pm_request_suspend() to do that, because it's valid to
> > call it many times in a row. (only the first request will be queued in such a
> > case).
> 
> Sorry, what I meant was that in each case the counter should be
> {inc,dec}remented if a new request had to be queued.  If one was
> already queued then the counter should be left alone.
> 
> The reason behind this is that a bunch of pm_request_suspend calls
> which all end up referring to the same workqueue item will result in a
> single async call to the runtime_suspend method.

Yes, that's why only the first one results in queuing up a request.

There is a problem with that if the later calls are supposed to use shorter
delays, but I have no real idea to handle this cleanly.

> Therefore they should cause a single decrement of the counter.  Likewise for
> pm_request_resume.

Hmm.  Why exactly do you think it's necessary to decrease the usage counter
in suspend functions?  You can't suspend a device more than once and you have
to resume it at the first request anyway.

I think it makes sense to increase the usage counter on every attempt to
resume, even if the device is not woken up as a result, because that means the
caller wants the device not to be suspended until the counter is decreased.
This way, even if the device is already active, multiple callers can prevent it
from suspending by calling pm_request_resume_get() or pm_runtime_resume_get()
and then dropping the references.

Now, we can also make pm_request_suspend() and pm_runtime_suspend() drop
the usage counter (if it's greater than zero), but that implies a usage model
in which a resume function called when I/O is started should be balanced with a
suspend function called after the I/O has been finished.

However, I'd prefer a usage model in which ->runtime_idle() is called when the
I/O is finished and the usage counter is zero and it decides whether to call a
suspend function.

So, perhaps I should make resume functions increase the usage counter
unconditionally and introduce pm_runtime_idle() to be called when the I/O is
done?  That is, pm_runtime_idle() will decrement the usage counter, check if
it's zero and call ->runtime_idle() when that's the case (well, this is what
pm_runtime_put_notify() does right now, but maybe the name is wrong).

Also, there should be a function to use when it's only necessary to drop the
usage counter, without calling ->runtime_idle() (for example, if another code
path is supposed to call a suspend function directly).

> > I'd prefer the caller to do pm_request_resume_get() (please see the patch
> > below) to put a resume request into the queue and then pm_runtime_put_notify()
> > when it's done with the I/O.  That will result in ->runtime_idle() being called
> > automatically if the device may be suspended.
> 
> If anyone does pm_request_resume or pm_runtime_resume, what is there to 
> prevent the device from being suspended again as soon as the resume is 
> finished (and before anything useful can be accomplished)?
> 
>      1. The driver's runtime_suspend method might be smart enough to 
> 	return -EBUSY until the driver has completed whatever it's 
> 	doing.
> 
>      2. The usage counter might be > 0.
> 
>      3. The number of children might be > 0.
> 
> In case 1 there's no reason not to also increment the counter, since
> the driver can decrement it again when it is finished.  In cases 2 and
> 3, we can assume the counter or the number of children was previously
> equal to 0, since otherwise the resume call would have been vacuous.  
> This implies that the resume call itself should be responsible for
> incrementing either the counter or the number of children.
> 
> What I'm getting at is this: There's no real point to having separate 
> pm_request_resume and pm_request_resume_get calls.  All such calls 
> should increment either the usage counter or the number of children.

OK

But there are devices with no children, so I think it's necessary to increment
the usage counter in all cases.

> (In the USB stack, a single counter is used for both purposes.  It 
> doesn't look like that will work here.)
> 
> 
> > > All bus types will want to implement _some_ delay; it doesn't make
> > > sense to power down a device immediately after every operation and then
> > > power it back up for the next operation.
> > 
> > Sure.  But you can use the pm_request_resume()'s delay to achieve that
> > without storing the delay in 'struct device'.  It seems.
> 
> If you do it that way then the delay has to be hard-coded or stored in
> some non-standardized location.  Which will be more common: devices
> where the delay is fixed by the bus type (or driver), or devices where
> the user should be able to adjust the delay?  If user-adjustable is 
> more common then the delay should be stored in dev_pm_info, so that it 
> can be controlled by a centralized sysfs attribute defined in the 
> driver core.  If not then you are right, the delay doesn't need to be 
> stored in struct device.

I agree, but I'd prefer not to add the delay and timestamp fields to the
picture in a future patch.

Best,
Rafael
