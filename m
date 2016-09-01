From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 2/4] cpu: expose pm_qos_resume_latency for each cpu
Date: Thu, 1 Sep 2016 11:39:40 +0800
Message-ID: <57C7A2FC.2030604@linaro.org>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-2-git-send-email-alex.shi@linaro.org>
 <20160831131829.GB19101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33388 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754574AbcIADkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 23:40:21 -0400
Received: by mail-pa0-f49.google.com with SMTP id cy9so25078143pac.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Aug 2016 20:39:45 -0700 (PDT)
In-Reply-To: <20160831131829.GB19101@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>


>> @@ -376,6 +377,8 @@ int register_cpu(struct cpu *cpu, int num)
>>  
>>  	per_cpu(cpu_sys_devices, num) = &cpu->dev;
>>  	register_cpu_under_node(num, cpu_to_node(num));
>> +	if (dev_pm_qos_expose_latency_limit(&cpu->dev, 0))
>> +		pr_debug("CPU%d: add resume latency failed\n", num);
> 
> Why is this a debug message?  And you have a struct device, why not use
> it?
> 

Looks no one care about the dev_pm_qos_expose_latency_limit's return
value, so this debug message like gilding the lily. will remove it.

> Also, what userspace changes does this require, or affect?  Any new
> sysfs files?

User can set values on each of cpu, like limit 100ms on cpu0, that means
the cpu0 response time should be in 100ms in possible idle. It similar
with DMA_LATENCY, but that request is for all cpu. This is just for
particular cpu, like a interrupt pined CPU.

echo 100 > /sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us
> 
> thanks,
> 
> greg k-h
> 
