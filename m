From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] devfreq: fix initialization of current frequency in last status
Date: Wed, 1 Jun 2016 19:23:52 +0900
Message-ID: <CAJ0PZbTFSP1MA4t9-4-+YyvcEXWUaqpw=RndM6A4H6U0pSAmKg@mail.gmail.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33951 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbcFAKYI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 06:24:08 -0400
Received: by mail-oi0-f67.google.com with SMTP id r64so2859109oie.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 03:24:07 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Wed, Jun 1, 2016 at 5:30 PM, Javi Merino <javi.merino@arm.com> wrote:
> On Tue, May 31, 2016 at 11:25:09AM +0100, Lukasz Luba wrote:
>> Some systems need current frequency from last_status for calculation
>> but it is zeroed during initialization. When the device starts there is
>> no history, but we can assume that the last frequency was the
>> same as the initial frequency (which is also used in 'previous_freq').
>> The log shows the result of this misinterpreted value.
>> [    2.042847] ... Failed to get voltage for frequency 0: -34
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>
> Looks good to me,
>
> Reviewed-by: Javi Merino <javi.merino@arm.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

This is going to be sent for rcX along with other fixes.


Anyway, I don't see a device driver that has the issue you've mentioned.
Could you please tell me which device driver is having this issue?



>
>> ---
>>  drivers/devfreq/devfreq.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 984c5e9..a3f2c3b 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -515,6 +515,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>       devfreq->profile = profile;
>>       strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>>       devfreq->previous_freq = profile->initial_freq;
>> +     devfreq->last_status.current_frequency = profile->initial_freq;
>>       devfreq->data = data;
>>       devfreq->nb.notifier_call = devfreq_notifier_call;
>>
>> --
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
