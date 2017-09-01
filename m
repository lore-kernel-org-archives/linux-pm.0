From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 02/13] thermal/drivers/hisi: Remove the multiple sensors
 support
Date: Fri, 1 Sep 2017 22:48:47 +0200
Message-ID: <2f333866-9001-9a67-4ae1-7dc92fc28b26@linaro.org>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-2-git-send-email-daniel.lezcano@linaro.org>
 <20170901140523.GB26177@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170901140523.GB26177@leoy-linaro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 01/09/2017 16:05, Leo Yan wrote:
> Hi Daniel,
> 
> On Wed, Aug 30, 2017 at 10:47:26AM +0200, Daniel Lezcano wrote:
>> By essence, the tsensor does not really support multiple sensor at the same
>> time. It allows to set a sensor and use it to get the temperature, another
>> sensor could be switched but with a delay of 3-5ms. It is difficult to read
>> simultaneously several sensors without a big delay.
>>
>> Today, just one sensor is used, it is not necessary to deal with multiple
>> sensors in the code. Remove them and if it is needed in the future add them
>> on top of a code which will be clean up in the meantime.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/hisi_thermal.c | 77 +++++++++++-------------------------------
>>  1 file changed, 20 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
>> index 8381696..92b6889 100644
>> --- a/drivers/thermal/hisi_thermal.c
>> +++ b/drivers/thermal/hisi_thermal.c
>> @@ -39,6 +39,7 @@
>>  #define HISI_TEMP_RESET			(100000)
>>  
>>  #define HISI_MAX_SENSORS		4
>> +#define HISI_DEFAULT_SENSOR		2
> 
> So if we always set the sensor id 2 as default sensor, that means it's
> pointless to bind sensor id in dts. E.g. I change to bind thermal
> sensor 0, then it's impossible to bind successfully:
> 
> -                               thermal-sensors = <&tsensor 2>;
> +                               thermal-sensors = <&tsensor 0>;
> 
> It's okay for this change, do you think we need reflect this in DT
> binding doc [1] ?
> 
> [1] Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt

Actually, the current behavior is to go through all the sensors and
register them. By side effect, we end up by registering a sensor with an
id matching the one specified in the DT, others are failing.

That is because there is something missing in the of-thermal API where
we can't call thermal_zone_of_sensor_register() without a matching index.

That is probably why we have in the drivers/thermal/qoriq_thermal.c file
the qoriq_tmu_get_sensor_id() which inspect the thermal-zone DT
structure for the thermal-sensors and read the sensor's id from there in
order to reuse it for thermal_zone_of_sensor_register(). Needless to say
that is not the right place to do that.

IMHO, as nothing gets changed for the moment on hi6220, we can live with
HISI_DEFAULT_SENSOR until we sort out what to do with
thermal_zone_of_sensor_register().


>>  struct hisi_thermal_sensor {
>>  	struct hisi_thermal_data *thermal;
>> @@ -53,11 +54,10 @@ struct hisi_thermal_data {
>>  	struct mutex thermal_lock;    /* protects register data */
>>  	struct platform_device *pdev;
>>  	struct clk *clk;
>> -	struct hisi_thermal_sensor sensors[HISI_MAX_SENSORS];
>> -
>> -	int irq, irq_bind_sensor;
>> +	struct hisi_thermal_sensor sensors;
>> +	int irq;
>>  	bool irq_enabled;
>> -
>> +	
> 
> Repots whitespace error when I apply patch.

Ok, I will fix that.

[ ... ]

Thanks for the review.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
