From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3 2/2] thermal: generic-adc: Add ADC based thermal sensor
 driver
Date: Mon, 18 Apr 2016 23:04:48 +0530
Message-ID: <57151AB8.7040405@nvidia.com>
References: <1460644878-19943-1-git-send-email-ldewangan@nvidia.com> <1460644878-19943-2-git-send-email-ldewangan@nvidia.com> <57136B7C.6030204@kernel.org> <57151023.8010505@nvidia.com> <D84D2ED7-81D4-4635-8244-4017D66C6A3B@jic23.retrosnub.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <D84D2ED7-81D4-4635-8244-4017D66C6A3B-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On Monday 18 April 2016 11:01 PM, Jonathan Cameron wrote:
>
> On 18 April 2016 17:49:39 BST, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> On Sunday 17 April 2016 04:24 PM, Jonathan Cameron wrote:
>>> On 14/04/16 15:41, Laxman Dewangan wrote:
>>> +static int gadc_thermal_read_channel(struct gadc_thermal_info *gti,
>> int *val)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = iio_read_channel_processed(gti->channel, val);
>>> +	if (ret < 0)
>>> +		ret = iio_read_channel_raw(gti->channel, val);
>>> Is this case actually useful given it means the scaling of the adc
>>> isn't known?
>>>
>>> I suppose you might have defined the table in terms of raw readings,
>>> but then when someone comes along and 'fixes' the ADC driver to
>> output
>>> it's scale your table will be wrong.
>>>
>> Yes, that may be possible if someone just move the implementation of
>> processed read to raw read.
>> I assumed that some of adc driver implemented as raw and some of
>> implemented as processed and so fallback.
>>
>> However, if adc driver has processed implementation then it should not
>> move to raw and deprecate the processed.
>>
>> It seems raw as default should be better option. We can have two option
>> now:
>>
>> - Support raw only, not to processed.
>>
>> - Or support the raw as default and processed as the optional from DT.
>> if (!processed)
>>      read_raw()
>> else
>>    read_processed()
>>
>>
>> Your opinion?
> Processed only. It will compute the right value if raw and scale are provided by the
>   device (which they should be for an ADC). The read_processed function does
>   the maths if needed.
>
>   The only time devices should
>   supply raw without scale is if their is no direct transform ( e.g. an infrared
>   intensity measure where only known transform involves combining it with
>   another signal) or their is an external unknown (e.g. proximity sensors where
>   you have to know what they were close to in order to know the scaling!)
>
> If there is a conventional ADC driver not providing either processed directly or
>   both raw and scale let us know and we will fix it!
>

Thanks, I will recycle this patch to use processed only.
