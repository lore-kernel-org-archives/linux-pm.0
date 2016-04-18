From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH V3 2/2] thermal: generic-adc: Add ADC based thermal sensor
 driver
Date: Mon, 18 Apr 2016 22:19:39 +0530
Message-ID: <57151023.8010505@nvidia.com>
References: <1460644878-19943-1-git-send-email-ldewangan@nvidia.com> <1460644878-19943-2-git-send-email-ldewangan@nvidia.com> <57136B7C.6030204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6445 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbcDRRBK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 13:01:10 -0400
In-Reply-To: <57136B7C.6030204@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, robh@kernel.org, edubezval@gmail.com, rui.zhang@intel.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org


On Sunday 17 April 2016 04:24 PM, Jonathan Cameron wrote:
> On 14/04/16 15:41, Laxman Dewangan wrote:
> +static int gadc_thermal_read_channel(struct gadc_thermal_info *gti, int *val)
> +{
> +	int ret;
> +
> +	ret = iio_read_channel_processed(gti->channel, val);
> +	if (ret < 0)
> +		ret = iio_read_channel_raw(gti->channel, val);
> Is this case actually useful given it means the scaling of the adc
> isn't known?
>
> I suppose you might have defined the table in terms of raw readings,
> but then when someone comes along and 'fixes' the ADC driver to output
> it's scale your table will be wrong.
>

Yes, that may be possible if someone just move the implementation of 
processed read to raw read.
I assumed that some of adc driver implemented as raw and some of 
implemented as processed and so fallback.

However, if adc driver has processed implementation then it should not 
move to raw and deprecate the processed.

It seems raw as default should be better option. We can have two option now:

- Support raw only, not to processed.

- Or support the raw as default and processed as the optional from DT.
if (!processed)
     read_raw()
else
   read_processed()


Your opinion?

