From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Sun, 24 Feb 2008 14:27:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802241409320.11316-100000__43516.7278083556$1203881380$gmane$org@netrider.rowland.org>
References: <200802241451.17334.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802241451.17334.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Sun, 24 Feb 2008, Rafael J. Wysocki wrote:

> > You know, with this new patch we probably don't need 
> > device_pm_schedule_removal() any more.
> 
> No, we don't.  However, because of that dpm_suspend() and device_power_down()
> need to be changed not to assume that the removed devices will end up on
> dpm_destroy.

Yes.  The safest approach will be to check whether the device is still 
at the end of the dpm_locked or dpm_off list; if it hasn't then we can 
assume that it has been removed (or scheduled for removal).

> IMO you also should add this change in device_power_down():
> 
> @@ -388,18 +343,15 @@ int device_power_down(pm_message_t state
>  		struct list_head *entry = dpm_off.prev;
>  		struct device *dev = to_device(entry);
>  
> -		list_del_init(&dev->power.entry);
>  		error = suspend_device_late(dev, state);
>  		if (error) {
>  			printk(KERN_ERR "Could not power down device %s: "
>  					"error %d\n",
>  					kobject_name(&dev->kobj), error);
> -			if (list_empty(&dev->power.entry))
> -				list_add(&dev->power.entry, &dpm_off);
>  			break;
>  		}
> -		if (list_empty(&dev->power.entry))
> -			list_add(&dev->power.entry, &dpm_off_irq);
> +		if (!list_empty(&dev->power.entry))
> +			list_move(&dev->power.entry, &dpm_off_irq);
>  	}

Actually I changed the last two lines to:

+
+		/* Don't move the entry if the device has been unregistered */
+		if (entry == dpm_off.prev)
+			list_move(entry, &dpm_off_irq);

with analogous changes to dpm_suspend().

Any more suggestions for updates?

Alan Stern
