From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Run-time PM framework (was: Re: [patch update]
 PM: Introduce core framework for run-time PM of I/O devices (rev. 6))
Date: Sun, 5 Jul 2009 10:50:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907041938580.10275-100000__950.799932661717$1246805529$gmane$org@netrider.rowland.org>
References: <200907042327.32073.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907042327.32073.rjw@sisk.pl>
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

On Sat, 4 Jul 2009, Rafael J. Wysocki wrote:

> > As for whether or not we should actually call cancel_work...  Which is 
> > more expensive: Calling cancel_work when no work is pending, or letting 
> > the work item run when it doesn't have anything to do?  Probably the 
> > latter.
> 
> Agreed, but that doesn't affect functionality.  We can get the desired
> functionality without the cancel_work() patch and then optimize things along
> with that patch.  This way it'll be easier to demontrate the benefit of it.

Good idea.

> That almost entirely depends on the bus type.  For PCI and probably PNP as well
> there's a notion of ACPI low power states and there are AML methods to put the
> devices into these states.  Unfortunately, the ACPI low power state to put the
> device into depends on the target sleep state of the system, so these devices
> will probably have to be put into D0 before system suspend anyway.
> 
> I think that the bus type can handle this as long as it knows the state the
> device is in before system suspend.  So, the only thing the core should do is
> to block the execution of run-time PM framework functions during system
> sleep and resume.  The state it leaves the device in shouldn't matter.
> 
> So, I think we can simply freeze the workqueue, set the 'disabled' bit for each
> device and wait for all run-time PM operations on it in progress to complete.
> 
> In the 'disabled' state the bus type or driver can modify the run-time PM
> status to whatever they like anyway.  Perhaps we can provide a helper to
> change 'request type' to RPM_REQ_NONE.

The only modification that really makes sense is like you said, going
back to full power in preparation for the platform suspend operation.  
Therefore perhaps we should allow pm_runtime_resume to work even when
rpm_disabled is set.  And if we're going to cancel pending suspend and
idle requests, then rpm_request would normally be RPM_REQ_NONE anyway.

Which leaves only the question of what to do when a resume request is 
pending...

> So, I guess we have the majority of things clarified and perhaps its time to
> write a patch for further discussion. :-)

Go ahead!

Alan Stern
