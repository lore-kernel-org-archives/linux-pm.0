From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
	it's in use
Date: Tue, 21 Apr 2009 20:46:45 +0200
Message-ID: <200904212046.45671.rjw@sisk.pl>
References: <20090416131323.GA16752@gandalf.sssup.it>
	<200904202354.04777.rjw@sisk.pl>
	<49ED530E.5010905@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49ED530E.5010905@gandalf.sssup.it>
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
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org, pavel@suse.cz, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 21 April 2009, Michael Trimarchi wrote:
> Rafael J. Wysocki wrote:
> > On Thursday 16 April 2009, Michael Trimarchi wrote:
> >   
> >> Drivers on embedded systems would be smart enough
> >> to know that some of the devices should remain powered up, because
> >> they could still be useful even when the CPU wasn't running.
> >> The patch add the in_use attribute, that it can be used by the
> >> the drivers to avoid power down during suspend.
> >>     
> >
> > OK, so the idea is that in_use will be set by the user space for devices that
> > shouldn't be suspended.  Is this correct?
> >
> > Assuming it is, I'd call the flag 'in_use' rather than 'is_inuse'.  Also, if
> > may_inuse is supposed to mean that we can set in_use for this device, I'd call
> > it 'in_use_valid', I'd make it be unset by default and I'd allow the driver to
> > unset it if it is going to react to 'in_use'.
> >   
> is_inuse is set for the device. The may_inuse is automatically setting 
> for the child
> device. This is done for automatically propagate the dependency

I see.  I'd call it differently, then.

Besides, is it really always the case that setting the flag for one device
implies that the entire subtree below it should have the flag set?  IOW,
there may be some devices in the subtree that we may want to suspend anyway,
I think.

> >> Signed-off-by: Michael Trimarchi <trimarchi@gandalf.sssup.it>
> >> Cc: "Alan Stern" <stern@rowland.harvard.edu>
> >> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> >> Cc: "Pavel Mackek" <pavel@ucw.cz>
> >> Cc: "Len Brown" <lenb@kernel.org>
> >>
> >> ---
> >> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >> index e73c92d..d67043b 100644
> >> --- a/drivers/base/core.c
> >> +++ b/drivers/base/core.c
> >> @@ -1124,6 +1124,49 @@ static struct device *next_device(struct klist_iter *i)
> >>  }
> >>  
> >>  /**
> >> + * device_visit_subtree - device subtree iterator.
> >> + * @root: root struct device.
> >> + * @data: data for the callback.
> >> + * @fn: function to be called for each device.
> >> + *
> >> + * Iterate the @parent's subtree devices, and call @fn for each,
> >> + * passing it @data.
> >> + *
> >> + */
> >>     
> >
> > Hmm, I'm not sure ig Greg is going to like it.
> >
> >   
> This function walk the tree of devices following the dependences in 
> iterative mode.

Yes, it does, but the implementation is not the cleanest one IMO.

> >> +void device_visit_subtree(struct device *root, void *data,
> >> +			  int (*fn)(struct device *dev, void *data))
> >> +{
> >> +	struct klist_iter i;
> >> +	struct device *parent = root;
> >>     
> >
> > I'd call it 'current' or 'cur';
> >
> >   
> ok
> >> +	struct device *child = NULL;
> >> +	int error;
> >> +
> >> +	klist_iter_init(&parent->p->klist_children, &i);
> >> +move_down:
> >> +	error = fn(parent, data);
> >> +	if (error && parent != root)
> >>     
> >
> > Shouldn't the iteration break on error?
> >
> >   
> The iteration don't break on error because, the return just said that the
> subtree is just enable

You're assuming that _your_ function will be the only one called via this one,
but in that case why do you introduce a generic low level helper?

> >> +		goto move_up;
> >> +
> >> +	pr_debug("device: '%s': %s\n", dev_name(parent), __func__);
> >> +
> >> +	child = next_device(&i);
> >> +	if (child) {
> >> +		parent = child;
> >> +		goto move_down;
> >> +	}
> >> +move_up:
> >> +	klist_iter_exit(&i);
> >> +	if (parent != root) {
> >> +		klist_iter_init_node(&parent->parent->p->klist_children, &i,
> >> +				     &parent->p->knode_parent);
> >> +		parent = next_device(&i);
> >> +		if (parent)
> >> +			goto move_down;
> >> +		klist_iter_exit(&i);
> >> +	}
> >>     
> >
> > Please find a way to reduce the number of gotos in this function.
> >
> > Besides, I'm not sure if it's really necessary.  What's wrong with using
> > simply device_for_each_child() instead?
> >   
> Just to have an iterative function

Care to elaborate?

> >   
> >> +}
> >> +
> >> +/**
> >>   * device_for_each_child - device child iterator.
> >>   * @parent: parent struct device.
> >>   * @data: data for the callback.
> >> @@ -1207,6 +1250,7 @@ int __init devices_init(void)
> >>  	return -ENOMEM;
> >>  }
> >>  
> >> +EXPORT_SYMBOL_GPL(device_visit_subtree);
> >>  EXPORT_SYMBOL_GPL(device_for_each_child);
> >>  EXPORT_SYMBOL_GPL(device_find_child);
> >>  
> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> >> index 69b4ddb..00ad150 100644
> >> --- a/drivers/base/power/main.c
> >> +++ b/drivers/base/power/main.c
> >> @@ -64,6 +64,45 @@ void device_pm_unlock(void)
> >>  	mutex_unlock(&dpm_list_mtx);
> >>  }
> >>  
> >> +int device_set_may_inuse_enable(struct device *dev, void *data)
> >>     
> >
> > What exactly is the purpose of this function?
> >
> >   
> This function said that the parent is used by a driver
> >> +{
> >> +	pr_debug("PM: Device change in use status: %s\n", dev_name(dev));
> >> +
> >> +	/* if the device is suspend the subtree is in may_suspend status */
> >> +	if (dev->power.is_inuse)
> >> +		goto out;
> >>     
> >
> >    return 1; ?
> >
> >   
> >> +
> >> +	dev->power.may_inuse = (unsigned int)data;
> >>     
> >
> > Can this conversion be avoided?
> >
> >   
> >> +	return 0;
> >> +out:
> >> +	/* cut the entire subtree */
> >> +	return 1;
> >> +}
> >> +
> >> +/**
> >> + *	device_set_inuse_enable - Mark the device as used by userspace
> >> + *	application
> >> + */
> >> +int device_set_inuse_enable(struct device *dev, int enable)
> >>     
> >
> > We have bool for things like 'enable'.
> >
> >   
> ok
> >> +{
> >> +	mutex_lock(&dpm_list_mtx);
> >> +
> >> +	/* the new status is equal the old one */
> >> +	if (dev->power.is_inuse == enable)
> >> +		goto out;
> >> +
> >> +	dev->power.is_inuse = enable;
> >> +
> >> +	/* Update device children to set the in use status */
> >> +	device_visit_subtree(dev, (void *)enable,
> >> +				device_set_may_inuse_enable);
> >>     
> >
> > Why not do:
> >
> >     if (dev->power.in_use != enable) {
> >          dev->power.in_use = enable;
> >          device_visit_subtree(dev, (void *)enable, device_set_may_inuse_enable);
> >     }
> >
> > Also, I think this 'enable' conversion isn't really necessary.  You can use two
> > separate helper functions for setting and unsetting and pass NULL as the second
> > argument.
> >
> >   
> ok
> >> +
> >> +out:
> >> +	mutex_unlock(&dpm_list_mtx);
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(device_set_inuse_enable);
> >> +
> >>  /**
> >>   *	device_pm_add - add a device to the list of active devices
> >>   *	@dev:	Device to be added to the list
> >> @@ -78,6 +117,13 @@ void device_pm_add(struct device *dev)
> >>  		if (dev->parent->power.status >= DPM_SUSPENDING)
> >>  			dev_warn(dev, "parent %s should not be sleeping\n",
> >>  				 dev_name(dev->parent));
> >> +		if (device_is_inuse(dev->parent)) {
> >> +			mutex_unlock(&dpm_list_mtx);
> >> +			/* if the parent has suspend disable, propagate it
> >> +			 * to the new child */
> >> +			device_set_may_inuse_enable(dev, (void *)1);
> >>     
> >
> > The conversion is just terrible.  I'd very much prefer it to be
> > device_set_in_use_possible_enable(dev, true).
> >
> >   
> ok
> >> +			mutex_lock(&dpm_list_mtx);
> >> +		}
> >>  	} else if (transition_started) {
> >>  		/*
> >>  		 * We refuse to register parentless devices while a PM
> >> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> >> index c7cb4fc..e7d21bb 100644
> >> --- a/drivers/base/power/power.h
> >> +++ b/drivers/base/power/power.h
> >> @@ -3,6 +3,11 @@ static inline void device_pm_init(struct device *dev)
> >>  	dev->power.status = DPM_ON;
> >>  }
> >>  
> >> +static inline int device_is_inuse(struct device *dev)
> >> +{
> >> +	return dev->power.is_inuse || dev->power.may_inuse;
> >> +}
> >>     
> >
> > OK, so what's the meaning of is_inuse and may_inuse?
> >
> >   
> Maybe the idea is if the parent is in_use the child are may_inuse so 
> they are potentialy in
> use. The user can disable a tree and after reanable a child.

So I'd call the flag subtree_in_use or better subtree_no_suspend, then.

Moreover, you don't really have to propagate the no_suspend bit down the
device tree when the flag is set for a device.  You can simply modify the
prepare phase of suspend to check if the current device's parent has
no_suspend or subtree_no_suspend set and to set that for the current device
if so (or clear otherwise).

Thanks,
Rafael
