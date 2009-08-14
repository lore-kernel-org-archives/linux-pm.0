From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/3] PM: Asynchronous suspend of devices
Date: Fri, 14 Aug 2009 18:35:09 +0200
Message-ID: <20090814163509.GK1626__49204.0860503495$1250353467$gmane$org@ucw.cz>
References: <200908122218.13975.rjw@sisk.pl> <200908122221.20568.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908122221.20568.rjw@sisk.pl>
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

> @@ -659,26 +674,61 @@ static pm_message_t resume_event(pm_mess
>  }
>  
>  /**
> - *	device_suspend_noirq - Shut down one device (late suspend).
> - *	@dev:	Device.
> - *	@state: PM transition of the system being carried out.
> + * __device_suspend_noirq - Execute a "late" suspend callback for given device.
> + * @dev: Device to suspend.
> + * @state: PM transition of the system being carried out.

>   *
> - *	This is called with interrupts off and only a single CPU running.

that still looks like useful comment... why delete it?

> + * The driver of the device won't receive interrupts while this function is
> + * being executed.
>   */
> @@ -696,13 +746,19 @@ int dpm_suspend_noirq(pm_message_t state
>  	suspend_device_irqs();
>  	mutex_lock(&dpm_list_mtx);
>  	list_for_each_entry_reverse(dev, &dpm_list, power.entry) {
> +		dev->power.status = DPM_OFF_IRQ;
>  		error = device_suspend_noirq(dev, state);
>  		if (error) {
>  			pm_dev_err(dev, state, " late", error);
> +			dev->power.status = DPM_OFF;
> +			break;
> +		}
> +		if (async_error) {
> +			error = async_error;
>  			break;

async_error is 'interesting'. How does locking work in noirq case?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
