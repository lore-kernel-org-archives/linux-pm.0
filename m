From: Andre Przywara <andre.przywara@linaro.org>
Subject: Re: [PATCH] ARM/cpuidle: remove __init tag from Calxeda cpuidle probe
 function
Date: Fri, 13 Dec 2013 23:47:41 +0100
Message-ID: <52AB8E8D.70806@linaro.org>
References: <1386967759-12952-1-git-send-email-andre.przywara@linaro.org> <52AB82CD.3040100@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:48741 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969Ab3LMWsM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2013 17:48:12 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so1620401bkz.11
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2013 14:48:11 -0800 (PST)
In-Reply-To: <52AB82CD.3040100@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, rob.herring@calxeda.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/13/2013 10:57 PM, Daniel Lezcano wrote:
> On 12/13/2013 09:49 PM, Andre Przywara wrote:
>> Commit 60a66e370007e8535b7a561353b07b37deaf35ba changed the Calxeda
>> cpuidle driver to a platform driver, copying the __init tag from the
>> _init() to the newly used _probe() function. However, "probe should
>> not be __init." (Rob said ;-)
>> Remove the __init tag to fix a section mismatch in the Calxeda
>> cpuidle driver.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
>> ---
>
> Applied to my tree for 3.14.

Daniel,

thanks!
But since this is a regression (3.12 compiles fine), can someone please 
push this still for 3.13? If I am not mistaken, the rework was 
introduced in the last merge window, so I'd consider this a bug fix.

Thanks,
Andre.

> Thanks for the fix.

>
>    -- Daniel
>
>>   drivers/cpuidle/cpuidle-calxeda.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-calxeda.c
>> b/drivers/cpuidle/cpuidle-calxeda.c
>> index 3679563..6e51114 100644
>> --- a/drivers/cpuidle/cpuidle-calxeda.c
>> +++ b/drivers/cpuidle/cpuidle-calxeda.c
>> @@ -65,7 +65,7 @@ static struct cpuidle_driver calxeda_idle_driver = {
>>       .state_count = 2,
>>   };
>>
>> -static int __init calxeda_cpuidle_probe(struct platform_device *pdev)
>> +static int calxeda_cpuidle_probe(struct platform_device *pdev)
>>   {
>>       return cpuidle_register(&calxeda_idle_driver, NULL);
>>   }
>>
>
>

