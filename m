From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 5)
Date: Thu, 25 Jun 2009 23:58:55 +0200
Message-ID: <200906252358.56909.rjw__919.662536080246$1245967233$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906251144280.4836-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906251144280.4836-100000@iolanthe.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 25 June 2009, Alan Stern wrote:
> On Wed, 24 Jun 2009, Alan Stern wrote:
> > More comments to follow when I get time to review more of the code...
> 
> Here we go.  This isn't so detailed, because I wasn't able to do a 
> detailed review.  Frankly, the code is kind of a mess.
> 
> The whole business about the runtime_notify and RPM_NOTIFY flags is 
> impenetrable.  My suggestion: Rename runtime_notify to notify_pending 
> and eliminate RPM_NOTIFY.  Then make sure that notify_pending is set 
> whenever a notify work item is queued.

I was going to do exactly that, but I realized it wouldn't work in general,
because ->runtime_idle() could run __pm_runtime_suspend() in theory.

The runtime_notify bit is only needed for pm_runtime_disable() so that it
knows there's a work item to cancel.

> The pm_notify_or_cancel_work routine should just be pm_notify_work.  
> It's silly to submit a workqueue item just to cancel a delayed
> workqueue item!

Maybe, but how do you think we should cancel it?  cancel_delayed_work()
doesn't guarantee that the work structure used for queuing the work will
not be accessed after it's returned and we can't schedule the next suspend
request until we know it's safe.  So, we have to use cancel_delayed_work_sync()
for that, which can't be done from interrupt context, so we need to do it in a
work function.

> Do all the cancellations in the __pm_runtime_resume and
> __pm_runtime_suspend routines, where you're already in process
> context.

I tried that, but it looked even worse. :-)

> If this means a work item occasionally runs at the wrong time
> then let it -- it will quickly find out that it has nothing to do.

It's not so easy, because it doesn't make sense to let suspend run
if there's already a resume being scheduled or running.
 
> And while you're at it, get rid of the runtime_break flag.

I think it's necessary.  Otherwise I wouldn't have put it in there.

> The logic in __pm_runtime_resume and __pm_runtime_suspend is too
> complicated to check.  This is probably because of the interactions
> with RPM_NOTIFY and runtime_break.  Once they are gone, the logic
> should be much more straightforward: test the flags, then do whatever 
> is needed based on the status.

I tried that, but it turned out to be insufficient, unless there are more
flags.  Well, perhaps adding more flags is the way to go.

> I think once these cleanups are made, the code will be a lot more 
> transparent.
> 
> In __pm_runtime_resume, don't assume that incrementing the parent's
> child_count will prevent the parent from suspending; also increment the
> resume_count.

It's incremented, but dropped too early.

> And don't forget to decrement the parent's child_count again if the resume
> fails.

I didn't _forget_it, because the device can't be RPM_SUSPENDED after
__pm_runtime_resume().

> In __pm_runtime_suspend, you should decrement the parent's child_count
> before releasing the child's lock.

Why exactly is that necessary?

> The pm_runtime_idle call should stay where it is, of course.
>
> One more thing: Don't use flush_work or its relatives -- it tends to
> cause deadlocks.

Oh, well.

> Use cancel_work_sync instead.

OK

Thanks for your comments, but I'm really afraid I won't be able to simplify
the code very much.  It's complicated, because the problem is complicated.

Best,
Rafael
