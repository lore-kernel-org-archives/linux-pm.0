From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [Update][RFC/RFT][PATCH v3 2/5] driver core: Functional
 dependencies tracking support
Date: Tue, 20 Sep 2016 00:46:30 +0200
Message-ID: <20160919224630.GA2933@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <5257325.y9rG1UM74b@vostro.rjw.lan>
 <2480829.3iNV7K5Pdo@vostro.rjw.lan>
 <2141382.sMORCbDyAF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:52533 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbcISWqS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2016 18:46:18 -0400
Content-Disposition: inline
In-Reply-To: <2141382.sMORCbDyAF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Fri, Sep 16, 2016 at 02:33:55PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, there is a problem with taking functional dependencies
> between into account.
         ^
	 devices

> What I mean by a "functional dependency" is when the driver of device
> B needs device A to be functional and (generally) its driver to be
> present in order to work properly.  This has certain consequences
> for power management (suspend/resume and runtime PM ordering) and
> shutdown ordering of these devices.  In general, it also implies that
> the driver of A needs to be working for B to be probed successfully
> and it cannot be unbound from the device before the B's driver.  
                                                                 ^^
                                                Trailing whitespace.

> Support for representing those functional dependencies between
> devices is added here to allow the driver core to track them and act
> on them in certain cases where applicable.
> 
> The argument for doing that in the driver core is that there are
> quite a few distinct use cases involving device dependencies, they
> are relatively hard to get right in a driver (if one wants to
> address all of them properly) and it only gets worse if multiplied
> by the number of drivers potentially needing to do it.  Morever, at
> least one case (asynchronous system suspend/resume) cannot be handled
> in a single driver at all, because it requires the driver of A to
> wait for B to suspend (during system suspend) and the driver of B to
> wait for A to resume (during system resume).
> 
> For this reason, represent dependencies between devices as "links",
> with the help of struct device_link objects each containing pointers
> to the "linked" devices, a list node for each of them, status
> information, flags, a lock and an RCU head for synchronization.
> 
> Also add two new list heads, links_to_consumers and links_to_suppliers,
> to struct device to represent the lists of links to the devices that
> depend on the given one (consumers) and to the devices depended on
> by it (suppliers), respectively.
> 
> The entire data structure consisting of all of the lists of link
> objects for all devices is protected by SRCU (for list walking)
> and a by mutex (for link object addition/removal).  In addition
      ^^^^
      by a

> to that, each link object has an internal status field whose
> value reflects what's happening to the devices pointed to by
> the link.  That status field is protected by an internal spinlock.

More precisely, the status field tracks the driver boundness of
the two devices comprising the link.  ("what's happening to the
devices" is a bit broad, this is really about the *drivers*.)

> New links are added by calling device_link_add() which takes four
> arguments: pointers to the devices in question, the initial status
> of the link and flags.  In particular, if DEVICE_LINK_STATELESS is
> set in the flags, the link status is not to be taken into account
> for this link and the driver core will not manage it.  In turn, if
> DEVICE_LINK_AUTOREMOVE is set in the flags, the driver core will
> remove the link automatically when the consumer device driver
> unbinds from it.
> 
> One of the actions carried out by device_link_add() is to reorder
> the lists used for device shutdown and system suspend/resume to
> put the consumer device along with all of its children and all of
> its consumers (and so on, recursively) to the ends of those list
                                                                  ^
                                                                  s

> in order to ensure the right ordering between all of the supplier
> and consumer devices.
> 
> For this reason, it is not possible to create a link between two
> devices if the would-be supplier device already depends on the
> would-be consumer device as either a direct descendant of it or a
> consumer of one of its direct descendants or one of its consumers
> and so on.
> 
> It also is impossible to create a link between a parent and a child
> device (in any direction).
>
> There are two types of link objects, persistent and non-persistent.
> The persistent ones stay around until one of the target devices is
> deleted, while the non-persistent ones are removed automatically when
> the consumer driver unbinds from its device (ie. they are assumed to
> be valid only as long as the consumer device has a driver bound to
> it).  Persistent links are created by default and non-persistent
> links are created when the DEVICE_LINK_AUTOREMOVE flag is passed
> to device_link_add().
> 
> Both persistent and non-persistent device links can be deleted
> explicitly with the help of device_link_del().
> 
> Links created without the DEVICE_LINK_STATELESS flag set are managed
> by the driver core using a simple state machine.  There are 5 states
> each link can be in: DORMANT (unused), AVAILABLE (the supplier driver
> is present and functional), CONSUMER_PROBE (the consumer driver is
> probing), ACTIVE (both supplier and consumer drivers are present and
> functional), and SUPPLIER_UNBIND (the supplier driver is unbinding).
> The driver core updates the link state automatically depending on
> what happens to the linked devices and for each link state specific
> actions are taken in addition to that.
> 
> For example, if the supplier driver unbinds from its device, the
> driver core will also unbind the drivers of all of its consumers
> automatically under the assumption that they cannot function
> properly without the supplier.  Analogously, the driver core will
> only allow the consumer driver to bind to its device is the
                                                       ^^
                                                       if

> supplier driver is present and functional (ie. the link is in
> the AVAILABLE state).  If that's not the case, it will rely on
> the existing deferred probing mechanism to wait for the supplier
> driver to become available.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
[snip]
> +/**
> + * device_link_add - Create a link between two devices.
> + * @consumer: Consumer end of the link.
> + * @supplier: Supplier end of the link.
> + * @status: The initial status of the link.
> + * @flags: Link flags.
> + *
> + * If the DEVICE_LINK_STATELESS flag is set, @status is ignored.  Otherwise,
> + * the caller is responsible for ensuring that @status reflects the current
> + * status of both @consumer and @supplier.
> + *
> + * If the DEVICE_LINK_AUTOREMOVE is set, the link will be removed automatically
> + * when the consumer device driver unbinds from it.  The combination of both
> + * DEVICE_LINK_AUTOREMOVE and DEVICE_LINK_STATELESS set is invalid and will
> + * cause NULL to be returned.
> + *
> + * A side effect of the link creation is re-ordering of dpm_list and the
> + * devices_kset list by moving the consumer device and all devices depending
> + * on it to the ends of these lists.
> + */
> +struct device_link *device_link_add(struct device *consumer,
> +				    struct device *supplier,
> +				    enum device_link_status status, u32 flags)
> +{
> +	struct device_link *link;
> +
> +	if (!consumer || !supplier || supplier == consumer->parent ||

So a link from the child to the parent is forbidden, but e.g. to the
grandparent is not.  Either this should be forbidden for all ancestors
of the child or none.  I'd vote for the latter.  I don't see a reason
why this shouldn't be allowed.  It doesn't introduce a dependency loop
and it might be useful if someone needs a driver presence dependency
between parent and child.

[snip]
> +static int device_links_read_lock(void)
> +{
> +	return srcu_read_lock(&device_links_srcu);
> +}
> +
> +static void device_links_read_unlock(int idx)
> +{
> +	return srcu_read_unlock(&device_links_srcu, idx);
> +}

How about declaring the above two functions inline?

[snip]
> +/**
> + * device_links_check_suppliers - Check supplier devices for this one.

The short description is mostly a repetition of the function name
and thus not very informative.

Imagine someone coming here from driver_probe_device(), where this
function is invoked.  They should immediately get an idea what
the function does.

How about: "Check presence of supplier drivers"

> + * @dev: Consumer device.
> + *
> + * Check links from this device to any suppliers.  Walk the list of the device's
> + * consumer links and see if all of the suppliers are available.  If not, simply
      ^^^^^^^^
"supplier links and see if all if them are available."

[snip]
> +/**
> + * device_links_no_driver - Update links of a device without a driver.
> + * @dev: Device without a drvier.
> + *
> + * Delete all non-persistent links from this device to any suppliers.
> + *
> + * Persistent links stay around, but their status is changed to "available",
> + * unless they already are in the "supplier unbind in progress" state in which
> + * case they need not be updated.

Kerneldoc refers to persistent links, a term which no longer exists in v3.

[snip]
> +void device_links_no_driver(struct device *dev)
> +{
> +	struct device_link *link, *ln;
> +
> +	mutex_lock(&device_links_lock);
> +
> +	list_for_each_entry_safe_reverse(link, ln, &dev->links_to_suppliers, c_node) {
> +		if (link->flags & DEVICE_LINK_STATELESS)
> +			continue;
> +
> +		if (link->flags & DEVICE_LINK_AUTOREMOVE) {
> +			__device_link_del(link);

The link will be autoremoved not only when the consumer unbinds,
but also when probing the consumer fails.

Looks like a bug.

Without the autoremove functionality, this function shrinks to just a
few LoC and it's probably okay to just duplicate that code and copy it
into device_links_driver_gone().  Then you'd have two separate
functions, one for the error path in really_probe() and the other for
__device_release_driver().

And you could then also give the functions names that match where
they're called from, e.g. device_links_probe_failed() and
device_links_driver_unbound().  Because the existing names
device_links_driver_gone() and device_links_no_driver() are very
similar and thus a bit confusing.

[snip]
> +void device_links_unbind_consumers(struct device *dev)
> +{
> +	struct device_link *link;
> +	int idx;
> +
> + start:
> +	idx = device_links_read_lock();
> +
> +	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
> +		enum device_link_status status;
> +
> +		if (link->flags & DEVICE_LINK_STATELESS)
> +			continue;
> +
> +		spin_lock(&link->lock);
> +		status = link->status;
> +		if (status == DEVICE_LINK_CONSUMER_PROBE) {
> +			spin_unlock(&link->lock);
> +
> +			device_links_read_unlock(idx);
> +
> +			wait_for_device_probe();
> +			goto start;
> +		}
> +		link->status = DEVICE_LINK_SUPPLIER_UNBIND;
> +		if (status == DEVICE_LINK_ACTIVE) {
> +			struct device *consumer = link->consumer;
> +
> +			get_device(consumer);

As long as the struct device_link exists, a ref is held on the
supplier and consumer.  Why acquire another ref here?

> +			spin_unlock(&link->lock);

The lock is released both at the beginning of this if-block and
immediately after the if-block (in case the if-condition is false).
Why not simply release the lock *before* the if-block?

[snip]
> @@ -1233,6 +1680,7 @@ void device_del(struct device *dev)
>  {
>  	struct device *parent = dev->parent;
>  	struct class_interface *class_intf;
> +	struct device_link *link, *ln;
>  
>  	/* Notify clients of device removal.  This call must come
>  	 * before dpm_sysfs_remove().
> @@ -1240,6 +1688,30 @@ void device_del(struct device *dev)
>  	if (dev->bus)
>  		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>  					     BUS_NOTIFY_DEL_DEVICE, dev);
> +
> +	/*
> +	 * Delete all of the remaining links from this device to any other
> +	 * devices (either consumers or suppliers).
> +	 *
> +	 * This requires that all links be dormant, so warn if that's no the
> +	 * case.
> +	 */

How about moving this to a separate function, e.g. device_links_purge(dev)?

In all other cases you've created a new function even though it's only
called from a single place, which makes sense because it avoids cluttering
up these central functions like device_del().

> +	mutex_lock(&device_links_lock);
> +
> +	list_for_each_entry_safe_reverse(link, ln, &dev->links_to_suppliers, c_node) {
> +		WARN_ON(link->status != DEVICE_LINK_DORMANT &&
> +			!(link->flags & DEVICE_LINK_STATELESS));
> +		__device_link_del(link);
> +	}

Shouldn't it also be legal for the supplier links to be in
DEVICE_LINK_AVAILABLE state upon removal of a consumer device?

(And perhaps also DEVICE_LINK_SUPPLIER_UNBIND?)

Looks like a bug.

[snip]
> --- linux-pm.orig/drivers/base/dd.c
> +++ linux-pm/drivers/base/dd.c
> @@ -249,6 +249,7 @@ static void driver_bound(struct device *
>  		 __func__, dev_name(dev));
>  
>  	klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
> +	device_links_driver_bound(dev);
>  
>  	device_pm_check_callbacks(dev);
>  
> @@ -399,6 +400,7 @@ probe_failed:
>  		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>  					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
>  pinctrl_bind_failed:
> +	device_links_no_driver(dev);
>  	devres_release_all(dev);
>  	driver_sysfs_remove(dev);
>  	dev->driver = NULL;
> @@ -489,6 +491,10 @@ int driver_probe_device(struct device_dr
>  	if (!device_is_registered(dev))
>  		return -ENODEV;
>  
> +	ret = device_links_check_suppliers(dev);
> +	if (ret)
> +		return ret;
> +

I think clarity would improve if you would move the call to
device_links_check_suppliers() down the call stack into really_probe().
Then it would be in the same place as the call to device_links_no_driver()
(if probing fails).

Furthermore, driver_probe_device() runtime resumes the parent before
probing a device, but you're not doing the same for the suppliers.
Looks like a bug.

[snip]
> --- linux-pm.orig/include/linux/device.h
> +++ linux-pm/include/linux/device.h
> @@ -706,6 +706,35 @@ struct device_dma_parameters {
>  	unsigned long segment_boundary_mask;
>  };
>  
> +enum device_link_status {
> +	DEVICE_LINK_NO_STATE = -1,

How about a comment like /* Stateless. */ so that the relationship to
the DEVICE_LINK_STATELESS flag is clear.

> +	DEVICE_LINK_DORMANT = 0,	/* Link not in use. */
> +	DEVICE_LINK_AVAILABLE,		/* Supplier driver is present. */
> +	DEVICE_LINK_ACTIVE,		/* Consumer driver is present too. */
> +	DEVICE_LINK_CONSUMER_PROBE,	/* Consumer is probing. */
> +	DEVICE_LINK_SUPPLIER_UNBIND,	/* Supplier is unbinding. */
> +};
> +
> +/*
> + * Device link flags.
> + *
> + * STATELESS: The state machine is not applicable to this link.

IMO the consequence of setting this flag is not immediately clear from the
comment. How about: "Ignore driver presence."

> + * AUTOREMOVE: Remove this link automatically on cunsumer driver unbind.
                                                     ^
                                                     o

Thanks,

Lukas
