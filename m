From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 2)
Date: Sat, 22 Mar 2008 19:28:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803221920150.8044-100000__12492.7319157452$1206228622$gmane$org@netrider.rowland.org>
References: <200803222317.58206.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803222317.58206.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sat, 22 Mar 2008, Rafael J. Wysocki wrote:

> > Yep.  The only thing to watch out for is in device_pm_remove(); it
> > would be a disaster if somehow a device was removed while it was being
> > prepared/suspended/resumed/completed/whatever.  I know that's not
> > supposed to happen but there's nothing to prevent it, especially if
> > the device in question doesn't have a driver.  No doubt you can invent
> > a way to allow this to happen safely.
> 
> Well, that's a separate issue that IMO should be addressed in a separate patch.
> Something like the one below comes to mind.
> 
> The comment removed by the patch is wrong IMO, because it implies that
> device_add() may be called with the device semaphore held and that might
> deadlock in bus_attach_device().

Are you talking about this comment?

> - * Since device_pm_add() may be called with a device semaphore held,
> - * we must never try to acquire a device semaphore while holding
> - * dpm_list_mutex.

It isn't wrong.  device_add() may indeed be called with a device 
semaphore held -- just not the semaphore for the device being added.  
Quite often it is called with device's parent's semaphore held.  The 
implication is not that we may deadlock in bus_attach_device(); rather 
it is that the order of acquisition must always be device semaphore 
first, dev_list_mutex second.

>  Thus, I think we can acquire dev->sem
> in device_pm_add() and in device_pm_remove().

No, you have missed the entire point.  The problem doesn't exist in the
current code; it exists only if we switch over to using a single list.  
Routines like dpm_suspend() won't be able to use list_for_each_entry()
to traverse the list because entries may be removed by other threads
during the traversal.  Even list_for_each_entry_safe() won't work
correctly without careful attention to details.

Alan Stern
