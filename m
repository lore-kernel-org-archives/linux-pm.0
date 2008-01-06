From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sun, 6 Jan 2008 17:21:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801061712480.19222-100000__31151.1939311915$1199658264$gmane$org@netrider.rowland.org>
References: <200801062057.01677.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801062057.01677.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Jan 2008, Rafael J. Wysocki wrote:

> > Still, shouldn't we fail the removal of the device apart from giving the
> > warning?
> 
> Actually, having thought about it a bit more, I don't see the point in
> preventing the removal of the device from the list in device_pm_remove() if
> we allow all of the operations in device_del() preceding it to be performed.

That's not the issue.  We _don't_ allow all of the operations in 
device_del() preceding the call to device_pm_remove().  In particular, 
the call to the device's driver's remove method will deadlock because 
device_release_driver() always has to acquire dev->sem.

> Shouldn't we just take pm_sleep_rwsem in device_del() upfront and block on that
> if locked?

No -- the whole idea here is to print an error message in the system
log if a driver's resume method tries to call device_del().  Deadlock 
is unavoidable in this case, but at least we'll know which driver is 
guilty.

Alan Stern
