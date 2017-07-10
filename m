From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 4/4] thermal: Add Tegra BPMP thermal sensor driver
Date: Mon, 10 Jul 2017 11:50:20 +0300
Message-ID: <24019d55-b4df-dd6e-f43d-57a41b208e09@kapsi.fi>
References: <20170616112825.31025-1-mperttunen@nvidia.com>
 <20170616112825.31025-4-mperttunen@nvidia.com>
 <20170701025325.GA11217@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:49236 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752454AbdGJIu1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jul 2017 04:50:27 -0400
In-Reply-To: <20170701025325.GA11217@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, rui.zhang@intel.com, thierry.reding@gmail.com, jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 01.07.2017 05:53, Eduardo Valentin wrote:
> Hey Mikko,
>
> Sorry for the late answer,

Likewise,

>
> On Fri, Jun 16, 2017 at 02:28:25PM +0300, Mikko Perttunen wrote:
>> On Tegra186, the BPMP (Boot and Power Management Processor) exposes an
>> interface to thermal sensors on the system-on-chip. This driver
>> implements access to the interface. It supports reading the
>> temperature, setting trip points and receiving notification of a
>> tripped trip point.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>  drivers/thermal/Makefile             |   2 +-
>>  drivers/thermal/tegra/Kconfig        |   7 +
>>  drivers/thermal/tegra/Makefile       |   3 +-
>>  drivers/thermal/tegra/bpmp-thermal.c | 253 +++++++++++++++++++++++++++++++++++
>>  4 files changed, 263 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/thermal/tegra/bpmp-thermal.c
>>
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 094d7039981c..c03dccdba7b8 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -54,7 +54,7 @@ obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
>>  obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
>>  obj-$(CONFIG_ST_THERMAL)	+= st/
>>  obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>> -obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
>> +obj-y				+= tegra/
>>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>>  obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
>>  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>> diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/Kconfig
>> index cec586ec7e4b..36e4b03bb98b 100644
>> --- a/drivers/thermal/tegra/Kconfig
>> +++ b/drivers/thermal/tegra/Kconfig
>> @@ -10,4 +10,11 @@ config TEGRA_SOCTHERM
>>  	  zones to manage temperatures. This option is also required for the
>>  	  emergency thermal reset (thermtrip) feature to function.
>>
>> +config TEGRA_BPMP_THERMAL
>> +	tristate "Tegra BPMP thermal sensing"
>> +	depends on TEGRA_BPMP
>
> Can you add COMPILE_TEST support here?

Sure.

>
>> +	help
>> +	 Enable this option for support for sensing system temperature of NVIDIA
>> +	 Tegra systems-on-chip with the BPMP coprocessor (Tegra186).
>> +
>>  endmenu
>> diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makefile
>> index 1ce1af2cf0f5..757abcd1feaf 100644
>> --- a/drivers/thermal/tegra/Makefile
>> +++ b/drivers/thermal/tegra/Makefile
>> @@ -1,4 +1,5 @@
>> -obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra-soctherm.o
>> +obj-$(CONFIG_TEGRA_SOCTHERM)		+= tegra-soctherm.o
>> +obj-$(CONFIG_TEGRA_BPMP_THERMAL)	+= bpmp-thermal.o
>>
>>  tegra-soctherm-y				:= soctherm.o soctherm-fuse.o
>>  tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+= tegra124-soctherm.o
>> diff --git a/drivers/thermal/tegra/bpmp-thermal.c b/drivers/thermal/tegra/bpmp-thermal.c
>> new file mode 100644
>> index 000000000000..3465a201d1ac
>> --- /dev/null
>> +++ b/drivers/thermal/tegra/bpmp-thermal.c
>> @@ -0,0 +1,253 @@
>> +/*
>> + * Copyright (c) 2015-2017, NVIDIA CORPORATION.  All rights reserved.
>> + *
>> + * Author:
>> + *	Mikko Perttunen <mperttunen@nvidia.com>
>> + *	Aapo Vienamo	<avienamo@nvidia.com>
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/thermal.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include <soc/tegra/bpmp.h>
>> +#include <soc/tegra/bpmp-abi.h>
>> +
>> +struct tegra_bpmp_thermal_zone {
>> +	struct tegra_bpmp_thermal *tegra;
>> +	struct thermal_zone_device *tzd;
>> +	struct work_struct tz_device_update_work;
>> +	unsigned int idx;
>> +};
>> +
>> +struct tegra_bpmp_thermal {
>> +	struct device *dev;
>> +	struct tegra_bpmp *bpmp;
>> +	unsigned int num_zones;
>> +	struct tegra_bpmp_thermal_zone *zones;
>> +};
>> +
>> +static int tegra_bpmp_thermal_get_temp(void *data, int *out_temp)
>> +{
>> +	struct tegra_bpmp_thermal_zone *zone = data;
>> +	struct mrq_thermal_host_to_bpmp_request req;
>> +	union mrq_thermal_bpmp_to_host_response reply;
>> +	struct tegra_bpmp_message msg;
>> +	int err;
>> +
>> +	memset(&req, 0, sizeof(req));
>> +	req.type = CMD_THERMAL_GET_TEMP;
>> +	req.get_temp.zone = zone->idx;
>> +
>> +	memset(&msg, 0, sizeof(msg));
>> +	msg.mrq = MRQ_THERMAL;
>> +	msg.tx.data = &req;
>> +	msg.tx.size = sizeof(req);
>> +	msg.rx.data = &reply;
>> +	msg.rx.size = sizeof(reply);
>> +
>> +	err = tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
>> +	if (err)
>> +		return err;
>> +
>> +	*out_temp = reply.get_temp.temp;
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_bpmp_thermal_set_trips(void *data, int low, int high)
>> +{
>> +	struct tegra_bpmp_thermal_zone *zone = data;
>> +	struct mrq_thermal_host_to_bpmp_request req;
>> +	struct tegra_bpmp_message msg;
>> +
>> +	memset(&req, 0, sizeof(req));
>> +	req.type = CMD_THERMAL_SET_TRIP;
>> +	req.set_trip.zone = zone->idx;
>> +	req.set_trip.enabled = true;
>> +	req.set_trip.low = low;
>> +	req.set_trip.high = high;
>> +
>> +	memset(&msg, 0, sizeof(msg));
>> +	msg.mrq = MRQ_THERMAL;
>> +	msg.tx.data = &req;
>> +	msg.tx.size = sizeof(req);
>> +
>> +	return tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
>> +}
>> +
>> +static void tz_device_update_work_fn(struct work_struct *work)
>> +{
>> +	struct tegra_bpmp_thermal_zone *zone;
>> +
>> +	zone = container_of(work, struct tegra_bpmp_thermal_zone,
>> +			    tz_device_update_work);
>> +
>> +	thermal_zone_device_update(zone->tzd, THERMAL_TRIP_VIOLATED);
>> +}
>> +
>> +static void bpmp_mrq_thermal(unsigned int mrq, struct tegra_bpmp_channel *ch,
>> +			     void *data)
>> +{
>> +	struct mrq_thermal_bpmp_to_host_request *req;
>> +	struct tegra_bpmp_thermal *tegra = data;
>> +	int zone_idx;
>> +
>> +	req = (struct mrq_thermal_bpmp_to_host_request *)ch->ib->data;
>> +
>> +	if (req->type != CMD_THERMAL_HOST_TRIP_REACHED) {
>> +		dev_err(tegra->dev, "%s: invalid request type: %d\n",
>> +			__func__, req->type);
>> +		tegra_bpmp_mrq_return(ch, -EINVAL, NULL, 0);
>> +		return;
>> +	}
>> +
>> +	zone_idx = req->host_trip_reached.zone;
>> +	if (zone_idx >= tegra->num_zones) {
>> +		dev_err(tegra->dev, "%s: invalid thermal zone: %d\n",
>> +			__func__, zone_idx);
>> +		tegra_bpmp_mrq_return(ch, -EINVAL, NULL, 0);
>> +		return;
>> +	}
>> +
>> +	tegra_bpmp_mrq_return(ch, 0, NULL, 0);
>> +
>> +	schedule_work(&tegra->zones[zone_idx].tz_device_update_work);
>
> Why not a thermal update right here?

The device update will call back to the .get_temp callback, which will 
call tegra_bpmp_transfer - but this function may not be called from 
atomic context. (bpmp_mrq_thermal is called from atomic context)

>
>> +}
>> +
>> +static int tegra_bpmp_thermal_get_num_zones(struct tegra_bpmp *bpmp,
>> +					    int *num_zones)
>> +{
>> +	struct mrq_thermal_host_to_bpmp_request req;
>> +	union mrq_thermal_bpmp_to_host_response reply;
>> +	struct tegra_bpmp_message msg;
>> +	int err;
>> +
>> +	memset(&req, 0, sizeof(req));
>> +	req.type = CMD_THERMAL_GET_NUM_ZONES;
>> +
>> +	memset(&msg, 0, sizeof(msg));
>> +	msg.mrq = MRQ_THERMAL;
>> +	msg.tx.data = &req;
>> +	msg.tx.size = sizeof(req);
>> +	msg.rx.data = &reply;
>> +	msg.rx.size = sizeof(reply);
>> +
>> +	err = tegra_bpmp_transfer(bpmp, &msg);
>> +	if (err)
>> +		return err;
>> +
>> +	*num_zones = reply.get_num_zones.num;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct thermal_zone_of_device_ops tegra_bpmp_of_thermal_ops = {
>> +	.get_temp = tegra_bpmp_thermal_get_temp,
>> +	.set_trips = tegra_bpmp_thermal_set_trips,
>> +};
>> +
>> +static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
>> +{
>> +	struct tegra_bpmp *bpmp = dev_get_drvdata(pdev->dev.parent);
>> +	struct tegra_bpmp_thermal *tegra;
>> +	struct thermal_zone_device *tzd;
>> +	unsigned int i;
>> +	int err;
>> +
>> +	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>> +	if (!tegra)
>> +		return -ENOMEM;
>> +
>> +	tegra->dev = &pdev->dev;
>> +	tegra->bpmp = bpmp;
>> +
>> +	err = tegra_bpmp_thermal_get_num_zones(bpmp, &tegra->num_zones);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "failed to get the number of zones: %d\n",
>> +			err);
>> +		return err;
>> +	}
>> +
>> +	tegra->zones = devm_kcalloc(&pdev->dev, tegra->num_zones,
>> +				    sizeof(*tegra->zones), GFP_KERNEL);
>> +	if (!tegra->zones)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < tegra->num_zones; ++i) {
>> +		int temp;
>> +
>> +		tegra->zones[i].idx = i;
>> +		tegra->zones[i].tegra = tegra;
>> +
>> +		err = tegra_bpmp_thermal_get_temp(&tegra->zones[i], &temp);
>> +		if (err < 0)
>> +			continue;
>
> Should we release the memory allocated for zones that fail to retrieve
> temperature here, given that you are not going to use it elsewhere.

That's possible, though then we will need a separate allocation for each 
zone struct. I'll make the change.

>
>> +
>> +		tzd = devm_thermal_zone_of_sensor_register(
>> +			&pdev->dev, i, &tegra->zones[i],
>> +			&tegra_bpmp_of_thermal_ops);
>> +		if (IS_ERR(tzd)) {
>> +			if (PTR_ERR(tzd) == -EPROBE_DEFER)
>> +				return -EPROBE_DEFER;
>> +			continue;
>
> same here?
>
>> +		}
>> +
>> +		tegra->zones[i].tzd = tzd;
>> +		INIT_WORK(&tegra->zones[i].tz_device_update_work,
>> +			  tz_device_update_work_fn);
>> +	}
>> +
>> +	err = tegra_bpmp_request_mrq(bpmp, MRQ_THERMAL, bpmp_mrq_thermal,
>> +				     tegra);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "failed to register mrq handler: %d\n",
>> +			err);
>> +		return err;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, tegra);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_bpmp_thermal_remove(struct platform_device *pdev)
>> +{
>> +	struct tegra_bpmp_thermal *tegra = platform_get_drvdata(pdev);
>> +
>> +	tegra_bpmp_free_mrq(tegra->bpmp, MRQ_THERMAL, tegra);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id tegra_bpmp_thermal_of_match[] = {
>> +	{ .compatible = "nvidia,tegra186-bpmp-thermal" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, tegra_bpmp_thermal_of_match);
>> +
>> +static struct platform_driver tegra_bpmp_thermal_driver = {
>> +	.probe = tegra_bpmp_thermal_probe,
>> +	.remove = tegra_bpmp_thermal_remove,
>> +	.driver = {
>> +		.name = "tegra-bpmp-thermal",
>> +		.of_match_table = tegra_bpmp_thermal_of_match,
>> +	},
>> +};
>> +module_platform_driver(tegra_bpmp_thermal_driver);
>> +
>> +MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
>> +MODULE_DESCRIPTION("NVIDIA Tegra BPMP thermal sensor driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.13.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Thanks,
Mikko
