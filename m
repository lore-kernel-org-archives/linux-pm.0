From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 13/13] thermal/drivers/hisi: Remove mutex_lock in the code
Date: Sat, 2 Sep 2017 15:11:30 +0200
Message-ID: <1e05ccb1-45b1-1b16-cab4-8a28dbfd4f9e@linaro.org>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-13-git-send-email-daniel.lezcano@linaro.org>
 <20170902040456.GE3841@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38252 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbdIBNLe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Sep 2017 09:11:34 -0400
Received: by mail-wm0-f48.google.com with SMTP id 187so14407738wmn.1
        for <linux-pm@vger.kernel.org>; Sat, 02 Sep 2017 06:11:33 -0700 (PDT)
In-Reply-To: <20170902040456.GE3841@leoy-linaro>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>

On 02/09/2017 06:04, Leo Yan wrote:
> On Wed, Aug 30, 2017 at 10:47:37AM +0200, Daniel Lezcano wrote:
>> The mutex is used to protect against writes in the configuration register.
>>
>> That happens at probe time, with no possible race yet.
>>
>> Then when the module is unloaded and at suspend/resume.
>>
>> When the module is unloaded, it is an userspace operation, thus via a process.
>> Suspending the system goes through the freezer to suspend all the tasks
>> synchronously before continuing. So it is not possible to hit the suspend ops
>> in this driver while we are unloading it.
>>
>> The resume is the same situation than the probe.
>>
>> In other words, even if there are several places where we write the
>> configuration register, there is no situation where we can write it at the same
>> time, so far as I can judge
> 
> After applied your previous patches, configuration reigster accessing
> only happens in the probe and resume functions. So shouldn't have
> chance to access it at the same time.
> 
> BTW, I verified this patch with system suspend/resume, so far it works
> well after system resume back.

Great, thanks for testing this.

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>
> 
>> ---
>>  drivers/thermal/hisi_thermal.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
>> index b1b086ab..b9e8ee2 100644
>> --- a/drivers/thermal/hisi_thermal.c
>> +++ b/drivers/thermal/hisi_thermal.c
>> @@ -51,7 +51,6 @@ struct hisi_thermal_sensor {
>>  };
>>  
>>  struct hisi_thermal_data {
>> -	struct mutex thermal_lock;    /* protects register data */
>>  	struct platform_device *pdev;
>>  	struct clk *clk;
>>  	struct hisi_thermal_sensor sensor;
>> @@ -196,14 +195,10 @@ static inline void hisi_thermal_hdak_set(void __iomem *addr, int value)
>>  
>>  static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
>>  {
>> -	mutex_lock(&data->thermal_lock);
>> -
>>  	/* disable sensor module */
>>  	hisi_thermal_enable(data->regs, 0);
>>  	hisi_thermal_alarm_enable(data->regs, 0);
>>  	hisi_thermal_reset_enable(data->regs, 0);
>> -	
>> -	mutex_unlock(&data->thermal_lock);
>>  }
>>  
>>  static int hisi_thermal_get_temp(void *__data, int *temp)
>> @@ -340,7 +335,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>>  	if (!data)
>>  		return -ENOMEM;
>>  
>> -	mutex_init(&data->thermal_lock);
>>  	data->pdev = pdev;
>>  
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -- 
>> 2.7.4
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
