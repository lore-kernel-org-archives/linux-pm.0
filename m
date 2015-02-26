From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] thermal: Default OF created trip points to writable
Date: Thu, 26 Feb 2015 10:16:19 +0000
Message-ID: <9hh4mq96kr0.fsf@e105922-lin.cambridge.arm.com>
References: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
	<20150216151432.GB8648@developer.hsd1.ca.comcast.net>
	<9hh1tloaj1l.fsf@e105922-lin.cambridge.arm.com>
	<20150224195201.GB353@developer.amazonguestwifi.org>
	<9hhbnki6uvp.fsf@e105922-lin.cambridge.arm.com>
	<20150225184742.GE2306@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:36324 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752193AbbBZKPt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 05:15:49 -0500
In-Reply-To: <20150225184742.GE2306@developer.amazonguestwifi.org> (Eduardo
	Valentin's message of "Wed, 25 Feb 2015 14:47:47 -0400")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org

Eduardo Valentin <edubezval@gmail.com> writes:

> Punit,
>
> On Wed, Feb 25, 2015 at 12:25:14PM +0000, Punit Agrawal wrote:
>> Eduardo Valentin <edubezval@gmail.com> writes:
>> 
>
> <cut>
>
>> > What is your optionion?
>> 
>> Although I understand your motivation for suggesting (1), I am not sure
>> this will work in practice. As soon as one platform enables the option
>> in the defconfig (arm64) or multi_v7_defconfig (arm), all platforms will
>> have it enabled.
>
> Well, just because it is enabled by default, it does not mean that
> everybody has to follow what is in defconfig. In practice, when building
> production kernels, defconfigs are changed.
>
> My concern now is more about allowing people to have the possibility to
> change the expected behavior. Only with the original patch, it will
> always be writable.

Makes sense. With the patch below, where required the Kconfig can be
turned off.


[...]

>> 
>> -- >8 --
>> 
>> Subject: [PATCH] thermal: core: Add Kconfig option to enable writable trips
>> 
>> Add a Kconfig option to allow system integrators to control whether
>> userspace tools can change trip temperatures. This option overrides
>> the thermal zone setup in the driver code and must be enabled for
>> platform specified writable trips to come into effect.
>> 
>> The original behaviour of requiring root privileges to change trip
>> temperatures remains unchanged.
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>
> Yes, something like this is what I was suggesting.

Can you pick it up from here, or do you prefer for me to re-send the two
patches?

Cheers,
Punit

>
>
> Thanks.
>
>> ---
>>  drivers/thermal/Kconfig        | 11 +++++++++++
>>  drivers/thermal/thermal_core.c |  3 ++-
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index af40db0..5d2d39b 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -42,6 +42,17 @@ config THERMAL_OF
>>  	  Say 'Y' here if you need to build thermal infrastructure
>>  	  based on device tree.
>>  
>> +config THERMAL_WRITABLE_TRIPS
>> +	bool "Enable writable trip points"
>> +	help
>> +	  This option allows the system integrator to choose whether
>> +	  trip temperatures can be changed from userspace. The
>> +	  writable trips need to be specified when setting up the
>> +	  thermal zone but the choice here takes precedence.
>> +
>> +	  Say 'Y' here if you would like to allow userspace tools to
>> +	  change trip temperatures.
>> +
>>  choice
>>  	prompt "Default Thermal governor"
>>  	default THERMAL_DEFAULT_GOV_STEP_WISE
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 48491d1..15111c1 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1378,7 +1378,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
>>  						tz->trip_temp_attrs[indx].name;
>>  		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
>>  		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
>> -		if (mask & (1 << indx)) {
>> +		if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
>> +		    mask & (1 << indx)) {
>>  			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
>>  			tz->trip_temp_attrs[indx].attr.store =
>>  							trip_point_temp_store;
>> -- 
>> 2.1.4
