Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5713C2E;
	Mon,  3 Aug 2026 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785716048; cv=none; b=qDNlT4oDxbQ7sGxa/E/hEuwh4+eteKHlceBCS5CndQ4x4iWYQSqasM8LoR/9HPzO/Ad/8S7rRkLxcE6168QKesO5KyAij5UbvvXwneiHuHV8Xv1kB84k6B/WcC6obRnDgbVHthNdgGDgTAaRi5VV6lXUrt+OU9/Q/lpQzFnjbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785716048; c=relaxed/simple;
	bh=PHsi2+RTBUloUbcdSpGaG5uysbk+Tqkc9Et/mvTqYJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSskMcYNFmfmLESpPMUBXqkwvBTOokRGXDbopaUZWlAtaw8irkYzPmnHmbR+vGSEk1rHzYYQ5UgV+iHsv6JWeChhwhU+klyUELs+v6caIe2VY2ZuEY6i/W5b+5q0gOBNviT53xc0gw+Az9WdJqXaAifCRZEzeOtivCi+Oto2VrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzCR4S7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzCR4S7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C621F000E9;
	Mon,  3 Aug 2026 00:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785716046;
	bh=yRGuw/XUwJhlsXaoSOHXWXL02azvdSRhbTxKLtQNy60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LzCR4S7wtSg8byxnQ7kmak7u8emOAO8QC22G1oJaD0JND+6TS3ZT63iB/VesBhtko
	 EV/UsLWxj9gqNzYkADsOVZQn7ew47qubFdcuX4H+ZA3kIM5EqYCj+Xps3aYjSjFbhR
	 tVtFvFui4ZHqRwmMye2YlGlM/693ZV1DYRBAiPooJx7QQYEfj9Y1GOydGNifVZS7V5
	 z6NLIODMN1I0dz9LTj66arr5BOt6I48yHGVb+ypqs4YR+IdRVrjS31hyE5hV66fdZe
	 POMBXpsoLsk1FxdlK4+IfYLRqudSZHCaYCrtSP4vZrP7S3mTIw+BqbJf0nKTTjDDE8
	 mi7SHrnF0AnOg==
Date: Mon, 3 Aug 2026 01:14:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Kamal Wadhwa
 <kamal.wadhwa@oss.qualcomm.com>, Anjelique Melendez
 <anjelique.melendez@oss.qualcomm.com>, Manaf Meethalavalappu Pallikunhi
 <manaf.pallikunhi@oss.qualcomm.com>, Priyansh Jain
 <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
Message-ID: <20260803011400.1fb6c93a@jic23-huawei>
In-Reply-To: <20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
	<20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 23:36:15 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
> for improved performance, mostly at the hardware level.
> 
> One significant software change is that ratiometric conversion resolution
> has been increased from 14 bits to 16 bits, so the maximum value of
> these measurements needs to be updated for Gen4. Add a new scaling
> function for thermistor channels which use this type of conversion.
> 
> In the latest PMIC arbiter version (v8), there can be up to 4 buses
> under the PMIC arbiter and 32 PMICs under each bus. In order to
> support communication between ADC on the master PMIC and ADCs on any
> of the other PMICs, a field of width 2 bits is added for bus index
> and the bits for SID are extended from 4 to 5 bits, in the SID
> register. Add support for this.
> 
> In addition, it is possible that the master PMIC has ADC of one generation
> and it needs to communicate with another PMIC with ADC of a different
> generation.

"Possible" sounds a bit hypothetical.  Can we state this actually happens
on some devices?

> Add new DT properties "qcom,adc5-gen3" and "qcom,adc5-gen4",
> to distinguish Gen3 channels under a Gen4 master and Gen4 channels
> under a Gen3 master respectively, to ensure that their conversions are handled

This line got a bit long. Wrap at 75 chars for commit message.

> correctly.
> 
> Co-developed-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 165 +++++++++++++++++++-------
>  drivers/iio/adc/qcom-vadc-common.c            |  32 +++++
>  include/linux/iio/adc/qcom-adc5-gen3-common.h |  44 ++++++-
>  include/linux/iio/adc/qcom-vadc-common.h      |   4 +
>  4 files changed, 195 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> index c68c6c5f6aca..810d25b665b1 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -86,7 +86,9 @@ int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
>  }
>  EXPORT_SYMBOL_NS_GPL(adc5_gen3_write, "QCOM_SPMI_ADC5_GEN3");
>  
> -static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
> +static int adc5_gen3_read_voltage_data(struct adc5_chip *adc,
> +				       struct adc5_channel_common_prop *prop,
> +				       u16 *data)
>  {
>  	u8 rslt[2];
>  	int ret;
> @@ -99,8 +101,10 @@ static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
>  	*data = get_unaligned_le16(rslt);
>  
>  	if (*data == ADC5_USR_DATA_CHECK) {
This feels backwards.   We first check for the top bit being
set then check whether we care if it is set or not.  I think
checking if we should look at it first makes more sense.  Also
shorter max line length:

	if (!(prop->generation == ADC5_GEN4 && prop->cal_method == ADC5_RATIOMETRIC_CAL)) {
		if (*data == ADC5_USR_DATA_CHECK) {
	...	

>  
> +static const struct adc5_channels adc5_gen4_chans_pmic[ADC5_MAX_CHANNEL] = {
> +	[ADC5_GEN4_OFFSET_REF]		= ADC5_CHAN_VOLT(0,
> +						SCALE_HW_CALIB_DEFAULT)

Probably just go long on these lines and I'm not sure there is enough benefit to
forcing the alignment though if you really want to it will be more useful with
them on a single line.

	[ADC5_GEN4_OFFSET_REF] = ADC5_CHAN_VOLT(0, SCALE_HW_CALIB_DEFAULT)
...

	[ADC5_GEN4_AMUX5_GPIO_100K_PU] = ADC5_CHAN_TEMP(0, SCALE_HW_CALIB_THERM_100K_PU_GEN4)

Obviously it has been there a while, but having the comma inside ADC_CHAN() macro
ends up making this look a little odd.


> +	[ADC5_GEN4_1P25VREF]		= ADC5_CHAN_VOLT(0,
> +						SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN4_VPH_PWR]		= ADC5_CHAN_VOLT(1,

> +
> +static const struct of_device_id adc5_match_table[] = {
> +	{
> +		.compatible = "qcom,spmi-adc5-gen3",
> +		.data = &adc5_gen3_data_pmic,
> +	},
> +	{
> +		.compatible = "qcom,spmi-adc5-gen4",
> +		.data = &adc5_gen4_data_pmic,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc5_match_table);

Why has this moved?  I'm not seeing any new references to adc5_match_table
before where it was before.

> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index b03cf584b165..cb23d0d178c7 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c

> @@ -341,6 +345,8 @@ static const struct qcom_adc5_scale_type scale_adc5_fn[] = {
>  					qcom_vadc7_scale_hw_calib_die_temp},
>  	[SCALE_HW_CALIB_PM5_CHG_TEMP] = {qcom_vadc_scale_hw_chg5_temp},
>  	[SCALE_HW_CALIB_PM5_SMB_TEMP] = {qcom_vadc_scale_hw_smb_temp},
> +	[SCALE_HW_CALIB_THERM_100K_PU_GEN4] = {
> +					qcom_adc5_gen4_scale_hw_calib_therm},

I don't mind if you want to go a little past 80 chars to avoid doing this sort
of line break that just makes things harder to read.

>  };
>  
>  static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
> @@ -556,6 +562,32 @@ static int qcom_vadc7_scale_hw_calib_therm(
>  	return 0;
>  }
>  
> +static int qcom_adc5_gen4_scale_hw_calib_therm(
> +				const struct u32_fract *prescale,
> +				const struct adc5_data *data,
> +				u16 adc_code, int *result_mdec)
> +{
> +	s64 resistance = adc_code;
> +	int ret, result;
> +
> +	if (adc_code >= RATIO_MAX_ADC5_GEN4)
> +		return -EINVAL;
> +
> +	/* (ADC code * R_PULLUP (100Kohm)) / (full_scale_code - ADC code)*/
> +	resistance *= R_PU_100K;
> +	resistance = div64_s64(resistance, RATIO_MAX_ADC5_GEN4 - adc_code);
> +
> +	ret = qcom_vadc_map_voltage_temp(adcmap7_100k,
> +					 ARRAY_SIZE(adcmap7_100k),
> +					 resistance, &result);

	ret = qcom_vadc_map_voltage_temp(adcmap7_100k, ARRAY_SIZE(adcmap7_100k),
					 resistance, &result);

is under 80 chars anyway. 

> +	if (ret)
> +		return ret;
> +
> +	*result_mdec = result;
> +
> +	return 0;
> +}
> +
>  static int qcom_vadc_scale_hw_calib_volt(
>  				const struct u32_fract *prescale,
>  				const struct adc5_data *data,
> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> index 39cbfcbdb101..5d8e38350827 100644
> --- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> @@ -40,7 +40,8 @@
>  
> +enum adc_generation {
> +	ADC5_GEN3 = 0,

Does the value matter anywhere?  If not just leave it unspecified.
If it does matter because it actually gets written to hardware somewhere
I'm missing then set GEN4 as well.

> +	ADC5_GEN4,
> +};
> +

Thanks,

Jonathan
