From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3] PM / devfreq: Restart previous governor if new governor
 fails to start
Date: Thu, 10 Nov 2016 09:10:41 +0900
Message-ID: <5823BB01.3090502@samsung.com>
References: <CGME20161026191715epcas1p311c2c626563a736e14c83fb0504c099e@epcas1p3.samsung.com>
 <1477509425-16936-1-git-send-email-skannan@codeaurora.org>
 <de0f8010-31b2-8cec-f793-393c2199f44d@samsung.com>
 <5820CE7E.40802@codeaurora.org> <5821948B.2010907@samsung.com>
 <58223AF1.2030605@codeaurora.org> <58227CDB.6050907@samsung.com>
 <58228B9E.2090108@samsung.com> <58228C10.3070502@samsung.com>
 <58238840.90802@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:53479 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753779AbcKJAKo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 19:10:44 -0500
In-reply-to: <58238840.90802@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 2016년 11월 10일 05:34, Saravana Kannan wrote:
> On 11/08/2016 06:38 PM, Chanwoo Choi wrote:
>> On 2016년 11월 09일 11:36, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> On 2016년 11월 09일 10:33, Chanwoo Choi wrote:
>>>> On 2016년 11월 09일 05:52, Saravana Kannan wrote:
>>>>> On 11/08/2016 01:02 AM, Chanwoo Choi wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 2016년 11월 08일 03:57, Saravana Kannan wrote:
>>>>>>> On 10/26/2016 05:06 PM, Chanwoo Choi wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 2016년 10월 27일 04:17, Saravana Kannan wrote:
>>>>>>>>> If the new governor fails to start, switch back to old governor so that the
>>>>>>>>> devfreq state is not left in some weird limbo.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>>>>>>>> ---
>>>>>>>>> * Fix NULL deref for real this time.
>>>>>>>>> * Addressed some style preferences.
>>>>>>>>>
>>>>>>>>>     drivers/devfreq/devfreq.c | 13 +++++++++++--
>>>>>>>>>     1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>>>>> index bf3ea76..77c41a5 100644
>>>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>>>> @@ -919,7 +919,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>>>>>>>         struct devfreq *df = to_devfreq(dev);
>>>>>>>>>         int ret;
>>>>>>>>>         char str_governor[DEVFREQ_NAME_LEN + 1];
>>>>>>>>> -    struct devfreq_governor *governor;
>>>>>>>>> +    const struct devfreq_governor *governor, *prev_governor;
>>>>>>>>>
>>>>>>>>>         ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>>>>>>>>>         if (ret != 1)
>>>>>>>>> @@ -944,12 +944,21 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>>>>>>>                 goto out;
>>>>>>>>>             }
>>>>>>>>>         }
>>>>>>>>> +    prev_governor = df->governor;
>>>>>>>>>         df->governor = governor;
>>>>>>>>>         strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>>>>>>>>>         ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>>>>>>>>> -    if (ret)
>>>>>>>>> +    if (ret) {
>>>>>>>>>             dev_warn(dev, "%s: Governor %s not started(%d)\n",
>>>>>>>>>                  __func__, df->governor->name, ret);
>>>>>>>>> +        if (prev_governor) {
>>>>>>>>
>>>>>>>> I think that prev_governor is always set. You don't need to check it.
>>>>>>>> Why do check it?
>>>>>>>
>>>>>>> Not true. Even higher up in this function, we check if df->governor != NULL. Simple example would be that the default governor passed in while adding the device isn't compiled in.
>>>>>>
>>>>>> I don't understand. If device is not registered by devfreq_add_device(),
>>>>>> you don't change the governor by using governor_store().
>>>>>>
>>>>>> If you can change the governor through governor_store(),
>>>>>> it means that the devfreq instance was added without any problem.
>>>>>> The added devfreq instance must have the sepecific governor
>>>>>> on df->governor variable.
>>>>>>
>>>>>> So, I think that df->governor is always set and then prev_governor is always set.
>>>>>
>>>>> Read the code more closely. add_device doesn't (and shouldn't) fail if the governor isn't present. After that, the governor could be changed from user space.
>>>>
>>>> If governor is not present during devfreq_add_device(),
>>>> the devfreq instance is not able to register the devfreq framework.
>>>> So, the user never touch the sysfs[1] to change the governor
>>>> because the sysfs[1] is not created by devfreq framework.
>>>> [1] /sys/class/devfreq/[device name]/governor
>>>>
>>>> In summary, if governor is not present during devfreq_add_device(),
>>>> the devfreq framework doesn't create tye sysfs[1] for governor.
>>>>
>>>> The user-space never change the governor through sysfs[1]
>>>> because there is no any sysfs entry[1].
>>>
>>> I checked the code of devfreq_add_device().
>>> As you mentioned, if there is no governor,
>>> devfreq_add_device() don't pass wihtout calling the devfreq->governor->even_handler().
>>
>> Wrong expression / don't pass -> pass
>>
> 
> I think it's correct as is. Just because the governor isn't there (or hasn't registered yet) doesn't mean the device add should fail.
> 
> That aside, do you care to ack this patch for the way the code is currently?

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

After fixing the bug of devfreq_add_device(),
I'll remove the unneeded 'if statement' of prev_governor in governor_store. 

Best Regards,
Chanwoo Choi
