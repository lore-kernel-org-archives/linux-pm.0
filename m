From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v3] PM / devfreq: Restart previous governor if new governor
 fails to start
Date: Mon, 07 Nov 2016 10:57:02 -0800
Message-ID: <5820CE7E.40802@codeaurora.org>
References: <CGME20161026191715epcas1p311c2c626563a736e14c83fb0504c099e@epcas1p3.samsung.com> <1477509425-16936-1-git-send-email-skannan@codeaurora.org> <de0f8010-31b2-8cec-f793-393c2199f44d@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <de0f8010-31b2-8cec-f793-393c2199f44d@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/26/2016 05:06 PM, Chanwoo Choi wrote:
> Hi,
>
> On 2016년 10월 27일 04:17, Saravana Kannan wrote:
>> If the new governor fails to start, switch back to old governor so that the
>> devfreq state is not left in some weird limbo.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>> * Fix NULL deref for real this time.
>> * Addressed some style preferences.
>>
>>   drivers/devfreq/devfreq.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index bf3ea76..77c41a5 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -919,7 +919,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>   	struct devfreq *df = to_devfreq(dev);
>>   	int ret;
>>   	char str_governor[DEVFREQ_NAME_LEN + 1];
>> -	struct devfreq_governor *governor;
>> +	const struct devfreq_governor *governor, *prev_governor;
>>
>>   	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>>   	if (ret != 1)
>> @@ -944,12 +944,21 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>   			goto out;
>>   		}
>>   	}
>> +	prev_governor = df->governor;
>>   	df->governor = governor;
>>   	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>>   	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>> -	if (ret)
>> +	if (ret) {
>>   		dev_warn(dev, "%s: Governor %s not started(%d)\n",
>>   			 __func__, df->governor->name, ret);
>> +		if (prev_governor) {
>
> I think that prev_governor is always set. You don't need to check it.
> Why do check it?

Not true. Even higher up in this function, we check if df->governor != 
NULL. Simple example would be that the default governor passed in while 
adding the device isn't compiled in.


Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
