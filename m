From: hl <hl@rock-chips.com>
Subject: Re: [PATCH v1 1/2] PM/devfreq: add suspend frequency support
Date: Thu, 3 Nov 2016 15:03:24 +0800
Message-ID: <581AE13C.9070706@rock-chips.com>
References: <1477990029-11062-1-git-send-email-hl@rock-chips.com>
 <CGME20161101084721epcas4p471cc74df8b12d042d1fac542e5371db8@epcas4p4.samsung.com>
 <422077764.570918.1478068526663.JavaMail.weblogic@ep1ml102b>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:59508 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbcKCHDe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Nov 2016 03:03:34 -0400
In-Reply-To: <422077764.570918.1478068526663.JavaMail.weblogic@ep1ml102b>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: Chanwoo Choi <cw00.choi@samsung.com>, "dianders@chromium.org" <dianders@chromium.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dbasehore@chromium.org" <dbasehore@chromium.org>

Hi MyungJoo Ham,

On 2016年11月02日 14:35, MyungJoo Ham wrote:
>> Add suspend frequency support and if needed set it to
>> the frequency obtained from the suspend opp (can be defined
>> using opp-v2 bindings and is optional).
>>
>> Change-Id: Iaa0d3848d63d9ce03f65ea76f263e4685a4c295e
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>> ---
>>   drivers/devfreq/devfreq.c | 17 ++++++++++++++++-
>>   include/linux/devfreq.h   |  9 +++++++++
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index bf3ea76..d1152eb 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -364,7 +364,10 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
>>   		return;
>>   	}
>>   
>> -	devfreq_update_status(devfreq, devfreq->previous_freq);
>> +	if (devfreq->suspend_freq)
>> +		devfreq_update_status(devfreq, devfreq->suspend_freq);
>> +	else
>> +		devfreq_update_status(devfreq, devfreq->previous_freq);
> This is incorrect.
>
> devfreq_update_status is to record the statistics.
> This code intends to record the current status before entering suspend;
> thus you should not record "suspend_freq" here.
>
> If you really need to record the frequency during suspended state
> for the statistics, you need to do that at resume; however, I object to
> that idea either.
>
> If you really want to set a predefined suspend-to-RAM mode frequency,
> (probably because of HW instability during resume process)
> you need to update, not udpate_status (statistics).
>
Thanks for pointing it, but if i use update_devfreq(), it can not 
specify the
frequency, it call the get_target_freq() to get the frequency and setting,
use now devfreq framework, it seems hard to set the specific freqeuency
when suspend. Do you have any idea, thanks.
>
>
> Cheers,
> MyungJoo
>

-- 
Lin Huang


