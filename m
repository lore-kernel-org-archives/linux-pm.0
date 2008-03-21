From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] apm-emulation: notify about all suspend
	events, not just	apm invoked ones
Date: Fri, 21 Mar 2008 14:29:25 +0100
Message-ID: <20080321132924.GD5331@ucw.cz>
References: <1205707065.1614.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1205707065.1614.5.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Stephen Rothwell <sfr@linuxcare.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> This revamps the apm-emulation code to get suspend notifications
> regardless of what way pm_suspend() was invoked, whether via the
> apm ioctl or via /sys/power/state. Also do some code cleanup and
> add comments while at it.

Does this actually change user-kernel ABI?

>  /*
> + * thread states (for threads using a writable /dev/apm_bios fd):
> + *
> + * SUSPEND_NONE:	nothing happening
> + * SUSPEND_PENDING:	suspend event queued for thread and pending to be read
> + * SUSPEND_READ:	suspend event read, pending acknowledgement
> + * SUSPEND_ACKED:	acknowledgement received from thread (via ioctl),
> + *			waiting for resume
> + * SUSPEND_ACKTO:	acknowledgement timeout
> + * SUSPEND_DONE:	thread had acked suspend and is now notified of
> + *			resume
> + *
> + * SUSPEND_WAIT:	this thread invoked suspend and is waiting for resume
> + *
> + * A thread migrates in one of three paths:
> + * 	NONE -1-> PENDING -2-> READ -3-> ACKED -4-> DONE -5-> NONE
> + *	                            -6-> ACKTO -7-> NONE
> + *	NONE -8-> WAIT -9-> NONE
> + *
> + * While in PENDING or READ, the thread is accounted for in the
> + * suspend_acks_pending counter.
> + *
> + * The transitions are invoked as follows:
> + *	1: suspend event is signalled from the core PM code
> + *	2: the suspend event is read from the fd by the userspace thread
> + *	3: userspace thread issues the APM_IOC_SUSPEND ioctl (as ack)
> + *	4: core PM code signals that we have resumed
> + *	5: APM_IOC_SUSPEND ioctl returns
> + *
> + *	6: the notifier invoked from the core PM code timed out waiting
> + *	   for all relevant threds to enter ACKED state and puts those
> + *	   that haven't into ACKTO
> + *	7: those threads issue APM_IOC_SUSPEND ioctl too late,
> + *	   get an error
> + *
> + *	8: userspace thread issues the APM_IOC_SUSPEND ioctl (to suspend),
> + *	   ioctl code invokes pm_suspend()
> + *	9: pm_suspend() returns indicating resume
> + */
> +enum apm_suspend_state {
> +	SUSPEND_NONE,
> +	SUSPEND_PENDING,
> +	SUSPEND_READ,
> +	SUSPEND_ACKED,
> +	SUSPEND_ACKTO,
> +	SUSPEND_WAIT,
> +	SUSPEND_DONE,
> +};
> +
> +/*
>   * The per-file APM data
>   */
>  struct apm_user {

These are not passed to userspace, are they?
						Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
