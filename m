From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: imx: fix regulator_get error handling
Date: Sun, 18 Oct 2015 18:40:45 +0200
Message-ID: <5623CB8D.2020405@gmail.com>
References: <56237C1C.80109@gmail.com> <20151018155509.GD19018@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36805 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbbJRQkx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2015 12:40:53 -0400
Received: by wicfx6 with SMTP id fx6so20520047wic.1
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2015 09:40:51 -0700 (PDT)
In-Reply-To: <20151018155509.GD19018@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Am 18.10.2015 um 17:55 schrieb Viresh Kumar:
> On 18-10-15, 13:01, Heiner Kallweit wrote:
>>  	arm_reg = regulator_get(cpu_dev, "arm");
>> +	if (IS_ERR(arm_reg)) {
>> +		ret = PTR_ERR(arm_reg);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(cpu_dev, "failed to get regulator arm\n");
>> +		goto put_reg;
> 
> So you will error out even for other errors, but that wasn't the case
> earlier. Are you sure this is what you want?
> 
This was the case before as well (just the error handling for
arm-reg and soc_reg was combined).
The only difference is that before all errors were mapped to
-ENOENT and now the actual error code is forwarded.

>> +	}
>> +
>>  	pu_reg = regulator_get_optional(cpu_dev, "pu");
> 
> Why don't we do error checking for this as well ?
> 
Please see patch 2/2. I separated it because it doeas a little bit
more than handling -EPROBE_DEFER.

>> +
>>  	soc_reg = regulator_get(cpu_dev, "soc");
>> -	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
>> -		dev_err(cpu_dev, "failed to get regulators\n");
>> -		ret = -ENOENT;
>> +	if (IS_ERR(soc_reg)) {
>> +		ret = PTR_ERR(soc_reg);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(cpu_dev, "failed to get regulator soc\n");
>>  		goto put_reg;
>>  	}
>>  
>> -- 
>> 2.6.1
> 

