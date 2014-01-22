From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [RFC PATCH] cpuidle: reduce unnecessary loop in c-state selection
Date: Wed, 22 Jan 2014 15:53:21 +0800
Message-ID: <52DF78F1.7080204@linaro.org>
References: <1389876316-27161-1-git-send-email-alex.shi@linaro.org> <13647359.XRIaiKjIK6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34409 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaAVHx0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 02:53:26 -0500
Received: by mail-pd0-f180.google.com with SMTP id x10so44624pdj.11
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2014 23:53:26 -0800 (PST)
In-Reply-To: <13647359.XRIaiKjIK6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org

On 01/16/2014 11:53 PM, Rafael J. Wysocki wrote:
> Hi Len, what do you think?

Is this patch correct?
> 
> On Thursday, January 16, 2014 08:45:16 PM Alex Shi wrote:
>> All deeper c-state have the longer target_residency and exit_latency
>> So, if the one can not meet our prediction, neither any later.
>> So, just break out the for loop to save few checking instructions.
>>
>> Signed-off-by: Alex Shi <alex.shi@linaro.org>
>> ---
>>  drivers/cpuidle/governors/menu.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> index cf7f2f0..48ed3fb 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -352,11 +352,11 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>>  		if (s->disabled || su->disable)
>>  			continue;
>>  		if (s->target_residency > data->predicted_us)
>> -			continue;
>> +			break;
>>  		if (s->exit_latency > latency_req)
>> -			continue;
>> +			break;
>>  		if (s->exit_latency * multiplier > data->predicted_us)
>> -			continue;
>> +			break;
>>  
>>  		data->last_state_idx = i;
>>  		data->exit_us = s->exit_latency;
>>
> 


-- 
Thanks
    Alex
