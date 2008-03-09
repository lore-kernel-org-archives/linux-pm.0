From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation
 callbacks (highest level) - updated
Date: Sun, 9 Mar 2008 15:56:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803091521230.16105-100000__1048.19381745092$1205092824$gmane$org@netrider.rowland.org>
References: <200803091428.31423.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803091428.31423.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sun, 9 Mar 2008, Rafael J. Wysocki wrote:

> > Didn't we decide it would be better to call @prepare in a separate
> > pass?
> 
> Afterwards I realized that it would be racy.  Namely, once a new device is
> registered, it may require ->prepare() to be called before ->suspend(), so if
> that happens after we've called ->prepare() for all devices, we'll be in
> trouble.

There's nothing wrong with doing it this way.  However the race you're 
worried about will never happen if drivers are written correctly.  Once 
prepare has been called for all devices, no new devices should be 
registered.

> > In any case, drivers aren't in a position to detect concurrent 
> > registrations.  The PM core shouldn't require them to return -EAGAIN; 
> > it can detect these registrations by itself.
> 
> In the appended new version of the patch, the core does it.  However, in theory
> there may be situations in which the core can't detect a race condition and
> recover from it, so I think it's reasonable to leave the possibility to signal
> such a condition by the driver.

I don't mind taking special action when drivers return -EAGAIN.  The 
point is that drivers shouldn't be _required_ to do it.

> > Finally, there needs to be a new "prepared" field added to dev_pm_info,
> > right next to the "sleeping" field.  Mention that it will be set prior
> > to calling @prepare and cleared prior to calling @complete.  Even
> > though it is read-only to drivers, they will find it useful.
> 
> Yes, I noticed that after sending the patch.  I handled it in a slightly
> different way, by converting 'sleeping' into 'status' that may assum one of
> the three values: DPM_ON, DPM_SUSPENDING, DPM_OFF.

Okay, that should work just as well.

> + * @prepare: Prepare the device for the upcoming transition, but do NOT change
> + *	its hardware state.  Prevent new children of the device from being
> + *	registered and prevent new calls to the probe method from being made
> + *	after @prepare() returns.  Also, if a concurrent child registration
> + *	or a call to the probe method already in progress is detected by
> + *	@prepare(), it may return -EAGAIN, so that the PM core can execute it
> + *	once again (e.g. after suspending the newly registered child) to recover
> + *	from the race condition. This method is executed for all kinds of
> + *	suspend transitions and is immediately followed by one of the suspend
> + *	callbacks: @suspend(), @freeze(), @poweroff(), or @quiesce().
> + *	[NOTE: The PM core is able to detect a registration of a new child of a
> + *	device concurrent with this device's @prepare() callback, in which case
> + *	@complete() will be called for the device and the core will try again to
> + *	suspend it later.  However, the core is NOT able to handle a call to
> + *	the probe method concurrent with @prepare().]

I think you can leave out this NOTE.  Direct probe method calls by 
drivers are pretty rare; almost all probing is done by the driver core.

> + * @complete: Undo the changes made by @prepare().  This method is executed for
> + *	all kinds of resume transitions, immediately following one of the resume
> + *	callbacks: @resume(), @thaw(), @restore(), or @recover().  Also executed
> + *	if a suspend callback (@suspend(), @freeze(), @poweroff(), @quiesce())
> + *	immediately following a successful @prepare() fails OR if @prepare()
> + *	returns -EAGAIN.

The last part is wrong.  If @prepare returns an error (such as -EAGAIN) 
then @complete shouldn't be called.  What you mean is that @complete 
will be invoked immediately following a successful @prepare if the PM 
core detects that a new child was registered while @prepare was 
running.

> +enum dpm_state {
> +	DPM_ON,
> +	DPM_SUSPENDING,
> +	DPM_OFF,
> +};

There should be kerneldoc for dpm_state.  Drivers may very well want to 
check dev->power.status to see whether a new child registration should 
be blocked.  The documentation should be very clear that 
dev->power.status doesn't describe the device's actual power state; 
rather it describes which method calls the PM core has made or is 
about to make.

> @@ -71,22 +71,29 @@ int device_pm_add(struct device *dev)
>  		 dev->bus ? dev->bus->name : "No Bus",
>  		 kobject_name(&dev->kobj));
>  	mutex_lock(&dpm_list_mtx);
> -	if ((dev->parent && dev->parent->power.sleeping) || all_sleeping) {
> -		if (dev->parent->power.sleeping)
> -			dev_warn(dev,
> -				"parent %s is sleeping, will not add\n",
> +	if (all_sleeping) {
> +		dev_warn(dev, "devices are sleeping, will not add\n");
> +		goto Failure;
> +	}
> +	if (dev->parent) {
> +		if (dev->parent->power.status == DPM_OFF) {
> +			dev_warn(dev, "parent %s is sleeping, will not add\n",
>  				dev->parent->bus_id);
> -		else
> -			dev_warn(dev, "devices are sleeping, will not add\n");
> -		WARN_ON(true);
> -		error = -EBUSY;
> -	} else {
> -		error = dpm_sysfs_add(dev);
> -		if (!error)
> -			list_add_tail(&dev->power.entry, &dpm_active);
> +			goto Failure;
> +		} else if (dev->parent->power.status == DPM_SUSPENDING) {
> +			dev->parent->power.status == DPM_ON;
> +		}

This part puzzled me until I read the rest of the patch.  It's a good
way to look specifically for new _child_ registrations as opposed to
any new registrations.

> @@ -418,22 +629,37 @@ static int dpm_suspend(pm_message_t stat
>  		struct list_head *entry = dpm_active.prev;
>  		struct device *dev = to_device(entry);
>  
> -		WARN_ON(dev->parent && dev->parent->power.sleeping);
> +		WARN_ON(dev->parent && dev->parent->power.status == DPM_OFF);
> +		dev->power.status = DPM_SUSPENDING;
> +		mutex_unlock(&dpm_list_mtx);
> +
> +		error = prepare_device(dev, state);
> +
> +		mutex_lock(&dpm_list_mtx);
> +		if (error == -EAGAIN)
> +			dev->power.status = DPM_ON;
> +		else if(error)
> +			break;

The last four lines should be:

		if (error) {
			dev->power.status = DPM_ON;
			if (error == -EAGAIN)
				continue;
			break;
		}

Insert:		/* Was a child added during prepare_device()? */
> +		if (dev->power.status == DPM_ON) {
> +			mutex_unlock(&dpm_list_mtx);
> +
> +			complete_device(dev, resume_event(state));
>  
> -		dev->power.sleeping = true;
> +			mutex_lock(&dpm_list_mtx);
> +			continue;
> +		}
> +		dev->power.status = DPM_OFF;
>  		mutex_unlock(&dpm_list_mtx);
> +
>  		error = suspend_device(dev, state);
> +
>  		mutex_lock(&dpm_list_mtx);
>  		if (error) {
> -			printk(KERN_ERR "Could not suspend device %s: "
> -					"error %d%s\n",
> -					kobject_name(&dev->kobj),
> -					error,
> -					(error == -EAGAIN ?
> -					" (please convert to suspend_late)" :
> -					""));
> -			dev->power.sleeping = false;
> -			break;
> +			dev->power.status = DPM_ON;
> +			mutex_unlock(&dpm_list_mtx);
> +
> +			complete_device(dev, resume_event(state));
> +			return error;

Early return?  I guess it's okay...

>  		}
>  		if (!list_empty(&dev->power.entry))
>  			list_move(&dev->power.entry, &dpm_off);

Looks good.

Alan Stern
