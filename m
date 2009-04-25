From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?iso-8859-1?q?=5BRFC_Add_no=5Fsuspend_attribute_V2=5D?=
 =?iso-8859-1?q?_Let_the_driver=09know_if_it=27s_in_use?=
Date: Sat, 25 Apr 2009 12:56:51 +0200
Message-ID: <200904251256.51633.rjw@sisk.pl>
References: <20090424172435.GA18448@gandalf.sssup.it>
	<20090424225501.GC3343@kroah.com>
	<49F2D2C7.3020705@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49F2D2C7.3020705@gandalf.sssup.it>
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
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

On Saturday 25 April 2009, Michael Trimarchi wrote:
> Greg KH wrote:
> > On Fri, Apr 24, 2009 at 07:55:55PM +0200, Michael Trimarchi wrote:
> >   
> >>>  /**
> >>> + *	device_set_no_suspend_enable - Mark the device as used by userspace
> >>> + *	application
> >>> + */
> >>>       
> >
> > This is not proper kernel-doc, please fix this up.
> >
> > And "no_suspend_enable" is ackward, drop the "enable" part?
> >
> >
> >   
> >>> +void device_set_no_suspend_enable(struct device *dev, bool enable)
> >>> +{
> >>> +	struct device *next;
> >>> +
> >>> +	mutex_lock(&dpm_list_mtx);
> >>> +
> >>> +	/* the new status is equal the old one */
> >>> +	if (dev->power.no_suspend == !!enable)
> >>> +		goto out;
> >>> +
> >>> +	/* change the device status */
> >>> +	dev->power.no_suspend = !!enable;
> >>> +	if (dev->power.no_suspend)
> >>> +		dev->power.subtree_no_suspend = 0;
> >>>   
> >>>       
> >> I find a bug here, i will fix.
> >> It can be ok the rest of the code?
> >>     
> >>> +
> >>> +	list_for_each_entry_reverse(next, &dev->power.entry, power.entry) {
> >>> +		/* 
> >>> +		 * exit if we find a node with the same parent of the start
> >>> +		 * device
> >>> +		 */
> >>> +		if (dev->parent && next->parent == dev->parent)
> >>> +			break;
> >>> +
> >>> +		if (next->parent) {
> >>> +			/* Propagate the status */
> >>> +			next->power.subtree_no_suspend =
> >>> +				device_no_suspend_enable(next->parent);
> >>> +		}
> >>> +	}
> >>> +out:
> >>> +	mutex_unlock(&dpm_list_mtx);
> >>> +	return;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(device_set_no_suspend_enable);
> >>> +
> >>> +/**
> >>>   *	device_pm_add - add a device to the list of active devices
> >>>   *	@dev:	Device to be added to the list
> >>>   */
> >>> @@ -78,6 +117,11 @@ void device_pm_add(struct device *dev)
> >>>  		if (dev->parent->power.status >= DPM_SUSPENDING)
> >>>  			dev_warn(dev, "parent %s should not be sleeping\n",
> >>>  				 dev_name(dev->parent));
> >>> +		if (device_no_suspend_enable(dev->parent)) {
> >>> +			/* if the parent has suspend disable, propagate it
> >>> +			 * to the new child */
> >>> +			dev->power.subtree_no_suspend = 1;
> >>> +		}
> >>>  	} else if (transition_started) {
> >>>  		/*
> >>>  		 * We refuse to register parentless devices while a PM
> >>> @@ -87,7 +131,15 @@ void device_pm_add(struct device *dev)
> >>>  		dev_WARN(dev, "Parentless device registered during a PM transaction\n");
> >>>  	}
> >>>  
> >>> -	list_add_tail(&dev->power.entry, &dpm_list);
> >>> +	if (dev->parent) {
> >>> +		/*
> >>> +		 * if the device has a parent insert just before it.
> >>> +		 */
> >>> +		list_add_tail(&dev->power.entry, &(dev->parent)->power.entry);
> >>> +	}
> >>> +	else
> >>> +		list_add_tail(&dev->power.entry, &dpm_list);
> >>> +
> >>>       
> >
> > Why are you changing the ordering for when we add devices to the list?
> > This seems like you are adding stuff now in backwards order, why make
> > this change?
> >   
> Sorry you are right the children must be discovere after and not  before 
> parent.
> I was convinced that children go to suspend before parent.

They generally do, but that's not precise.

More precisely, there are three walks of dpm_list during suspend.  First,
dpm_prepare() walks the list in the straight order, so if the parents are
in the list before their children, they will be visited first.  This is the
phase you can use to propagate your "no_suspend" flags from the parents to the
children, IMO.

Then, dpm_suspend() and device_power_down() walk the list in the reverse order,
and that's where the device drivers' suspend callbacks are executed.

Thanks,
Rafael
