From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update 2 fix] PM: Introduce core framework
	for run-time PM of I/O devices
Date: Sun, 21 Jun 2009 01:48:56 +0200
Message-ID: <200906210148.57199.rjw__27843.3058913381$1245541748$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906201010590.12994-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906201010590.12994-100000@netrider.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Saturday 20 June 2009, Alan Stern wrote:
> Some more thoughts...
> 
> Magnus, you might have some insights here.  It occurred to me that some 
> devices can switch power levels very quickly, and the drivers might 
> therefore want the runtime suspend and resume methods to be called as 
> soon as possible, even in interrupt context.

Then, we'll need special suspend and resume calls for them.

> In terms of the current framework, this probably means holding the
> runtime PM lock (i.e., not releasing it) across the calls to
> ->runtime_suspend and ->runtime_resume.  It also means that
> pm_request_suspend and pm_request_resume should carry out their jobs
> immediately instead of queuing a work item.  (Unless the current status 
> is RPM_SUSPENDING or RPM_RESUMING, which should never happen.)
> 
> Should there be a flag in dev_pm_info to select this behavior?

I don't think we should complicate pm_request_suspend() and pm_request_resume()
further to handle this particular case.  IMO it's better to provide separate
core calls for that.

> When a device structure is unregistered and deallocated, we have to
> insure that there aren't any pending runtime PM workqueue items.  
> Hence device_del should call a routine that changes the status to an
> exceptional state (not RPM_ERROR but something else) to prevent new
> requests from being queued, and then calls cancel_work_sync or
> cancel_delayed_work_sync as required.

This is done in the patch I've just sent.
 
> Similarly, we should insure that runtime PM calls made before the
> device is registered don't do anything.  So when the device structure
> is first created and the contents are all 0, this should also be
> interpreted as an exceptional state.  We could call it RPM_UNREGISTERED
> and use it for both purposes.

Hmm.  How do you think is possible that the pm_runtime_* functions will be
called in such a situation?

Best,
Rafael
