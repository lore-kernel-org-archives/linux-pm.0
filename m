From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH V2] thermal/drivers/step_wise: Fix temperature regulation
 misbehavior
Date: Fri, 8 Sep 2017 17:55:24 +0530
Message-ID: <d2fc01f9-c9d9-4247-2baf-6e544e5ef172@ti.com>
References: <20170908030513.GC2755@localhost.localdomain>
 <1504861502-4093-1-git-send-email-daniel.lezcano@linaro.org>
 <2ed0c54f-4e86-308e-92c8-19b8a852286d@ti.com>
 <620ae07f-fd37-d97b-ad0c-5d11a3022084@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <620ae07f-fd37-d97b-ad0c-5d11a3022084@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, john.stultz@linaro.org, leo.yan@linaro.org
List-Id: linux-pm@vger.kernel.org



On Friday 08 September 2017 05:17 PM, Daniel Lezcano wrote:
> On 08/09/2017 11:49, Keerthy wrote:
>>
>>
>> On Friday 08 September 2017 02:35 PM, Daniel Lezcano wrote:
>>> There is a particular situation when the cooling device is cpufreq and the heat
>>> dissipation is not efficient enough where the temperature increases little by
>>> little until reaching the critical threshold and leading to a SoC reset.
>>>
>>> The behavior is reproducible on a hikey6220 with bad heat dissipation (eg.
>>> stacked with other boards).
>>>
>>> Running a simple C program doing while(1); for each CPU of the SoC makes the
>>> temperature to reach the passive regulation trip point and ends up to the
>>> maximum allowed temperature followed by a reset.
>>>
>>> This issue has been also reported by running the libhugetlbfs test suite.
>>>
>>> What is observed is a ping pong between two cpu frequencies, 1.2GHz and 900MHz
>>> while the temperature continues to grow.
>>>
>>> It appears the step wise governor calls get_target_state() the first time with
>>> the throttle set to true and the trend to 'raising'. The code selects logically
>>> the next state, so the cpu frequency decreases from 1.2GHz to 900MHz, so far so
>>> good. The temperature decreases immediately but still stays greater than the
>>> trip point, then get_target_state() is called again, this time with the
>>> throttle set to true *and* the trend to 'dropping'. From there the algorithm
>>> assumes we have to step down the state and the cpu frequency jumps back to
>>> 1.2GHz. But the temperature is still higher than the trip point, so
>>> get_target_state() is called with throttle=1 and trend='raising' again, we jump
>>> to 900MHz, then get_target_state() is called with throttle=1 and
>>> trend='dropping', we jump to 1.2GHz, etc ... but the temperature does not
>>> stabilizes and continues to increase.
>>>
>>> [  237.922654] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=1,throttle=1
>>> [  237.922678] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=1,throttle=1
>>> [  237.922690] thermal cooling_device0: cur_state=0
>>> [  237.922701] thermal cooling_device0: old_target=0, target=1
>>> [  238.026656] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=2,throttle=1
>>> [  238.026680] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=2,throttle=1
>>> [  238.026694] thermal cooling_device0: cur_state=1
>>> [  238.026707] thermal cooling_device0: old_target=1, target=0
>>> [  238.134647] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=1,throttle=1
>>> [  238.134667] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=1,throttle=1
>>> [  238.134679] thermal cooling_device0: cur_state=0
>>> [  238.134690] thermal cooling_device0: old_target=0, target=1
>>>
>>> In this situation the temperature continues to increase while the trend is
>>> oscillating between 'dropping' and 'raising'. We need to keep the current state
>>> untouched if the throttle is set, so the temperature can decrease or a higher
>>> state could be selected, thus prevening this oscillation.
>>>
>>> Keeping the next_target untouched when 'throttle' is true at 'dropping' time
>>> fixes the issue.
>>>
>>> The following traces show the governor does not change the next state if
>>> trend==2 (dropping) and throttle==1.
>>>
>>> [ 2306.127987] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=1,throttle=1
>>> [ 2306.128009] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=1,throttle=1
>>> [ 2306.128021] thermal cooling_device0: cur_state=0
>>> [ 2306.128031] thermal cooling_device0: old_target=0, target=1
>>> [ 2306.231991] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=2,throttle=1
>>> [ 2306.232016] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=2,throttle=1
>>> [ 2306.232030] thermal cooling_device0: cur_state=1
>>> [ 2306.232042] thermal cooling_device0: old_target=1, target=1
>>> [ 2306.335982] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=0,throttle=1
>>> [ 2306.336006] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=0,throttle=1
>>> [ 2306.336021] thermal cooling_device0: cur_state=1
>>> [ 2306.336034] thermal cooling_device0: old_target=1, target=1
>>> [ 2306.439984] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=2,throttle=1
>>> [ 2306.440008] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=2,throttle=0
>>> [ 2306.440022] thermal cooling_device0: cur_state=1
>>> [ 2306.440034] thermal cooling_device0: old_target=1, target=0
>>>
>>> [ ... ]
>>>
>>> After a while, if the temperature continues to increase, the next state becomes
>>> 2 which is 720MHz on the hikey. That results in the temperature stabilizing
>>> around the trip point.
>>>
>>> [ 2455.831982] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=1,throttle=1
>>> [ 2455.832006] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=1,throttle=0
>>> [ 2455.832019] thermal cooling_device0: cur_state=1
>>> [ 2455.832032] thermal cooling_device0: old_target=1, target=1
>>> [ 2455.935985] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=0,throttle=1
>>> [ 2455.936013] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=0,throttle=0
>>> [ 2455.936027] thermal cooling_device0: cur_state=1
>>> [ 2455.936040] thermal cooling_device0: old_target=1, target=1
>>> [ 2456.043984] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=0,throttle=1
>>> [ 2456.044009] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=0,throttle=0
>>> [ 2456.044023] thermal cooling_device0: cur_state=1
>>> [ 2456.044036] thermal cooling_device0: old_target=1, target=1
>>> [ 2456.148001] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=1,throttle=1
>>> [ 2456.148028] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=1,throttle=1
>>> [ 2456.148042] thermal cooling_device0: cur_state=1
>>> [ 2456.148055] thermal cooling_device0: old_target=1, target=2
>>> [ 2456.252009] thermal thermal_zone0: Trip0[type=1,temp=65000]:trend=2,throttle=1
>>> [ 2456.252041] thermal thermal_zone0: Trip1[type=1,temp=75000]:trend=2,throttle=0
>>> [ 2456.252058] thermal cooling_device0: cur_state=2
>>> [ 2456.252075] thermal cooling_device0: old_target=2, target=1
>>>
>>> IOW, this change is needed to keep the state for a cooling device if the
>>> temperature trend is oscillating while the temperature increases slightly.
>>>
>>> Without this change, the situation above leads to a catastrophic crash by a
>>> hardware reset on hikey.
>>
>> Daniel,
>>
>> By design this governor is throttling and un-throttling based on the
>> computed trend.
> 
> Hi Keerthy,
> 
> that was true until commit 3dbfff3d (Nov 2012) but now the function has:

Daniel,

I understand that commit. It still is stepwise every time you see the
trend toggling you end up changing the cooling level. That is what i meant.

> 
> [ ... ]
> 
>         case THERMAL_TREND_RAISING:
>                 if (throttle) {
>                         next_target = cur_state < instance->upper ?
>                                     (cur_state + 1) : instance->upper;
>                         if (next_target < instance->lower)
>                                 next_target = instance->lower;
>                 }
>                 break;
> 
>   If "the trend is raising and we have to throttle" then state++
> 
> The change I'm proposing is an action which is the mirror of the one above.
> 
>   If "the trend is dropping and we don't have to throttle" then state--

I understand this completely.

> 
> 
>> Why not add an intermediate trip point with the highest cooling enabled.
>> Say High alert trip point that allows only the lowest OPP for cpufreq to
>> operate.
>>
>> For example: alert trip is at 100C (where cpufreq cooling kicks in)
>>              critical trip is at 125C(shutdown temperature).
>>
>> We have Something like below @110C which allows only the lowest
>> frequency or lowest 2 frequencies based on experimentation:
>>
>> +&cpu_trips {
>> +	cpu_high_alert: cpu_high_alert {
>> +		temperature = <110000>; /* millicelsius */
>> +		hysteresis = <2000>; /* millicelsius */
>> +		type = "passive";
>> +	};
>> +};
>> +
>> +&cpu_cooling_maps {
>> +	map1: map1 {
>> +		trip = <&cpu_high_alert>;
>> +		cooling-device =
>> +				<&cpu0 2 THERMAL_NO_LIMIT>;
>> +	};
>> +};
>> +
>>
>> I have seen this problem myself on dra7 platforms. The above will cool
>> the device post 110C by keeping the cpu frequency at the lowest or lower
>> values. That way when you are in between 100 - 110C you can still get
>> highest performance depending on the trend computed and post 110C.
> 
> Yeah, so we can drop the graveyard legendary card at clash royal without
> any lag and boil our hands ;)
> 
> Seriously, from my POV, that is a hack to workaround a governor which is
> unable to stabilize the temperature in a specific situation.
> 
> This patch fixes this.


This definitely is an issue i have seen on dra7 and if step_wise by
design can accommodate this change, It will fix the issue!

Then you should be updating the documentation as well.

/*
 * If the temperature is higher than a trip point,
 *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
 *       state for this trip point
 *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
 *       state for this trip point

Now with your patch applied the point b. will change to:

b. if the trend is THERMAL_TREND_DROPPING, Maintain the same cooling
level till the temperature drops below trip point.

Regards,
Keerthy

> 
>   -- Daniel
> 
