From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for
	run-time PM of	I/O devices (rev. 8)
Date: Fri, 10 Jul 2009 01:22:40 +0200
Message-ID: <20090709232239.GG1469@ucw.cz>
References: <200907060252.12755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200907060252.12755.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

hi!

> +/**
> + * Device run-time power management request types.
> + *
> + * RPM_REQ_NONE		Do nothing.
> + *
> + * RPM_REQ_IDLE		Run the device bus type's ->runtime_idle() callback
> + *
> + * RPM_REQ_SUSPEND	Run the device bus type's ->runtime_suspend() callback
> + *
> + * RPM_REQ_RESUME	Run the device bus type's ->runtime_resume() callback
> + */
> +
> +enum rpm_request {
> +	RPM_REQ_NONE = 0,
> +	RPM_REQ_IDLE,
> +	RPM_REQ_SUSPEND,
> +	RPM_REQ_RESUME,
> +};
> +
>  struct dev_pm_info {
>  	pm_message_t		power_state;
> -	unsigned		can_wakeup:1;
> -	unsigned		should_wakeup:1;
> +	unsigned int		can_wakeup:1;
> +	unsigned int		should_wakeup:1;
>  	enum dpm_state		status;		/* Owned by the PM core */
> -#ifdef	CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM_SLEEP
>  	struct list_head	entry;
>  #endif
> +#ifdef CONFIG_PM_RUNTIME
> +	struct timer_list	suspend_timer;
> +	unsigned long		timer_expires;
> +	struct work_struct	work;
> +	wait_queue_head_t	wait_queue;
> +	spinlock_t		lock;
> +	atomic_t		usage_count;
> +	atomic_t		child_count;
> +	unsigned int		ignore_children:1;
> +	unsigned int		runtime_disabled:1;
> +	unsigned int		runtime_failure:1;
> +	unsigned int		idle_notification:1;
> +	unsigned int		request_pending:1;
> +	unsigned int		deferred_resume:1;
> +	enum rpm_request	request;
> +	enum rpm_status		runtime_status;

runtime_status seems to be accessed outside spinlocks. Should it be of
type atomic_t?


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
