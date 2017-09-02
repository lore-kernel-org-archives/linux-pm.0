From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 09/13] thermal/drivers/hisi: Remove costly sensor
 inspection
Date: Sat, 2 Sep 2017 15:10:29 +0200
Message-ID: <30efb5b7-fdb4-cbdc-56a3-d06e90720a75@linaro.org>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-9-git-send-email-daniel.lezcano@linaro.org>
 <20170902032924.GB3841@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170902032924.GB3841@leoy-linaro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/09/2017 05:29, Leo Yan wrote:
> On Wed, Aug 30, 2017 at 10:47:33AM +0200, Daniel Lezcano wrote:
>> The sensor is all setup, bind, resetted, acked, etc... every single second.
>>
>> That was the way to workaround a problem with the interrupt bouncing again and
>> again.
>>
>> With the following changes, we fix all in one:
>>
>>  - Do the setup, one time, at probe time
>>
>>  - Add the IRQF_ONESHOT, ack the interrupt in the threaded handler
>>
>>  - Remove the interrupt handler
>>
>>  - Set the correct value for the LAG register
>>
>>  - Remove all the irq_enabled stuff in the code as the interruption
>>    handling is fixed
>>
>>  - Remove the 3ms delay
>>
>>  - Reorder the initialization routine to be in the right order
>>
>> It ends up to a nicer code and more efficient, the 3-5ms delay is removed from
>> the get_temp() path.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/hisi_thermal.c | 203 +++++++++++++++++++----------------------
>>  1 file changed, 93 insertions(+), 110 deletions(-)
>>
>> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
>> index 3e03908..b038d8a 100644
>> --- a/drivers/thermal/hisi_thermal.c
>> +++ b/drivers/thermal/hisi_thermal.c
>> @@ -39,6 +39,7 @@
>>  #define HISI_TEMP_BASE			(-60000)
>>  #define HISI_TEMP_RESET			(100000)
>>  #define HISI_TEMP_STEP			(784)
>> +#define HISI_TEMP_LAG			(3500)
> 
> So I am curious what's the reason to select 3.5'c for lag value? Is
> this a heuristics result?

Yes, it is. I tried 5°C but I find it too long. After several tests, I
found 3.5°C looked fine.

[ ... ]

>> + * A very short lag can lead to an interrupt storm, a long lag
>> + * increase the latency to react to the temperature changes.  In our
>> + * case, that is not really a problem as we are polling the
>> + * temperature.
> 
> So here means if we set a long lag value and the interrupt is delayed,
> sometimes we even don't receive the interrupt; but this is acceptable
> due we are polling the temperature so we still can get the updated
> temperature value, right?
No, what I meant is if the hysteresis is too large, eg. 45 - 65, then
the interrupt will come after the temperature goes below 45 and that may
take a long time, especially if the temperature is fluctuating between
the two hysteresis values.

The only setup preventing an interrupt to happen is when crossing the
low value hysteresis is not possible in practical. For example, the
temperature of the SoC is ~44°C at idle time. If we set the threshold to
65°C and the lag to the max 24°C, the interrupt will raised when we go
below 41°C and that situation can't happen.

In the current situation, the interrupt is only used to raise an alarm.
The get temperature is resulting from a polling, so the delay between
the alarm on/off is not issue for now.

>> + *
>> + * [0:4] : lag register
>> + *
>> + * The temperature is coded in steps, cf. HISI_TEMP_STEP.
>> + *
>> + * Min : 0x00 :  0.0 °C
>> + * Max : 0x1F : 24.3 °C
>> + *
>> + * The 'value' parameter is in milliCelsius.
>> + */
>>  static inline void hisi_thermal_set_lag(void __iomem *addr, int value)
>>  {
>> -	writel(value, addr + TEMP0_LAG);
>> +	writel((value / HISI_TEMP_STEP) & 0x1F, addr + TEMP0_LAG);
>>  }


[ ... ]

>> -	thermal_zone_device_update(data->sensors.tzd,
>> -				   THERMAL_EVENT_UNSPECIFIED);
>> +	} else if (temp < sensor->thres_temp) {
>> +		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
>> +			 temp, sensor->thres_temp);
>> +	}
> 
> For temperature increasing and decreasing both cases, can always call
> thermal_zone_device_update()?

That is something I asked myself but I finally decided to not change the
current behavior and let that be added in a separate patch.


[ ... ]



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
