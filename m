From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] PM: Introduce core framework for
 run-time PM of I/O devices (rev. 5)
Date: Fri, 26 Jun 2009 14:06:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906261155160.2965-100000__24103.0737096027$1246039698$gmane$org@iolanthe.rowland.org>
References: <200906252358.56909.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906252358.56909.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 25 Jun 2009, Rafael J. Wysocki wrote:

> > The whole business about the runtime_notify and RPM_NOTIFY flags is 
> > impenetrable.  My suggestion: Rename runtime_notify to notify_pending 
> > and eliminate RPM_NOTIFY.  Then make sure that notify_pending is set 
> > whenever a notify work item is queued.
> 
> I was going to do exactly that, but I realized it wouldn't work in general,
> because ->runtime_idle() could run __pm_runtime_suspend() in theory.

I'll cut this short by noting the dilemma.  If the runtime_idle 
callback does a synchronous suspend, and __pm_runtime_suspend sees the 
status is already RPM_SUSPENDING, then it will wait for the suspend to 
finish.  Hence it's not safe to do cancel_work_sync from within 
__pm_runtime_suspend; it might deadlock.

It occurs to me that the problem would be solved if were a cancel_work
routine.  In the same vein, it ought to be possible for
cancel_delayed_work to run in interrupt context.  I'll see what can be
done.

What do you think about adding a version of pm_runtime_put that would 
call pm_runtime_idle directly when the counter reaches 0, instead of 
queuing an idle request?  I feel that drivers should have a choice 
about which sort of notification to use.


> > And don't forget to decrement the parent's child_count again if the resume
> > fails.
> 
> I didn't _forget_it, because the device can't be RPM_SUSPENDED after
> __pm_runtime_resume().

You're right; that fact escaped me.

> > In __pm_runtime_suspend, you should decrement the parent's child_count
> > before releasing the child's lock.
> 
> Why exactly is that necessary?

I guess it isn't.  But it won't hurt to keep the parent's counter
synchronized with the child's state as closely as possible.

Alan Stern
