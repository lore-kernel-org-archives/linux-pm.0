Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295274;
	b=b/wXOGYuBPBJCuz2IB8RvVs3h2nD7kerRk2bxbpfnv0LjJCJemhwiqN77Nrbp0dMni4P
	 Exgph8yCAqljYpoDzDBkrmCgqtEqfcxIr32Svoakmcp89W+1IR11yecvkE2e6/x88K/Es
	 zZ6uVhsmqg+MfWPPIDj0uOIEbN/xlREPlU/zaGARkKJcuRluiZhu68rFP/lG6Y3J+ljVJ
	 UbrNWDCouwqf7YRfsw77hLCzQuCLwLdnayWosQbWP6SUaVo17djNEuS1oxlDZI0oOkbCF
	 Syh7Fi4Dhvr29zVezcEr19phChRPebY10XxSleOtXMTF6wxtIB6aGHDydxe1EXLh3gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295274;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y9efMSfiICdKBHxaD4Qe7FBs3NUO/APCxh6CXXXWIkw=;
	b=1msm8e7lVoq2WgYFqLSGC7W0h0+JZJsgU7uyMJYSuekp4LFUgEoNyPfk3Rw2MwXJN5bj
	 87R74AcNDTbtBjEK0z6uO478wZN+WpNkBhRsMALiylnf17rdSGhY7BzIxmz6ss44w/aOF
	 t62I9YXvn1R7ULR/BnPoOiRhlLsncNVbQe7UB9NMbCgEvegazViv8cin9p8bxRydDsVXb
	 mHTVC//82zXyKPALDuXjn48aXAU0iNhpwvecM8PdRC/36fjuEmYhfBfRZRKSdX1wfhKMf
	 bKSbu66c4+bM57OTjboXCViCvB70LDIEZCdcN8tPJNdx+3d7J/V9lvsIZUocU1Sq4og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLUVJz6i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6F606A32A;
	Sat, 21 Nov 2026 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLUVJz6i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF96A1F000C0;
	Sat, 21 Nov 2026 21:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295274;
	bh=Y9efMSfiICdKBHxaD4Qe7FBs3NUO/APCxh6CXXXWIkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DLUVJz6i1r2LUrOhXlLPx7bIyGBLHxgFewMYoIeRzNXeY3nYKCSRrX+8CO23Lpnqy
	 WDKgOmjNX5myxIc/e4b+V+iiqcZzHtwYXe467YFnEek0qW6jeUCZ2obJ+7is6Z+xsS
	 EZEVLFfNlYDPbk4edyzPfeZoNCwEqY+3GkNGKCnjNiueURchxzGzzUkWstNgdEjDim
	 S8UX9A7AWRMTdBcTz+E8soP4mLPC57nRWP4zrLSIpflSUQK28Sn9RE9knn7+Jg0pSO
	 To5eE0WBZbYR1qVkhTPZtrhEjvg9BFDMLoC5hYgsgwlG0dEZ9KiGvfoqSvrmaM4T4f
	 qQshgmO+61QjA==
Date: Sat, 21 Nov 2026 21:07:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Kamal Wadhwa
 <kamal.wadhwa@oss.qualcomm.com>, Anjelique Melendez
 <anjelique.melendez@oss.qualcomm.com>, Manaf Meethalavalappu Pallikunhi
 <manaf.pallikunhi@oss.qualcomm.com>, Priyansh Jain
 <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/7] thermal: qcom: qcom-spmi-adc-tm5-gen3: Add
 support for QCOM PMIC5 Gen4 ADC
Message-ID: <20261121210747.0ab59a9f@jic23-hlaptop>
In-Reply-To: <20261120-pmic5_gen4_adc-v2-4-94d0e1fd6847@oss.qualcomm.com>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
	<20261120-pmic5_gen4_adc-v2-4-94d0e1fd6847@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 14:49:44 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
> for improved performance, mostly at the hardware level.
> 
> One significant software change is that ratiometric conversion resolution
> has been increased from 14 bits to 16 bits. Add a reverse scaling function
> for Gen4 ADC thermistor channels.
> 
> In the latest PMIC arbiter version (v8), there can be up to 4 buses
> under the PMIC arbiter and 32 PMICs under each bus. In order to
> support communication between ADC on the master PMIC and ADCs on any
> of the other PMICs, a field of width 2 bits is added for bus index
> and the bits for SID are extended from 4 to 5 bits, in the SID
> register. Add support for this.
> 
> Co-developed-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
>  drivers/iio/adc/qcom-vadc-common.c            | 11 +++++++++++
>  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 19 ++++++++++++++-----
>  include/linux/iio/adc/qcom-vadc-common.h      |  2 ++
>  3 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index 5c4052f6f24f..779c2a66a858 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -718,6 +718,17 @@ u16 qcom_adc_tm5_gen2_temp_res_scale(int temp)
>  }
>  EXPORT_SYMBOL(qcom_adc_tm5_gen2_temp_res_scale);
>  
> +u16 qcom_adc_tm5_gen4_temp_res_scale(int temp)
> +{
> +	s64 resistance;
> +
> +	resistance = qcom_vadc_map_temp_voltage(adcmap7_100k,
> +						ARRAY_SIZE(adcmap7_100k), temp);
> +
> +	return div64_s64(resistance * RATIO_MAX_ADC5_GEN4, resistance + R_PU_100K);

If you were keeping this (See below) I'd have a helper that does the maths
called by both the gen2 and gen4 versions. I think it just has that multiplier
different.

> +}
> +EXPORT_SYMBOL(qcom_adc_tm5_gen4_temp_res_scale);
> +
>  int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
>  		    unsigned int prescale_ratio,
>  		    const struct adc5_data *data,
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> index 910b241fa94d..aeaf13f4fc66 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> @@ -207,15 +207,23 @@ static int adc_tm5_gen3_disable_channel(struct adc_tm5_gen3_channel_props *prop)
>  			       ADC5_GEN3_CONV_REQ, &val, sizeof(val));
>  }
>  
> +typedef u16 (*temp_res_scale)(int temp);
> +
>  static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
>  				  int low_temp, int high_temp)
>  {
>  	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
>  	u8 buf[ADC_TM5_GEN3_CONFIG_REGS];
> +	temp_res_scale tm_scal_fn;
>  	u8 conv_req;
>  	u16 adc_code;
>  	int ret;
>  
> +	if (prop->common_props.generation == ADC5_GEN4)
> +		tm_scal_fn = qcom_adc_tm5_gen4_temp_res_scale;
> +	else
> +		tm_scal_fn = qcom_adc_tm5_gen2_temp_res_scale;

A little messy patch ordering wise, but I think those should
be function pointers in common_props.data and set in the adc
driver (where it currently sets generation).

That will put all the information in one place rather
than a mix of data and stuff patched in the code in various
other places.

For anyone not reading review of previous patch, I want that
generation value to go away.

However, the two callbacks differ (I think) in only one value.
Just put that value in the data instead of having two callbacks
and add a parameter to the function to pass it in.

> +
>  	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
>  	if (ret < 0)
>  		return ret;
> @@ -225,8 +233,9 @@ static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Write SID */
> -	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->common_props.sid);
> +	/* Write SID and bus_id*/
> +	buf[0] = FIELD_PREP(ADC5_GEN4_BUS_INDEX_MASK, prop->common_props.bus_index) |
> +		 FIELD_PREP(ADC5_GEN4_SID_MASK, prop->common_props.sid);
>  
>  	/* Select TM channel and indicate there is an actual conversion request */
>  	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
> @@ -252,7 +261,7 @@ static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
>  	/* High temperature corresponds to low voltage threshold */
>  	prop->low_thr_en = (high_temp != INT_MAX);
>  	if (prop->low_thr_en) {
> -		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
> +		adc_code = tm_scal_fn(high_temp);
>  		put_unaligned_le16(adc_code, &buf[8]);
>  		buf[7] |= ADC5_GEN3_LOW_THR_INT_EN;
>  	}
> @@ -260,7 +269,7 @@ static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
>  	/* Low temperature corresponds to high voltage threshold */
>  	prop->high_thr_en = (low_temp != -INT_MAX);
>  	if (prop->high_thr_en) {
> -		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low_temp);
> +		adc_code = tm_scal_fn(low_temp);
>  		put_unaligned_le16(adc_code, &buf[10]);
>  		buf[7] |= ADC5_GEN3_HIGH_THR_INT_EN;
>  	}
> @@ -306,7 +315,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_gen3_chip *adc_tm5)
>  	int ret;
>  
>  	for (int i = 0; i < adc_tm5->nchannels; i++) {
> -		channel = ADC5_GEN3_V_CHAN(adc_tm5->chan_props[i].common_props);
> +		channel = ADC5_GEN4_V_CHAN(adc_tm5->chan_props[i].common_props);
>  		tzd = devm_thermal_of_zone_register(adc_tm5->dev, channel,
>  						    &adc_tm5->chan_props[i],
>  						    &adc_tm_ops);
> diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
> index 4be682083843..55efad27ed73 100644
> --- a/include/linux/iio/adc/qcom-vadc-common.h
> +++ b/include/linux/iio/adc/qcom-vadc-common.h
> @@ -159,6 +159,8 @@ u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
>  
>  u16 qcom_adc_tm5_gen2_temp_res_scale(int temp);
>  
> +u16 qcom_adc_tm5_gen4_temp_res_scale(int temp);
> +
>  int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
>  
>  int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
> 

