From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation
 callbacks (highest level) - updated
Date: Sat, 8 Mar 2008 23:13:33 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803082234080.10362-100000__35193.1016230539$1205036120$gmane$org@netrider.rowland.org>
References: <200803090220.17431.linux-acpi-owner@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803090220.17431.linux-acpi-owner@vger.kernel.org>
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

> Hi,
> 
> Below is a new version of the patch that introduces the separation of suspend
> and hibernation callbacks on the highest level.
> 
> Relative to the previous version two additional callbacks have been added,
> ->prepare() and ->complete(), allowing to prepare the device for a "suspend"
> transition and to finalize the "resume" respectively.
> 
> Also, all callbacks and PM_EVENT_ messages are now described in the
> comments in include/linux/pm.h (the documentation in Documentation/power
> will be updated separately).
> 
> As previously, it is assumed that the existing (legacy) ->suspend() and
> ->resume() callbacks will be used for bus types, device classes and device
> types that don't implement the new callbacks.  As a result, the patch doesn't
> introduce any visible functional changes.
> 
> The patch has been compilation tested on x86-64.
> 
> Comments welcome.

On the whole this looks pretty good.  A few comments are below.

Alan Stern

> @@ -122,6 +120,169 @@ typedef struct pm_message {
>   * to the rest of the driver stack (such as a driver that's ON gating off
>   * clocks which are not in active use).
>   *
> + * The externally visible transitions are handled with the help of the following
> + * callbacks included in this structure:
> + *
> + * @prepare: Prepare the device for the upcoming transition, but do NOT change
> + *	its hardware state.  Prevent new children of the device from being
> + *	registered after @prepare() returns.  Also, if a concurrent child
> + *	registration already in progress is detected by @prepare(), it should
> + *	wait for the registration to complete, block the subsequent
> + *	registrations of children and return -EAGAIN, so that the PM core can
> + *	execute it once again (after suspending the newly registered child) to
> + *	recover from the race condition.  This method is executed for all kinds
> + *	of suspend transitions and is immediately followed by one of the suspend
> + *	callbacks: @suspend(), @freeze(), @poweroff(), or @quiesce().

Didn't we decide it would be better to call @prepare in a separate
pass?  In any case, drivers aren't in a position to detect concurrent
registrations.  The PM core shouldn't require them to return -EAGAIN; 
it can detect these registrations by itself.

It is also worth mentioning that subsystems should treat calls to probe 
methods the same as child registrations: wait for concurrent ones to 
complete and block subsequent ones.  This will of course be handled 
automatically for probes initiating in the driver core.

Finally, there needs to be a new "prepared" field added to dev_pm_info,
right next to the "sleeping" field.  Mention that it will be set prior
to calling @prepare and cleared prior to calling @complete.  Even
though it is read-only to drivers, they will find it useful.

> + * @recover: Hibernation-specific, executed after a failing creation of a
> + *	hibernation image OR after a failing attempt to restore the contents of
> + *	main memory from such an image.  Undo the changes made by the preceding
> + *	@freeze() or @quiesce, so the device can be operated in the same was as

s/was/way/

> + *	immediately before the failing transition.
> + */

Don't you mean the preceding @poweroff or @quiesce?  When recovering 
after @freeze(), you can use @thaw instead of @recover.

>  struct dev_pm_info {
>  	pm_message_t		power_state;
>  	unsigned		can_wakeup:1;

Add the new "prepared" field.

> -static int resume_device_early(struct device *dev)
> +static int resume_device_noirq(struct device *dev, pm_message_t state)
>  {
>  	int error = 0;
>  
>  	TRACE_DEVICE(dev);
>  	TRACE_RESUME(0);
>  
> -	if (dev->bus && dev->bus->resume_early) {
> -		dev_dbg(dev, "EARLY resume\n");
> -		error = dev->bus->resume_early(dev);
> -	}
> +	if (!dev->bus)
> +		goto End;
>  
> +	pm_dev_dbg(dev, state, "EARLY ");
> +	if (dev->bus->pm_noirq)
> +		error = pm_op(dev, dev->bus->pm_noirq, state);
> +	else if (dev->bus->resume_early)
> +		error = dev->bus->resume_early(dev);

Here and below, you have the pm_dev_dbg() call before the test for
whether the method exists.  This will generate a lot of useless
debugging output.  Although it makes the code a bit larger, IMO it
would be to test for the existence of either the new or the legacy
method before calling pm_dev_dbg(), like you do in the pm_op() routine.

> -static void dpm_resume(void)
> +static void dpm_resume(pm_message_t state)
>  {
>  	mutex_lock(&dpm_list_mtx);
>  	all_sleeping = false;
> @@ -241,7 +387,8 @@ static void dpm_resume(void)
>  		list_move_tail(entry, &dpm_active);
>  		dev->power.sleeping = false;
>  		mutex_unlock(&dpm_list_mtx);
> -		resume_device(dev);
> +		resume_device(dev, state);

Clear dev->power.prepared.

> +		complete_device(dev, state);
>  		mutex_lock(&dpm_list_mtx);
>  	}
>  	mutex_unlock(&dpm_list_mtx);

> @@ -419,21 +623,29 @@ static int dpm_suspend(pm_message_t stat
>  		struct device *dev = to_device(entry);
>  
>  		WARN_ON(dev->parent && dev->parent->power.sleeping);
> +		mutex_unlock(&dpm_list_mtx);
>  

If dev->power.prepared is already set, skip calling prepare_device().
Otherwise set dev->power.prepared and proceed.

> +		error = prepare_device(dev, state);
> +
> +		mutex_lock(&dpm_list_mtx);
> +		if (error) {

Clear dev->power.prepared.

> +			if (error == -EAGAIN)
> +				continue;
> +			else
> +				break;
> +		}

At this point, if dev isn't still the last entry on dpm_active then
start the next loop iteration.  As a corollary, in case a suspend
aborts partway through, after the resume code has put all the devices
back onto dpm_active you will still have to run through the devices
that were already on dpm_active, calling @complete if
dev->power.prepared is set.

>  		dev->power.sleeping = true;
>  		mutex_unlock(&dpm_list_mtx);
> +
>  		error = suspend_device(dev, state);
> +
>  		mutex_lock(&dpm_list_mtx);
>  		if (error) {
