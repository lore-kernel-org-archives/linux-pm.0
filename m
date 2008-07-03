From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add new PM_EVENT_ codes for runtime
	power transitions
Date: Thu, 3 Jul 2008 23:36:16 +0200
Message-ID: <200807032336.16913.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0807021325040.3538-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0807021325040.3538-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 2 of July 2008, Alan Stern wrote:
> This patch (as1112) adds some new PM_EVENT_* codes for use by kernel
> subsystems.  They describe runtime power-state transitions of the sort
> already implemented by the USB subsystem.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> Rafael:
> 
> Can we get this into linux-next so that it will enter the main kernel 
> during the 2.6.27-rc1 merge window?  All it does is add some new 
> macros.
> 
> I don't have a linux-next tree here, so I can't even compile-test the 
> patch.  Can you make sure that it doesn't contain any horrendous 
> errors?  Thanks.

I'm currently testing it.  If it compiles, I'll send it to Andrew along with
some other PM patches for inclusion into -mm and hopefully into .27-rc,
eventually.

Thanks,
Rafael

 
> Index: pci/include/linux/pm.h
> ===================================================================
> --- pci.orig/include/linux/pm.h
> +++ pci/include/linux/pm.h
> @@ -317,6 +317,21 @@ struct pm_ext_ops {
>   * RECOVER	Creation of a hibernation image or restoration of the main
>   *		memory contents from a hibernation image has failed, call
>   *		->thaw() and ->complete() for all devices.
> + *
> + * The following PM_EVENT_ messages are defined for internal use by
> + * kernel subsystems.  They are never issued by the PM core.
> + *
> + * USER_SUSPEND		Manual selective suspend was issued by userspace.
> + *
> + * USER_RESUME		Manual selective resume was issued by userspace.
> + *
> + * REMOTE_WAKEUP	Remote-wakeup request was received from the device.
> + *
> + * AUTO_SUSPEND		Automatic (device idle) runtime suspend was
> + *			initiated by the subsystem.
> + *
> + * AUTO_RESUME		Automatic (device needed) runtime resume was
> + *			requested by a driver.
>   */
>  
>  #define PM_EVENT_ON		0x0000
> @@ -328,9 +343,18 @@ struct pm_ext_ops {
>  #define PM_EVENT_THAW		0x0020
>  #define PM_EVENT_RESTORE	0x0040
>  #define PM_EVENT_RECOVER	0x0080
> +#define PM_EVENT_USER		0x0100
> +#define PM_EVENT_REMOTE		0x0200
> +#define PM_EVENT_AUTO		0x0400
> +
> +#define PM_EVENT_SLEEP		(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
> +#define PM_EVENT_USER_SUSPEND	(PM_EVENT_USER | PM_EVENT_SUSPEND)
> +#define PM_EVENT_USER_RESUME	(PM_EVENT_USER | PM_EVENT_RESUME)
> +#define PM_EVENT_REMOTE_WAKEUP	(PM_EVENT_REMOTE | PM_EVENT_RESUME)
> +#define PM_EVENT_AUTO_SUSPEND	(PM_EVENT_AUTO | PM_EVENT_SUSPEND)
> +#define PM_EVENT_AUTO_RESUME	(PM_EVENT_AUTO | PM_EVENT_RESUME)
>  
> -#define PM_EVENT_SLEEP	(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
> -
> +#define PMSG_ON		((struct pm_message){ .event = PM_EVENT_ON, })
>  #define PMSG_FREEZE	((struct pm_message){ .event = PM_EVENT_FREEZE, })
>  #define PMSG_QUIESCE	((struct pm_message){ .event = PM_EVENT_QUIESCE, })
>  #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
> @@ -339,7 +363,16 @@ struct pm_ext_ops {
>  #define PMSG_THAW	((struct pm_message){ .event = PM_EVENT_THAW, })
>  #define PMSG_RESTORE	((struct pm_message){ .event = PM_EVENT_RESTORE, })
>  #define PMSG_RECOVER	((struct pm_message){ .event = PM_EVENT_RECOVER, })
> -#define PMSG_ON		((struct pm_message){ .event = PM_EVENT_ON, })
> +#define PMSG_USER_SUSPEND	((struct pm_messge) \
> +					{ .event = PM_EVENT_USER_SUSPEND, })
> +#define PMSG_USER_RESUME	((struct pm_messge) \
> +					{ .event = PM_EVENT_USER_RESUME, })
> +#define PMSG_REMOTE_RESUME	((struct pm_messge) \
> +					{ .event = PM_EVENT_REMOTE_RESUME, })
> +#define PMSG_AUTO_SUSPEND	((struct pm_messge) \
> +					{ .event = PM_EVENT_AUTO_SUSPEND, })
> +#define PMSG_AUTO_RESUME		((struct pm_messge) \
> +					{ .event = PM_EVENT_AUTO_RESUME, })
>  
>  /**
>   * Device power management states
> 
> 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
