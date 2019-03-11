From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM / Runtime: Consolidate code to get active/suspended time
Date: Mon, 11 Mar 2019 13:01:50 +0100
Message-ID: <1896578.0Ev3Nro9jJ@aspire.rjw.lan>
References: <20190305125526.21360-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190305125526.21360-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 5, 2019 1:55:26 PM CET Ulf Hansson wrote:
> In a step to consolidate code around fetching the runtime PM active/suspend
> time for a device, let's re-factor the existing pm_runtime_suspended_time()
> and add a new corresponding pm_runtime_active_time(). Make the latter
> shared internally to the PM core, as in following changes it starts making
> use of it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/power.h   |  1 +
>  drivers/base/power/runtime.c | 14 ++++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index c511def48b48..ec33fbdb919b 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -21,6 +21,7 @@ static inline void pm_runtime_early_init(struct device *dev)
>  extern void pm_runtime_init(struct device *dev);
>  extern void pm_runtime_reinit(struct device *dev);
>  extern void pm_runtime_remove(struct device *dev);
> +extern u64 pm_runtime_active_time(struct device *dev);
>  
>  #define WAKE_IRQ_DEDICATED_ALLOCATED	BIT(0)
>  #define WAKE_IRQ_DEDICATED_MANAGED	BIT(1)
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 78937c45278c..d1908fc422cc 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -98,7 +98,7 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
>  	dev->power.runtime_status = status;
>  }
>  
> -u64 pm_runtime_suspended_time(struct device *dev)
> +static u64 rpm_account_time(struct device *dev, bool suspend)
>  {
>  	u64 time;
>  	unsigned long flags;
> @@ -106,12 +106,22 @@ u64 pm_runtime_suspended_time(struct device *dev)
>  	spin_lock_irqsave(&dev->power.lock, flags);
>  
>  	update_pm_runtime_accounting(dev);
> -	time = dev->power.suspended_time;
> +	time = suspend ? dev->power.suspended_time : dev->power.active_time;
>  
>  	spin_unlock_irqrestore(&dev->power.lock, flags);
>  
>  	return time;
>  }
> +
> +u64 pm_runtime_active_time(struct device *dev)
> +{
> +	return rpm_account_time(dev, false);
> +}
> +
> +u64 pm_runtime_suspended_time(struct device *dev)
> +{
> +	return rpm_account_time(dev, true);
> +}
>  EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
>  
>  /**
> 

Both [1-2/2] applied with some manual changes (please see linux-next
tomorrow).
