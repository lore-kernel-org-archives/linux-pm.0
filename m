From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: qoriq: add multiple sensors support
Date: Mon, 15 Oct 2018 10:55:38 +0200
Message-ID: <cf157e9f-a4cb-6d7d-f51d-8b9d91f3335c@linaro.org>
References: <20180927024204.17314-1-andy.tang@nxp.com>
 <3d1f8304-9005-23f3-2e0e-ef9c962c9f6e@linaro.org>
 <DB5PR0401MB2213D4C1874291B87F231547F3FD0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB5PR0401MB2213D4C1874291B87F231547F3FD0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15/10/2018 03:41, Andy Tang wrote:
> Thanks Daniel,
> 
> Please see my reply inline.
> 
>> -----Original Message-----
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Sent: 2018年10月14日 4:43
>> To: Andy Tang <andy.tang@nxp.com>; rui.zhang@intel.com
>> Cc: edubezval@gmail.com; linux-pm@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] thermal: qoriq: add multiple sensors support
>>
>>
>> Hi Yuantian,
>>
>>
>> On 27/09/2018 04:42, andy.tang@nxp.com wrote:
>>> From: Yuantian Tang <andy.tang@nxp.com>
>>>
>>> There is only one sensor supported in current driver.
>>> Multiple sensors are existing on Layscape socs. To support them,
>>> covert this driver to support multiple sensors.
>>
>> s/covert/convert/
>>
>> What about the following changelog ?
>>
>> "
>> The QorIQ Layerscape SoC has several thermal sensors but the current
>> driver only supports one.
>>
>> Massage the code to be sensor oriented and allow the support for
>> multiple sensors.
>> "
> [Andy]  Thanks, will update
> 
>>
>>> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
>>> ---
>>>  drivers/thermal/qoriq_thermal.c |  117
>>> +++++++++++++++++++++++----------------
>>>  1 files changed, 70 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/drivers/thermal/qoriq_thermal.c
>>> b/drivers/thermal/qoriq_thermal.c index c866cc1..7c1e88a 100644
>>> --- a/drivers/thermal/qoriq_thermal.c
>>> +++ b/drivers/thermal/qoriq_thermal.c
>>> @@ -69,14 +69,21 @@ struct qoriq_tmu_regs {
>>>  	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>>>  };
>>>
>>> +struct qoriq_tmu_data;
>>> +
>>>  /*
>>>   * Thermal zone data
>>>   */
>>> +struct qoriq_sensor {
>>> +	struct thermal_zone_device	*tzd;
>>> +	struct qoriq_tmu_data		*qdata;
>>> +	int				id;
>>> +};
>>
>> Can you move the qoriq_tmu_site_regs structure content inside the
>> qoriq_sensor structure and kill the 'sites' field in the qoriq_tmu_regs
>> structure ? Otherwise we end up with a SITES_MAX array in the
>> qoriq_tmu_data structure and another one in the qoriq_tmu_regs
>> structure.
> [Andy] I am afraid I can't.
> qoriq_tmu_site_regs structure is to define the registers. After iomap, TMU can be accessed.
> qoriq_sensor structure is used for each sensor. It DONOT include the register defines.
> qoriq_tmu_data structure is used for global TMU date.
> So there is no any duplicated or redundant data here.

It is not about duplicate but just code reorg.

This patch changes the structure as:

struct qoriq_tmu_data {
-	struct thermal_zone_device *tz;
 	struct qoriq_tmu_regs __iomem *regs;
-	int sensor_id;
 	bool little_endian;
+	struct qoriq_sensor	*sensor[SITES_MAX];
 };


So we have:

struct qoriq_tmu_data
  => struct qoriq_sensor[SITES_MAX]
  => struct qoriq_tmu_regs
     => struct qoriq_tmu_site_regs[SITES_MAX]

I'm proposing to move struct qoriq_tmu_site_regs inside the struct
qoriq_sensor.


We end up with:

struct qoriq_sensor {
   struct thermal_zone_device *tzd;
   struct struct qoriq_tmu_site_regs *regs;
   struct qoriq_tmu_data *qdata;
   int id;
};


>>> -	if (sensor_specs.args_count >= 1) {
>>> -		id = sensor_specs.args[0];
>>> -		WARN(sensor_specs.args_count > 1,
>>> -				"%s: too many cells in sensor specifier %d\n",
>>> -				sensor_specs.np->name, sensor_specs.args_count);
>>> -	} else {
>>> -		id = 0;
>>> +		if (id > SITES_MAX)
>>> +			return -EINVAL;
>>> +
>>> +		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>>> +				sizeof(struct qoriq_sensor), GFP_KERNEL);
>>> +		if (!qdata->sensor[id])
>>> +			return -ENOMEM;
>>> +
>>> +		qdata->sensor[id]->id = id;
>>> +		qdata->sensor[id]->qdata = qdata;
>>> +
>>> +		qdata->sensor[id]->tzd =
>> devm_thermal_zone_of_sensor_register(
>>> +				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
>>> +
>>> +		if (IS_ERR(qdata->sensor[id]->tzd)) {
>>> +			ret = PTR_ERR(qdata->sensor[id]->tzd);
>>> +			dev_err(&pdev->dev,
>>> +				"Failed to register thermal zone device.\n");
>>> +			return -ENODEV;
>>> +		}
>>> +
>>> +		sites |= 0x1 << (15 - id);
>>
>> The current code is reading the DT in order to get the sensor id and
>> initialize it. IOW, the DT gives the sensors to use.
>>
>> IMO, it would be more self contained if the driver initializes all the sensors
>> without taking care of the DT and let the of- code to do the binding when
>> the thermal zone, no ?
> [Andy] could you please explain more about this way? I am not sure how to implement it.
> But one thing is for sure: we must get the sensor IDs explicitly so that we can enable them by
> the following command:  tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);

What I meant is about code separation between the driver itself and the
of-thermal code.

The code above re-inspect the DT to find out the sensor ids in order to
enable them and somehow this is not wrong but breaks the self
encapsulation of the driver. I was suggesting if it isn't possible to
enable all the sensors without taking care of digging into the DT.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
