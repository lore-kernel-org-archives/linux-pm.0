From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 26 Nov 2014 08:22:06 -0700
Message-ID: <20141126152206.GD594@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
 <1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
 <54662622.2020307@linaro.org>
 <20141119174339.GA891@linaro.org>
 <5475B724.80202@linaro.org>
 <20141126152003.GC594@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:57895 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbaKZPWJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 10:22:09 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so3032080pac.36
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 07:22:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141126152003.GC594@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On Wed, Nov 26 2014 at 08:20 -0700, Lina Iyer wrote:
>On Wed, Nov 26 2014 at 04:19 -0700, Daniel Lezcano wrote:
>>On 11/19/2014 06:43 PM, Lina Iyer wrote:
>>>On Fri, Nov 14 2014 at 08:56 -0700, Daniel Lezcano wrote:
>>>>On 10/25/2014 01:40 AM, Lina Iyer wrote:
>>>
>>
>>>>>+
>>>>>+    if ((cpu > -1) && !cpuidle_drv_init) {
>>>>>+        platform_device_register(&qcom_cpuidle_device);
>>>>>+        cpuidle_drv_init = true;
>>>>>+    }
>>>>
>>>>'cpu' is always > -1.
>>>>
>>>OK. I was hoping to use -1 for not a cpu (i.e, L2) SPM. For now, I will
>>>change.
>>>
>>>
>>>>If the 'spm_get_drv' succeed, cpu is no longer equal to -EINVAL.
>>>>Otherwise we do not reach this point because we return right after
>>>>spm_get_drv with an error.
>>>>
>>>>Adding the platform_device_register depending in a static variable is
>>>>not very nice. Why not add it explicitely in a separate init routine
>>>>we know it will be called one time (eg. at the same place than cpufreq
>>>>is) ?
>>>>
>>>We want to register the cpuidle device only if any of the SPM devices
>>>have been probed.
>>>
>>>Ideally, Stephen and I would like to register cpuidle device separately
>>>for each CPU SPM, when it is probed, so we would invoke cpuidle driver
>>>and thereby the low power modes only for those cpus. However, the
>>>complexity to do that, AFAICS, is very complex. I would need to change
>>>quite a bit of the framework and in the cpuidle driver, I may have to
>>>stray from the recommended format.
>>>
>>>Here I set up cpuidle device, when I know atleast 1 cpu is ready to
>>>allow low power modes.
>>
>>Yes, instead of using the generic cpuidle_register function, you can 
>>use the low level functions for that.
>>
>>One call to cpuidle_register_driver in a single place and then 
>>cpuidle_register_device for each spm probe.
>>
>>Wouldn't make sense ?
>
>Yes, but there are some assumptions if we dont use
>MULTIPLE_CPUIDLE_DRIVERS like this -
>
>static void __cpuidle_driver_init(struct cpuidle_driver *drv)
>{
>       int i;
>	
>	drv->refcnt = 0; // Overwrites any cpuidle_driver_get()
>
>
>The clean way was to use MULTIPLE_CPUIDLE_DRIVERS, which seems like an
>incorrect use for this SoC.
>
Also, I probe and parse the cpuidle dt states for every SPM, which seems
redundant and any optimization looks as hackish as this check.

>Thanks,
>Lina
