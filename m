From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Handle unregistering devices during
	suspend/hibernation
Date: Sat, 23 Feb 2008 01:21:49 +0100
Message-ID: <200802230121.50232.rjw__46802.380870986$1203726386$gmane$org@sisk.pl>
References: <200802230053.12180.rjw@sisk.pl> <20080223000222.GA26104@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080223000222.GA26104@suse.de>
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
To: Greg KH <gregkh@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 23 of February 2008, Greg KH wrote:
> On Sat, Feb 23, 2008 at 12:53:11AM +0100, Rafael J. Wysocki wrote:
> > Hi Greg,
> > 
> > The appended patch fixes the issue with the new code for suspending/resuming
> > devices, related to the fact that some device drivers and CPU hotplug notifiers
> > unregister device objects while suspend is in progress, which leads to
> > deadlocks.
> > 
> > Please consider taking it for 2.6.25.
> > 
> > Thanks,
> > Rafael
> > 
> > ---
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Introduce a mechanism preventing drivers and CPU hotplug notifiers
> > from deadlocking suspend/hibernation by unregistering device objects
> > while it is in progress.  Specifically, make device_del() detect if
> > it has been called by the suspending task and automatically defer the
> > removal of the device object if that's the case.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > ---
> >  drivers/base/core.c        |    5 +++++
> >  drivers/base/power/main.c  |    9 +++++++++
> >  drivers/base/power/power.h |    5 +++++
> >  3 files changed, 19 insertions(+)
> > 
> > Index: linux-2.6/drivers/base/power/main.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/base/power/main.c
> > +++ linux-2.6/drivers/base/power/main.c
> > @@ -59,6 +59,13 @@ static DECLARE_RWSEM(pm_sleep_rwsem);
> >  
> >  int (*platform_enable_wakeup)(struct device *dev, int is_on);
> >  
> > +static struct task_struct *suspending_task;
> > +
> > +bool in_suspend_context(void)
> > +{
> > +	return (suspending_task == current);
> > +}
> > +
> >  /**
> >   *	device_pm_add - add a device to the list of active devices
> >   *	@dev:	Device to be added to the list
> > @@ -272,6 +279,7 @@ static void dpm_resume(void)
> >  		mutex_lock(&dpm_list_mtx);
> >  	}
> >  	mutex_unlock(&dpm_list_mtx);
> > +	suspending_task = NULL;
> >  }
> >  
> >  /**
> > @@ -460,6 +468,7 @@ static int dpm_suspend(pm_message_t stat
> >  {
> >  	int error = 0;
> >  
> > +	suspending_task = current;
> >  	mutex_lock(&dpm_list_mtx);
> >  	while (!list_empty(&dpm_locked)) {
> >  		struct list_head *entry = dpm_locked.prev;
> > Index: linux-2.6/drivers/base/core.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/base/core.c
> > +++ linux-2.6/drivers/base/core.c
> > @@ -929,6 +929,11 @@ void device_del(struct device *dev)
> >  	struct device *parent = dev->parent;
> >  	struct class_interface *class_intf;
> >  
> > +	if (in_suspend_context()) {
> > +		get_device(dev);
> > +		device_pm_schedule_removal(dev);
> > +		return;
> > +	}
> 
> Why are you grabbing an additional reference to the device here?  That
> would seem to get out of balance when the device is later scheduled for
> removal, right?

No, IMO the reference is necessary, because unregister_dropped_devices() uses
device_unregister() that does the put_device() eventually.

If we are called by device_unregister(), the get_device() is needed to balance
the put_device() that will be called by device_unregister() after we return.

OTOH, if we are called directly, then we need to balance the put_device()
that will be done by device_unregister() called from
unregister_dropped_devices().

Thanks,
Rafael
