From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC v2 06/12] PM / cpu_domains: Record CPUs that are part of
 the domain
Date: Tue, 1 Mar 2016 12:24:21 -0700
Message-ID: <20160301192421.GM1440@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-7-git-send-email-lina.iyer@linaro.org>
 <20160226192033.GX28849@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33055 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbcCATYZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 14:24:25 -0500
Received: by mail-pa0-f54.google.com with SMTP id fl4so117373501pad.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 11:24:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160226192033.GX28849@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com

On Fri, Feb 26 2016 at 12:20 -0700, Stephen Boyd wrote:
>On 02/12, Lina Iyer wrote:
>> diff --git a/include/linux/cpu_domains.h b/include/linux/cpu_domains.h
>> index bab4846..0c539f0 100644
>> --- a/include/linux/cpu_domains.h
>> +++ b/include/linux/cpu_domains.h
>> @@ -11,8 +11,10 @@
>>  #ifndef __CPU_DOMAINS_H__
>>  #define __CPU_DOMAINS_H__
>>
>> +#include <linux/cpumask.h>
>
>Just forward declare struct cpumask instead?
>
Sure.

Thanks,
Lina

>> +
>>  struct cpu_pd_ops {
>> -	int (*power_off)(u32 state_idx, u32 param);
>> +	int (*power_off)(u32 state_idx, u32 param, const struct cpumask *mask);
>>  	int (*power_on)(void);
>>  };
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
