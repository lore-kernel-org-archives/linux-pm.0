Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294689;
	b=zhASTHgi8jWCjMDBrZUyBYglhmMyCFYpvoN4QtQ6v2Mi0rr6N13ySiEYS8cdtyu26n2D
	 tNQjGLww3tPH+41w+BxLU9uOrO9qoV7JAJxa0ZSrPZ1HFQuv5o+rcCkf2bTqqDNGCIGeA
	 syBsMoBhAfnu6PrNvmuBZBhx4fWKV4mwuN/O1KVIXLN1zAIPA1xt0VU095HMafPKe7L2n
	 wZuwv+kARxhGk/DlHIgSfNIEA5h6cDiIXr0EU4o6CwHWBVdT6F+cE0mnSOsfBL53dHJVr
	 M4t9I1WzRLHw6msBRoqZFfwqyFN2vw5DilhqW4kBS40KwM+WNx8NFFA/Xqx/nl7/Yxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294689;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KY0/LkKEKo3FUFd1efuIx6x2byXqY/xtc6DQ9I+e5QA=;
	b=i9xmJNfKXxFyJlsZ76KLlAYILsyrx+fAFKHrJX2iZe59Nl7lXWihZ4d8rU2QQPdmT1oh
	 0JvVrRz/5Dzyp0YlJib3SD5ofleCndj3JAufiU23ZqSWvu0JqkSciqU861F2k2A9N24ER
	 NqfAuRqcdvlxSC/wvhUBCcESvHvIAEhCvA0vFFTwE2hXz/aZOnayZswYmvYYx0zW74beo
	 Sgb3xVsqmzqZWcg23WmGy3EjuWkjgc0yvmsAuMGs9TrxTidglRmoYLpValc1iLaSnOQfk
	 RaSY5fhKFz1mrY/RLkl4Tu0OaIoLsk6IggBD6Zenk7UOTxDDFfpS6tJiQrdMAUKf1Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJxGgIqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57862606A320;
	Sat, 21 Nov 2026 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJxGgIqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4861F000C4;
	Sat, 21 Nov 2026 20:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294688;
	bh=KY0/LkKEKo3FUFd1efuIx6x2byXqY/xtc6DQ9I+e5QA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FJxGgIqyW+hmwxc6Iot1xFrm2WKQAfCdBQ+Hky/AkXtAJBHI92E2sW0xp7cZV2762
	 8TYcNWJA4NEbzK/OGlhM80KLOoZMbkhE/WQP/RmSUFONqeH2NKe0lVVdNeXf8LfnJk
	 tqCSG1nT0E9RGC4tNdaQOBhHbRUNPy/EkkLFQldSDn+0NaJ9YbtFJCMwdwJW10mDZy
	 uIf5or34aMtb4sGe8HBgibd1ICReRyMj0/jSuMOHvEjleJXhbPS/2zJPmhopUsetwW
	 VYuR5cEkb4v15ltNjaDyRW49EfXYTKQeQu1JP/rD6XxMqZ6W5mJvrmtdkKwRA4jnQ8
	 qOrKI7N+nM1bg==
Date: Sat, 21 Nov 2026 20:58:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, Conor Dooley
 <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Amit Kucheria
 <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, Manaf
 Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>, Priyansh
 Jain <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/7] iio: adc: qcom-spmi-adc5-gen3: Add support for
 QCOM PMIC5 Gen4 ADC
Message-ID: <20261121205804.382bdb91@jic23-hlaptop>
In-Reply-To: <20261120-pmic5_gen4_adc-v2-3-94d0e1fd6847@oss.qualcomm.com>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
	<20261120-pmic5_gen4_adc-v2-3-94d0e1fd6847@oss.qualcomm.com>
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

On Fri, 20 Nov 2026 14:49:43 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
> for improved performance, mostly at the hardware level.
> 
> One significant software change is that ratiometric conversion resolution
> has been increased from 14 bits to 16 bits, so the maximum value of
> these measurements needs to be updated for Gen4. Add a new scaling
> function for thermistor channels which use this type of conversion.
> 
> It is possible that the master PMIC has ADC of one generation and it needs
> to communicate with another PMIC with ADC of a different generation. For
> example, on SM8750, PMK8550 is the master PMIC with Gen3 ADC and it
> communicates with PMIH0108, which has Gen4 ADC. Add a new DT property
> "qcom,adc5-gen4" to distinguish Gen4 channels under a Gen3 master, to
> ensure that their conversions are handled correctly.
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
Hi Jishnu

Various things inline to add to what Andy has raised.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 125 ++++++++++++++++++--------
>  drivers/iio/adc/qcom-vadc-common.c            |  30 +++++++
>  include/linux/iio/adc/qcom-adc5-gen3-common.h |  42 +++++++++
>  include/linux/iio/adc/qcom-vadc-common.h      |   4 +
>  4 files changed, 164 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> index be12bb6781cb..aa06d4d1083a 100644
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
> @@ -98,9 +100,11 @@ static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
>  
>  	*data = get_unaligned_le16(rslt);
>  
> -	if (*data == ADC5_USR_DATA_CHECK) {
> -		dev_err(adc->dev, "Invalid data:%#x\n", *data);
> -		return -EINVAL;
> +	if (!(prop->generation == ADC5_GEN4 && prop->cal_method == ADC5_RATIOMETRIC_CAL)) {

See below.  I would not expect to see generation (so an enum ID type field(
as well as a structure representing the differences in hardware.

Add something to the prop->data structure to represent this difference.
bool no_datacheck_with_ratcal
or something like that.

Or can you derive this from other data already in there?

> +		if (*data == ADC5_USR_DATA_CHECK) {
> +			dev_err(adc->dev, "Invalid data:%#x\n", *data);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	dev_dbg(adc->dev, "voltage raw code:%#x\n", *data);
> @@ -131,8 +135,9 @@ static int adc5_gen3_configure(struct adc5_chip *adc,
>  	if (ret)
>  		return ret;
>  
> -	/* Write SID */
> -	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->sid);
> +	/* Write SID and bus_id*/
> +	buf[0] = FIELD_PREP(ADC5_GEN4_BUS_INDEX_MASK, prop->bus_index) |
> +		 FIELD_PREP(ADC5_GEN4_SID_MASK, prop->sid);

Similar to below.  You are using the fact the SID_MASKS are the same
here but the defines don't enforce that.  Simple change to make
one macro for the mask defined in terms of the other one and lock
in that relationship.

>  
>  	/*
>  	 * Use channel 0 by default for immediate conversion and to indicate
> @@ -268,7 +273,7 @@ static int adc5_gen3_do_conversion(struct adc5_chip *adc,
>  		return -ETIMEDOUT;
>  	}
>  
> -	ret = adc5_gen3_read_voltage_data(adc, data_volt);
> +	ret = adc5_gen3_read_voltage_data(adc, prop, data_volt);
>  	if (ret)
>  		return ret;
>  
> @@ -325,7 +330,7 @@ static int adc5_gen3_fwnode_xlate(struct iio_dev *indio_dev,
>  	int i, v_channel;
>  
>  	for (i = 0; i < adc->nchannels; i++) {
> -		v_channel = ADC5_GEN3_V_CHAN(adc->chan_props[i].common_props);
> +		v_channel = ADC5_GEN4_V_CHAN(adc->chan_props[i].common_props);

Maybe should include a change to the ADC5_GEN3_V_CHAN() macro to be
defined in terms of the GEN4 one as might make it more obvious why
this change is fine.  Also the masks that are the same and hence allow
that lack of differentiation between the two.

>  		if (v_channel == iiospec->args[0])
>  			return i;
>  	}
> @@ -351,7 +356,7 @@ static int adc5_gen3_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		ret = qcom_adc5_hw_scale(prop->scale_fn_type, prop->prescale,
> -					 adc->data, adc_code_volt, val);
> +					 prop->data, adc_code_volt, val);
>  		if (ret)
>  			return ret;
>  

> +static const struct adc5_data adc5_gen3_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.adc_chans = adc5_gen3_chans_pmic,
> +	.info = &adc5_gen3_info,
> +	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
> +			   { 85, 340, 1360 },

See below. I'd expect the default decimation to be in here as well.

> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> +			   { 15, 100, 200, 300,
> +			     400, 500, 600, 700,
> +			     1000, 2000, 4000, 8000,
> +			     16000, 32000, 64000, 128000 },
> +};
> +
> +static const struct adc5_data adc5_gen4_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.adc_chans = adc5_gen4_chans_pmic,
> +	.info = &adc5_gen3_info,
> +	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
> +			   { 85, 340, 1360 },
> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> +			   { 15, 100, 200, 300,
> +			     400, 500, 600, 700,
> +			     1000, 2000, 4000, 8000,
> +			     16000, 32000, 64000, 128000 },
> +};
> +
>  static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
>  					 struct adc5_channel_prop *prop,
>  					 struct fwnode_handle *fwnode)
>  {
>  	const char *name = fwnode_get_name(fwnode);
> -	const struct adc5_data *data = adc->data;
> +	const struct adc5_data *data;
> +	u32 chan, value, sid, bus_index;
>  	struct device *dev = adc->dev;
>  	const char *channel_name;
> -	u32 chan, value, sid;
>  	u32 varr[2];
>  	int ret;
>  
> @@ -452,27 +502,42 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
>  
>  	/*
>  	 * Value read from "reg" is virtual channel number
> -	 * virtual channel number = sid << 8 | channel number
> +	 * virtual channel number = bus index << 13 | sid << 8 | channel number
> +	 * For ADC5 GEN3 channels, bus index = 0
>  	 */
> -	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
> -	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
> +	bus_index = FIELD_GET(ADC5_GEN4_V_CHAN_BUS_INDEX_MASK, chan);
> +	sid = FIELD_GET(ADC5_GEN4_V_CHAN_SID_MASK, chan);
> +	chan = FIELD_GET(ADC5_GEN4_V_CHAN_CHANNEL_MASK, chan);
>  
>  	if (chan >= ADC5_MAX_CHANNEL)
>  		return dev_err_probe(dev, -EINVAL,
>  				     "%s invalid channel number %d\n",
>  				     name, chan);
>  
> +	prop->common_props.bus_index = bus_index;
>  	prop->common_props.channel = chan;
>  	prop->common_props.sid = sid;
>  
> -	if (!adc->data->adc_chans[chan].info_mask)
> +	if (fwnode_property_read_bool(fwnode, "qcom,adc5-gen4")) {
> +		prop->common_props.generation = ADC5_GEN4;

See below. That generation enum is a thing that makes me wonder
if they generalization is being handled as it should be.

> +		data = &adc5_gen4_data_pmic;
> +	} else {
> +		prop->common_props.generation = ADC5_GEN3;
> +		data = &adc5_gen3_data_pmic;
> +	}
> +	prop->common_props.data = data;
> +
> +	if (!data->adc_chans[chan].info_mask)
>  		return dev_err_probe(dev, -EINVAL, "Channel %#x not supported\n", chan);
>  
>  	channel_name = name;
>  	fwnode_property_read_string(fwnode, "label", &channel_name);
>  	prop->common_props.label = channel_name;
>  
> -	value = data->decimation[ADC5_DECIMATION_DEFAULT];
> +	if (prop->common_props.generation == ADC5_GEN3)
> +		value = data->decimation[ADC5_DECIMATION_DEFAULT];
> +	else
> +		value = data->decimation[ADC5_GEN4_DECIMATION_DEFAULT];

I'm confused.  I thought data was a structure that differentiated
between GEN4 and GEN5 PMIC supplied channels. If so why are both
decimation values in there?  If both generations support same options
but the default has changed, add a default value to the data and this
becomes

	value = data->decimation[data->default_decimation];

That will mean updating the other adc5 drivers I think, but should be
fairly trivial and puts the values where they should be rather than
in defines at top of files.


>  	fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
>  	ret = qcom_adc5_decimation_from_dt(value, data->decimation);
>  	if (ret < 0)
> @@ -480,7 +545,7 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
>  				     chan, value);
>  	prop->common_props.decimation = ret;
>  
> -	prop->common_props.prescale = adc->data->adc_chans[chan].prescale_index;
> +	prop->common_props.prescale = data->adc_chans[chan].prescale_index;

This could be a precursor change to use local data variable consistently in
this function.  Perhaps it isn't wroth it though.

>  	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
>  	if (!ret) {
>  		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
> @@ -526,19 +591,6 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
>  	return 0;
>  }

> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> index ec7238e93396..fa7e08d67f26 100644
> --- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h

> @@ -117,6 +148,11 @@ enum adc5_time_select {
>  	MEAS_INT_NONE,
>  };
>  
> +enum adc_generation {
> +	ADC5_GEN3,
> +	ADC5_GEN4,
> +};
See below.  Seeing an enum for variants is often a sign something
is less than ideal in how a driver had been made to deal with more
than one variant.  It is too inflexible - much better to just
have one place where you describe what the actual differences are.
Then when GEN5-10 turn up you can avoid lots of inline code
changes to match on particular generations.

> +
>  /**
>   * struct adc5_sdam_data - data per SDAM allocated for adc usage
>   * @base_addr: base address for the ADC SDAM peripheral.
> @@ -155,6 +191,9 @@ struct adc5_device_data {
>   *	that is an average of multiple measurements.
>   * @scale_fn_type: Represents the scaling function to convert voltage
>   *	physical units desired by the client for the channel.
> + * @generation: Generation of the ADC HW of the channel.
> + * @bus_index: SPMI bus index of PMIC owning the channel.
> + * @data: top-level ADC data structure.
>   */
>  struct adc5_channel_common_prop {
>  	unsigned int channel;
> @@ -166,6 +205,9 @@ struct adc5_channel_common_prop {
>  	unsigned int hw_settle_time_us;
>  	unsigned int avg_samples;
>  	enum vadc_scale_fn_type scale_fn_type;
> +	enum adc_generation generation;
> +	unsigned int bus_index;
> +	const struct adc5_data *data;

Having both generation and data in here suggests to me
that we have multiple sources of data for generation specific stuff.
See above.

>  };


