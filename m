From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 02/12] PM / devfreq: Fix handling of min/max_freq ==
 0
Date: Thu, 12 Jul 2018 17:34:20 +0900
Message-ID: <fd7e9774-bf19-e6eb-c095-c453d534e479@samsung.com>
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703235032epcas3p3443729f2230e205f1a0a4b03e6e8f62b@epcas3p3.samsung.com>
        <20180703234705.227473-3-mka@chromium.org> <5B3C2EEF.4080309@samsung.com>
        <20180706163624.GE129942@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180706163624.GE129942@google.com>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On 2018년 07월 07일 01:36, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Wed, Jul 04, 2018 at 11:20:31AM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
>>> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
>>> devfreq device") initializes df->min/max_freq with the min/max OPP when
>>> the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
>>> available min/max frequency") adds df->scaling_min/max_freq and the
>>> following to the frequency adjustment code:
>>>
>>>   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>>>
>>> With the current handling of min/max_freq this is incorrect:
>>>
>>> Even though df->max_freq is now initialized to a value != 0 user space
>>> can still set it to 0, in this case max_freq would be 0 instead of
>>> df->scaling_max_freq as intended. In consequence the frequency adjustment
>>> is not performed:
>>>
>>>   if (max_freq && freq > max_freq) {
>>> 	freq = max_freq;
>>>
>>> To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
>>> when the user passes a value of 0. This also prevents df->max_freq from
>>> being set below the min OPP when df->min_freq is 0, and similar for
>>> min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
>>> checks for this case can be removed.
>>>
>>> Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> Reviewed-by: Brian Norris <briannorris@chromium.org>
>>> ---
>>> Changes in v5:
>>> - none
>>>
>>> Changes in v4:
>>> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
>>>
>>> Changes in v3:
>>> - none
>>>
>>> Changes in v2:
>>> - handle freq tables sorted in ascending and descending order in
>>>   min/max_freq_store()
>>> - use same order for conditional statements in min/max_freq_store()
>>> ---
>>>  drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++-----------
>>>  1 file changed, 30 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 0057ef5b0a98..6f604f8b2b81 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -283,11 +283,11 @@ int update_devfreq(struct devfreq *devfreq)
>>>  	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>>>  	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
>>>  
>>> -	if (min_freq && freq < min_freq) {
>>> +	if (freq < min_freq) {
>>>  		freq = min_freq;
>>>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>>>  	}
>>> -	if (max_freq && freq > max_freq) {
>>> +	if (freq > max_freq) {
>>>  		freq = max_freq;
>>>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>>  	}
>>> @@ -1122,18 +1122,27 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>  {
>>>  	struct devfreq *df = to_devfreq(dev);
>>>  	unsigned long value;
>>> +	unsigned long *freq_table;
>>
>> You can move 'freq_table' under 'else' statement.
> 
> Will do
> 
>>>  	int ret;
>>> -	unsigned long max;
>>>  
>>>  	ret = sscanf(buf, "%lu", &value);
>>>  	if (ret != 1)
>>>  		return -EINVAL;
>>>  
>>>  	mutex_lock(&df->lock);
>>> -	max = df->max_freq;
>>> -	if (value && max && value > max) {
>>> -		ret = -EINVAL;
>>> -		goto unlock;
>>> +
>>> +	if (value) {
>>> +		if (value > df->max_freq) {
>>> +			ret = -EINVAL;
>>> +			goto unlock;
>>> +		}
>>> +	} else {
>>> +		freq_table = df->profile->freq_table;
>>> +		/* typical order is ascending, some drivers use descending */
>>
>> You better to explain what is doing of following code.
>> How about modifying it as following?
>>
>> 		/* Get minimum frequency according to sorting way */
> 
> Ok, will slightly modify it to 'sorting order' if you don't mind.

I don't mind of 'soring order'. Thanks.

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
