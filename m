From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 6)
Date: Mon, 29 Jun 2009 17:55:37 +0200
Message-ID: <200906291755.38232.rjw__38185.686877887$1246291010$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906291107040.16597-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906291107040.16597-100000@iolanthe.rowland.org>
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

On Monday 29 June 2009, Alan Stern wrote:
> On Mon, 29 Jun 2009, Rafael J. Wysocki wrote:
> 
> > > > So, it seems, pm_request_resume() can't kill suspend requests by itself
> > > > and instead it has to queue up resume requests for this purpose, which
> > > > brings us right back to the problem of two requests queued up at a time
> > > > (a delayed suspend request and a resume request that is supposed to cancel it).
> > > 
> > > No, you're trying to do too much.  If the state is RPM_IDLE (i.e., a 
> > > suspend request is pending) then rpm_request_resume doesn't need to do 
> > > anything.  The device is already resumed!  Sure, it can try to kill the 
> > > request and change the state to RPM_ACTIVE, but it doesn't need to.
> > 
> > I think it does need to do that, because the reuqest may be scheduled way
> > in the future and we can't preserve its work structure until it runs.
> > pm_request_resume() doesn't know in advance when the suspend work function is
> > going to be queued up and run.
> 
> It doesn't need to know.  All it needs to do is guarantee that the
> device will be in a resumed state some time not long after the function
> returns.  Thus calling rpm_request_resume while the status is RPM_IDLE
> is like calling it while the status is RPM_ACTIVE.  In neither case
> does it have to do anything, because the device will already be resumed
> when it returns.

Not exactly, because RPM_IDLE prevents idle notifications from being run,
as it means a suspend has already been requested, which is not really the
case after pm_request_resume().

> Perhaps instead we should provide a way to kill a pending suspend
> request?  It's not clear that anyone would need this.  The only reason
> I can think of is if you wanted to change the timeout duration.  But it
> wouldn't be able to run in interrupt context.
> 
> > > Think about it.  Even if the suspend request were killed off, there's 
> > > always the possibility that someone could call rpm_runtime_suspend 
> > > right afterward.  If the driver really wants to resume the device and 
> > > prevent it from suspending again, then the driver should call 
> > > pm_runtime_get before pm_request_resume.  Then it won't matter if the 
> > > suspend request runs.
> > 
> > No, it doesn't matter if the request runs, but it does matter if the work
> > structure used for queuing it up may be used for another purpose. :-)
> 
> What else would it be used for?  If rpm_request_resume returns without 
> doing anything and leaves the status set to RPM_IDLE, then the work 
> structure won't be reused until the status changes.

Which is not right, because we may want to run ->runtime_idle() before
the status is changed.

That's why I think pm_request_resume() should queue up a resume request if
a suspend request is pending.

> > The problem with pm_<something>_put is that it does two things at a time,
> > decrements the resume counter and runs or queues up an idle notification.
> > Perhaps it's a good idea to call it after the second thing and change
> > pm_runtime_get() to pm_runtime_inuse(), so that we have:
> > 
> > * pm_runtime_inuse() - increment the resume counter
> > * pm_runtime_idle() - decrement the resume counter and run idle notification
> > * pm_request_idle()  - decrement the resume counter and queue idle notification
> > 
> > and __pm_runtime_idle() as the "bare" idle notification function?
> 
> I could live with that, but the nice thing about "get" and "put" is
> that they directly suggest a counter is being maintained and therefore
> the calls have to balance.  Maybe we should just call it 
> rpm_request_put and not worry that the put happens immediately.

OK

Best,
Rafael
