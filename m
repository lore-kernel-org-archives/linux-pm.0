From: Thomas Martitz <kugel@rockbox.org>
Subject: Re: [PATCH] PM / core: Fix direct_complete handling for devices with
 no callbacks
Date: Tue, 22 May 2018 13:12:40 +0200
Message-ID: <229515f7-d812-b92e-6918-886b62718991@rockbox.org>
References: <6238546.EnOBWIOf9o@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <6238546.EnOBWIOf9o@aspire.rjw.lan>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lukas Wunner <lukas@wunner.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

thanks for for your effort and the patch.

Is this eligible for stable?

Best regards

Am 22.05.2018 um 13:02 schrieb Rafael J. Wysocki:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 08810a4119aa (PM / core: Add NEVER_SKIP and SMART_PREPARE
> driver flags) inadvertently prevented the power.direct_complete flag
> from being set for devices without PM callbacks and with disabled
> runtime PM which also prevents power.direct_complete from being set
> for their parents.  That led to problems including a resume crash on
> HP ZBook 14u.
> 
> Restore the previous behavior by causing power.direct_complete to be
> set for those devices again, but do that in a more direct way to
> avoid overlooking that case in the future.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199693
> Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and SMART_PREPARE driver flags)
> Reported-by: Thomas Martitz <kugel@rockbox.org>
> Tested-by: Thomas Martitz <kugel@rockbox.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/base/power/main.c |    7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1920,10 +1920,8 @@ static int device_prepare(struct device
>   
>   	dev->power.wakeup_path = false;
>   
> -	if (dev->power.no_pm_callbacks) {
> -		ret = 1;	/* Let device go direct_complete */
> +	if (dev->power.no_pm_callbacks)
>   		goto unlock;
> -	}
>   
>   	if (dev->pm_domain)
>   		callback = dev->pm_domain->ops.prepare;
> @@ -1957,7 +1955,8 @@ unlock:
>   	 */
>   	spin_lock_irq(&dev->power.lock);
>   	dev->power.direct_complete = state.event == PM_EVENT_SUSPEND &&
> -		pm_runtime_suspended(dev) && ret > 0 &&
> +		((pm_runtime_suspended(dev) && ret > 0) ||
> +		 dev->power.no_pm_callbacks) &&
>   		!dev_pm_test_driver_flags(dev, DPM_FLAG_NEVER_SKIP);
>   	spin_unlock_irq(&dev->power.lock);
>   	return 0;
> 
