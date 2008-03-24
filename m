From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 3)
Date: Mon, 24 Mar 2008 16:14:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803241519090.24400-100000__1187.75556698001$1206389922$gmane$org@iolanthe.rowland.org>
References: <200803241839.39469.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803241839.39469.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Mar 2008, Rafael J. Wysocki wrote:

> Hi,
> 
> This is the 3rd revision of the patch introducing new callbacks for suspend
> and hibernation.  It has been tested on x86-64.
...
> * The registrations of parentless devices are disabled before the first
>   ->prepare() method is called and enabled before the first ->resume() method
>   is called

It would be okay to wait until after the last prepare() method is
called.  I don't know if it makes any difference in the end, however.

> +enum dpm_state {
> +	DPM_ON,
> +	DPM_RESUMING,
> +	DPM_SUSPENDING,
> +	DPM_OFF,
> +	DPM_OFF_IRQ,
> +};

Can we also have a DPM_PREPARING state, set when ->prepare() is about
to be called?  The PM core wouldn't make use of it but some drivers
would.  (I can't think of any use at all for the analogous
DPM_COMPLETING state, however.)

> @@ -68,22 +59,30 @@ int device_pm_add(struct device *dev)
...
> +	if (dev->parent) {
> +		if (dev->parent->power.status > DPM_RESUMING) {

Clearer to say: if (dev->parent->power.status >= DPM_SUSPENDING) {

...
> +	} else if (transition_started) {
> +		/*
> +		 * We refuse to register parentless devices while a PM
> +		 * transition is in progress in order to avoid leaving them
> +		 * unhandled down the road
> +		 */

Log a warning here?  If this ever happened, it would be the sort of 
unexpected regression that people get all excited about.

> +		goto Refuse;
>  	}
...

> +static void dpm_resume(pm_message_t state)
> +{
> +	struct list_head list;
> +
> +	INIT_LIST_HEAD(&list);
> +	mutex_lock(&dpm_list_mtx);
> +	transition_started = false;
> +	while (!list_empty(&dpm_list)) {
> +		struct device *dev = to_device(dpm_list.next);
> +
> +		if (dev->power.status > DPM_SUSPENDING) {

Clearer to say: if (dev->power.status >= DPM_OFF) {

Note that if dev->power.status is equal to DPM_SUSPENDING then you 
don't want to call resume_device(), but you still do want to change 
dev->power.status to DPM_RESUMING so that new children can be 
registered.

> +			dev->power.status = DPM_RESUMING;
> +			get_device(dev);
> +			mutex_unlock(&dpm_list_mtx);
> +
> +			resume_device(dev, state);
> +
> +			mutex_lock(&dpm_list_mtx);
> +			put_device(dev);
> +		}
> +		if (!list_empty(&dev->power.entry))
> +			list_move_tail(&dev->power.entry, &list);

A little problem here: You refer to dev after calling put_device().

> +	}
> +	list_splice(&list, &dpm_list);

This isn't the way I imagined doing it (your extra "list"), but it's 
fine.

...
> +static void dpm_complete(pm_message_t state)
>  {
...
> +			complete_device(dev, state);
> +
> +			mutex_lock(&dpm_list_mtx);
> +			put_device(dev);
> +		}
> +		if (!list_empty(&dev->power.entry))
> +			list_move(&dev->power.entry, &list);

Same problem with use-after-put.  Also present in dpm_prepare().

>  	}
> +	list_splice(&list, &dpm_list);
>  	mutex_unlock(&dpm_list_mtx);
>  }

...
>  static int dpm_suspend(pm_message_t state)
>  {
...
>  		error = suspend_device(dev, state);
> +
>  		mutex_lock(&dpm_list_mtx);
> +		put_device(dev);
>  		if (error) {
>  			printk(KERN_ERR "Could not suspend device %s: "
> -					"error %d%s\n",
> -					kobject_name(&dev->kobj),
> -					error,
> -					(error == -EAGAIN ?
> -					" (please convert to suspend_late)" :
> -					""));
> -			dev->power.sleeping = false;
> +				"error %d\n", kobject_name(&dev->kobj), error);
> +			list_splice_init(&dpm_list, &list);
>  			break;
>  		}
> -		if (!list_empty(&dev->power.entry))
> -			list_move(&dev->power.entry, &dpm_off);
> +		if (!list_empty(&dev->power.entry)) {
> +			dev->power.status = DPM_OFF;
> +			list_move(&dev->power.entry, &list);
> +		}

Use-after-put again.

>  	}
> -	if (!error)
> -		all_sleeping = true;
> +	list_splice(&list, &dpm_list);

Instead you could eliminate the list_splice_init() above and put here:

	list_splice(&list, dpm_list->prev);

This will move the entries from list to the end of dpm_list.

>  	mutex_unlock(&dpm_list_mtx);
> +	return error;
> +}

On the whole it looks quite good.

Alan Stern
