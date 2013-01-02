From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 0/7] Support for Multiple sensors per zone
Date: Wed, 2 Jan 2013 18:46:15 +0200
Message-ID: <50E46457.8090108@ti.com>
References: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com> <50E456B7.6010401@ti.com> <4D68720C2E767A4AA6A8796D42C8EB59252EA0@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44038 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab3ABQqd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jan 2013 11:46:33 -0500
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59252EA0@BGSMSX101.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "wni@nvidia.com" <wni@nvidia.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "hongbo.zhang@linaro.org" <hongbo.zhang@linaro.org>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>

Hello Durga,

On 02-01-2013 18:29, R, Durgadoss wrote:
> Hello Eduardo,
>
>> -----Original Message-----
>> From: Eduardo Valentin [mailto:eduardo.valentin@ti.com]
>> Sent: Wednesday, January 02, 2013 9:18 PM
>> To: R, Durgadoss
>> Cc: Zhang, Rui; linux-pm@vger.kernel.org; wni@nvidia.com;
>> amit.kachhap@linaro.org; hongbo.zhang@linaro.org;
>> sachin.kamat@linaro.org
>> Subject: Re: [RFC PATCH 0/7] Support for Multiple sensors per zone
>>
>>
>> Hello Durga,
>>
>> First of all, sorry for the late answer. Happy New Year to you BTW. :-)
>
> Wish you a Happy New Year too :-)

Thanks.

> Yeah, we are talking after a long time!!
>

Indeed.

>>
>> On 17-11-2012 12:45, Durgadoss R wrote:
>>> This patch series attempts to add support for multiple
>>> sensors per zone. The work is based on the Thermal discussion
>>> happened in plumbers conference 2012, here:
>>> http://www.linuxplumbersconf.org/2012/schedule/
>>> Title: "Enhancing the Thermal Management Infrastructure in Linux"
>>>
>>
>> On the above discussion one point which was not really clear was if we
>> would create virtual thermal zones, with a fop to determine its
>> temperature in a given time, or if we would write APIs to fetch
>> temperature from a thermal zone and then in the platform code to would
>> derive the real temperature.

Forgot to mention that the agreement during the thermal session was to 
use the concept of virtual thermal zone/sensor as agregator.

>
> A really difficult but interesting question; Happy to answer :-)
> Actually we discussed this very same point various times internally,
> before coming up with this new framework. Let me explain that in
> brief to you.
>
>>
>>   From this patch series, looks like we are going to both directions at
>> the same time. Let me try to understand your proposal by introducing a
>> simple example.
>>
>> Let us assume a simple scenario which we have a thermal zone with 2
>> sensors, say, for skin management, one for back cover and one for LCD.
>> Assume also you have two different HW sensors, for whatever reason. By
>> your proposal, we would have two simple sensor drivers, one for each HW,
>> which is good. A platform driver that would add these two sensor
>> instances into a thermal zone.
>
> Perfect. Valid example.
>
>>
>> Now. what I don't know is how to determine the temperature of that zone.
>
> Yeah. Here we are.
>  From the new framework onwards, we are treating the 'zone' as a complete
> virtual concept. A zone can have multiple sensors reporting temperature.
>
> To compute the 'theoretical zone temperature', consider 'zone' as a 'virtual
> sensor'. This means, the platform driver will register one more sensor using
> thermal_sensor_register API with a name 'virtual_XXXX' (or something like
> that; we have not finalized the name yet). This sensor can be added to the
> required zone also. Now, to compute the zone temperature, the 'get_temp'
> callback of this sensor (inside the platform driver) can do 'whatever magic
> it wants to do'.

OK. then we are going to do same thing we discussed in LPC. Just that I 
got a bit confused on the patch set. Reusing get_temp is actually ideal 
because we can keep the remaining API as it is.

> A rather simple magic could be:
> temp_of_virtual_sensor = (sum of all sensor
> temperatures in this zone)/num_sensors_in_this_zone.
>

Yeah.

> This way, we could provide trip_points & thresholds for this virtual sensor
> also. i.e. everything else remains same.

Exactly.

>
>> I believe we need to have a thermal zone fops with get temperature. I am
>
> We thought through this to some extent.
> Assume we introduce a 'temp' sysfs interface (and the fops) for zone temperature.
> Now, we have to provide trip_points and thresholds also for this; Then, in the
> governors, what should we refer to ? on what basis shall we take actions ?
> Based on sensor temperature crossing a trip point ? or
> Based on the zone temperature crossing its own trip point ?
> If it is zone based, then it has to be 'polled' because a virtual zone
> cannot support programmable thresholds.

Yeah, I think using the concept of virtual thermal zone is the best. The 
trips and cooling actions are bound to the provided computed 
temperature, and then everything else remains the same, except that the 
zone temperature is actually synthetic.

>
> Moreover, the platform data mapping is also between sensors and
> cooling devices. A close look at patches 4 & 5 will explain this.
> So, If we go by 'zone' = 'virtual sensor',
> the governors can work as usual, and the way we provide platform data
> remains the same etc.. Hence, this idea was chosen.
>

good. that was also my suggestion during LPC.

> This 'virtual sensor' is also one important reason why we want to
> maintain the separation between 'sensor drivers' and 'platform drivers'.
> One that works for the hardware, and the other which can do magic :-)
>
> Let me know if this makes sense.

Yes it does. I will have a closer look on your series and come back later.

>
> Thanks again for the question!!
>
> Thanks,
> Durga
>
>> assuming the platform driver would be the one who introduces the thermal
>> zone, and adds the sensors, and knows how to determine the temperature
>> of that zone. This way, one can easily write a function to determine the
>> "summary temperature". Remember that using index to select one specific
>> temperature sensor for a given time may not be enough, as there are
>> scenarios in which one may write an equation which uses all sensors
>> temperature values to determine the ending zone temperature.
>>
>>> The intention is to make it easy for generic sensor drivers
>>> to register with the framework, and let them participate in
>>> platform thermal management. Another goal is to expose the
>>> binding information in a consistent way so that user space
>>> can consume the information and potentially manage platform thermals.
>>>
>>> This series contains 7 patches:
>>> Patch 1/7: Creates new sensor level APIs
>>> Patch 2/7: Creates new zone level APIs. The existing tzd structure is
>>> 	   kept as such for clarity and compatibility purposes.
>>> Patch 3/7: Creates functions to add/remove a cdev to/from a zone. The
>>> 	   existing tcd structure need not be modified.
>>> Patch 4/7: Adds a thermal_trip sysfs node, which exposes various trip
>>> 	   points for all sensors present in a zone.
>>> Patch 5/7: Adds a thermal_map sysfs node. It is a compact representation
>>> 	   of the binding relationship between a sensor and a cdev,
>>> 	   within a zone.
>>> Patch 6/7: Creates Documentation for the new APIs. A new file is
>>> 	   created for clarity. Final goal is to merge with the existing
>>> 	   file or refactor the files, as whatever seems appropriate.
>>> Patch 7/7: A dummy driver that can be used for testing. This is not for
>> merge.
>>>
>>> Next steps:
>>>    1. Move all the existing drivers to the new implementation model.
>>>       Help welcomed from individual driver authors/maintainers for this.
>>>    2. Make the thermal governors work with this new model.
>>>    3. Remove old/unused code from thermal_sys.c.
>>>    4. Add more detailed documentation
>>>
>>>    I didn't want to submit patches for all these in one-go, since it
>>>    might end-up being difficult to comprehend, besides delaying the
>>>    review process. The other obvious reason being I cannot test all
>>>    the changes on various drivers for 1.
>>>
>>>    All these patches have been tested on a Core-i5 desktop running
>>>    ubuntu 12.04 and an atom notebook running ubuntu 11.10.
>>>    Kindly help review.
>>>
>>> Durgadoss R (7):
>>>     Thermal: Create sensor level APIs
>>>     Thermal: Create zone level APIs
>>>     Thermal: Add APIs to bind cdev to new zone structure
>>>     Thermal: Add Thermal_trip sysfs node
>>>     Thermal: Add 'thermal_map' sysfs node
>>>     Thermal: Add Documentation to new APIs
>>>     Thermal: Dummy driver used for testing
>>>
>>>    Documentation/thermal/sysfs-api2.txt |  213 ++++++++
>>>    drivers/thermal/Kconfig              |    5 +
>>>    drivers/thermal/Makefile             |    3 +
>>>    drivers/thermal/thermal_sys.c        |  915
>> ++++++++++++++++++++++++++++++++++
>>>    drivers/thermal/thermal_test.c       |  321 ++++++++++++
>>>    include/linux/thermal.h              |  118 +++++
>>>    6 files changed, 1575 insertions(+)
>>>    create mode 100644 Documentation/thermal/sysfs-api2.txt
>>>    create mode 100644 drivers/thermal/thermal_test.c
>>>
>

