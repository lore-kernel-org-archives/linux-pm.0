From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 21:38:21 +0200
Message-ID: <200906112138.22067.rjw__16685.6746342548$1244749233$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906111010360.2939-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906111010360.2939-100000@iolanthe.rowland.org>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 11 June 2009, Alan Stern wrote:
> On Thu, 11 Jun 2009, Oliver Neukum wrote:
> 
> > Am Donnerstag, 11. Juni 2009 15:48:33 schrieb Rafael J. Wysocki:
> > > > > But after pm_request_resume() returns there's no means to make sure
> > > > > nothing alters it back to RPM_SUSPENDED. The workqueue doesn't help
> > > > > you because you've scheduled nothing by that time. The suspension will
> > > > > work because C is still in RPM_SUSPENDED.
> > > >
> > > > This is an example where usage counters come in handy.
> > >
> > > Do you mean we can count suspend/resume requests for a device?
> > 
> > No, we count reasons a device cannot be suspended. Drivers are allowed to
> > add their own reasons. The core uses that mechanism to indicate that an
> > ongoing resumption lower down is also a reason.
> > The count going to zero is equivalent to a request to suspend.
> 
> Right.

Ah.  *That* is what you had in mind.  Yes, we can do that.
 
> Here's a related thought.  Change the resume routines as follows:
>
> void pm_runtime_resume(struct device *dev)
> {
> // Do the actual resume ...
> }
> EXPORT_SYMBOL_GPL(pm_runtime_resume);
> 
> static void pm_runtime_resume_work(struct work_struct *work)
> {
> 	pm_runtime_resume(resume_work_to_device(work));
> }
> 
> Then there's no need for a separate pm_resume_sync(); drivers can
> simply call pm_runtime_resume() directly.  The same trick works for 
> suspending.
> 
> Of course, this means you have to give up the notion that all suspends 
> and resumes are funnelled through the workqueue.  IMO that notion isn't 
> worth keeping in any case.

That's already not the case for resuming.

Well, ISTR a reason why I thought pm_resume_sync() was needed anyway, but the
idea is actually good.

Thanks,
Rafael
