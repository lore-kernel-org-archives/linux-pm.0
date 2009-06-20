From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update 2 fix] PM: Introduce core framework
 for run-time PM of I/O devices
Date: Sat, 20 Jun 2009 10:30:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906201010590.12994-100000__6672.9849124842$1245508331$gmane$org@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Magnus Damm <magnus.damm@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Some more thoughts...

Magnus, you might have some insights here.  It occurred to me that some 
devices can switch power levels very quickly, and the drivers might 
therefore want the runtime suspend and resume methods to be called as 
soon as possible, even in interrupt context.

In terms of the current framework, this probably means holding the
runtime PM lock (i.e., not releasing it) across the calls to
->runtime_suspend and ->runtime_resume.  It also means that
pm_request_suspend and pm_request_resume should carry out their jobs
immediately instead of queuing a work item.  (Unless the current status 
is RPM_SUSPENDING or RPM_RESUMING, which should never happen.)

Should there be a flag in dev_pm_info to select this behavior?


When a device structure is unregistered and deallocated, we have to
insure that there aren't any pending runtime PM workqueue items.  
Hence device_del should call a routine that changes the status to an
exceptional state (not RPM_ERROR but something else) to prevent new
requests from being queued, and then calls cancel_work_sync or
cancel_delayed_work_sync as required.

Similarly, we should insure that runtime PM calls made before the
device is registered don't do anything.  So when the device structure
is first created and the contents are all 0, this should also be
interpreted as an exceptional state.  We could call it RPM_UNREGISTERED
and use it for both purposes.

Alan Stern
