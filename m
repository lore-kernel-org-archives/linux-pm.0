From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: qoriq: add multiple sensors support
Date: Tue, 16 Oct 2018 13:20:56 +0200
Message-ID: <77993e69-db55-a2a0-799f-5225d5ffb010@linaro.org>
References: <20180927024204.17314-1-andy.tang@nxp.com>
 <3d1f8304-9005-23f3-2e0e-ef9c962c9f6e@linaro.org>
 <DB5PR0401MB2213D4C1874291B87F231547F3FD0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
 <cf157e9f-a4cb-6d7d-f51d-8b9d91f3335c@linaro.org>
 <DB5PR0401MB2213E291AC455D61ED15AF4AF3FE0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB5PR0401MB2213E291AC455D61ED15AF4AF3FE0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16/10/2018 05:01, Andy Tang wrote:
> Hi Daniel,
> 
> Please see my reply inline.
> 
>> -----Original Message-----

[ ... ]

>> I'm proposing to move struct qoriq_tmu_site_regs inside the struct
>> qoriq_sensor.
>>
>>
>> We end up with:
>>
>> struct qoriq_sensor {
>>    struct thermal_zone_device *tzd;
>>    struct struct qoriq_tmu_site_regs *regs;
>>    struct qoriq_tmu_data *qdata;
>>    int id;
>> };
> [Andy] I see your point. If I add a *regs member to qoriq_sensor struct, then I can speed up the access to the register.
> But I don't think it is better. Currently I can access sensor register by: qdata->regs->site[qsensor->id].
> The whole point here is we can't MOVE struct qoriq_tmu_site_regs to the struct qoriq_sensor. We can only COPY
> it to struct qoriq_sensor. 
> 
> This is the TMU module memory map:
> struct qoriq_tmu_regs {
> ......
>         u32 tscfgr;             /* Sensor Configuration Register */
>         u8 res4[0x78];
>         struct qoriq_tmu_site_regs site[SITES_MAX];
>         u8 res5[0x9f8];
>         u32 ipbrr0;             /* IP Block Revision Register 0 */
>         u32 ipbrr1;             /* IP Block Revision Register 1 */
> .......}
> struct qoriq_tmu_site_regs site[SITES_MAX] is part of the memory
> map.
> It can't be removed or we have to define a similar struct to fill it up.

Mmh, I see. Thanks for the clarification.

A consolidation around this would have been nice but it means a DT
change (reduce the size of the map). So I guess we can leave it as it is.


>>>>> -	if (sensor_specs.args_count >= 1) {
>>>>> -		id = sensor_specs.args[0];
>>>>> -		WARN(sensor_specs.args_count > 1,
>>>>> -				"%s: too many cells in sensor specifier %d\n",
>>>>> -				sensor_specs.np->name,
>> sensor_specs.args_count);
>>>>> -	} else {
>>>>> -		id = 0;
>>>>> +		if (id > SITES_MAX)
>>>>> +			return -EINVAL;
>>>>> +
>>>>> +		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>>>>> +				sizeof(struct qoriq_sensor), GFP_KERNEL);
>>>>> +		if (!qdata->sensor[id])
>>>>> +			return -ENOMEM;
>>>>> +
>>>>> +		qdata->sensor[id]->id = id;
>>>>> +		qdata->sensor[id]->qdata = qdata;
>>>>> +
>>>>> +		qdata->sensor[id]->tzd =
>>>> devm_thermal_zone_of_sensor_register(
>>>>> +				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
>>>>> +
>>>>> +		if (IS_ERR(qdata->sensor[id]->tzd)) {
>>>>> +			ret = PTR_ERR(qdata->sensor[id]->tzd);
>>>>> +			dev_err(&pdev->dev,
>>>>> +				"Failed to register thermal zone device.\n");
>>>>> +			return -ENODEV;
>>>>> +		}
>>>>> +
>>>>> +		sites |= 0x1 << (15 - id);
>>>>
>>>> The current code is reading the DT in order to get the sensor id and
>>>> initialize it. IOW, the DT gives the sensors to use.
>>>>
>>>> IMO, it would be more self contained if the driver initializes all
>>>> the sensors without taking care of the DT and let the of- code to do
>>>> the binding when the thermal zone, no ?
>>> [Andy] could you please explain more about this way? I am not sure how
>> to implement it.
>>> But one thing is for sure: we must get the sensor IDs explicitly so
>>> that we can enable them by the following command:  tmu_write(qdata,
>>> sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
>>
>> What I meant is about code separation between the driver itself and the
>> of-thermal code.
>>
>> The code above re-inspect the DT to find out the sensor ids in order to
>> enable them and somehow this is not wrong but breaks the self
>> encapsulation of the driver. I was suggesting if it isn't possible to enable all
>> the sensors without taking care of digging into the DT.
> 
> [Andy] I don't want to re-parse the DT here too. But I have to.
> This driver will be used by all our SOCs with different sensor IDs and number.
> For example: there are 2 sensors on ls1088a platform with ID 0 and 1.
> While on ls1043a there are 6 sensors with ID 0, 1, 2, 3, 4, 5.
> If we don't scan the DT we would not know how many sensors it is and what are the sensor's IDs,
> unless we hardcode it in driver.

Yes, you are not the only one in this situation IMO and the drivers
supporting multiple sensors are increasing, so this will repeat again
and again.

That could be hardcoded in the driver by using the compatible string but
it will be nicer if we can fix that in the DT.

[Cc'ing Rob]

What is missing is a description of the sensors id in the temperature
device node. We have the <thermal-sensor-cells> with 0 or 1 telling if
there is one or several sensors but we can't specify which sensor ids we
have. The only alternative is to parse the thermal zones to found out
which sensors are in use and use them to initialize the driver, an
approach which breaks the self-encapsulation: the of-thermal framework
is the one in charge of doing the link between the thermal zone and a
sensor id.

Is it acceptable to add the list of the sensors id in the temp device
node, so the driver can initialize these sensors without parsing the
thermal zone in the DT ?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
