From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Towards eliminating the freezer
Date: Tue, 24 Jul 2007 10:29:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707241027280.3568-100000__35817.8746224896$1185287434$gmane$org@iolanthe.rowland.org>
References: <200707241133.40287.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707241133.40287.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 24 Jul 2007, Rafael J. Wysocki wrote:

> > Now here's an idea which might work.  Can we require every caller of
> > device_add() to hold some existing device's semaphore?  Normally it
> > would be the semaphore of the new device's parent, but it could be a
> > higher ancestor.  There even could be a single "root" semaphore for
> > drivers registering a top-level device with no parent.
> > 
> > (Some testing shows that during startup things like ACPI and IDE don't 
> > fulfill this requirement, so maybe we should require it only after 
> > userspace has begun running.  After all, the system can't suspend 
> > until then.)
> > 
> > It seems like a reasonable sort of thing to do.  Hotplugged devices
> > tend to be registered as they are discovered by their parent's driver,
> > so it shouldn't be too much to ask that the parent's semaphore be held
> > when the new device is registered.  Static devices generally aren't
> > quite so nice; the serial and floppy drivers in particular would need a
> > little work (and probably some other drivers too).
> > 
> > If we do this, then once the PM core has acquired the semaphore for 
> > every device it will be guaranteed that no new devices can be added.  
> > It would be a simple solution to a rather nasty problem.
> 
> Hmm, in device_pm_add() and device_pm_remove() we acquire dpm_list_mtx which
> also is acquired by device_suspend() and device_resume().  Thus, every attempt
> to register a new device or unregister an existing one will be blocked while
> either device_suspend() or device_resume() is running.
> 
> If we arrange things so that dpm_list_mtx is acquired, but not released, by
> device_suspend() and released, but not acquired, by device_resume(), then it
> won't be possible to register/unregister a device during a suspend-resume
> cycle.

As with Oliver's suggestion, this would create a locking order 
violation.  Drivers registering children (and thus acquiring 
dpm_list_mtx) will often already hold the parent's sem.  But 
device_suspend() needs to acquire device sems while holding 
dpm_list_mtx.

Alan Stern
