From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Mon, 7 Jan 2008 16:32:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801071622560.6739-100000__8700.1126063571$1199741609$gmane$org@iolanthe.rowland.org>
References: <200801072137.43401.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801072137.43401.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Jan 2008, Rafael J. Wysocki wrote:

> > > Do you mean it might have been released already by another thread
> > > calling device_pm_destroy_suspended() on the same device?
> > 
> > I was thinking that it might be called before lock_all_devices().
> 
> I've added pm_sleep_start_end_mtx and the locking dance in
> device_pm_destroy_suspended() specifically to prevent this from happening.

Yes, I see.  What about the fact that device_suspend() locks 
pm_sleep_start_end_mtx first and pm_sleep_rwsem second, whereas 
device_pm_destroy_suspended() locks pm_sleep_start_end_mtx while 
holding pm_sleep_rwsem?  That should produce a lockdep warning.

> > However let's ignore that possibility and simplify the discussion by 
> > assuming that destroy_suspended_device() is never called except by a 
> > suspend or resume method for that device or one of its ancestors.  
> 
> It may also be called by one of the CPU hotplug notifiers.

This suggests another approach, simpler but not as general.  So far all
the problems we've seen have been associated with those CPU notifiers.  
Suppose the notifications about CPUs that failed to come back up were
delayed until after the resume was complete?  Drivers like msr would
then have to check in their resume handler whether the CPU was actually 
up, but no other changes would be needed.

In this way we could fix the immediate problem.  It wouldn't help with 
other sorts of devices that need to be unregistered during a suspend, 
though.

> Okay, well, now I'm leaning towards the asynchronous approach.
> 
> I'll prepare a new patch and send it later today.

Okay.

Alan Stern
