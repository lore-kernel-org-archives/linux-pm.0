From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH v3 3/5] thermal: rockchip: fixes invalid temperature case
Date: Mon, 12 Dec 2016 18:46:16 +0800
Message-ID: <e5356242-590a-821b-c80f-d63bfcf85c9f@rock-chips.com>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-4-git-send-email-wxt@rock-chips.com>
 <20161129014553.GA3097@localhost.localdomain>
 <20161129215744.GA99997@google.com>
 <20161130050239.GA27079@localhost.localdomain>
 <20161130055927.GA125421@google.com>
 <20161130062658.GA28498@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.139]:51736 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932338AbcLLKqk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 05:46:40 -0500
In-Reply-To: <20161130062658.GA28498@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Brian Norris <briannorris@chromium.org>
Cc: heiko@sntech.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, linux-rockchip@lists.infradead.org, rui.zhang@intel.com, Caesar Wang <wxt@rock-chips.com>

Hi

在 2016年11月30日 14:26, Eduardo Valentin 写道:
> Hello,
>
> On Tue, Nov 29, 2016 at 09:59:28PM -0800, Brian Norris wrote:
>> On Tue, Nov 29, 2016 at 09:02:42PM -0800, Eduardo Valentin wrote:
>>> On Tue, Nov 29, 2016 at 01:57:45PM -0800, Brian Norris wrote:
>>>> I was thinking while reviewing that the binary search serves more to
>>>> complicate things than to help -- it's much harder to read (and validate
>>>> that the loop termination logic is correct). And searching through a few
>>>> dozen table entries doesn't really get much benefit from a O(n) ->
>>>> O(log(n)) speed improvement.
>>> true. but if in your code path you do several walks in the table just to
>>> check if parameters are valid, given that you could simply decide if
>>> they are valid or not with simpler if condition, then, still worth, no?
>>> :-)
>> Yes, your suggestions seems like they would have made the code both (a
>> little) more straightforward and efficient. But...
>>
>>>> Anyway, I'm not sure if you were thinking along the same lines as me.
>>>>
>>> Something like that, except I though of something even simpler:
>>> +	if ((temp % table->step) != 0)
>>> +		return -ERANGE;
>>>
>>> If temp passes that check, then you go to the temp -> code conversion.
>> ...that check isn't valid as of patch 4, where Caesar adds handling for
>> intermediate steps. We really never should have been strictly snapping
>> to the 5C steps in the first place; intermediate values are OK.
>>
>> So, we still need some kind of search to find the right step -- or
>> closest bracketing range, to compute the interpolated value. We should
>> only reject temperatures that are too high or too low for the ADC to
>> represent.
> Ok. got it. check small comment on patch 4 then.
>
>>
>> --- Side track ---
>>
>> BTW, when we're considering rejecting temperatures here: shouldn't this
>> be fed back to the upper layers more nicely? We're improving the error
>> handling for this driver in this series, but it still leaves things
>> behaving a little odd. When I tested, I can do:
>>
>> ## set something obviously way too high
>> echo 700000 > trip_point_X_temp
>>
>> and get a 0 (success) return code from the sysfs write() syscall, even
>> though the rockchip driver rejected it with -ERANGE. Is there really no
>> way to feed back thermal range limits of a sensor to the of-thermal
>> framework?
>>
> well, that is a bit strange to me. Are you sure you are returning the
> -ERANGE? Because, my assumption is that the following of-thermal code
> path would return the error code back to core:
>   328         if (data->ops->set_trip_temp) {
>   329                 int ret;
>   330
>   331                 ret = data->ops->set_trip_temp(data->sensor_data, trip, temp);
>   332                 if (ret)
>   333                         return ret;
>   334         }
>
> And this part of thermal core would return it back to sysfs layer:
>   757         ret = tz->ops->set_trip_temp(tz, trip, temperature);
>   758         if (ret)
>   759                 return ret;
>
> or am I missing something?

that should be related to the many trips. The trips will search the next 
trips.
So in general, trip_ponit_0_temp <= trip_ponit_1_temp <=trip_ponit_1_temp.

I'm assume you set"echo 700000 > trip_point_0_temp", and you keep trip1 
and trip2....

  [   34.449718] trip_point_temp_store, temp=700000
[   34.454568] of_thermal_set_trip_temp:336,temp=700000
[   34.459612] thermal_sys: thermal_zone_set_trips:583, temp=45000, 
trip_temp=700000, hys=2000
[   34.468026] thermal_sys: thermal_zone_set_trips:583, temp=45000, 
trip_temp=85000, hys=2000
[   34.476336] thermal_sys: thermal_zone_set_trips:583, temp=45000, 
trip_temp=95000, hys=2000
[   34.484634] thermal thermal_zone0: new temperature boundaries: 
-2147483647 < x < 85000
[   34.492619] rockchip-thermal ff260000.tsadc: 
rockchip_thermal_set_trips: sensor 0: low: -2147483647, high 85000
===>　So rockchip thermal will return 0.


That should report error when you meet the needs of order.
order--> trip_ponit_0_temp <= trip_ponit_1_temp <=trip_ponit_1_temp.

Fox example:
[  100.898552] thermal_sys: thermal_zone_set_trips:583, temp=58333, 
trip_temp=700000, hys=2000
[  100.906964] thermal_sys: thermal_zone_set_trips:583, temp=58333, 
trip_temp=710000, hys=2000
[  100.916329] thermal_sys: thermal_zone_set_trips:583, temp=58333, 
trip_temp=720000, hys=2000
[  100.924685] thermal thermal_zone0: new temperature boundaries: 
-2147483647 < x < 700000
[  100.932965] rockchip-thermal ff260000.tsadc: 
rockchip_thermal_set_trips: sensor 0: low: -2147483647, high 700000
[  100.943138] rk_tsadcv2_alarm_temp:682, temp=700000
[  100.948201] rk_tsadcv2_temp_to_code: invalid temperature, temp=700000 
error=1023
[  100.955598] thermal thermal_zone0: Failed to set trips: -34
===>　So rockchip thermal will return error.

-
Caesar
>
>> Brian
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


