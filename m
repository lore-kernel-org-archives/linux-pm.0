From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 04/12] PM / devfreq: Add struct devfreq_policy
Date: Fri, 03 Aug 2018 09:04:44 +0900
Message-ID: <5B639C1C.40605@samsung.com>
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703235030epcas4p423e7bf876628913adb3e41ffdc8ba3cd@epcas4p4.samsung.com>
        <20180703234705.227473-5-mka@chromium.org> <5B3C3632.1010706@samsung.com>
        <20180706170701.GF129942@google.com>
        <4863cf97-37d9-7d81-f44b-10de3dc8267e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <4863cf97-37d9-7d81-f44b-10de3dc8267e@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On 2018년 07월 12일 17:38, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 07월 07일 02:07, Matthias Kaehlcke wrote:
>> Hi,
>>
>> On Wed, Jul 04, 2018 at 11:51:30AM +0900, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
>>>> Move variables related with devfreq policy changes from struct devfreq
>>>> to the new struct devfreq_policy and add a policy field to struct devfreq.
>>>>
>>>> The following variables are moved:
>>>>
>>>> df->min/max_freq           =>   p->user.min/max_freq
>>>> df->scaling_min/max_freq   =>   p->devinfo.min/max_freq
>>>> df->governor               =>   p->governor
>>>> df->governor_name          =>   p->governor_name
>>>>
>>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>>> Reviewed-by: Brian Norris <briannorris@chromium.org>
>>>> ---
>>>> Changes in v5:
>>>> - none
>>>>
>>>> Changes in v4:
>>>> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
>>>>
>>>> Changes in v3:
>>>> - none
>>>>
>>>> Changes in v2:
>>>> - performance, powersave and simpleondemand governors don't need changes
>>>>   with "PM / devfreq: Don't adjust to user limits in governors"
>>>> - formatting fixes
>>>> ---
>>>>  drivers/devfreq/devfreq.c          | 137 ++++++++++++++++-------------
>>>>  drivers/devfreq/governor_passive.c |   4 +-
>>>>  include/linux/devfreq.h            |  38 +++++---
>>
>>
>>>>  3 files changed, 103 insertions(+), 76 deletions(-)
>>>>
>>>
>>> (skip)
>>>
>>>>  
>>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>>> index 3bc29acbd54e..e0987c749ec2 100644
>>>> --- a/drivers/devfreq/governor_passive.c
>>>> +++ b/drivers/devfreq/governor_passive.c
>>>> @@ -99,12 +99,12 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>>>>  {
>>>>  	int ret;
>>>>  
>>>> -	if (!devfreq->governor)
>>>> +	if (!devfreq->policy.governor)
>>>>  		return -EINVAL;
>>>>  
>>>>  	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
>>>>  
>>>> -	ret = devfreq->governor->get_target_freq(devfreq, &freq);
>>>> +	ret = devfreq->policy.governor->get_target_freq(devfreq, &freq);
>>>>  	if (ret < 0)
>>>>  		goto out;
>>>>  
>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>> index 3aae5b3af87c..9bf23b976f4d 100644
>>>> --- a/include/linux/devfreq.h
>>>> +++ b/include/linux/devfreq.h
>>>> @@ -109,6 +109,30 @@ struct devfreq_dev_profile {
>>>>  	unsigned int max_state;
>>>>  };
>>>>  
>>>> +/**
>>>> + * struct devfreq_freq_limits - Devfreq frequency limits
>>>> + * @min_freq:	minimum frequency
>>>> + * @max_freq:	maximum frequency
>>>> + */
>>>> +struct devfreq_freq_limits {
>>>> +	unsigned long min_freq;
>>>> +	unsigned long max_freq;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct devfreq_policy - Devfreq policy
>>>> + * @user:	frequency limits requested by the user
>>>> + * @devinfo:	frequency limits of the device (available OPPs)
>>>> + * @governor:	method how to choose frequency based on the usage.
>>>
>>> nitpick. remove '.' on the end of line.
>>
>> Ok
>>
>>>> + * @governor_name:	devfreq governor name for use with this devfreq
>>>> + */
>>>> +struct devfreq_policy {
>>>> +	struct devfreq_freq_limits user;
>>>> +	struct devfreq_freq_limits devinfo;
>>>> +	const struct devfreq_governor *governor;
>>>> +	char governor_name[DEVFREQ_NAME_LEN];
>>>> +};
>>>> +
>>>>  /**
>>>>   * struct devfreq - Device devfreq structure
>>>>   * @node:	list node - contains the devices with devfreq that have been
>>>> @@ -117,8 +141,6 @@ struct devfreq_dev_profile {
>>>>   * @dev:	device registered by devfreq class. dev.parent is the device
>>>>   *		using devfreq.
>>>>   * @profile:	device-specific devfreq profile
>>>> - * @governor:	method how to choose frequency based on the usage.
>>>> - * @governor_name:	devfreq governor name for use with this devfreq
>>>>   * @nb:		notifier block used to notify devfreq object that it should
>>>>   *		reevaluate operable frequencies. Devfreq users may use
>>>>   *		devfreq.nb to the corresponding register notifier call chain.
>>>> @@ -126,10 +148,7 @@ struct devfreq_dev_profile {
>>>>   * @previous_freq:	previously configured frequency value.
>>>>   * @data:	Private data of the governor. The devfreq framework does not
>>>>   *		touch this.
>>>> - * @min_freq:	Limit minimum frequency requested by user (0: none)
>>>> - * @max_freq:	Limit maximum frequency requested by user (0: none)
>>>> - * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>>> - * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>>> + * @policy:		Policy for frequency adjustments
>>>
>>> The devfreq_policy contains the range of frequency and governor information.
>>> But, this description focus on the frequency. You need to explain the more
>>> correct description of 'policy'.
>>
>> I wouldn't say that the focus is on 'frequency', but on 'frequency
>> adjustments', and the governor is an integral part of them.
> 
> OK. I agree your original description.
> 
>>
>> I can change it to "Policy for frequency adjustments, including
>> frequency limits and the governor" if you prefer. I'm open to other
>> suggestions.
> 
> (snip)
> 

When you resend next patch with my comment except for description of 'policy',
feel free to add my reviewed-by tag.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
