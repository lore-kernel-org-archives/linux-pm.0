From: Laura Abbott <labbott@redhat.com>
Subject: Re: [REGRESSION] 774ac8b7eff6 ("Thermal: initialize thermal zone
 device correctly") causes performance drop
Date: Fri, 18 Mar 2016 15:28:44 -0700
Message-ID: <56EC811C.6020404@redhat.com>
References: <56E9DDED.7000805@redhat.com> <20160316224634.GA3580@kroah.com>
 <56E9F387.9080703@redhat.com> <1458173863.4703.18.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34019 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbcCRW2s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 18:28:48 -0400
Received: by mail-pf0-f180.google.com with SMTP id x3so184659843pfb.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 15:28:47 -0700 (PDT)
In-Reply-To: <1458173863.4703.18.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "ammdispose-arch@yahoo.com" <ammdispose-arch@yahoo.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "manuelkrause@netscape.net" <manuelkrause@netscape.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "szegadlo@poczta.onet.pl" <szegadlo@poczta.onet.pl>, "prash.n.rao@gmail.com" <prash.n.rao@gmail.com>, "javi.merino@arm.com" <javi.merino@arm.com>, "morpheusxyz123@yahoo.de" <morpheusxyz123@yahoo.de>, frolvlad@gmail.com

(bringing this back to the main thread)

On 03/16/2016 05:20 PM, Pandruvada, Srinivas wrote:
> On Wed, 2016-03-16 at 17:00 -0700, Laura Abbott wrote:
>> On 03/16/2016 03:46 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Mar 16, 2016 at 03:27:57PM -0700, Laura Abbott wrote:
>>>> Hi,
>>>>
>>>> Fedora received a bug report (https://bugzilla.redhat.com/show_bu
>>>> g.cgi?id=1317190)
>>>> of a major performance drop on various bench marks and general
>>>> system
>>>> sluggishness with the 4.4.4 kernel update. The benchmarks were
>>>> showing
>>>> a reduction to about 18% performance (not minor).
>>>>
>>>> Bisection showed the first bad commit was
>>>>
>>>> commit 774ac8b7eff69e0786970157de2157e68b22f456
>>>> Author: Zhang Rui <rui.zhang@intel.com>
>>>> Date:   Fri Oct 30 16:31:47 2015 +0800
>>>>
>>>>       Thermal: initialize thermal zone device correctly
>>>>       commit bb431ba26c5cd0a17c941ca6c3a195a3a6d5d461 upstream.
>>>>       After thermal zone device registered, as we have not read
>>>> any
>>>>       temperature before, thus tz->temperature should not be 0,
>>>>       which actually means 0C, and thermal trend is not available.
>>>>       In this case, we need specially handling for the first
>>>>       thermal_zone_device_update().
>>>>       Both thermal core framework and step_wise governor is
>>>>       enhanced to handle this. And since the step_wise governor
>>>>       is the only one that uses trends, so it's the only thermal
>>>>       governor that needs to be updated.
>>>>       Tested-by: Manuel Krause <manuelkrause@netscape.net>
>>>>       Tested-by: szegad <szegadlo@poczta.onet.pl>
>>>>       Tested-by: prash <prash.n.rao@gmail.com>
>>>>       Tested-by: amish <ammdispose-arch@yahoo.com>
>>>>       Tested-by: Matthias <morpheusxyz123@yahoo.de>
>>>>       Reviewed-by: Javi Merino <javi.merino@arm.com>
>>>>       Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>>>       Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>>>       Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.or
>>>> g>
>>>>
>>>>
>>>>
>>>> Reverting this plus to other commits in the series (a67208e94d94
>>>> "Thermal: handle thermal zone device properly during system
>>>> sleep"
>>>> and 27f356149d59 "Thermal: do thermal zone update after a cooling
>>>> device registered") confirmed the performance was back to normal.
>>>>
>>>> Bugzilla has the full discussion but this comment from one of the
>>>> reporters sums it up:
>>>>
>>>> "In 4.4.3 and prior, my 2.40 MHz processor would fluctuate
>>>> between
>>>> 1000 and 3400 MHz.  In 4.4.4, the processor would fluctuate
>>>> between
>>>> 400 and 700 MHz, according to /proc/cpuinfo.
>>>>
>>>> Setting /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
>>>> to
>>>> performance, instead of the default "powersave" forces the CPU to
>>>> 2400 MHz, and improves performance greatly, but still not to the
>>>> same level as in 4.4.3."
>>>>
>>>> Any ideas?
>>>
>>> Is this same "slowdown" also seen in 4.5?
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> Yes, the same issue is seen on 4.5 according to the reporter.
> What does it show here when performance drops?
> grep . /sys/devices/system/cpu/intel_pstate/*
>
> Is the problem still occurs if you set
> /sys/class/thermal/thermal_zone*/mode to "disabled"
>
> Thanks,
> Srinivas
>

A separate thread was started which gave this insight:

"I think
the problem is your device has a passive trip temp of 0
/sys/class/thermal/thermal_zone0/trip_point_2_temp:0
/sys/class/thermal/thermal_zone0/trip_point_2_type:passive

Which triggers a false throttle = true. I think we should this trip as
invalid in the case of
if (tz->temperature >= trip_temp) {} check
in thermal_zone_trip_update()."

So would something like the following work?

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index ea9366a..1228797 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -143,7 +143,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
  
         trend = get_tz_trend(tz, trip);
  
-       if (tz->temperature >= trip_temp) {
+       if (trip_type != THERMAL_TRIPS_NONE && tz->temperature >= trip_temp) {
                 throttle = true;
                 trace_thermal_zone_trip(tz, trip, trip_type);
         }

(completely untested, no idea if I'm even close)

Thanks,
Laura
