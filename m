From: "Narendran Rajan" <nrajan@codeaurora.com>
Subject: RE: [PATCH] thermal: Add msm tsens thermal sensor driver
Date: Thu, 29 Jan 2015 17:36:35 -0800
Message-ID: <001601d03c2d$2fd57ea0$8f807be0$@codeaurora.com>
References: <1422331786-19620-1-git-send-email-nrajan@codeaurora.org> <20150129014621.GB23506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150129014621.GB23506@codeaurora.org>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Stephen Boyd' <sboyd@codeaurora.org>, 'Narendran Rajan' <nrajan@codeaurora.org>
Cc: 'Zhang Rui' <rui.zhang@intel.com>, 'Eduardo Valentin' <edubezval@gmail.com>, 'Linux ARM MSM' <linux-arm-msm@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Siddartha Mohanadoss' <smohanad@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Thank you Stephen for the detail comments.

> -----Original Message-----
> From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
> owner@vger.kernel.org] On Behalf Of Stephen Boyd
> Sent: Wednesday, January 28, 2015 5:46 PM
> To: Narendran Rajan
> Cc: Zhang Rui; Eduardo Valentin; Linux ARM MSM; Linux PM; Siddartha
> Mohanadoss
> Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
> 
> On 01/26, Narendran Rajan wrote:
> > TSENS supports reading temperature from multiple thermal sensors
> > present in QCOM SOCs.
> > TSENS HW is enabled only when the main sensor is requested.
> > The TSENS block is disabled if the main senors is disabled
> > irrespective of any other sensors that are being enabled.
> > TSENS driver supports configurable threshold for temperature
> > monitoring in which case it can generate an interrupt when specific
> > thresholds are reached
> >
> > Based on code by Siddartha Mohanadoss and Stephen Boyd.
> 
> So as far as I can tell you removed my loop TODOs, added debug prints and
> the device singleton, put the calibration data offset into DT (another
TODO),
> used regmap on the qfprom, made this into a standalone device instead of a
> child of GCC, and moved to OF thermal zones (forcing that
> THERMAL_TSENS8960_HWTRIPS ifdef I
> suppose?) Anything else?
>

Let me please know if you prefer a different attribution, would be glad to
add.
 
> >
> > Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Narendran Rajan  <nrajan@codeaurora.org>
> 
> Something is wrong with your git. There should only be one space between
> your name and the email id.
> 

Good eyes :-)
Thx, I did notice just after a I sent the mail. Fixed it internally, will be
corrected in next patch.

> > ---
> > diff --git a/drivers/thermal/msm8960_tsens.c
> > b/drivers/thermal/msm8960_tsens.c new file mode 100644 index
> > 0000000..307bdc8
> > --- /dev/null
> > +++ b/drivers/thermal/msm8960_tsens.c
> > +
> > +static u32 tsens_hi_code(int trip, u32 reg_cntl, u32 thresh) {
> > +	u32 hi_code;
> > +
> > +	switch (trip) {
> > +	case TSENS_TRIP_STAGE0:
> > +		if (!(reg_cntl & TSENS_LOWER_STATUS_CLR)) {
> > +			hi_code = thresh >>
> TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
> > +			break;
> > +		}
> > +		/* else fall through */
> > +	case TSENS_TRIP_STAGE1:
> > +		if (!(reg_cntl & TSENS_UPPER_STATUS_CLR)) {
> > +			hi_code = thresh >>
> TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
> > +			break;
> > +		}
> > +		/* else fall through */
> > +	case TSENS_TRIP_STAGE2:
> > +		if (!(reg_cntl & TSENS_MAX_STATUS_MASK)) {
> > +			hi_code = thresh >>
> TSENS_THRESHOLD_MAX_LIMIT_SHIFT;
> > +			break;
> > +		}
> > +		/* else fall through */
> > +	case TSENS_TRIP_STAGE3:
> > +	default:
> > +		hi_code = TSENS_THRESHOLD_MAX_CODE;
> > +		break;
> > +	}
> > +
> > +	return hi_code & TSENS_THRESHOLD_MAX_CODE; }
> > +
> > +static u32 tsens_lo_code(int trip, u32 reg_cntl, u32 thresh) {
> > +	u32 lo_code;
> > +
> > +	switch (trip) {
> > +	case TSENS_TRIP_STAGE3:
> > +		if (!(reg_cntl & TSENS_UPPER_STATUS_CLR)) {
> > +			lo_code = thresh >>
> TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
> > +			break;
> > +		}
> > +		/* else fall through */
> > +	case TSENS_TRIP_STAGE2:
> > +		if (!(reg_cntl & TSENS_LOWER_STATUS_CLR)) {
> > +			lo_code = thresh >>
> TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
> > +			break;
> > +		}
> > +		/* else fall through */
> > +	case TSENS_TRIP_STAGE1:
> > +		if (!(reg_cntl & TSENS_MIN_STATUS_MASK)) {
> > +			lo_code = thresh >>
> TSENS_THRESHOLD_MIN_LIMIT_SHIFT;
> > +			break;
> > +		}
> > +		/* else fall through */
> > +	case TSENS_TRIP_STAGE0:
> > +	default:
> > +		lo_code = TSENS_THRESHOLD_MIN_CODE;
> > +		break;
> > +	}
> > +
> > +	return lo_code & TSENS_THRESHOLD_MAX_CODE; }
> 
> I wonder if these can be loops, or something on top of find_next_bit()?
> That's what my TODO was about, hoping to reduce these functions even
> further.
> 
This looked pretty readable enough. Let me see find_next_bit helps. Thx

> > +
> > +static int tsens_tz_set_trip_temp(struct tsens_sensor *tm_sensor,
> > +	int trip, unsigned long temp)
> > +{
> > +	struct tsens_device *tmdev = tm_sensor->tmdev;
> > +	struct regmap_field *status = tmdev->status_field;
> > +	u32 thresh, reg_cntl, mask = TSENS_THRESHOLD_MAX_CODE;
> > +	u32 code, hi_code, lo_code, code_err_chk;
> > +
> > +	code_err_chk = code = tsens_tz_mdegC_to_code(temp,
> tm_sensor);
> > +
> > +	regmap_field_read(status, &reg_cntl);
> > +	regmap_read(tmdev->map, TSENS_THRESHOLD_ADDR, &thresh);
> > +
> > +	switch (trip) {
> > +	case TSENS_TRIP_STAGE3:
> > +		code <<= TSENS_THRESHOLD_MAX_LIMIT_SHIFT;
> > +		mask <<= TSENS_THRESHOLD_MAX_LIMIT_SHIFT;
> > +		break;
> > +	case TSENS_TRIP_STAGE2:
> > +		code <<= TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
> > +		mask <<= TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
> > +		break;
> > +	case TSENS_TRIP_STAGE1:
> > +		code <<= TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
> > +		mask <<= TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
> > +		break;
> > +	case TSENS_TRIP_STAGE0:
> > +		code <<= TSENS_THRESHOLD_MIN_LIMIT_SHIFT;
> > +		mask <<= TSENS_THRESHOLD_MIN_LIMIT_SHIFT;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	hi_code = tsens_hi_code(trip, reg_cntl, thresh);
> > +	lo_code = tsens_lo_code(trip, reg_cntl, thresh);
> > +
> > +	if (code_err_chk < lo_code || code_err_chk > hi_code)
> > +		return -EINVAL;
> > +
> > +	regmap_update_bits(tmdev->map, TSENS_THRESHOLD_ADDR,
> mask, code);
> > +
> > +	return 0;
> > +}
> > +
> > +static int tsens_set_trips(void *_sensor, long low, long high)
> 
> Is this function even used?
> 

Yes, only when HW trip path is present.  Let me remove this as you suggested
in previous comment 
And have only polling mode.

> > +{
> > +	struct tsens_sensor *tm_sensor = _sensor;
> > +
> > +	tsens_print_trip_temp(tm_sensor);
> > +
> > +	if (tsens_tz_set_trip_temp(tm_sensor, TSENS_TRIP_STAGE2, high))
> > +		return -EINVAL;
> > +
> > +	if (tsens_tz_set_trip_temp(tm_sensor, TSENS_TRIP_STAGE1, low))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static void tsens_scheduler_fn(struct work_struct *work) {
> > +	struct tsens_device *tmdev;
> > +	struct regmap_field *status;
> > +	unsigned int threshold, threshold_low, i, code, bits, mask = 0;
> > +	unsigned long sensor;
> > +	bool upper_th_x, lower_th_x;
> > +
> > +	tmdev = container_of(work, struct tsens_device, tsens_work);
> > +	status = tmdev->status_field;
> > +
> > +	regmap_field_update_bits(status,
> > +			TSENS_LOWER_STATUS_CLR |
> TSENS_UPPER_STATUS_CLR,
> > +			TSENS_LOWER_STATUS_CLR |
> TSENS_UPPER_STATUS_CLR);
> > +
> > +	regmap_read(tmdev->map, TSENS_THRESHOLD_ADDR, &threshold);
> > +	threshold_low = threshold >>
> TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
> > +	threshold_low &= TSENS_THRESHOLD_MAX_CODE;
> > +	threshold = threshold >> TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
> > +	threshold &= TSENS_THRESHOLD_MAX_CODE;
> > +
> > +	regmap_read(tmdev->map, TSENS_CNTL_ADDR, &bits);
> > +	sensor = bits;
> > +	sensor >>= TSENS_SENSOR0_SHIFT;
> > +	for_each_set_bit(i, &sensor, tmdev->num_sensors) {
> > +		regmap_read(tmdev->map, tmdev->sensor[i].status,
> &code);
> > +		upper_th_x = code >= threshold;
> > +		lower_th_x = code <= threshold_low;
> > +
> > +		if (upper_th_x)
> > +			mask |= TSENS_UPPER_STATUS_CLR;
> > +
> > +		if (lower_th_x)
> > +			mask |= TSENS_LOWER_STATUS_CLR;
> > +
> > +#ifdef THERMAL_TSENS8960_HWTRIPS
> > +		if (upper_th_x || lower_th_x) {
> > +			dev_info(tsens_dev,
> > +				"Threshold reached for sensor(%d)\n", i);
> 
> This looks like debug noise. Please remove.

Will do (in fact plan to remove interrupt mode completely)
> 
> > +			thermal_zone_device_update(tmdev-
> >sensor[i].tz_dev);
> > +		}
> > +#endif
> > +	}
> > +
> > +	regmap_field_update_bits(status,
> > +			TSENS_UPPER_STATUS_CLR |
> TSENS_LOWER_STATUS_CLR, mask); }
> > +
> > +static irqreturn_t tsens_isr(int irq, void *data) {
> > +	schedule_work(data);
> 
> I was going to move this to threaded irqs, please do that.
> 
I guess in a polling mode, this will not be needed. Will remove this
completely.

> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void tsens_disable_mode(const struct tsens_device *tmdev) {
> > +	u32 reg_cntl;
> > +	u32 mask;
> > +
> > +	mask = GENMASK(tmdev->num_sensors - 1, 0);
> > +	mask <<= TSENS_SENSOR0_SHIFT;
> > +	mask |= TSENS_EN;
> > +
> > +	regmap_read(tmdev->map, TSENS_CNTL_ADDR, &reg_cntl);
> > +	reg_cntl &= ~mask;
> > +	if (tmdev->num_sensors > 1)
> > +		reg_cntl &= ~TSENS_8960_SLP_CLK_ENA;
> > +	else
> > +		reg_cntl &= ~TSENS_8660_SLP_CLK_ENA;
> > +	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg_cntl); }
> > +
> > +static void tsens_hw_init(struct tsens_device *tmdev) {
> > +	u32 reg_cntl, reg_thr;
> > +
> > +	reg_cntl = TSENS_SW_RST;
> > +	regmap_update_bits(tmdev->map, TSENS_CNTL_ADDR,
> TSENS_SW_RST,
> > +reg_cntl);
> > +
> > +	if (tmdev->num_sensors > 1) {
> > +		reg_cntl |= TSENS_8960_SLP_CLK_ENA |
> > +			(TSENS_MEASURE_PERIOD << 18);
> 
> Unnecessary ()?

Ok, Srini also wanted not to hardcode '18' (and '16' below). Will redefine
TSENS_MEASURE_PERIOD_8960 as BIT(18)

> 
> > +		reg_cntl &= ~TSENS_SW_RST;
> > +		regmap_update_bits(tmdev->map,
> TSENS_8960_CONFIG_ADDR,
> > +				   TSENS_8960_CONFIG_MASK,
> TSENS_8960_CONFIG);
> > +	} else {
> > +		reg_cntl |= TSENS_8660_SLP_CLK_ENA |
> > +			(TSENS_MEASURE_PERIOD << 16);
> 
> Unnecessary ()?


Ok, Srini also wanted not to hardcode '18' (and '16' below). Will redefine
TSENS_MEASURE_PERIOD_8960 as BIT(16)

> 
> > +		reg_cntl &= ~TSENS_8660_CONFIG_MASK;
> > +		reg_cntl |= TSENS_8660_CONFIG <<
> TSENS_8660_CONFIG_SHIFT;
> > +	}
> > +
> > +	reg_cntl |= GENMASK(tmdev->num_sensors - 1, 0) <<
> TSENS_SENSOR0_SHIFT;
> > +	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg_cntl);
> > +
> > +	regmap_field_update_bits(tmdev->status_field,
> > +			TSENS_LOWER_STATUS_CLR |
> TSENS_UPPER_STATUS_CLR |
> > +			TSENS_MIN_STATUS_MASK |
> TSENS_MAX_STATUS_MASK,
> > +			TSENS_LOWER_STATUS_CLR |
> TSENS_UPPER_STATUS_CLR |
> > +			TSENS_MIN_STATUS_MASK |
> TSENS_MAX_STATUS_MASK);
> > +
> > +	reg_cntl |= TSENS_EN;
> > +	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg_cntl);
> > +
> > +	reg_thr = (TSENS_LOWER_LIMIT_TH <<
> TSENS_THRESHOLD_LOWER_LIMIT_SHIFT) |
> > +		(TSENS_UPPER_LIMIT_TH <<
> TSENS_THRESHOLD_UPPER_LIMIT_SHIFT) |
> > +		(TSENS_MIN_LIMIT_TH <<
> TSENS_THRESHOLD_MIN_LIMIT_SHIFT) |
> > +		(TSENS_MAX_LIMIT_TH <<
> TSENS_THRESHOLD_MAX_LIMIT_SHIFT);
> > +	regmap_write(tmdev->map, TSENS_THRESHOLD_ADDR, reg_thr); }
> > +
> > +static int
> > +tsens_calib_sensors8660(struct tsens_device *tmdev, struct regmap
> > +*map) {
> > +	u32 temp_data, data;
> > +	struct tsens_sensor *s = &tmdev->sensor[0];
> > +
> > +	if (regmap_read(map, tmdev->calib_offset, &temp_data))
> > +		return -EINVAL;
> > +
> > +	data = (temp_data >> 24) & 0xff;
> > +
> > +	if (!data) {
> > +		dev_err(tsens_dev, "QFPROM TSENS calibration data not
> present\n");
> 
> Ah we do use it for an error here. It isn't hard to put a struct device
inside
> tmdev...

Agree (did look around some drivers and they seem to have used). Anyways, I
agree
It's a bad practice. Will correct

> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	s->offset = TSENS_CAL_MDEGC - s->slope * data;
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +tsens_calib_sensors8960(struct tsens_device *tmdev, struct regmap
> > +*map) {
> > +	int i;
> > +	u32 temp_data[TSENS_MAX_SENSORS];
> > +	u8 *byte_data;
> > +	u32 fuse, redun, num_read;
> > +	struct tsens_sensor *s = tmdev->sensor;
> > +
> > +	fuse = tmdev->calib_offset;
> > +	redun = tmdev->backup_calib_offset;
> > +
> > +	/**
> > +	* syscon regmap is 32-bit data, but calibration data is 8-bit.
> > +	* read 4 bytes from regmap in a loop and then extract bytes
> seprately
> > +	*/
> 
> Weird comment style. Please do it like
> 

Thx. Will correct.

>  /*
>   * This because this isn't kernel-doc.
>   */
> 
> > +
> > +	num_read = DIV_ROUND_UP(tmdev->num_sensors, 4);
> > +
> > +	for (i = 0; i < num_read; i++) {
> > +		if (regmap_read(map, (redun + i*4), &temp_data[i]))
> > +			return -EINVAL;
> > +
> > +		if (!temp_data[i]) {
> > +			dev_dbg(tsens_dev, "Main calib data not valid\n");
> > +			if (regmap_read(map, (fuse + i*4), &temp_data[i]))
> > +				return -EINVAL;
> > +		}
> > +	}
> > +
> > +	byte_data = (u8 *)temp_data;
> > +
> > +	for (i = 0; i < tmdev->num_sensors; i++, s++) {
> > +		s->offset = TSENS_CAL_MDEGC - s->slope * byte_data[i];
> > +		dev_dbg(tsens_dev, "calib data %d is %c", i, byte_data[i]);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> This is a lot of hoops to jump through just to use a syscon regmap (does
this
> even work in big-endian mode?). Given your point about consumers wanting
> to read with different strides makes me think that using a regmap is not a
> good idea. It would be better if we had an API that could be used to read
an
> arbitrary number of bytes from an eeprom.
>

I guess Srini's solution is elegant enough. It allows to set stride values
and then helper 
Functions to read the number of bytes needed.
 
> > +
> > +static const struct thermal_zone_of_device_ops tsens_thermal_of_ops =
> {
> > +	.get_temp = tsens_tz_get_temp,
> > +};
> > +
> > +
> 
> Nitpick: Two newlines instead of one.
> 
> > +static int tsens_register(struct tsens_device *tmdev, int i) {
> > +	char name[18];
> > +	u32 addr = TSENS_S0_STATUS_ADDR;
> > +	struct tsens_sensor *s = &tmdev->sensor[i];
> > +
> > +	/*
> > +	* The status registers for each sensor are discontiguous
> > +	* because some SoCs have 5 sensors while others have more
> > +	* but the control registers stay in the same place, i.e.
> > +	* directly after the first 5 status registers.
> > +	*/
> > +	if (i >= 5)
> > +		addr += 40;
> > +
> > +	addr += i * 4;
> > +
> > +	snprintf(name, sizeof(name), "tsens_tz_sensor%d", i);
> > +	s->mode = THERMAL_DEVICE_ENABLED;
> > +	s->sensor_num = i;
> > +	s->status = addr;
> > +	s->tmdev = tmdev;
> > +	s->tz_dev = thermal_zone_of_sensor_register(tsens_dev, i, s,
> > +						&tsens_thermal_of_ops);
> > +
> > +	if (IS_ERR(s->tz_dev))
> > +		return -ENODEV;
> 
> So if it's an error pointer we leave it there? And then if an interrupt
arrives
> and this sensor has a new temperature to report we'll update the thermal
> framework with an invalid pointer? When I wrote this code I didn't allow
> probe to continue if any of these zones failed to register. Why change
that
> because we're using the sensor API?
> 

When the registration fails, the sensor is not enabled (its explicitly
disabled in the code). 
The interrupts by design is common across all sensors. Primary sensor
registration fail means
Probe fail and the code deregisters from thermal framework.

The registration of other sensors can fail as there may not a dt entry for
that sensor. 
This is valid in mind as the system integrator may prefer (based on thermal
profiling) to enable
only a few sensors out of total N and monitor only them.

> > +
> > +	return 0;
> > +}
> > +
> > +static int tsens_probe(struct platform_device *pdev) {
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct device_node *base_node;
> > +	struct platform_device *base_pdev;
> > +	int ret, i, irq, num;
> > +	struct tsens_sensor *s;
> > +	struct tsens_device *tmdev;
> > +	struct regmap *map, *imem_regmap;
> > +	struct reg_field *field;
> > +	static struct reg_field status_0 = {
> > +		.reg = TSENS_8064_STATUS_CNTL,
> > +		.lsb = 0,
> > +		.msb = 3,
> > +	};
> > +	static struct reg_field status_8 = {
> > +		.reg = TSENS_CNTL_ADDR,
> > +		.lsb = 8,
> > +		.msb = 11,
> > +	};
> > +
> > +	tsens_dev = &pdev->dev;
> > +
> > +	num = of_property_count_u32_elems(np, "qcom,tsens-slopes");
> > +	if (num <= 0) {
> > +		dev_err(tsens_dev, "invalid tsens slopes\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	tmdev = devm_kzalloc(tsens_dev, sizeof(*tmdev) +
> > +			     num * sizeof(struct tsens_sensor), GFP_KERNEL);
> > +	if (tmdev == NULL)
> > +		return -ENOMEM;
> > +
> > +	tmdev->num_sensors = num;
> > +	for (i = 0, s = tmdev->sensor; i < num; i++, s++)
> > +		of_property_read_u32_index(np, "qcom,tsens-slopes", i,
> > +					   &s->slope);
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(tsens_dev,  "no irq resource?\n");
> > +		return  -EINVAL;
> > +	}
> > +
> > +	ret = of_property_read_u32_index(np, "qcom,calib-offsets", 0,
> > +					   &tmdev->calib_offset);
> > +	if (ret != 0) {
> > +		dev_err(tsens_dev,  "No calibration offset set\n");
> > +		return  -EINVAL;
> > +	}
> > +
> > +	ret = of_property_read_u32_index(np, "qcom,calib-offsets", 1,
> > +					   &tmdev->backup_calib_offset);
> > +	if (ret) {
> > +		dev_info(tsens_dev, "Missing backup calibration offset\n");
> 
> Why make any noise at all? A backup is here.

Ok, will move to dbg.
> 
> > +		tmdev->backup_calib_offset = tmdev->calib_offset;
> > +	}
> > +
> > +	imem_regmap = syscon_regmap_lookup_by_phandle(np,
> "qcom,imem");
> > +	if (IS_ERR(imem_regmap)) {
> > +		dev_err(tsens_dev, "syscon regmap look up error\n");
> > +		return PTR_ERR(imem_regmap);
> > +	}
> > +
> > +	if (num == 1)
> > +		ret = tsens_calib_sensors8660(tmdev, imem_regmap);
> > +	else
> > +		ret = tsens_calib_sensors8960(tmdev, imem_regmap);
> > +
> > +	if (ret < 0) {
> > +		dev_err(tsens_dev, "tsense calibration failed\n");
> > +		return ret;
> > +	}
> > +
> > +	base_node = of_parse_phandle(np, "qcom,tsens-base", 0);
> > +	if (base_node == NULL) {
> 
> Kernel style is typically
> 

Thx, will correct

>  if (!base_node)
> 
> > +		dev_err(tsens_dev, "no base node present\n");
> > +		return  -EINVAL;
> > +	}
> > +
> > +	base_pdev = of_find_device_by_node(base_node);
> > +	if (base_pdev == NULL) {
> > +		dev_err(tsens_dev, "no base pdev node\n");
> > +		return  -ENODEV;
> > +	}
> > +
> > +	tmdev->map = map = dev_get_regmap(&base_pdev->dev, NULL);
> > +	if (map == NULL) {
> > +		dev_err(tsens_dev, "base regmap get failed\n");
> > +		return  -ENODEV;
> > +	}
> > +
> > +	/* Status bits move when the sensor bits next to them overlap */
> > +	if (num > 5)
> > +		field = &status_0;
> > +	else
> > +		field = &status_8;
> > +
> > +	tmdev->status_field = devm_regmap_field_alloc(tsens_dev, map,
> *field);
> > +	if (IS_ERR(tmdev->status_field)) {
> > +		dev_err(tsens_dev, "regmap alloc failed\n");
> > +		return PTR_ERR(tmdev->status_field);
> > +	}
> > +
> > +	tsens_hw_init(tmdev);
> > +
> > +	/*
> > +	 * Register sensor 0 separately. This sensor is always
> > +	 * expected to be present and if this fails, thermal
> > +	 * sensor probe would fail
> > +	 * Other sensors are optional and if registration fails
> > +	 * disable the sensor and continue
> > +	*/
> > +	ret = tsens_register(tmdev, 0);
> > +	if (ret < 0) {
> > +		dev_err(tsens_dev, "Registering failed for primary sensor");
> > +		ret = -ENODEV;
> > +		goto fail;
> > +	} else {
> > +		tsens_tz_set_mode(&tmdev->sensor[0],
> THERMAL_DEVICE_ENABLED);
> > +	}
> > +
> > +	for (i = 1;  i < tmdev->num_sensors; i++) {
> > +		ret = tsens_register(tmdev, i);
> > +
> > +		if (ret < 0) {
> > +			dev_err(tsens_dev,
> > +				"Registering failed. Sensor(%i), disabled",
i);
> 
> Missing newline...

Thx, will fix

> 
> > +			tsens_tz_set_mode(&tmdev->sensor[i],
> > +				THERMAL_DEVICE_DISABLED);
> 
> Does this do anything? The mode is already THERMAL_DEVICE_DISABLED so I
> imagine it just bails out immediately?

Didn't want to rely on default.  As noted above, the registration for non
Primary sensors are allowed to fail and the driver just mark those sensors 
As disabled and continue.

> 
> > +		} else {
> > +			tsens_tz_set_mode(&tmdev->sensor[i],
> > +				THERMAL_DEVICE_ENABLED);
> > +		}
> > +	}
> > +
> > +	INIT_WORK(&tmdev->tsens_work, tsens_scheduler_fn);
> > +
> > +	ret = devm_request_irq(tsens_dev, irq, tsens_isr,
> IRQF_TRIGGER_RISING,
> > +			       "tsens", &tmdev->tsens_work);
> > +	if (ret < 0)
> > +		goto err_irq;
> > +
> > +	platform_set_drvdata(pdev, tmdev);
> > +
> > +	dev_info(tsens_dev, "Tsens driver initialized\n");
> 
> Please remove.
> 

Less boot up noise ? Ok.

> > +
> > +	return 0;
> > +err_irq:
> > +	for (i = 0, s = tmdev->sensor; i < tmdev->num_sensors; i++, s++)
> 
> I should have made this simpler like:
> 
>   for (s = tmdev->sensor; s < tmdev->sensor + tmdev->num_sensors; s++)
> 
> > +		thermal_zone_of_sensor_unregister(&pdev->dev, s-
> >tz_dev);
> > +fail:
> > +	tsens_disable_mode(tmdev);
> > +	return ret;
> > +}
> > +
> > +static int tsens_remove(struct platform_device *pdev) {
> > +	int i;
> 
> Because then we can save a whole variable here.
> 
> > +	struct tsens_sensor *s;
> > +	struct tsens_device *tmdev = platform_get_drvdata(pdev);
> > +
> > +	tsens_disable_mode(tmdev);
> > +	for (i = 0, s = tmdev->sensor; i < tmdev->num_sensors; i++, s++)
> > +		thermal_zone_device_unregister(s->tz_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct of_device_id tsens_match_table[] = {
> > +	{.compatible = "qcom,ipq806x-tsens"},
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, tsens_match_table);
> 
> I would prefer we leave it as a child of GCC like I had done in my
original
> patch. The one ugly part was passing the DT node to the virtual tsens
device
> so that it could figure out the number of sensors, etc. We should be able
to
> fix that by creating the device, assigning the of_node, and then
registering
> the device with the platform bus.
> 

Ok - personally the existing one looked cleaner, but I agree with both you
and Srini.
Will change to GCC child node.

> > +
> > +static struct platform_driver tsens_driver = {
> > +	.probe = tsens_probe,
> > +	.remove = tsens_remove,
> > +	.driver = {
> > +		.of_match_table = tsens_match_table,
> > +		.name = "tsens8960-thermal",
> 
> A better name may be tsens-tm or qcom-tsens. The same version of the
> hardware exists in so many different SoCs there really isn't anything SoC
> specific about the hardware. The SoC difference is almost entirely in the
> qfprom layout, except for when the hw engineers decide to put a different
> number of sensors on the chip. The same comment applies to the file name.
> Probably qcom-tsens.c or something.
>

Looks like this is the consensus, so will change to qcom-tsens.

> > +		.owner = THIS_MODULE,
> > +#ifdef CONFIG_PM
> > +		.pm	= &tsens_pm_ops,
> > +#endif
> > +	},
> > +};
> > +module_platform_driver(tsens_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Temperature Sensor driver");
> > +MODULE_ALIAS("platform:tsens8960-tm");
> 
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
