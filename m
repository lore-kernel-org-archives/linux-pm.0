From: gsantosh@codeaurora.org
Subject: Re: [PATCH] devfreq: replace sscanf with kstrtol
Date: Mon, 07 Aug 2017 10:17:45 +0530
Message-ID: <a5453d63a9c82cc1ffd4c2963a563200@codeaurora.org>
References: <a74af8cd71537efd19c5b7154d34ec65@codeaurora.org>
 <CAGTfZH06PFTBu4VE_5AQjmpKfhr=TD9Qj8wcHpxQubCRtRMzzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33072 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdHGErr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2017 00:47:47 -0400
In-Reply-To: <CAGTfZH06PFTBu4VE_5AQjmpKfhr=TD9Qj8wcHpxQubCRtRMzzA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cwchoi00@gmail.com, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: gsantosh@qti.qualcomm.com, skannan@quicinc.com

On 2017-08-04 20:42, Chanwoo Choi wrote:
> Hi,
> 
> On Fri, Aug 4, 2017 at 12:57 PM,  <gsantosh@codeaurora.org> wrote:
>> Hi,
>> 
>> Adding error checks to devfreq userspace governor, the current
>> implementation results in setting wrong
>> frequency when sscanf returns error.
>> 
>> 
>> From 12e0a347addd70529b2c378299b27b65f0766f99 Mon Sep 17 00:00:00 2001
>> From: Santosh Mardi <gsantosh@codeaurora.org>
>> Date: Tue, 25 Jul 2017 18:47:11 +0530
>> Subject: [PATCH] devfreq: replace sscanf with kstrtol
>> 
>> store_freq function of devfreq userspace governor
>> executes further, even if error is returned from sscanf,
>> this will result in setting up wrong frequency value.
>> 
>> The usage for the sscanf is only for single variable so
>> replace sscanf with kstrtol along with error check to
>> bail out if any error is returned.
>> 
>> Signed-off-by: Santosh Mardi <gsantosh@codeaurora.org>
>> ---
>>  drivers/devfreq/governor_userspace.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/devfreq/governor_userspace.c
>> b/drivers/devfreq/governor_userspace.c
>> index 77028c2..a84796d 100644
>> --- a/drivers/devfreq/governor_userspace.c
>> +++ b/drivers/devfreq/governor_userspace.c
>> @@ -53,12 +53,15 @@ static ssize_t store_freq(struct device *dev, 
>> struct
>> device_attribute *attr,
>>         mutex_lock(&devfreq->lock);
>>         data = devfreq->data;
>> 
>> -       sscanf(buf, "%lu", &wanted);
>> +       err = kstrtol(buf, 0, &wanted);
>> +       if (err < 0)
>> +               goto out;
> 
> I think that just you can check the return value as following:
> The other point of devfreq already uses the following style
> to check the return value of sscanf. I think kstrtol is not necessary.
> 
>      err = sscanf(buf, "%lu", &wanted);
>      if (err != 1)
>           goto out;
> 

[Santosh] - I Agree we need to have this error check as mentioned by you 
if we are scanning an arrary from the sscanf,
but in the above code we are only scanning one variable and there is a 
rule in the checkpatch scripts, not to use sscanf if it is a single 
variable, So I need to replace sscanf to strtol

I have added all the mails I got as output from 
scripts/get_maintainer.pl scripts in this mail.


> And please use the scripts/get_maintainer.pl
> in order to prevent the missing of the reviewer.
> 
>>         data->user_frequency = wanted;
>>         data->valid = true;
>>         err = update_devfreq(devfreq);
>>         if (err == 0)
>>                 err = count;
>> +out:
>>         mutex_unlock(&devfreq->lock);
>>         return err;
>>  }
>> --
>> 
>> Regards,
>> Santosh M G.
>> Qualcomm Innovation Center
