From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 13/13] thermal/drivers/hisi: Remove mutex_lock in the code
Date: Sat, 2 Sep 2017 12:04:56 +0800
Message-ID: <20170902040456.GE3841@leoy-linaro>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-13-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33400 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdIBEFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Sep 2017 00:05:06 -0400
Received: by mail-pf0-f178.google.com with SMTP id n73so5303381pfj.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Sep 2017 21:05:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1504082857-21702-13-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>

On Wed, Aug 30, 2017 at 10:47:37AM +0200, Daniel Lezcano wrote:
> The mutex is used to protect against writes in the configuration register.
> 
> That happens at probe time, with no possible race yet.
> 
> Then when the module is unloaded and at suspend/resume.
> 
> When the module is unloaded, it is an userspace operation, thus via a process.
> Suspending the system goes through the freezer to suspend all the tasks
> synchronously before continuing. So it is not possible to hit the suspend ops
> in this driver while we are unloading it.
> 
> The resume is the same situation than the probe.
> 
> In other words, even if there are several places where we write the
> configuration register, there is no situation where we can write it at the same
> time, so far as I can judge

After applied your previous patches, configuration reigster accessing
only happens in the probe and resume functions. So shouldn't have
chance to access it at the same time.

BTW, I verified this patch with system suspend/resume, so far it works
well after system resume back.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/thermal/hisi_thermal.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index b1b086ab..b9e8ee2 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -51,7 +51,6 @@ struct hisi_thermal_sensor {
>  };
>  
>  struct hisi_thermal_data {
> -	struct mutex thermal_lock;    /* protects register data */
>  	struct platform_device *pdev;
>  	struct clk *clk;
>  	struct hisi_thermal_sensor sensor;
> @@ -196,14 +195,10 @@ static inline void hisi_thermal_hdak_set(void __iomem *addr, int value)
>  
>  static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
>  {
> -	mutex_lock(&data->thermal_lock);
> -
>  	/* disable sensor module */
>  	hisi_thermal_enable(data->regs, 0);
>  	hisi_thermal_alarm_enable(data->regs, 0);
>  	hisi_thermal_reset_enable(data->regs, 0);
> -	
> -	mutex_unlock(&data->thermal_lock);
>  }
>  
>  static int hisi_thermal_get_temp(void *__data, int *temp)
> @@ -340,7 +335,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	mutex_init(&data->thermal_lock);
>  	data->pdev = pdev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 2.7.4
> 
