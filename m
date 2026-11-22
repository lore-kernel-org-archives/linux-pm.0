Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317194;
	b=msh1wCh134U4p0xzmSXI/8WmbhDg64JFRA5d6uXzVMzcr+lCYkwlFT9J4nGMXV2Niv7a
	 ba9Uzc+64XIRJmjZ6vqsq5pAkPqGThprjQq/R3TwiiOOEueUGUeLshqPdVmkbuYp0Hrpw
	 GLWKHdBdDbj9U3YlkylPNpSS2nzOBkGeEjln4noJVMt2p0UmslSzsc/2C9sh1n/XRVNjw
	 7n0yr9cfMkxzFanH3UkIm5tSDEEWyCcqoddLMDdsfGAdSrIElB7szDU8yZBlCaI7d6Pmt
	 kiiuWBsAB04GAMBlSL6SL9ITPz1WS6r6rhb0hG1J64PjMtx1+/IUyzRAfpH6f1C6P0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317194;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/2hvWwbIPhw3r0ndAN0gtAb+KTY8jNkvolhkXuBthoQ=;
	b=ug2NAxbGYmqIcIqyLW9m2KT4g1DDpJA8Cy94AgSNQWIiTX9/SOkkXlr5hOhD6xvQ8ZYr
	 TQXgV2ZCS7vFkoUCBDsWbSozmnFBqoZQVsr5agHR+GzPTDTnOxUYKvfBAy5FDiVjQJn+M
	 rv7lqs51jUlrg8aXtLCy7h/KDCDwWfdu5VWqTsmE4aR5GI+NWzGLt/O4gkfjzQtQfxIxt
	 a3A8qbReV/NYFQ4eL+moaH4asebo2VsiXxo4PHfuaNksEmFmWSb3AodOYUwk+8yCWCbo6
	 fmu3jdFgNLDl6r/zqY0C5yupQnXgDsJRLVrNPZ5tbdFpBIqgZamZNFFI/LX7Cs44aag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpEVbvTw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DF606A320;
	Sun, 22 Nov 2026 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpEVbvTw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27F01F000C4;
	Sun, 22 Nov 2026 03:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795317194;
	bh=/2hvWwbIPhw3r0ndAN0gtAb+KTY8jNkvolhkXuBthoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OpEVbvTw29B9IQxp9k8sambPABaC/rf23xtBAryQsiQ71wlPBcSMVq8KiKdbLCtmN
	 v+bdS5pKz2RcY9hFzLa5P+4sRc5dOzAqFStaTVAYVj/E0cp6oMbjGR5s56L0ZcwtBD
	 1gZG/VuIr54me6yIccw9Mzg/WzxvCBZK27GcaiRq0P37cXmWEhk3nTPZFtpIRWbOw+
	 6pNy7Ms2YmpKu92YeHH/Rj3qiw0AUkgT5K67VngvJoi0HMkI2qw7h6qjYdk4sqo5xU
	 KZgaPpCMFdzdp8UG8V1qA7RjkaImV5mmitHrR4oXJSYUQnrYyBX4J6SdD3xOQwf9Xx
	 DlhZQuhAjRMOQ==
Date: Sun, 22 Nov 2026 03:13:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan
 <ldewangan@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, Jens
 Reidel <adrian@mainlining.org>, Casey Connolly <casey.connolly@linaro.org>,
 Val Packett <val@packett.cool>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/5] iio: adc: qcom-spmi-adc5: Add battery thermal
 channels
Message-ID: <20261122031305.0fdc69cd@jic23-hlaptop>
In-Reply-To: <20261117-bat-temp-adc-v4-1-14d5d309ebfa@fairphone.com>
References: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
	<20261117-bat-temp-adc-v4-1-14d5d309ebfa@fairphone.com>
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

On Tue, 17 Nov 2026 09:23:11 +0100
Luca Weiss <luca.weiss@fairphone.com> wrote:

> Add the BAT_THERM channels with millivolt as output, which can then be
> used along with information regarding the NTC in the battery, to get the
> actual battery temperature.
> 
> A static lookup table in the ADC driver won't work since different
> devices have different Ohm and Beta values in their battery NTCs, for
> example a NTC can be 10kOhm & B=3435K.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Given this is independent of the following elements other than
the dtsi changes, do you want me to pick it up now?

You may need to use numeric values in dtsi until the header
catches up then chase with a patch flipping to the defines next cycle.
That's how we normally avoid that dependency slowing things down.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c         |  6 ++++++
>  drivers/iio/adc/qcom-vadc-common.c       | 16 ++++++++++++++++
>  include/linux/iio/adc/qcom-vadc-common.h |  3 +++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index d57ba8526e0c..24ac84580570 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -542,6 +542,12 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 0,
>  					SCALE_HW_CALIB_XOTHERM)
> +	[ADC5_BAT_THERM_30K_PU]	= ADC5_CHAN_VOLT("bat_therm_30k_pu", 0,
> +					SCALE_HW_CALIB_THERM_VOLT)
> +	[ADC5_BAT_THERM_100K_PU] = ADC5_CHAN_VOLT("bat_therm_100k_pu", 0,
> +					SCALE_HW_CALIB_THERM_VOLT)
> +	[ADC5_BAT_THERM_400K_PU] = ADC5_CHAN_VOLT("bat_therm_400k_pu", 0,
> +					SCALE_HW_CALIB_THERM_VOLT)
>  	[ADC5_BAT_ID_100K_PU]	= ADC5_CHAN_TEMP("bat_id", 0,
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index b03cf584b165..101b3c724f8d 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -309,6 +309,10 @@ static int qcom_vadc_scale_hw_calib_therm(
>  				const struct u32_fract *prescale,
>  				const struct adc5_data *data,
>  				u16 adc_code, int *result_mdec);
> +static int qcom_vadc_scale_hw_calib_therm_volt(
> +				const struct u32_fract *prescale,
> +				const struct adc5_data *data,
> +				u16 adc_code, int *result_mV);
>  static int qcom_vadc7_scale_hw_calib_therm(
>  				const struct u32_fract *prescale,
>  				const struct adc5_data *data,
> @@ -333,6 +337,7 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
>  static const struct qcom_adc5_scale_type scale_adc5_fn[] = {
>  	[SCALE_HW_CALIB_DEFAULT] = {qcom_vadc_scale_hw_calib_volt},
>  	[SCALE_HW_CALIB_THERM_100K_PULLUP] = {qcom_vadc_scale_hw_calib_therm},
> +	[SCALE_HW_CALIB_THERM_VOLT] = {qcom_vadc_scale_hw_calib_therm_volt},
>  	[SCALE_HW_CALIB_XOTHERM] = {qcom_vadc_scale_hw_calib_therm},
>  	[SCALE_HW_CALIB_THERM_100K_PU_PM7] = {
>  					qcom_vadc7_scale_hw_calib_therm},
> @@ -583,6 +588,17 @@ static int qcom_vadc_scale_hw_calib_therm(
>  				 voltage, result_mdec);
>  }
>  
> +static int qcom_vadc_scale_hw_calib_therm_volt(
> +				const struct u32_fract *prescale,
> +				const struct adc5_data *data,
> +				u16 adc_code, int *result_mV)
> +{
> +	*result_mV = qcom_vadc_scale_code_voltage_factor(adc_code,
> +				prescale, data, MICRO / MILLI);
> +
> +	return 0;
> +}
> +
>  static int qcom_vadc_scale_hw_calib_die_temp(
>  				const struct u32_fract *prescale,
>  				const struct adc5_data *data,
> diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
> index 3bf4c49726a7..7586016ff14d 100644
> --- a/include/linux/iio/adc/qcom-vadc-common.h
> +++ b/include/linux/iio/adc/qcom-vadc-common.h
> @@ -93,6 +93,8 @@ struct vadc_linear_graph {
>   *	voltage (uV) with hardware applied offset/slope values to adc code.
>   * @SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC using
>   *	lookup table. The hardware applies offset/slope to adc code.
> + * @SCALE_HW_CALIB_THERM_VOLT: Returns voltage in mV of a temperature channel.
> + *	The hardware applies offset/slope to adc code.
>   * @SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
>   *	100k pullup. The hardware applies offset/slope to adc code.
>   * @SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC using
> @@ -114,6 +116,7 @@ enum vadc_scale_fn_type {
>  	SCALE_PMI_CHG_TEMP,
>  	SCALE_HW_CALIB_DEFAULT,
>  	SCALE_HW_CALIB_THERM_100K_PULLUP,
> +	SCALE_HW_CALIB_THERM_VOLT,
>  	SCALE_HW_CALIB_XOTHERM,
>  	SCALE_HW_CALIB_THERM_100K_PU_PM7,
>  	SCALE_HW_CALIB_PMIC_THERM,
> 

