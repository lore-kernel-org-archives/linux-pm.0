From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Add extra PM_EVENT_* codes for use by
	subsystems
Date: Sat, 1 Mar 2008 12:47:18 +0100
Message-ID: <20080301114718.GA17945@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0802291223300.6695-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0802291223300.6695-100000@iolanthe.rowland.org>
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

Hi!

> Is there any objection to adding extra PM_EVENT_* codes?  Although they
> won't ever be issued by the PM core, they will come in handy for
> internal uses in power-aware subsystems (like USB).

I guess we cando that.

> Alan Stern
> 
> 
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

I'd move that "not used by core" note here.

> +#define PM_EVENT_USER_SUSPEND	0x0010
> +#define PM_EVENT_USER_RESUME	0x0020
> +#define PM_EVENT_REMOTE_WAKEUP	0x0040
> +#define PM_EVENT_AUTOSUSPEND	0x0080
> +#define PM_EVENT_AUTORESUME	0x0100
>  
>  #define PM_EVENT_SLEEP	(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
