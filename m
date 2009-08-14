From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/3] PM: Asynchronous resume of devices
Date: Fri, 14 Aug 2009 18:33:28 +0200
Message-ID: <20090814163328.GF1626__18995.7578703345$1250353363$gmane$org@ucw.cz>
References: <200908122218.13975.rjw@sisk.pl> <200908122220.03363.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908122220.03363.rjw@sisk.pl>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

> The patch below introduces a mechanism allowing some devices to be
> resumed asynchronously, using completions with the following rules:
> (1) There is a completion, dev->power.comp, for each device object.
> (2) All of these completions are reset before suspend as well as
>     each resume stage (dpm_resume_noirq(), dpm_resume()).
> (3) If dev->power.async_suspend is set for dev or for its parent, the
>     PM core waits for the parent's completion before attempting to
>     run the resume callbacks, appropriate for this particular stage
>     of resume, for dev.

at least this needs to go in as a comment.

> (4) dev->power.comp is completed for each device after running its
> @@ -411,9 +412,12 @@ struct dev_pm_info {
>  	pm_message_t		power_state;
>  	unsigned int		can_wakeup:1;
>  	unsigned int		should_wakeup:1;
> +	unsigned		async_suspend:1;
>  	enum dpm_state		status;		/* Owned by the PM core */

unsigned int? Or bool?

Should it go under config_pm_sleep?

>  #ifdef CONFIG_PM_SLEEP
>  	struct list_head	entry;
> +	struct completion	comp;
> +	pm_message_t		async_state;
>  #endif
>  }
>  
> +static inline void device_enable_async_suspend(struct device *dev, bool enable)
> +{
> +	if (dev->power.status == DPM_ON)
> +		dev->power.async_suspend = enable;
> +}
> +
> @@ -163,6 +166,34 @@ void device_pm_move_last(struct device *
>  	list_move_tail(&dev->power.entry, &dpm_list);
>  }
>  
> +static void dpm_synchronize_noirq(void)
> +{
> +	struct device *dev;
> +
> +	async_synchronize_full();
> +
> +	list_for_each_entry(dev, &dpm_list, power.entry)
> +		INIT_COMPLETION(dev->power.comp);
> +}
> +
> +static void dpm_synchronize(void)
> +{
> +	struct device *dev;
> +
> +	async_synchronize_full();
> +
> +	mutex_lock(&dpm_list_mtx);
> +	list_for_each_entry(dev, &dpm_list, power.entry)
> +		INIT_COMPLETION(dev->power.comp);
> +	mutex_unlock(&dpm_list_mtx);
> +}

Why is it ok to avoid locking in noirq case? Do we really need async for
noirq handlers?


>  /**
> - *	device_resume_noirq - Power on one device (early resume).
> - *	@dev:	Device.
> - *	@state: PM transition of the system being carried out.
> + * __device_resume_noirq - Execute an "early resume" callback for given device.
> + * @dev: Device to resume.
> + * @state: PM transition of the system being carried out.
>   *
> - *	Must be called with interrupts disabled.
> + * The driver of the device won't receive interrupts while this function is
> + * being executed.
>   */

You still want it called with interrupts disabled, right?


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
