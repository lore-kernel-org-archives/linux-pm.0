From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Subject: Re: [PATCH V3 2/2] thermal: generic-adc: Add ADC based thermal sensor driver
Date: Mon, 18 Apr 2016 18:31:36 +0100
Message-ID: <D84D2ED7-81D4-4635-8244-4017D66C6A3B@jic23.retrosnub.co.uk>
References: <1460644878-19943-1-git-send-email-ldewangan@nvidia.com> <1460644878-19943-2-git-send-email-ldewangan@nvidia.com> <57136B7C.6030204@kernel.org> <57151023.8010505@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60151 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbcDRRbr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 13:31:47 -0400
In-Reply-To: <57151023.8010505@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, robh@kernel.org, edubezval@gmail.com, rui.zhang@intel.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org



On 18 April 2016 17:49:39 BST, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>
>On Sunday 17 April 2016 04:24 PM, Jonathan Cameron wrote:
>> On 14/04/16 15:41, Laxman Dewangan wrote:
>> +static int gadc_thermal_read_channel(struct gadc_thermal_info *gti,
>int *val)
>> +{
>> +	int ret;
>> +
>> +	ret = iio_read_channel_processed(gti->channel, val);
>> +	if (ret < 0)
>> +		ret = iio_read_channel_raw(gti->channel, val);
>> Is this case actually useful given it means the scaling of the adc
>> isn't known?
>>
>> I suppose you might have defined the table in terms of raw readings,
>> but then when someone comes along and 'fixes' the ADC driver to
>output
>> it's scale your table will be wrong.
>>
>
>Yes, that may be possible if someone just move the implementation of 
>processed read to raw read.
>I assumed that some of adc driver implemented as raw and some of 
>implemented as processed and so fallback.
>
>However, if adc driver has processed implementation then it should not 
>move to raw and deprecate the processed.
>
>It seems raw as default should be better option. We can have two option
>now:
>
>- Support raw only, not to processed.
>
>- Or support the raw as default and processed as the optional from DT.
>if (!processed)
>     read_raw()
>else
>   read_processed()
>
>
>Your opinion?
Processed only. It will compute the right value if raw and scale are provided by the
 device (which they should be for an ADC). The read_processed function does
 the maths if needed.

 The only time devices should
 supply raw without scale is if their is no direct transform ( e.g. an infrared
 intensity measure where only known transform involves combining it with
 another signal) or their is an external unknown (e.g. proximity sensors where
 you have to know what they were close to in order to know the scaling!)

If there is a conventional ADC driver not providing either processed directly or
 both raw and scale let us know and we will fix it!

Jonathan
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
