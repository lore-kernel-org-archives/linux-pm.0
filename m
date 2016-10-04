From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH][v3] mfd: intel-lpss: Avoid resuming runtime-suspended
 lpss unnecessarily
Date: Tue, 4 Oct 2016 15:55:58 +0100
Message-ID: <20161004145558.GF29257@dell>
References: <1475125286-12167-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1475125286-12167-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 29 Sep 2016, Chen Yu wrote:

> We have report that the intel_lpss_prepare() takes too much time during
> suspend, and this is because we first resume the devices from runtime
> suspend by resume_lpss_device(), to make sure they are in proper state
> before system suspend, which takes 100ms for each LPSS devices(PCI power
> state from D3_cold to D0). And since resume_lpss_device() resumes the
> devices synchronously, we might get huge latency if we have many
> LPSS devices.
> 
> So first try is to use pm_request_resume() instead, to make the runtime
> resume process asynchronously. Unfortunately the asynchronous runtime
> resume relies on pm_wq, which is freezed at early stage. So we choose
> another method, that is to avoid resuming runtime-suspended devices,
> if they are already runtime suspended. This is safe because for LPSS
> driver, the runtime suspend and system suspend are of the same
> hook - i.e., intel_lpss_suspend(). And moreover, this device is
> neither runtime wakeup source nor system wakeup source.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/mfd/intel-lpss.c | 9 +++++++++
>  include/linux/pm.h       | 7 +++++++
>  2 files changed, 16 insertions(+)

Applied for v4.10, thanks.

> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index 41b1138..2583db8 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -485,6 +485,15 @@ static int resume_lpss_device(struct device *dev, void *data)
>  int intel_lpss_prepare(struct device *dev)
>  {
>  	/*
> +	 * This is safe because:
> +	 * 1. The runtime suspend and system suspend
> +	 * are of the same hook.
> +	 * 2. This device is neither runtime wakeup source
> +	 * nor system wakeup source.
> +	 */
> +	if (pm_runtime_status_suspended(dev))
> +		return DPM_DIRECT_COMPLETE;
> +	/*
>  	 * Resume both child devices before entering system sleep. This
>  	 * ensures that they are in proper state before they get suspended.
>  	 */
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 06eb353..4a788b4 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -786,4 +786,11 @@ enum dpm_order {
>  	DPM_ORDER_DEV_LAST,
>  };
>  
> +/*
> + * Return this from system suspend/hibernation ->prepare() callback to
> + * request the core to leave the device runtime-suspended during system
> + * suspend if possible.
> + */
> +#define DPM_DIRECT_COMPLETE 1
> +
>  #endif /* _LINUX_PM_H */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
