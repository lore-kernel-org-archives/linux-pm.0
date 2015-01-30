From: "Narendran Rajan" <nrajan@codeaurora.com>
Subject: RE: [PATCH] thermal: Add msm tsens thermal sensor driver
Date: Thu, 29 Jan 2015 16:52:39 -0800
Message-ID: <000e01d03c27$0c8a5d90$259f18b0$@codeaurora.com>
References: <1422331786-19620-1-git-send-email-nrajan@codeaurora.org> <54C73B0B.609@linaro.org> <002f01d03a81$07fabf10$17f03d30$@codeaurora.com> <54C9CDB3.2070008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:38319 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbbA3Awm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 19:52:42 -0500
In-Reply-To: <54C9CDB3.2070008@linaro.org>
Content-Language: en-us
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Srinivas Kandagatla' <srinivas.kandagatla@linaro.org>, 'Narendran Rajan' <nrajan@codeaurora.org>, 'Zhang Rui' <rui.zhang@intel.com>, 'Eduardo Valentin' <edubezval@gmail.com>
Cc: 'Linux ARM MSM' <linux-arm-msm@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Siddartha Mohanadoss' <smohanad@codeaurora.org>, 'Stephen Boyd' <sboyd@codeaurora.org>


> -----Original Message-----
> From: Srinivas Kandagatla [mailto:srinivas.kandagatla@linaro.org]
> Sent: Wednesday, January 28, 2015 10:06 PM
> To: Narendran Rajan; 'Narendran Rajan'; 'Zhang Rui'; 'Eduardo Valentin'
> Cc: 'Linux ARM MSM'; 'Linux PM'; 'Siddartha Mohanadoss'; 'Stephen Boyd'
> Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
> 
> 
> 
> On 27/01/15 22:31, Narendran Rajan wrote:
> >
> >> -----Original Message-----
> >> From: Srinivas Kandagatla [mailto:srinivas.kandagatla@linaro.org]
> >> Sent: Monday, January 26, 2015 11:15 PM
> >> To: Narendran Rajan; Zhang Rui; Eduardo Valentin
> >> Cc: Linux ARM MSM; Linux PM; Siddartha Mohanadoss; Stephen Boyd
> >> Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
> >>
> >> Thankyou for sending the patch..
> >> here are some comments
> >>
> >
> > Thanks Srini for the detail review.
> >
> >> On 27/01/15 04:09, Narendran Rajan wrote:
> >> ...
> >>
> ...
> 
> >>
> >>> +#include <linux/io.h>
> >>> +#include <linux/mfd/syscon.h>
> >>> +
> >>> +/* Trips: from very hot to very cold */ enum tsens_trip_type {
> >>> +	TSENS_TRIP_STAGE3,
> >>> +	TSENS_TRIP_STAGE2,
> >>> +	TSENS_TRIP_STAGE1,
> >>> +	TSENS_TRIP_STAGE0,
> >>> +	TSENS_TRIP_NUM,
> >>> +};
> >> Do you need this if trips are actually coming from DT?
> >>
> >
> > Yes, for HW driven trip points. This feature still under development
> > in the core framework.
> > Please see https://patchwork.ozlabs.org/patch/364812/
> >
> > I should have added this under THERMAL_TSENS8960_HWTRIPS as rest of
> > the code.  Thx
> >
> >>> +
> >>> +#define TSENS_CAL_MDEGC				30000
> >>> +
> >>> +#define TSENS_MAX_SENSORS			11
> >>> +
> >>> +#define TSENS_8960_CONFIG_ADDR			0x3640
> >>> +#define TSENS_8960_CONFIG			0x9b
> >>> +#define TSENS_8960_CONFIG_MASK			0xf
> >>> +
> >>> +#define TSENS_CNTL_ADDR				0x3620
> >>> +#define TSENS_CNTL_RESUME_MASK			0xfffffff9
> >>> +#define TSENS_EN				BIT(0)
> >>> +#define TSENS_SW_RST				BIT(1)
> >>> +#define SENSOR0_EN				BIT(3)
> >>> +#define TSENS_MIN_STATUS_MASK			BIT(0)
> >>> +#define TSENS_LOWER_STATUS_CLR			BIT(1)
> >>> +#define TSENS_UPPER_STATUS_CLR			BIT(2)
> >>> +#define TSENS_MAX_STATUS_MASK			BIT(3)
> >>> +#define TSENS_MEASURE_PERIOD			1
> >>> +#define TSENS_8960_SLP_CLK_ENA			BIT(26)
> >>> +#define TSENS_8660_SLP_CLK_ENA			BIT(24)
> >>> +#define TSENS_8064_STATUS_CNTL			0x3660
> >>> +
> >>> +#define TSENS_THRESHOLD_ADDR			0x3624
> >>> +#define TSENS_THRESHOLD_MAX_CODE		0xff
> >>> +#define TSENS_THRESHOLD_MIN_CODE		0
> >>> +#define TSENS_THRESHOLD_MAX_LIMIT_SHIFT		24
> >>> +#define TSENS_THRESHOLD_MIN_LIMIT_SHIFT		16
> >>> +#define TSENS_THRESHOLD_UPPER_LIMIT_SHIFT	8
> >>> +#define TSENS_THRESHOLD_LOWER_LIMIT_SHIFT	0
> >>> +
> >>> +/* Initial temperature threshold values */
> >>> +#define TSENS_LOWER_LIMIT_TH			0x50
> >>> +#define TSENS_UPPER_LIMIT_TH			0xdf
> >>> +#define TSENS_MIN_LIMIT_TH			0x0
> >>> +#define TSENS_MAX_LIMIT_TH			0xff
> >>> +
> >>> +#define TSENS_S0_STATUS_ADDR			0x3628
> >>> +
> >>> +#define TSENS_INT_STATUS_ADDR			0x363c
> >>> +#define TSENS_LOWER_INT_MASK			BIT(1)
> >>> +#define TSENS_UPPER_INT_MASK			BIT(2)
> >>> +#define TSENS_MAX_INT_MASK			BIT(3)
> >>> +#define TSENS_TRDY_MASK				BIT(7)
> >>> +
> >>> +#define TSENS_SENSOR_SHIFT			16
> >>> +#define TSENS_REDUND_SHIFT			24
> >>> +#define TSENS_SENSOR0_SHIFT			3
> >>> +
> >>> +#define TSENS_8660_QFPROM_ADDR			0x00bc
> >> ?? Why is this offset defined in the driver, Is'nt this supposed to
> >> come
> > via dt?
> 
> ???

Correct, needs to be removed.

> >>> +#define TSENS_8660_CONFIG			1
> >>> +#define TSENS_8660_CONFIG_SHIFT			28
> >>> +#define TSENS_8660_CONFIG_MASK			(3 <<
> >> TSENS_8660_CONFIG_SHIFT)
> >>> +
> >>> +struct tsens_device;
> >>> +
> >>> +struct tsens_sensor {
> >>> +	struct thermal_zone_device	*tz_dev;
> >>> +	enum thermal_device_mode	mode;
> >>> +	unsigned int			sensor_num;
> >>> +	int				offset;
> >>> +	u32				slope;
> >>> +	struct tsens_device		*tmdev;
> >>> +	u32                             status;
> >>> +};
> >>> +
> >>> +struct tsens_device {
> >>> +	bool			prev_reading_avail;
> >>> +	unsigned int		num_sensors;
> >>> +	int			pm_tsens_thr_data;
> >>> +	int			pm_tsens_cntl;
> >>> +	unsigned int            calib_offset;
> >>> +	unsigned int            backup_calib_offset;
> >>> +	struct work_struct	tsens_work;
> >>> +	struct regmap		*map;
> >>> +	struct regmap_field	*status_field;
> >>> +	struct tsens_sensor	sensor[0];
> >>> +};
> >>> +
> >>> +static struct device *tsens_dev;
> >> Hmm.. I think you should remove this global variable and find a
> >> better way
> > to
> >> get hold of this.
> >>
> > Didn't find anything simple enough. A few other drivers seems to use
> > global as well. Will look around. If you have some quick tips let me
please
> know.
> 
> Add this to struct tsens_device.
> 

Thx, this would work.

> >
> ...
> 
> >>> +#ifdef THERMAL_TSENS8960_HWTRIPS
> >>
> >> Should this be a kernel config?
> >>    Or by default this should'nt be On?
> >> Do you need this code if the trip values are actually coming from DT?
> >>
> >
> > This feature need thermal core framework change as well.
> > This is not yet landed in upstream, but is used in some downstream
> > Kernels (like chrome kernel). Hence under #ifdef and disabled by
default.
> >
> 
> Am not sure if this is right thing to do it now, the email thread you
pointed to
> be last updated in 1st Aug 2014 .

Agree, the both Stephen and you have pointed out not to base the code on
this work.
Let me redo the patch to remove the dependency on HWTRIPs and have just a
polling based 
Solution.

> >>
> >>> +static int
> >>> +tsens_calib_sensors8960(struct tsens_device *tmdev, struct regmap
> >>> +*map) {
> >>> +	int i;
> >>> +	u32 temp_data[TSENS_MAX_SENSORS];
> >>> +	u8 *byte_data;
> >>> +	u32 fuse, redun, num_read;
> >>> +	struct tsens_sensor *s = tmdev->sensor;
> >>> +
> >>> +	fuse = tmdev->calib_offset;
> >>> +	redun = tmdev->backup_calib_offset;
> >>> +
> >>> +	/**
> >>> +	* syscon regmap is 32-bit data, but calibration data is 8-bit.
> >>> +	* read 4 bytes from regmap in a loop and then extract bytes
> >> seprately
> >>> +	*/
> >>> +
> >> It looks like workaround for the problem in syscon driver.
> >> Please use this patch to fix it.
> >>
> > Unfortunately, this won't work. The same imem region as read as 32-bit
> > for OPP table chip characterization. Looks like this workaround needs
> > to stay Please see the patch below for reference
> > https://chromium-review.googlesource.com/#/c/231792/6
> 
> Does'nt matter If we can read a byte we can also read a word, use
> regmap_read_bulk().
> 
> Again the big plan is to abstract the qfprom access this into something
like
> http://www.spinics.net/lists/linux-arm-msm/msg13090.html
> 
> This will take care of all the code related to qfprom in the drivers.
> Please have a look and give us some comments so that we know whats best.
> 
> ...

My mistake, stride solution is indeed elegant. I just need to put a patch to
change 
the above patch in reference to read 4 bytes.

> 
> >>> +
> >>> +static int tsens_register(struct tsens_device *tmdev, int i) {
> >>> +	char name[18];
> >>> +	u32 addr = TSENS_S0_STATUS_ADDR;
> >>> +	struct tsens_sensor *s = &tmdev->sensor[i];
> >>> +
> >>> +	/*
> >>> +	* The status registers for each sensor are discontiguous
> >>> +	* because some SoCs have 5 sensors while others have more
> >>> +	* but the control registers stay in the same place, i.e.
> >>> +	* directly after the first 5 status registers.
> >>> +	*/
> >>> +	if (i >= 5)
> >>> +		addr += 40;
> >>
> >> This magic values should be going in to some descriptive constants..
> >>
> > There is descriptive comment just above and this is not used anywhere
> else.
> > Perhaps this is easier to read?
> This seems to be like an register offset, So I would prefer it to be a
nice
> #define

Fair enough.

> >
> >>> +
> >>> +	addr += i * 4;
> >>> +
> >>> +	snprintf(name, sizeof(name), "tsens_tz_sensor%d", i);
> >> Hmm where is the name actually used??
> >
> > Oops, not needed in the of based registration. Will remove
> >
> >>
> >>> +	s->mode = THERMAL_DEVICE_ENABLED;
> >>> +	s->sensor_num = i;
> >>> +	s->status = addr;
> >>> +	s->tmdev = tmdev;
> >>> +	s->tz_dev = thermal_zone_of_sensor_register(tsens_dev, i, s,
> >>> +						&tsens_thermal_of_ops);
> >>> +
> >>> +	if (IS_ERR(s->tz_dev))
> >>> +		return -ENODEV;
> >> So does that mean that driver would not register tsens unless there
> >> is a
> > DT
> >> node for it?
> >> For apq8064 which has 11 sensors, its becomes necessary to add all 11
> >> sensors in DT with trip points and cooling devices. Which IMO is not
> > right.
> >> You could probably do something like:
> >>
> >> 	s->tz_dev = thermal_zone_of_sensor_register(tsens_dev, i, s,
> >> 					&tsens_thermal_of_ops);
> >>
> >> 	if (IS_ERR(s->tz_dev)) {
> >> 		s->tz_dev = thermal_zone_device_register( ... )
> >> 		if (IS_ERR(s->tz_dev))
> >> 			return -ENODEV;
> >> 	}
> >>
> >> same thing in faliure/remove case ..
> >>
> >
> > Not really. If you look at further down where tsens_register is called
> > (around ln 752), only primary register Is mandatory. If other sensor
> > registration fails, the code just  disables those sensors. Code
> > snipped pasted below
> 
> I think you missed my point.
> Ok, I agree sensor 0 is primary one and should always be registered.
> 
> What am saying is Lets say we have 11 sensors ex: in APQ8064.
> 
> Now we have got dt entries for sensor0 and sensor6.
> Your code would only register sensor0 and sensor6, because you only
> considered DT nodes.
> This is not correct, as we are not short of any resources to populate the
other
> 9 sensors. You should still register all the 11 sensors but 2 of them are
> comming from dt with there own trip point values and the rest of them are
> registered as regular non dt thermal sensors.
> 
> Doing this way would give the user to see all the sensors via sysfs If not
you
> are loosing the real value of all the 9 sensors in the system.
> 
> have a look at other drivers like TI you will understand what Am saying.
> 

Ah, thx for the clarification. 
Alternate thought : 
What if the system want to leverage only say 2 sensors out of 11. The user
has the flexibility 
to select the sensors by specifying this in the dt node. If I do what is
done in TI drivers, all sensors
get registered and polled regardless of this being used in the userspace
thermal daemon.

As a data point, the user-space daemon that exists seems to use only a sub
set of sensors.

> 
> > --------------------->cut<----------------------
> > 	/*
> > 	 * Register sensor 0 separately. This sensor is always
> > 	 * expected to be present and if this fails, thermal
> > 	 * sensor probe would fail
> > 	 * Other sensors are optional and if registration fails
> > 	 * disable the sensor and continue
> > 	*/
> > 	ret = tsens_register(tmdev, 0);
> > 	if (ret < 0) {
> > 		dev_err(tsens_dev, "Registering failed for primary sensor");
> > 		ret = -ENODEV;
> > 		goto fail;
> > 	} else {
> > 		tsens_tz_set_mode(&tmdev->sensor[0],
> > THERMAL_DEVICE_ENABLED);
> > 	}
> > --------------------->cut<----------------------
> >
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int tsens_probe(struct platform_device *pdev) {
> >>> +	struct device_node *np = pdev->dev.of_node;
> >>> +	struct device_node *base_node;
> >>> +	struct platform_device *base_pdev;
> >>> +	int ret, i, irq, num;
> >>> +	struct tsens_sensor *s;
> >>> +	struct tsens_device *tmdev;
> >>> +	struct regmap *map, *imem_regmap;
> >>> +	struct reg_field *field;
> >>> +	static struct reg_field status_0 = {
> >>> +		.reg = TSENS_8064_STATUS_CNTL,
> >>> +		.lsb = 0,
> >>> +		.msb = 3,
> >>> +	};
> >>> +	static struct reg_field status_8 = {
> >>> +		.reg = TSENS_CNTL_ADDR,
> >>> +		.lsb = 8,
> >>> +		.msb = 11,
> >>> +	};
> >>> +
> >>> +	tsens_dev = &pdev->dev;
> >>> +
> >>> +	num = of_property_count_u32_elems(np, "qcom,tsens-slopes");
> >>> +	if (num <= 0) {
> >>> +		dev_err(tsens_dev, "invalid tsens slopes\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	tmdev = devm_kzalloc(tsens_dev, sizeof(*tmdev) +
> >>> +			     num * sizeof(struct tsens_sensor), GFP_KERNEL);
> >>> +	if (tmdev == NULL)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	tmdev->num_sensors = num;
> >>> +	for (i = 0, s = tmdev->sensor; i < num; i++, s++)
> >>> +		of_property_read_u32_index(np, "qcom,tsens-slopes", i,
> >>> +					   &s->slope);
> >>> +
> >>> +	irq = platform_get_irq(pdev, 0);
> >>> +	if (irq < 0) {
> >>> +		dev_err(tsens_dev,  "no irq resource?\n");
> >>> +		return  -EINVAL;
> >>> +	}
> >>> +
> >>> +	ret = of_property_read_u32_index(np, "qcom,calib-offsets", 0,
> >>> +					   &tmdev->calib_offset);
> >>> +	if (ret != 0) {
> >>> +		dev_err(tsens_dev,  "No calibration offset set\n");
> >>> +		return  -EINVAL;
> >>> +	}
> >>> +
> >>> +	ret = of_property_read_u32_index(np, "qcom,calib-offsets", 1,
> >>> +					   &tmdev->backup_calib_offset);
> >>> +	if (ret) {
> >>> +		dev_info(tsens_dev, "Missing backup calibration offset\n");
> >>> +		tmdev->backup_calib_offset = tmdev->calib_offset;
> >>> +	}
> >>> +
> >>> +	imem_regmap = syscon_regmap_lookup_by_phandle(np,
> >> "qcom,imem");
> >>> +	if (IS_ERR(imem_regmap)) {
> >>> +		dev_err(tsens_dev, "syscon regmap look up error\n");
> >>> +		return PTR_ERR(imem_regmap);
> >>> +	}
> >>> +
> >> Please see my comments in the bindings patch.
> >
> > As mentioned above, the syscon needs to be 32-bit for other
> > calibration data, so I guess no option.
> >
> > On base_regmap, I am good with either ways. Will wait for your further
> > comments and update accordingly in next revision.
> have a look at http://www.spinics.net/lists/linux-arm-msm/msg13090.html

Agree, my error.

> >
> >>
> >>> +	if (num == 1)
> >>> +		ret = tsens_calib_sensors8660(tmdev, imem_regmap);
> >>> +	else
> >>> +		ret = tsens_calib_sensors8960(tmdev, imem_regmap);
> >>> +
> >>> +	if (ret < 0) {
> >>> +		dev_err(tsens_dev, "tsense calibration failed\n");
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	base_node = of_parse_phandle(np, "qcom,tsens-base", 0);
> >>> +	if (base_node == NULL) {
> >>> +		dev_err(tsens_dev, "no base node present\n");
> >>> +		return  -EINVAL;
> >>> +	}
> >>> +
> >>> +	base_pdev = of_find_device_by_node(base_node);
> >>> +	if (base_pdev == NULL) {
> >>> +		dev_err(tsens_dev, "no base pdev node\n");
> >>> +		return  -ENODEV;
> >>> +	}
> >>> +
> >>> +	tmdev->map = map = dev_get_regmap(&base_pdev->dev, NULL);
> >>> +	if (map == NULL) {
> >>> +		dev_err(tsens_dev, "base regmap get failed\n");
> >>> +		return  -ENODEV;
> >>> +	}
> >>> +
> >>> +	/* Status bits move when the sensor bits next to them overlap */
> >>> +	if (num > 5)
> >>> +		field = &status_0;
> >>> +	else
> >>> +		field = &status_8;
> >>> +
> >>> +	tmdev->status_field = devm_regmap_field_alloc(tsens_dev, map,
> >> *field);
> >>> +	if (IS_ERR(tmdev->status_field)) {
> >>> +		dev_err(tsens_dev, "regmap alloc failed\n");
> >>> +		return PTR_ERR(tmdev->status_field);
> >>> +	}
> >>> +
> >>> +	tsens_hw_init(tmdev);
> >>> +
> >>> +	/*
> >>> +	 * Register sensor 0 separately. This sensor is always
> >>> +	 * expected to be present and if this fails, thermal
> >>> +	 * sensor probe would fail
> >>> +	 * Other sensors are optional and if registration fails
> >>> +	 * disable the sensor and continue
> >>> +	*/
> >>> +	ret = tsens_register(tmdev, 0);
> >>> +	if (ret < 0) {
> >>> +		dev_err(tsens_dev, "Registering failed for primary sensor");
> >>> +		ret = -ENODEV;
> >>> +		goto fail;
> >>> +	} else {
> >>> +		tsens_tz_set_mode(&tmdev->sensor[0],
> >> THERMAL_DEVICE_ENABLED);
> >>> +	}
> >>> +
> >>> +	for (i = 1;  i < tmdev->num_sensors; i++) {
> >>> +		ret = tsens_register(tmdev, i);
> >>> +
> >>> +		if (ret < 0) {
> >>> +			dev_err(tsens_dev,
> >>> +				"Registering failed. Sensor(%i), disabled",
> > i);
> >>> +			tsens_tz_set_mode(&tmdev->sensor[i],
> >>> +				THERMAL_DEVICE_DISABLED);
> >>> +		} else {
> >>> +			tsens_tz_set_mode(&tmdev->sensor[i],
> >>> +				THERMAL_DEVICE_ENABLED);
> >>> +		}
> >>> +	}
> >>> +
> >>> +	INIT_WORK(&tmdev->tsens_work, tsens_scheduler_fn);
> >>> +
> >>> +	ret = devm_request_irq(tsens_dev, irq, tsens_isr,
> >> IRQF_TRIGGER_RISING,
> >>> +			       "tsens", &tmdev->tsens_work);
> >> Unless I missing something,...Would it actually get an interrupt
> >> without setting the proper trip values in the hw? For example in this
> >> driver we
> > only
> >> register from DT.. and the values from Dt never ends up writing into
> >> the
> > hw
> >> registers.. so this would never trigger an interrupt from trip points
> >> mentioned in DT. Unless the default reg values makes sense..
> >> still its out of sync from DT trip values.
> >>
> > Correct, in polling mode (which is what exists in thermal framework
> > today), HW interrupt do not make sense as the trip points are set to
> > default and never updated based on Dt values.
> >
> > But the code under the #ifdef THERMAL_TSENS8960_HWTRIPS supports
> the
> > HW trip point mode.
> > This code needs the additional patch
> > Please see https://patchwork.ozlabs.org/patch/364812/
> >
> > May be I will remove everything under HWTRIPs until it lands in the
> > core thermal framework?
> >
> >> Does the interrupt actually work? Last time when I tested it on 3.4
> >> It
> > never
> >> did work?..
> 
> ???

The code was indeed running in polling mode and interrupts are not getting
triggered on 
3.14 as well. 
I need to go back and check the older version to see if I am missing some
register
setting. From a register map, it has only documented interrupt status, not
enable/disable.

> 
> How do you enable/disable the interrupt in the tses IP, I did not find any
> register to do that?
> Do we have one?
> >>> +	if (ret < 0)
> >>> +		goto err_irq;
> >>> +
> >>> +	platform_set_drvdata(pdev, tmdev);
> >>> +
> >>> +	dev_info(tsens_dev, "Tsens driver initialized\n");
> >>> +
> >>> +	return 0;
> >>> +err_irq:
> >>> +	for (i = 0, s = tmdev->sensor; i < tmdev->num_sensors; i++, s++)
> >>> +		thermal_zone_of_sensor_unregister(&pdev->dev, s-
> >>> tz_dev);
> >>> +fail:
> >>> +	tsens_disable_mode(tmdev);
> >>> +	return ret;
> >>> +}
> >>> +
> >>> +static int tsens_remove(struct platform_device *pdev) {
> >>> +	int i;
> >>> +	struct tsens_sensor *s;
> >>> +	struct tsens_device *tmdev = platform_get_drvdata(pdev);
> >>> +
> >>> +	tsens_disable_mode(tmdev);
> >>> +	for (i = 0, s = tmdev->sensor; i < tmdev->num_sensors; i++, s++)
> >>> +		thermal_zone_device_unregister(s->tz_dev);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static struct of_device_id tsens_match_table[] = {
> >>> +	{.compatible = "qcom,ipq806x-tsens"},
> >> should be "qcom,msm8960-tsens"
> >>
> >
> > Thx, will address in next version.
> >
> >>> +	{},
> >>> +};
> >>> +
> >>> +MODULE_DEVICE_TABLE(of, tsens_match_table);
> >>> +
> >>> +static struct platform_driver tsens_driver = {
> >>> +	.probe = tsens_probe,
> >>> +	.remove = tsens_remove,
> >>> +	.driver = {
> >>> +		.of_match_table = tsens_match_table,
> >>> +		.name = "tsens8960-thermal",
> >>> +		.owner = THIS_MODULE,
> >> remove the owner as it would be set anyway byt the core.
> >
> > Thx, will address in next version.
> >
> >>> +#ifdef CONFIG_PM
> >>> +		.pm	= &tsens_pm_ops,
> >>> +#endif
> >> Please use SIMPLE_DEV_PM_OPS(...)
> >>
> >
> > Thx, will address in next version.
> >
> >>> +	},
> >>> +};
> >>> +module_platform_driver(tsens_driver);
> >>> +
> >>> +MODULE_LICENSE("GPL v2");
> >>> +MODULE_DESCRIPTION("Temperature Sensor driver");
> >>> +MODULE_ALIAS("platform:tsens8960-tm");
> >>>
> >> --srini
> >

--Naren

