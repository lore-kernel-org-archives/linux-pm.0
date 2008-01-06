From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sun, 6 Jan 2008 23:34:05 +0100
Message-ID: <200801062334.05982.rjw__22980.3361733959$1199658775$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0801061712480.19222-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801061712480.19222-100000@netrider.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sunday, 6 of January 2008, Alan Stern wrote:
> On Sun, 6 Jan 2008, Rafael J. Wysocki wrote:
> 
> > > Still, shouldn't we fail the removal of the device apart from giving the
> > > warning?
> > 
> > Actually, having thought about it a bit more, I don't see the point in
> > preventing the removal of the device from the list in device_pm_remove() if
> > we allow all of the operations in device_del() preceding it to be performed.
> 
> That's not the issue.  We _don't_ allow all of the operations in 
> device_del() preceding the call to device_pm_remove().  In particular, 
> the call to the device's driver's remove method will deadlock because 
> device_release_driver() always has to acquire dev->sem.
> 
> > Shouldn't we just take pm_sleep_rwsem in device_del() upfront and block on that
> > if locked?
> 
> No -- the whole idea here is to print an error message in the system
> log if a driver's resume method tries to call device_del().  Deadlock 
> is unavoidable in this case, but at least we'll know which driver is 
> guilty.

Still, if we do that, we won't need to acquire dev->sem in device_pm_remove()
any more.  Apart from this, by acqiring pm_sleep_rwsem for reading in
device_del() we can prevent a suspend from starting while the device is being
removed.

Consider, for example, the scenario possible with the $subject patch:
- device_del() starts and notices pm_sleep_rwsem unlocked, so the warning is
  not printed
- it proceeds and everything before device_pm_remove() succeeds
- now, device_suspend() is called and locks dev->sem
- device_del() calls device_pm_remove() and blocks on that with the device
  partialy removed
I think we should prevent this from happening.

Rafael
