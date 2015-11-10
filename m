From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Tue, 10 Nov 2015 10:26:30 -0800
Message-ID: <20151110182629.GA5240@localhost.localdomain>
References: <1447064013-13026-1-git-send-email-s.hauer@pengutronix.de>
 <1447064013-13026-3-git-send-email-s.hauer@pengutronix.de>
 <20151110120554.GB3551@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36808 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbbKJS0e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2015 13:26:34 -0500
Content-Disposition: inline
In-Reply-To: <20151110120554.GB3551@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tue, Nov 10, 2015 at 12:05:54PM +0000, Javi Merino wrote:
> On Mon, Nov 09, 2015 at 11:13:32AM +0100, Sascha Hauer wrote:

<cut>

> > +
> > +/*
> > + * The MT8173 thermal controller has four banks. Each bank can read up to
> > + * four temperature sensors simultaneously. The MT8173 has a total of 5
> > + * temperature sensors. We use each bank to measure a certain area of the
> > + * SoC. Since TS2 is located centrally in the SoC it is influenced by multiple
> > + * areas, hence is used in different banks.
> > + */
> > +static const struct mtk_thermal_bank_cfg bank_data[] = {
> > +	{
> > +		.num_sensors = 2,
> > +		.sensors = { MT8173_TS2, MT8173_TS3 },
> > +	}, {
> > +		.num_sensors = 2,
> > +		.sensors = { MT8173_TS2, MT8173_TS4 },
> > +	}, {
> > +		.num_sensors = 3,
> > +		.sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> > +	}, {
> > +		.num_sensors = 1,
> > +		.sensors = { MT8173_TS2 },
> > +	},
> > +};

Would it make sense to simply expose all sensors and let the
configuration of their aggregation be done by DT?

There is already ongoing effort to get aggregation functions
generalized.

> > +
> > +struct mtk_thermal_sense_point {
> > +	int msr;
> > +	int adcpnp;
> > +};
> > +
> > +static const struct mtk_thermal_sense_point
> > +		sensing_points[MT8173_NUM_SENSORS_PER_ZONE] = {
> > +	{
> > +		.msr = TEMP_MSR0,
> > +		.adcpnp = TEMP_ADCPNP0,
> > +	}, {
> > +		.msr = TEMP_MSR1,
> > +		.adcpnp = TEMP_ADCPNP1,
> > +	}, {
> > +		.msr = TEMP_MSR2,
> > +		.adcpnp = TEMP_ADCPNP2,
> > +	}, {
> > +		.msr = TEMP_MSR3,
> > +		.adcpnp = TEMP_ADCPNP3,
> > +	},
> > +};
> > +
> > +/**
> > + * raw_to_mcelsius - convert a raw ADC value to mcelsius
> > + * @mt:		The thermal controller
> > + * @raw:	raw ADC value
> > + *
> > + * This converts the raw ADC value to mcelsius using the SoC specific
> > + * calibration constants
> > + */
> > +static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
> > +{
> > +	s32 tmp;
> > +
> > +	raw &= 0xfff;
> > +
> > +	tmp = 203450520 << 3;
> > +	tmp /= 165 + mt->o_slope;
> > +	tmp /= 10000 + mt->adc_ge;
> > +	tmp *= raw - mt->vts[sensno] - 3350;
> > +	tmp >>= 3;
> > +
> > +	return mt->degc_cali * 500 - tmp;
> > +}
> > +
> > +/**
> > + * mtk_thermal_get_bank - get bank
> > + * @bank:	The bank
> > + *
> > + * The bank registers are banked, we have to select a bank in the
> > + * PTPCORESEL register to access it.
> > + */
> > +static void mtk_thermal_get_bank(struct mtk_thermal_bank *bank)
> > +{
> > +	struct mtk_thermal *mt = bank->mt;
> > +	u32 val;
> > +
> > +	mutex_lock(&mt->lock);
> > +
> > +	val = readl(mt->thermal_base + PTPCORESEL);
> > +	val &= ~0xf;
> > +	val |= bank->id;
> > +	writel(val, mt->thermal_base + PTPCORESEL);
> > +}
> > +
> > +/**
> > + * mtk_thermal_put_bank - release bank
> > + * @bank:	The bank
> > + *
> > + * release a bank previously taken with mtk_thermal_get_bank,
> > + */
> > +static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
> > +{
> > +	struct mtk_thermal *mt = bank->mt;
> > +
> > +	mutex_unlock(&mt->lock);
> > +}
> > +
> > +/**
> > + * mtk_thermal_bank_temperature - get the temperature of a bank
> > + * @bank:	The bank
> > + *
> > + * The temperature of a bank is considered the maximum temperature of
> > + * the sensors associated to the bank.
> > + */
> > +static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
> > +{
> > +	struct mtk_thermal *mt = bank->mt;
> > +	int temp, i, max;
> > +	u32 raw;
> > +
> > +	temp = max = INT_MIN;
> > +
> > +	for (i = 0; i < bank_data[bank->id].num_sensors; i++) {
> > +		raw = readl(mt->thermal_base + sensing_points[i].msr);
> > +
> > +		temp = raw_to_mcelsius(mt, bank_data[bank->id].sensors[i], raw);
> > +
> > +		/*
> > +		 * The first read of a sensor often contains very high bogus
> > +		 * temperature value. Filter these out so that the system does
> > +		 * not immediately shut down.
> > +		 */
> > +		if (temp > 200000)
> > +			temp = 0;
> > +
> > +		if (temp > max)
> > +			max = temp;
> > +	}
> > +
> > +	return max;
> > +}
> > +
> > +static int mtk_read_temp(void *data, int *temperature)
> > +{
> > +	struct mtk_thermal *mt = data;
> > +	int i;
> > +	int tempmax = INT_MIN;
> > +
> > +	for (i = 0; i < MT8173_NUM_ZONES; i++) {
> > +		struct mtk_thermal_bank *bank = &mt->banks[i];
> > +		int t;
> > +
> > +		mtk_thermal_get_bank(bank);
> > +
> > +		t = mtk_thermal_bank_temperature(bank);
> 
> IIUIC, when you had multiple thermal zones
> mtk_thermal_bank_temperature() made sense, but now it looks like
> you're just doing the maximum of all sensors.  Why bother with the
> banks any more?  Aren't you just calculating the maximum of all
> sensors?  As TS2 is present in all banks, there's no point in reading
> it four times just to get the maximum of all sensors.
> 

Yeah, agreed here. If that is your intention, maybe read each sensor one
time, then compute the max of each subset from memory instead.

> > +		mtk_thermal_put_bank(bank);
> > +
> > +		if (t > tempmax)
> > +			tempmax = t;
> > +	}
> > +
> > +	*temperature = tempmax;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
> > +	.get_temp = mtk_read_temp,
> > +};
> 
> Cheers,
> Javi
> 
