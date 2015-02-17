From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] thermal: Default OF created trip points to writable
Date: Tue, 17 Feb 2015 11:12:22 +0000
Message-ID: <9hh1tloaj1l.fsf@e105922-lin.cambridge.arm.com>
References: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
	<20150216151432.GB8648@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:46947 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755185AbbBQLLy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 06:11:54 -0500
In-Reply-To: <20150216151432.GB8648@developer.hsd1.ca.comcast.net> (Eduardo
	Valentin's message of "Mon, 16 Feb 2015 11:14:34 -0400")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org

Eduardo Valentin <edubezval@gmail.com> writes:

> Hey Punit,
>
> On Tue, Feb 10, 2015 at 06:21:46PM +0000, Punit Agrawal wrote:
>> When registering a thermal zone from device tree, default the trip
>> points to writable. By default, only the root user can change these.
>> 
>> This allows the trip points to be tweaked after the system has
>> booted.
>
> Can you please elaborate more on why having default writable makes sense
> against having default read only? The purpose of this patch seams to be
> targeted to development/debugging systems, not productions systems. The
> default has to make sense for production systems.

Agreed about the default making sense for production systems.

We've seen deployments in the field where the default value of the trip
temperatures are modulated by a userspace component that has contextual
knowledge about workloads and device margins. Using OF for thermal
setup, it is not possible to get this functionality.

I guess you are worried about safety - as you still need root privileges
to be able to change the trip temperatures so it's not by-passing the
security setup of the system.

>
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> ---
>> Hi Eduardo,
>> 
>> We've been using this patch internally and haven't run into any
>>  issues. Without these changes there is no way to change trip points
>>  from a running system.
>
> Ok. I see.
>
> So, the problem statement here is to be able to change the trip points
> from a running system. What is the purpose? Do you have something in
> userland that is benefiting of having these trips writable? Or is it
> just for development fun?

Sure it helps with development too. In a workflow where the development
of the drivers and the tuning are separate activities, and not
necessarily done by the same people, it is very helpful to be able to
evaluate different parameters for power-performance-thermal tuning
without having to rebuild the dtb and reboot the system.

I think it makes it easier for folks to get up and running with OF and
thermals. But I'll defer to your judgement here.

Cheers,
Punit

>
>
> BR,
>
> Eduardo Valentin
>
>> 
>> Comments welcome.
>> 
>> Cheers,
>> Punit
>> 
>>  drivers/thermal/of-thermal.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
>> index 668fb1b..b7ad5c0 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -865,6 +865,7 @@ int __init of_parse_thermal_zones(void)
>>  	for_each_child_of_node(np, child) {
>>  		struct thermal_zone_device *zone;
>>  		struct thermal_zone_params *tzp;
>> +		int i, mask = 0;
>>  
>>  		/* Check whether child is enabled or not */
>>  		if (!of_device_is_available(child))
>> @@ -891,8 +892,11 @@ int __init of_parse_thermal_zones(void)
>>  		/* No hwmon because there might be hwmon drivers registering */
>>  		tzp->no_hwmon = true;
>>  
>> +		for (i = 0; i < tz->ntrips; i++)
>> +			mask |= 1 << i;
>> +
>>  		zone = thermal_zone_device_register(child->name, tz->ntrips,
>> -						    0, tz,
>> +						    mask, tz,
>>  						    ops, tzp,
>>  						    tz->passive_delay,
>>  						    tz->polling_delay);
>> -- 
>> 2.1.4
>> 
