From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sun, 6 Jan 2008 23:47:48 +0100
Message-ID: <200801062347.49935.rjw__44187.9853759476$1199659692$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0801061734150.20032-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801061734150.20032-100000@netrider.rowland.org>
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
> > > No -- the whole idea here is to print an error message in the system
> > > log if a driver's resume method tries to call device_del().  Deadlock 
> > > is unavoidable in this case, but at least we'll know which driver is 
> > > guilty.
> > 
> > Still, if we do that, we won't need to acquire dev->sem in device_pm_remove()
> > any more.
> 
> There's a window in lock_all_devices() when dpm_list_mtx isn't held.  
> We don't want device_pm_remove() taking an already-locked device off 
> the dpm_locked list at that time.  So we do need to acquire dev->sem in 
> device_pm_remove().

Not if pm_sleep_rwsem is held by device_del(), since in that case we won't
reach lock_all_devices() (device_add() calls device_pm_remove() under
pm_sleep_rwsem already).

> > Apart from this, by acqiring pm_sleep_rwsem for reading in
> > device_del() we can prevent a suspend from starting while the device is being
> > removed.
> > 
> > Consider, for example, the scenario possible with the $subject patch:
> > - device_del() starts and notices pm_sleep_rwsem unlocked, so the warning is
> >   not printed
> > - it proceeds and everything before device_pm_remove() succeeds
> > - now, device_suspend() is called and locks dev->sem
> > - device_del() calls device_pm_remove() and blocks on that with the device
> >   partialy removed
> > I think we should prevent this from happening.
> 
> I don't see anything wrong with it.  All that will happen is that the 
> removal will start before the suspend and finish after the resume.

In that case, we'll attempt to call the device's .suspend() and .resume()
routines, but we shouldn't do that, IMHO.

Rafael
