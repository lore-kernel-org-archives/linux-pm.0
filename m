From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v2 1/5] devfreq: refactor set_target frequency function
Date: Tue, 4 Dec 2018 10:36:51 +0100
Message-ID: <545653c6-d68f-9177-6765-15a1beccb60f@partner.samsung.com>
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5@eucas1p2.samsung.com>
        <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
        <5C060511.8020802@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C060511.8020802@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 12/4/18 5:39 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 2018년 12월 03일 23:31, Lukasz Luba wrote:
>> The refactoring is needed for the new client in devfreq: suspend.
>> To avoid code duplication, move it to the new local function
>> devfreq_set_target.
>>
>> The patch is based on earlier work by Tobias Jakobi.
> 
> As I already commented, Please remove it. You already mentioned it on cover-letter.
> If you want to contain the contribution history of Tobias, you might better
> to add 'Signed-off-by' or others.
OK

Regards,
Lukasz
> 
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 62 +++++++++++++++++++++++++++--------------------
>>   1 file changed, 36 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 1414130..a9fd61b 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -285,6 +285,40 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>   	return 0;
>>   }
>>   
>> +static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>> +			      u32 flags)
>> +{
>> +	struct devfreq_freqs freqs;
>> +	unsigned long cur_freq;
>> +	int err = 0;
>> +
>> +	if (devfreq->profile->get_cur_freq)
>> +		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>> +	else
>> +		cur_freq = devfreq->previous_freq;
>> +
>> +	freqs.old = cur_freq;
>> +	freqs.new = new_freq;
>> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>> +
>> +	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
>> +	if (err) {
>> +		freqs.new = cur_freq;
>> +		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> +		return err;
>> +	}
>> +
>> +	freqs.new = new_freq;
>> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> +
>> +	if (devfreq_update_status(devfreq, new_freq))
>> +		dev_err(&devfreq->dev,
>> +			"Couldn't update frequency transition information.\n");
>> +
>> +	devfreq->previous_freq = new_freq;
>> +	return err;
>> +}
>> +
>>   /* Load monitoring helper functions for governors use */
>>   
>>   /**
>> @@ -296,8 +330,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>    */
>>   int update_devfreq(struct devfreq *devfreq)
>>   {
>> -	struct devfreq_freqs freqs;
>> -	unsigned long freq, cur_freq, min_freq, max_freq;
>> +	unsigned long freq, min_freq, max_freq;
>>   	int err = 0;
>>   	u32 flags = 0;
>>   
>> @@ -333,31 +366,8 @@ int update_devfreq(struct devfreq *devfreq)
>>   		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>   	}
>>   
>> -	if (devfreq->profile->get_cur_freq)
>> -		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>> -	else
>> -		cur_freq = devfreq->previous_freq;
>> -
>> -	freqs.old = cur_freq;
>> -	freqs.new = freq;
>> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>> +	return devfreq_set_target(devfreq, freq, flags);
>>   
>> -	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
>> -	if (err) {
>> -		freqs.new = cur_freq;
>> -		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> -		return err;
>> -	}
>> -
>> -	freqs.new = freq;
>> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> -
>> -	if (devfreq_update_status(devfreq, freq))
>> -		dev_err(&devfreq->dev,
>> -			"Couldn't update frequency transition information.\n");
>> -
>> -	devfreq->previous_freq = freq;
>> -	return err;
>>   }
>>   EXPORT_SYMBOL(update_devfreq);
>>   
>>
> 
> 
