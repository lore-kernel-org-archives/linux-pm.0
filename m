From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Runtime: return the right value when deferred_resume is true in rpm_suspend()
Date: Wed, 16 Jan 2013 00:51:58 +0100
Message-ID: <5832238.gzeSCHdU79@vostro.rjw.lan>
References: <1358263571.1223.26.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358263571.1223.26.camel@cliu38-desktop-build>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 15, 2013 11:26:11 PM Chuansheng Liu wrote:
> 
> For the case that in rpm_suspend() and deferred_resume is true,
> the rpm_resume() will be called, and if rpm_resume() return error,
> at this time, the device is still in SUSPENDED state.
> 
> In this case it is still an suspend succeeding case, we should
> return non-error instead of EAGAIN.
> 
> An example like below for this case:
> CPU1:                                                      CPU2:
> pm_runtime_get_sync()
> pm_runtime_put_sync_suspend()
>   rpm_suspend()
>     __update_runtime_status(dev, RPM_SUSPENDING)
>     rpm_callback()
>         spin_unlock_irq()
>           ...                                               pm_runtime_get()
>                                                               spin_lock_irqsave()
>           cb()                                                rpm_resume()
>           ...                                                   dev->power.deferred_resume = true
>                                                               spin_unlock_irqrestore()
>         spin_lock_irq()
>     __update_runtime_status(dev, RPM_SUSPENDED)
>     rpm_resume() is called due to deferred_resume is true
> 
> Here if rpm_resume() failed in CPU1, the runtime_status is still SUSPENDED,
> we should return 0 in this case.

No, we shouldn't.

Please note that rpm_resume() may fail for multiple reasons and some of them
actually mean real errors, in which case we shouldn't return 0, because that
may confuse the caller.

However, if we return -EAGAIN regardless, whatever the caller does next will
be fine.

Thanks,
Rafael


> Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
> ---
>  drivers/base/power/runtime.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 3148b10..0adc713 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -436,9 +436,11 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>  
>  	if (dev->power.deferred_resume) {
>  		dev->power.deferred_resume = false;
> -		rpm_resume(dev, 0);
> -		retval = -EAGAIN;
> -		goto out;
> +		if (rpm_resume(dev, 0) >= 0) {
> +			/* In case resuming succeeded, return EAGAIN error */
> +			retval = -EAGAIN;
> +			goto out;
> +		}
>  	}
>  
>  	/* Maybe the parent is now able to suspend. */
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
