From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Subject: Re: [1/9] i2c: designware: Fix system suspend
Date: Fri, 8 Sep 2017 11:23:28 +0800
Message-ID: <5597d9a7-8b1a-d45d-e8d5-d1c0b46ddb7a@hisilicon.com>
References: <1498072888-14782-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1498072888-14782-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, stable@vger.linux.org
List-Id: linux-pm@vger.kernel.org


This patch can fix the issue we found on hikey960 that i2c doesn't skip system suspend when it is runtime suspended.

在 2017/6/22 3:21, Ulf Hansson 写道:
> The commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming
> during system suspend"), may suggest to the PM core to try out the so
> called direct_complete path for system sleep. In this path, the PM core
> treats a runtime suspended device as it's already in a proper low power
> state for system sleep, which makes it skip calling the system sleep
> callbacks for the device, except for the ->prepare() and the ->complete()
> callback.
> 
> Moreover, under certain circumstances the PM core may unset the
> direct_complete flag for a parent device, in case its child device are
> being system suspended before. In other words, the PM core doesn't skip
> calling the system sleep callbacks, no matter if the device is runtime
> suspended or not.
> 
> In cases of an i2c slave device, the above situation is triggered.
> Unfortunate, this also breaks the assumption that the i2c device is always
> runtime resumed, whenever the dw_i2c_plat_suspend() callback is being
> invoked, which then leads to a regression.
> 
> More precisely, dw_i2c_plat_suspend() then calls clk_core_disable() and
> clk_core_unprepare(), for an already disabled/unprepared clock, leading to
> complaints about clocks calls being wrongly balanced.
> 
> In cases when the i2c device is attached to the ACPI PM domain, the problem
> doesn't occur. That's because ACPI's ->suspend() callback, assigned to
> acpi_subsys_suspend(), calls pm_runtime_resume() for the i2c device.
> 
> To make a simple fix for this regression, let's runtime resume the i2c
> device in the ->prepare() callback, assigned to dw_i2c_plat_prepare(). This
> prevents the direct_complete path from being executed by the PM core and
> guarantees the dw_i2c_plat_suspend() is called with the i2c device always
> being runtime resumed.
> 
> Of course this change is suboptimal, because to always force a runtime
> resume of the i2c device in ->prepare() is a waste, especially in those
> cases when it could have remained runtime suspended during the entire
> system sleep sequence. However, to accomplish that behaviour a bigger
> change is needed, so defer that to future changes not applicable as fixes
> or for stable.
> 
> Fixes: 8503ff166504 ("i2c: designware: Avoid unnecessary resuming...")
> Cc: stable@vger.linux.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index d1263b8..2b7fa75 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -375,17 +375,11 @@ MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
>   #ifdef CONFIG_PM_SLEEP
>   static int dw_i2c_plat_prepare(struct device *dev)
>   {
> -	return pm_runtime_suspended(dev);
> -}
> -
> -static void dw_i2c_plat_complete(struct device *dev)
> -{
> -	if (dev->power.direct_complete)
> -		pm_request_resume(dev);
> +	pm_runtime_resume(dev);
> +	return 0;
>   }
>   #else
>   #define dw_i2c_plat_prepare	NULL
> -#define dw_i2c_plat_complete	NULL
>   #endif
>   
>   #ifdef CONFIG_PM
> @@ -413,7 +407,6 @@ static int dw_i2c_plat_resume(struct device *dev)
>   
>   static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
>   	.prepare = dw_i2c_plat_prepare,
> -	.complete = dw_i2c_plat_complete,
>   	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
>   	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
>   };
> 
