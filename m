From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface
	for interrupt	handlers
Date: Mon, 11 Apr 2011 17:47:40 +0200
Message-ID: <4DA3229C.8070808@samsung.com>
References: <201010062347.18232.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1011191044400.1344-100000__32659.8797612407$1290181721$gmane$org@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.1011191044400.1344-100000__32659.8797612407$1290181721$gmane$org@iolanthe.rowland.org>
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
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On 11/19/2010 04:45 PM, Alan Stern wrote:
> This patch (as1431b) makes the synchronous runtime-PM interface
> suitable for use in interrupt handlers.  Subsystems can call the new
> pm_runtime_irq_safe() function to tell the PM core that a device's
> runtime-PM callbacks should be invoked with interrupts disabled
> (runtime_suspend and runtime_resume callbacks will be invoked with the
> spinlock held as well).  This permits the pm_runtime_get_sync() and
> pm_runtime_put_sync() routines to be called from within interrupt
> handlers.
> 
> When a device is declared irq-safe in this way, the PM core increments
> the parent's usage count, so the parent will never be runtime
> suspended.  This prevents difficult situations in which an irq-safe
> device can't resume because it is forced to wait for its non-irq-safe
> parent.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
...
>  
> +  void pm_runtime_irq_safe(struct device *dev);
> +    - set the power.irq_safe flag for the device, causing the runtime-PM
> +      callbacks to be invoked with interrupts disabled
> +
>    void pm_runtime_mark_last_busy(struct device *dev);
>      - set the power.last_busy field to the current time
>  
> @@ -438,6 +454,16 @@ pm_runtime_suspended()
>  pm_runtime_mark_last_busy()
>  pm_runtime_autosuspend_expiration()
>  
> +If pm_runtime_irq_safe() has been called for a device then the following helper
> +functions may also be called in interrupt context:

I was wondering what is the proper usage of this API. From a point of view of
a driver, does it mean that in runtime_resume/runtime_suspend helpers any
blocking calls cannot be used, so the device driver is prepared for situations
when some other subsystem invokes pm_runtime_irq_safe() on its device?

Or is pm_runtime_irq_safe() intended to be called only by the device driver
in such case?

I'd like to use blocking calls for a voltage regulator control within
the runtime PM helpers in the driver but I'm not sure whether this wouldn't
violate the API.

Thanks,
Sylwester

> +
> +pm_runtime_idle()
> +pm_runtime_suspend()
> +pm_runtime_autosuspend()
> +pm_runtime_resume()
> +pm_runtime_get_sync()
> +pm_runtime_put_sync()
> +
>  5. Run-time PM Initialization, Device Probing and Removal
>  
>  Initially, the run-time PM is disabled for all devices, which means that the
> 
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
