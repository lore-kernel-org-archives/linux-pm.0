From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [Bug] ARM: cpuidle: possible memleak
Date: Tue, 29 Aug 2017 11:04:43 +0200
Message-ID: <7a5e668d-61dc-90f2-deae-36ef3398af07@linaro.org>
References: <1980049531.494543.1502543973258@email.1und1.de>
 <20170813035040.GA13637@leoy-linaro>
 <37728512.316309.1502619006183@email.1und1.de>
 <299133306.50715.1503747980116@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38578 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbdH2JEr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 05:04:47 -0400
Received: by mail-wm0-f48.google.com with SMTP id t201so18107148wmt.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2017 02:04:46 -0700 (PDT)
In-Reply-To: <299133306.50715.1503747980116@email.1und1.de>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Leo Yan <leo.yan@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 26/08/2017 13:46, Stefan Wahren wrote:

[ ... ]

>> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>> index 7080c38..827ab25 100644
>> --- a/drivers/cpuidle/cpuidle-arm.c
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>> @@ -104,12 +104,14 @@ static int __init arm_idle_init(void)
>>  		ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
>>  		if (ret <= 0) {
>>  			ret = ret ? : -ENODEV;
>> +			kfree(drv);
>>  			goto out_fail;
>>  		}
>>  
>>  		ret = cpuidle_register_driver(drv);
>>  		if (ret) {
>>  			pr_err("Failed to register cpuidle driver\n");
>> +			kfree(drv);
>>  			goto out_fail;
>>  		}

I would prefer if you create another label on top of out_fail to free
'drv' and 'dev'. So you can remove the kfree in this loop (also take the
opportunity to remove the pr_err("Failed to allocate cpuidle device")
message.

> should i split this patch (fix for "my" memleak and cleanup fix)?

Yes, please.

Thanks.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
