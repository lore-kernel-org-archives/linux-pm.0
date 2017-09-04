From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 2/3] thermal: hisilicon: add thermal sensor driver for
 Hi3660
Date: Mon, 4 Sep 2017 13:06:39 +0200
Message-ID: <8fe3ad22-59db-40c6-18db-7b6859f05a95@linaro.org>
References: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
 <1503994666-13954-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1503994666-13954-3-git-send-email-kevin.wangtao@hisilicon.com>
 <77ceb395-57bb-8de7-7b1a-3218baa5d5f3@linaro.org>
 <b884f2ca-86e1-0df3-0cbf-99b13232ee03@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b884f2ca-86e1-0df3-0cbf-99b13232ee03@hisilicon.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>, rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, kevin.wangtao@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com
List-Id: linux-pm@vger.kernel.org


Hi Kevin,


On 04/09/2017 09:56, Wangtao (Kevin, Kirin) wrote:
> 
> 
> 在 2017/9/1 5:17, Daniel Lezcano 写道:
>>
>> Hi Kevin,
>>
>>
>> On 29/08/2017 10:17, Tao Wang wrote:
>>> From: Tao Wang <kevin.wangtao@linaro.org>
>>>
>>> This patch adds the support for thermal sensor of Hi3660 SoC.
>>
>> for the Hi3660 SoC thermal sensor.
>>
>>> this will register sensors for thermal framework and use device
>>> tree to bind cooling device.
>>
>> Is it possible to give a pointer to some documentation or to describe
>> the hardware?
> Yes, there used to be on patch V3, I removed it on V4.
>>
>> An explanation of the adc min max coef[] range[] conversion would be
>> nice.
> OK
>>
>> In addition, having the rational behind the average and the max would be
>> nice. Do we really need both avg and max as virtual sensor?
> We only need max currently.
>>
>>> Signed-off-by: Tao Wang <kevin.wangtao@linaro.org>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> ---
>>>   drivers/thermal/Kconfig        |  13 +++
>>>   drivers/thermal/Makefile       |   1 +
>>>   drivers/thermal/hisi_tsensor.c | 209
>>> +++++++++++++++++++++++++++++++++++++++++
>>
>>
>> IMO, we don't need a new file, but merge this code with the current
>> hisi_thermal.c driver. BTW, the hi6220 has also a tsensor which is
>> different from this one.
>>
>> I suggest to base the hi3660 thermal driver on top of the cleanup I sent
>> for the hi6220.
> The tsensor of hi3660 is a different one, merging the code with hi6220
> will need a lot of change.

Have a look at the hisi_thermal.c at:

https://git.linaro.org/people/daniel.lezcano/linux.git/tree/drivers/thermal/hisi_thermal.c?h=thermal/hikey-4.14

after the cleanup I recently sent.

I'm pretty sure, with a little effort, we can merge both.

Especially if the virtual things is separated.

At the end, what do we do ? Read a register.

>>>   3 files changed, 223 insertions(+)
>>>   create mode 100644 drivers/thermal/hisi_tsensor.c
>>>
>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>> index b5b5fac..32f582d 100644
>>> --- a/drivers/thermal/Kconfig
>>> +++ b/drivers/thermal/Kconfig
>>> @@ -203,6 +203,19 @@ config HISI_THERMAL
>>>         thermal framework. cpufreq is used as the cooling device to
>>> throttle
>>>         CPUs when the passive trip is crossed.
>>>   +config HISI_TSENSOR
>>> +    tristate "Hisilicon tsensor driver"
>>> +    depends on ARCH_HISI || COMPILE_TEST
>>> +    depends on HAS_IOMEM
>>> +    depends on OF
>>> +    default y
>>> +    help
>>> +      Enable this to plug Hisilicon's tsensor driver into the Linux
>>> thermal
>>> +      framework. Besides all the hardware sensors, this also support
>>> two
>>> +      virtual sensors, one for maximum of all the hardware sensor, and
>>> +      one for average of all the hardware sensor.
>>> +      Compitable with Hi3660 or higher.
>>
>> s/Compitable/Compatible/
> OK
>>
>>> +
>>>   config IMX_THERMAL
>>>       tristate "Temperature sensor driver for Freescale i.MX SoCs"
>>>       depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
>>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>>> index 094d703..8a16bd4 100644
>>> --- a/drivers/thermal/Makefile
>>> +++ b/drivers/thermal/Makefile
>>> @@ -56,6 +56,7 @@ obj-$(CONFIG_ST_THERMAL)    += st/
>>>   obj-$(CONFIG_QCOM_TSENS)    += qcom/
>>>   obj-$(CONFIG_TEGRA_SOCTHERM)    += tegra/
>>>   obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>>> +obj-$(CONFIG_HISI_TSENSOR)    += hisi_tsensor.o
>>>   obj-$(CONFIG_MTK_THERMAL)    += mtk_thermal.o
>>>   obj-$(CONFIG_GENERIC_ADC_THERMAL)    += thermal-generic-adc.o
>>>   obj-$(CONFIG_ZX2967_THERMAL)    += zx2967_thermal.o
>>> diff --git a/drivers/thermal/hisi_tsensor.c
>>> b/drivers/thermal/hisi_tsensor.c
>>> new file mode 100644
>>> index 0000000..34cf2ba
>>> --- /dev/null
>>> +++ b/drivers/thermal/hisi_tsensor.c
>>> @@ -0,0 +1,209 @@
>>> +/*
>>> + *  linux/drivers/thermal/hisi_tsensor.c
>>> + *
>>> + *  Copyright (c) 2017 Hisilicon Limited.
>>> + *  Copyright (c) 2017 Linaro Limited.
>>> + *
>>> + *  Author: Tao Wang <kevin.wangtao@linaro.org>
>>> + *  Author: Leo Yan <leo.yan@linaro.org>
>>> + *
>>> + *  This program is free software; you can redistribute it and/or
>>> modify
>>> + *  it under the terms of the GNU General Public License as
>>> published by
>>> + *  the Free Software Foundation; version 2 of the License.
>>> + *
>>> + *  This program is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *  GNU General Public License for more details.
>>> + *
>>> + *  You should have received a copy of the GNU General Public License
>>> + *  along with this program.  If not, see
>>> <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/device.h>
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/of.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/thermal.h>
>>> +
>>> +#include "thermal_core.h"
>>> +
>>> +#define VIRTUAL_SENSORS        2
>>> +
>>> +/* hisi Thermal Sensor Dev Structure */
>>> +struct hisi_thermal_sensor {
>>> +    struct hisi_thermal_data *thermal;
>>> +    struct thermal_zone_device *tzd;
>>> +    void __iomem *sensor_reg;
>>> +    unsigned int id;
>>> +};
>>> +
>>> +struct hisi_thermal_data {
>>> +    struct platform_device *pdev;
>>> +    struct hisi_thermal_sensor *sensors;
>>> +    unsigned int range[2];
>>> +    unsigned int coef[2];
>>> +    unsigned int max_hw_sensor;
>>> +};
>>> +
>>> +static int hisi_thermal_get_temp(void *_sensor, int *temp)
>>> +{
>>> +    struct hisi_thermal_sensor *sensor = _sensor;
>>> +    struct hisi_thermal_data *data = sensor->thermal;
>>> +    unsigned int idx, adc_min, adc_max, max_sensor;
>>> +    int val, average = 0, max = 0;
>>> +
>>> +    adc_min = data->range[0];
>>> +    adc_max = data->range[1];
>>> +    max_sensor = data->max_hw_sensor;
>>> +
>>> +    if (sensor->id < max_sensor) {
>>> +        val = readl(sensor->sensor_reg);
>>> +        val = clamp_val(val, adc_min, adc_max);
>>
>> That looks a bit fuzzy. Why not create a get_temp for physical sensor
>> and another one for the virtual? So there will be a clear distinction
>> between both.
> make sense

After thinking about it. I think it virtual sensor should be a separate
driver.

[ ... ]

>> Do we really need a max sensor definition in the DT? Isn't it something
>> we can deduce by looping with platform_get_resource below ?
>>
>> eg.
>>
>> while ((res = platform_get_resource(..., num_sensor++)) {
>>     ...
>> }
>>
>> That said, I think we can assume there are 3 sensors always, no?
> If we have three CPU cluster or two cluster share the same sensor in
> future, that number is certain on hi3660

Do you mean, it is always 3 ?

>>> +    data->sensors = devm_kzalloc(dev,
>>> +        sizeof(*data->sensors) * (max_sensor + VIRTUAL_SENSORS),
>>> +        GFP_KERNEL);
>>> +    if (IS_ERR(data->sensors)) {

[ ... ]

>>> +            }
>>> +        }
>>> +
>>> +        sensor->id = i;
>>
>> How can we deal with holes in the DT?Do you mean the holes of sensor id?

Yes.

[ ... ]


  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
