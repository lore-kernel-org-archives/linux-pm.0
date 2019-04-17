From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 2/3] drivers: devfreq: events: extend events by type of
 counted data
Date: Wed, 17 Apr 2019 13:00:05 +0200
Message-ID: <15ec9cce-8cce-0bfb-44d2-1f8e5acaebc0@partner.samsung.com>
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda@eucas1p1.samsung.com>
        <1555487288-4777-3-git-send-email-l.luba@partner.samsung.com>
        <628d298a-0c44-11c9-d27b-165cdfc0d2a2@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <628d298a-0c44-11c9-d27b-165cdfc0d2a2@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 4/17/19 10:22 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 4. 17. 오후 4:48, Lukasz Luba wrote:
>> This patch adds posibility to choose what type of data should be counted
>> by the PPMU counter. Now the type comes from DT where the event has been
>> defined. When there is no 'event-data-type' the default value is used,
>> which is 'read data in bytes'.
>> It is needed when you want to know not only read+write data bytes but
>> i.e. only write data in byte, or number of read requests, etc.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/event/exynos-ppmu.c | 38 +++++++++++++++++++++++++------------
>>   include/linux/devfreq-event.h       |  6 ++++++
>>   2 files changed, 32 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>> index c61de0b..e5f81a5 100644
>> --- a/drivers/devfreq/event/exynos-ppmu.c
>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>> @@ -140,6 +140,7 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>>   	int id = exynos_ppmu_find_ppmu_id(edev);
>>   	int ret;
>>   	u32 pmnc, cntens;
>> +	u32 evt_sel = edev->desc->data_type;
>>   
>>   	if (id < 0)
>>   		return id;
>> @@ -154,9 +155,12 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	/* Set the event of Read/Write data count  */
>> -	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
>> -				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
>> +	/* Check if the data type has been defined in DT, use default if not */
>> +	if (evt_sel == UINT_MAX)
>> +		evt_sel = PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT;
>> +
>> +	/* Set the event of Read or Write or both (RDWR) data count  */
>> +	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id), evt_sel);
>>   	if (ret < 0)
>>   		return ret;
>>   
>> @@ -357,6 +361,7 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>>   	unsigned int pmnc, cntens;
>>   	int id = exynos_ppmu_find_ppmu_id(edev);
>>   	int ret;
>> +	u32 evt_sel = edev->desc->data_type;
>>   
>>   	/* Enable all counters */
>>   	ret = regmap_read(info->regmap, PPMU_V2_CNTENS, &cntens);
>> @@ -368,24 +373,28 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	/* Set the event of Read/Write data count  */
>> +
>> +	/* Set the event of proper data type counting.
>> +	 * Check if the data type has been defined in DT,
>> +	 * use default if not.
>> +	 */
>>   	switch (id) {
>>   	case PPMU_PMNCNT0:
>>   	case PPMU_PMNCNT1:
>>   	case PPMU_PMNCNT2:
>> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>> -				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
>> -		if (ret < 0)
>> -			return ret;
>> +		if (evt_sel == UINT_MAX)
>> +			evt_sel = PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT;
>>   		break;
>>   	case PPMU_PMNCNT3:
>> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>> -				PPMU_V2_EVT3_RW_DATA_CNT);
>> -		if (ret < 0)
>> -			return ret;
>> +		if (evt_sel == UINT_MAX)
>> +			evt_sel = PPMU_V2_EVT3_RW_DATA_CNT;
>>   		break;
>>   	}
>>   
>> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id), evt_sel);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>   	/* Reset cycle counter/performance counter and enable PPMU */
>>   	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
>>   	if (ret < 0)
>> @@ -508,6 +517,7 @@ static int of_get_devfreq_events(struct device_node *np,
>>   	struct device *dev = info->dev;
>>   	struct device_node *events_np, *node;
>>   	int i, j, count;
>> +	int ret;
>>   
>>   	events_np = of_get_child_by_name(np, "events");
>>   	if (!events_np) {
>> @@ -544,6 +554,10 @@ static int of_get_devfreq_events(struct device_node *np,
>>   		desc[j].driver_data = info;
>>   
>>   		of_property_read_string(node, "event-name", &desc[j].name);
>> +		ret = of_property_read_u32(node, "event-data-type",
>> +					   &desc[j].data_type);
>> +		if (!ret)
>> +			desc[i].data_type = UINT_MAX;
> 
> I think that it is not proper to use 'UINT_MAX'.
> If you want to use the default value, you can initialize
> the 'desc[i].data_type' according to the device type or compatible name.
> 
> For all exynos SoC except for exynos5433,
> 	desc[i].data_type = PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT;
> 
> For exynos5433,
> 	desc[i].data_type = PPMU_V2_EVT3_RW_DATA_CNT;
> 
OK, I will set these default values here.

>>   
>>   		j++;
>>   	}
>> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
>> index 4db00b0..cc160b1 100644
>> --- a/include/linux/devfreq-event.h
>> +++ b/include/linux/devfreq-event.h
>> @@ -81,14 +81,20 @@ struct devfreq_event_ops {
>>    * struct devfreq_event_desc - the descriptor of devfreq-event device
>>    *
>>    * @name	: the name of devfreq-event device.
>> + * @data_type	: the data type which is going to be counted in the register.
>>    * @driver_data	: the private data for devfreq-event driver.
>>    * @ops		: the operation to control devfreq-event device.
>>    *
>>    * Each devfreq-event device is described with a this structure.
>>    * This structure contains the various data for devfreq-event device.
>> + * The data_type describes what is going to be counted in the register.
>> + * It might choose to count e.g. read requests, write data in bytes, etc.
>> + * The full supported list of types is present in specyfic header in:
>> + * include/dt-bindings/pmu/.
> 
> Why did you make the path name as the 'pmu' instead of 'ppmu'?
The directory may contain in future other Performance Monitoring Unit
subsystems. In Exynos case we have: Platform Performance Monitoring Unit
but different SoCs might have other names, like: System PMU.
Since there is no 'pmu' in this directory, I am allocating it for
Performance Monitoring Unit and not Power Management Unit.

> 
> It might have some confusion because 'pmu' has
> the two meaning in linux kernel.
> - PMU, Power Management Unit
> - PMU, Performance Monitoring Unit
Regards,
Lukasz
> 
>>    */
>>   struct devfreq_event_desc {
>>   	const char *name;
>> +	u32 data_type;
>>   	void *driver_data;
>>   
>>   	const struct devfreq_event_ops *ops;
>>
> 
> 
