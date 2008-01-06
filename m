From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sun, 6 Jan 2008 12:06:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801061203510.7367-100000__44282.967845402$1199639283$gmane$org@netrider.rowland.org>
References: <200801061419.52277.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801061419.52277.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Jan 2008, Rafael J. Wysocki wrote:

> > If you can figure out a way to disable the warning in device_del() for 
> > just the one device being unregistered by 
> > device_pm_destroy_suspended(),
> 
> Something like this, perhaps:
> 
> @@ -905,6 +915,18 @@ void device_del(struct device * dev)
>  	struct device * parent = dev->parent;
>  	struct class_interface *class_intf;
>  
> +	if (down_trylock(&dev->sem)) {
> +		if (pm_sleep_lock()) {
> +			dev_warn(dev, "Illegal %s during suspend\n",
> +				__FUNCTION__);
> +			dump_stack();
> +		} else {
> +			pm_sleep_unlock();
> +		}
> +	} else {
> +		up(&dev->sem);
> +	}
> +
>  	if (parent)
>  		klist_del(&dev->knode_parent);
>  	if (MAJOR(dev->devt))

Bizarre, but it should work.  Be sure to include plenty of explanatory 
comments -- otherwise nobody will be able to figure it out!  :-)

Alan Stern
