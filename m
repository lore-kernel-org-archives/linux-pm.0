From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] Add extra PM_EVENT_* codes for use by
	subsystems
Date: Sun, 2 Mar 2008 13:57:42 +0100
Message-ID: <200803021357.42826.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0802291223300.6695-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0802291223300.6695-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Friday, 29 of February 2008, Alan Stern wrote:
> Is there any objection to adding extra PM_EVENT_* codes?  Although they
> won't ever be issued by the PM core, they will come in handy for
> internal uses in power-aware subsystems (like USB).

Well, this is in a (slight) conflict with the hibernation/suspend callbacks
rework that I'm working on with Alex.  I'll send the first patch in a few
minutes for comments.

Thanks,
Rafael


> Index: usb-2.6/include/linux/pm.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pm.h
> +++ usb-2.6/include/linux/pm.h
> @@ -164,21 +164,40 @@ typedef struct pm_message {
>   * well as during system sleep states like PM_SUSPEND_STANDBY.  They may
>   * be able to use wakeup events to exit from runtime low-power states,
>   * or from system low-power states such as standby or suspend-to-RAM.
> + *
> + * The PM core will never issue the PMSG_ codes for USER_SUSPEND,
> + * USER_RESUME, REMOTE_WAKEUP, AUTOSUSPEND, or AUTORESUME.  They are
> + * provided for internal use by power-aware subsystems.
>   */
>  
> -#define PM_EVENT_ON 0
> -#define PM_EVENT_FREEZE 1
> -#define PM_EVENT_SUSPEND 2
> -#define PM_EVENT_HIBERNATE 4
> -#define PM_EVENT_PRETHAW 8
> +#define PM_EVENT_ON		0x0000
> +#define PM_EVENT_FREEZE		0x0001
> +#define PM_EVENT_SUSPEND	0x0002
> +#define PM_EVENT_HIBERNATE	0x0004
> +#define PM_EVENT_PRETHAW	0x0008
> +#define PM_EVENT_USER_SUSPEND	0x0010
> +#define PM_EVENT_USER_RESUME	0x0020
> +#define PM_EVENT_REMOTE_WAKEUP	0x0040
> +#define PM_EVENT_AUTOSUSPEND	0x0080
> +#define PM_EVENT_AUTORESUME	0x0100
>  
>  #define PM_EVENT_SLEEP	(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
>  
> +#define PMSG_ON		((struct pm_message){ .event = PM_EVENT_ON, })
>  #define PMSG_FREEZE	((struct pm_message){ .event = PM_EVENT_FREEZE, })
>  #define PMSG_PRETHAW	((struct pm_message){ .event = PM_EVENT_PRETHAW, })
>  #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
>  #define PMSG_HIBERNATE	((struct pm_message){ .event = PM_EVENT_HIBERNATE, })
> -#define PMSG_ON		((struct pm_message){ .event = PM_EVENT_ON, })
> +#define PMSG_USER_SUSPEND	((struct pm_message) \
> +					{ .event = PM_EVENT_USER_SUSPEND, })
> +#define PMSG_USER_RESUME	((struct pm_message) \
> +					{ .event = PM_EVENT_USER_RESUME, })
> +#define PMSG_REMOTE_WAKEUP	((struct pm_message) \
> +					{ .event = PM_EVENT_REMOTE_WAKEUP, })
> +#define PMSG_AUTOSUSPSEND	((struct pm_message) \
> +					{ .event = PM_EVENT_AUTOSUSPSEND, })
> +#define PMSG_AUTORESUME		((struct pm_message) \
> +					{ .event = PM_EVENT_AUTORESUME, })
>  
>  struct dev_pm_info {
>  	pm_message_t		power_state;
> 
> 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
