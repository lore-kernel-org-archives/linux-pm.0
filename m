From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH] fix: thermal: avoid possible deadlock calling
 thermal_zone_get_temp()
Date: Mon, 13 Mar 2017 14:52:30 +0000
Message-ID: <15cc711d-b409-06a0-097d-56afe815e0d7@arm.com>
References: <20170210161547.28625-1-lukasz.luba@arm.com>
 <1489373034.5841.14.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbdCMOwd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Mar 2017 10:52:33 -0400
In-Reply-To: <1489373034.5841.14.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com, linux-pm@vger.kernel.org


>>
>> tz->gov->throttle() [=power_allocator_throttle]
>>   power_allocator_throttle
>>     allocate_power
>> ==>   (lock tz->lock taken)
>>       (for each cooling device:)
>>          cdev->ops->get_requested_power
>>          [=devfreq_cooling_get_requested_power]
>>               get_static_power
>>                  (call driver specific function)
>>                  dfc->power_ops->get_static_power
>>                  [=mock_devfreq_get_static_power]
>>                       tz = thermal_zone_get_zone_by_name()
>>                       thermal_zone_get_temp(tz, &temp)
>> ===>                    (try to lock again tz->lock)
>>
> I didn't find mock_devfreq_get_static_power, thus I don't understand
> why thermal_zone_get_zone_by_name() and thermal_zone_get_temp() needs
> to be called in .get_static_power() callback.

The mock_devfreq_get_static_power is just the mock function which
mimics a driver function registered to get_static_power.
Inside this function you can ask for thermal zone pointer
to check the temperature in that thermal_zone.
Based on that temperature you can scale your static power value
before returning it to the framework.

So in this case the driver code should not scale the static
power based on temperature (for now).

>
>> This patch changes the mutex_lock into mutex_trylock
>> just to avoid the deadlock.
>>
> Well, I don't think this is the right solution.
> We should either avoid poking thermal lock in .get_static_power()
> callback, in the thermal driver, or avoid invoking the callback with
> lock hold, in power_allocator code.

I agree that this is not the solution.
It just highlights the problem.
I will try to allocate some time for this issue.

Regards,
Lukasz Luba
