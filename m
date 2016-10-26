From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v2] PM / devfreq: Restart previous governor if new governor
 fails to start
Date: Wed, 26 Oct 2016 12:17:24 -0700
Message-ID: <58110144.9020909@codeaurora.org>
References: <CGME20161026012617epcas1p4c8f51ab0efde871ed15c217f62ff522e@epcas1p4.samsung.com> <1477445160-990-1-git-send-email-skannan@codeaurora.org> <581059C8.3000408@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57836 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbcJZTRb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 15:17:31 -0400
In-Reply-To: <581059C8.3000408@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/26/2016 12:22 AM, Chanwoo Choi wrote:
> Hi,
>
> On 2016년 10월 26일 10:25, Saravana Kannan wrote:
>> If the new governor fails to start, switch back to old governor so that the
>> devfreq state is not left in some weird limbo.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>> * Fixed typo in commit text
>> * Fixed potential NULL deref
>>
>>   drivers/devfreq/devfreq.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index bf3ea76..243253e 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -919,7 +919,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>   	struct devfreq *df = to_devfreq(dev);
>>   	int ret;
>>   	char str_governor[DEVFREQ_NAME_LEN + 1];
>> -	struct devfreq_governor *governor;
>> +	const struct devfreq_governor *governor, *prev_gov;
>>
>>   	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>>   	if (ret != 1)
>> @@ -944,12 +944,17 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>   			goto out;
>>   		}
>>   	}
>> +	prev_gov = df->governor;
>>   	df->governor = governor;
>>   	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>>   	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>> -	if (ret)
>> +	if (ret) {
>>   		dev_warn(dev, "%s: Governor %s not started(%d)\n",
>>   			 __func__, df->governor->name, ret);
>> +		df->governor = prev_gov;
>> +		strncpy(df->governor_name, prev_gov->name, DEVFREQ_NAME_LEN);
>> +		df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>> +	}

Sigh... looks like I added the changes to the index but forgot to commit 
it before I sent the patch. Will send v3.

>>   out:
>>   	mutex_unlock(&devfreq_list_lock);
>>
>>
>
> Looks good to me.
> But, how about using the 'prev_governor' instead of 'prev_gov'?
> because the variable name of current governor is 'governor' instead of 'gov'.

I was trying to avoid wrapping lines too much. But this doesn't cause 
any additional wraps. Done.

>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>

Can you please review v3?

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
