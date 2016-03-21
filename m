From: Vladyslav Frolov <frolvlad@gmail.com>
Subject: Re: [REGRESSION] 774ac8b7eff6 ("Thermal: initialize thermal zone
 device correctly") causes performance drop
Date: Mon, 21 Mar 2016 19:14:44 +0700
Message-ID: <CAJABK0Oi6-w3496FSCT5W5J1xKX1fGiDM4bk7aBwB2fv5A3kKQ@mail.gmail.com>
References: <56E9DDED.7000805@redhat.com> <1458362616.3043.1.camel@rzhang1-mobl4>
 <CAJABK0MXJRh9wtud+RQrL-==afymcqVovRC8FAZ6=qG4Sob+Tw@mail.gmail.com> <CAJABK0P3nO24OjH3v9Fs3tCgdayAWT+Nx9ivfNiCgZua0_L-XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJABK0P3nO24OjH3v9Fs3tCgdayAWT+Nx9ivfNiCgZua0_L-XQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Laura Abbott <labbott@redhat.com>, Javi Merino <javi.merino@arm.com>, Chen Yu <yu.c.chen@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manuel Krause <manuelkrause@netscape.net>, szegad <szegadlo@poczta.onet.pl>, prash <prash.n.rao@gmail.com>, amish <ammdispose-arch@yahoo.com>, Matthias <morpheusxyz123@yahoo.de>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rui,

The patch seems to work fine! I have tried both `rmmod & modprobe
thermal` and suspend & resume. Great!

On 21 March 2016 at 18:14, Vladyslav Frolov <frolvlad@gmail.com> wrote:
> Hi Rui,
>
> I'm sorry for the delay; Reading the e-mail the first time I have
> missed the part about the patch, so I'm building the kernel now.
>
> By the way, the patch reported a slight offset missmatch:
>
> patching file drivers/thermal/thermal_core.c
> Hunk #2 succeeded at 1800 (offset -4 lines).
> Hunk #3 succeeded at 1872 (offset -4 lines).
>
> Is this fine?
>
>
> On 21 March 2016 at 18:09, Vladyslav Frolov <frolvlad@gmail.com> wrote:
>> Hi Rui,
>>
>> I'm sorry for the delay; Reading the e-mail the first time I have missed the
>> part about the patch, so I'm building the kernel now.
>>
>> By the way, the patch reported a slight offset missmatch:
>>
>> patching file drivers/thermal/thermal_core.c
>> Hunk #2 succeeded at 1800 (offset -4 lines).
>> Hunk #3 succeeded at 1872 (offset -4 lines).
>>
>> Is this fine?
>>
>>
>>
>> On 19 March 2016 at 11:43, Zhang Rui <rui.zhang@intel.com> wrote:
>>>
>>>
>>> Hi, all,
>>>
>>> On Wed, 2016-03-16 at 15:27 -0700, Laura Abbott wrote:
>>> > Hi,
>>> >
>>> > Fedora received a bug report
>>> > (https://bugzilla.redhat.com/show_bug.cgi?id=1317190)
>>> > of a major performance drop on various bench marks and general system
>>> > sluggishness with the 4.4.4 kernel update. The benchmarks were showing
>>> > a reduction to about 18% performance (not minor).
>>> >
>>> > Bisection showed the first bad commit was
>>> >
>>> > commit 774ac8b7eff69e0786970157de2157e68b22f456
>>> > Author: Zhang Rui <rui.zhang@intel.com>
>>> > Date:   Fri Oct 30 16:31:47 2015 +0800
>>> >
>>> >      Thermal: initialize thermal zone device correctly
>>> >
>>> >      commit bb431ba26c5cd0a17c941ca6c3a195a3a6d5d461 upstream.
>>> >
>>> >      After thermal zone device registered, as we have not read any
>>> >      temperature before, thus tz->temperature should not be 0,
>>> >      which actually means 0C, and thermal trend is not available.
>>> >      In this case, we need specially handling for the first
>>> >      thermal_zone_device_update().
>>> >
>>> >      Both thermal core framework and step_wise governor is
>>> >      enhanced to handle this. And since the step_wise governor
>>> >      is the only one that uses trends, so it's the only thermal
>>> >      governor that needs to be updated.
>>> >
>>> >      Tested-by: Manuel Krause <manuelkrause@netscape.net>
>>> >      Tested-by: szegad <szegadlo@poczta.onet.pl>
>>> >      Tested-by: prash <prash.n.rao@gmail.com>
>>> >      Tested-by: amish <ammdispose-arch@yahoo.com>
>>> >      Tested-by: Matthias <morpheusxyz123@yahoo.de>
>>> >      Reviewed-by: Javi Merino <javi.merino@arm.com>
>>> >      Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>> >      Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>> >      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> According to https://bugzilla.redhat.com/show_bug.cgi?id=1317190#c30
>>> and https://bugzilla.kernel.org/show_bug.cgi?id=114551,
>>> the root cause of the problem is that
>>> 1. BIOS reports bogus passive trip point value, which is 0 degree
>>> Celsius
>>> 2. Without the thermal patches, thermal core does nothing upon driver
>>> probe, thus processor cooling states are not changed.
>>> 3. With the thermal patches applied, thermal core checks the new
>>> registered thermal zone driver when it is probed, and set the cooling
>>> devices to proper state, for example, fan device could be spinning
>>> during boot, even if the system is cool.
>>> 4. Thus, on these Lenovo laptops, processor cooling devices are
>>> throttled because the current temperature (around 50C) is higher than
>>> the passive trip point (0C), and the thermal zone is considered as
>>> overheating.
>>>
>>> In order to workaround this bogus BIOS, we should disable those invalid
>>> trip points by checking the trip point value, like the patch below,
>>> Laura and Vlad,
>>> can you please try the patch below and confirm if it fixes the problem
>>> for you?
>>>
>>> From 81ad4276b505e987dd8ebbdf63605f92cd172b52 Mon Sep 17 00:00:00 2001
>>> From: Zhang Rui <rui.zhang@intel.com>
>>> Date: Fri, 18 Mar 2016 10:03:24 +0800
>>> Subject: [PATCH] Thermal: Ignore invalid trip points
>>>
>>> In some cases, platform thermal driver may report invalid trip points,
>>> thermal core should not take any action for these trip points.
>>>
>>> This fixed a regression that bogus trip point starts to screw up thermal
>>> control on some Lenovo laptops, after
>>> commit bb431ba26c5cd0a17c941ca6c3a195a3a6d5d461
>>> Author: Zhang Rui <rui.zhang@intel.com>
>>> Date:   Fri Oct 30 16:31:47 2015 +0800
>>>
>>>     Thermal: initialize thermal zone device correctly
>>>
>>>     After thermal zone device registered, as we have not read any
>>>     temperature before, thus tz->temperature should not be 0,
>>>     which actually means 0C, and thermal trend is not available.
>>>     In this case, we need specially handling for the first
>>>     thermal_zone_device_update().
>>>
>>>     Both thermal core framework and step_wise governor is
>>>     enhanced to handle this. And since the step_wise governor
>>>     is the only one that uses trends, so it's the only thermal
>>>     governor that needs to be updated.
>>>
>>>     Tested-by: Manuel Krause <manuelkrause@netscape.net>
>>>     Tested-by: szegad <szegadlo@poczta.onet.pl>
>>>     Tested-by: prash <prash.n.rao@gmail.com>
>>>     Tested-by: amish <ammdispose-arch@yahoo.com>
>>>     Tested-by: Matthias <morpheusxyz123@yahoo.de>
>>>     Reviewed-by: Javi Merino <javi.merino@arm.com>
>>>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>>     Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>>
>>> CC: <stable@vger.kernel.org> #3.18+
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1317190
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=114551
>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>> ---
>>>  drivers/thermal/thermal_core.c | 13 ++++++++++++-
>>>  include/linux/thermal.h        |  2 ++
>>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/thermal_core.c
>>> b/drivers/thermal/thermal_core.c
>>> index a0a8fd1..d4b5465 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -454,6 +454,10 @@ static void handle_thermal_trip(struct
>>> thermal_zone_device *tz, int trip)
>>>  {
>>>         enum thermal_trip_type type;
>>>
>>> +       /* Ignore disabled trip points */
>>> +       if (test_bit(trip, &tz->trips_disabled))
>>> +               return;
>>> +
>>>         tz->ops->get_trip_type(tz, trip, &type);
>>>
>>>         if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
>>> @@ -1800,6 +1804,7 @@ struct thermal_zone_device
>>> *thermal_zone_device_register(const char *type,
>>>  {
>>>         struct thermal_zone_device *tz;
>>>         enum thermal_trip_type trip_type;
>>> +       int trip_temp;
>>>         int result;
>>>         int count;
>>>         int passive = 0;
>>> @@ -1871,9 +1876,15 @@ struct thermal_zone_device
>>> *thermal_zone_device_register(const char *type,
>>>                 goto unregister;
>>>
>>>         for (count = 0; count < trips; count++) {
>>> -               tz->ops->get_trip_type(tz, count, &trip_type);
>>> +               if (tz->ops->get_trip_type(tz, count, &trip_type))
>>> +                       set_bit(count, &tz->trips_disabled);
>>>                 if (trip_type == THERMAL_TRIP_PASSIVE)
>>>                         passive = 1;
>>> +               if (tz->ops->get_trip_temp(tz, count, &trip_temp))
>>> +                       set_bit(count, &tz->trips_disabled);
>>> +               /* Check for bogus trip points */
>>> +               if (trip_temp == 0)
>>> +                       set_bit(count, &tz->trips_disabled);
>>>         }
>>>
>>>         if (!passive) {
>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>> index 9c48199..a55d052 100644
>>> --- a/include/linux/thermal.h
>>> +++ b/include/linux/thermal.h
>>> @@ -156,6 +156,7 @@ struct thermal_attr {
>>>   * @trip_hyst_attrs:   attributes for trip points for sysfs: trip
>>> hysteresis
>>>   * @devdata:   private pointer for device private data
>>>   * @trips:     number of trip points the thermal zone supports
>>> + * @trips_disabled;    bitmap for disabled trips
>>>   * @passive_delay:     number of milliseconds to wait between polls when
>>>   *                     performing passive cooling.
>>>   * @polling_delay:     number of milliseconds to wait between polls when
>>> @@ -191,6 +192,7 @@ struct thermal_zone_device {
>>>         struct thermal_attr *trip_hyst_attrs;
>>>         void *devdata;
>>>         int trips;
>>> +       unsigned long trips_disabled;   /* bitmap for disabled trips */
>>>         int passive_delay;
>>>         int polling_delay;
>>>         int temperature;
>>> --
>>> 1.9.1
>>>
>>>
>>>
>>
