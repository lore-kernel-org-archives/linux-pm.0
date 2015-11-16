From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 3/3] cpufreq: arm_big_little: Add support to register a cpufreq cooling device
Date: Mon, 16 Nov 2015 15:29:09 +0000
Message-ID: <9hha8qeq7y2.fsf@e105922-lin.cambridge.arm.com>
References: <1447090163-13700-1-git-send-email-punit.agrawal@arm.com>
	<1447090163-13700-4-git-send-email-punit.agrawal@arm.com>
	<20151113045610.GC3576@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151113045610.GC3576@ubuntu> (Viresh Kumar's message of "Fri,
	13 Nov 2015 10:26:10 +0530")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On 09-11-15, 17:29, Punit Agrawal wrote:
>> Register passive cooling devices when initialising cpufreq on
>> big.LITTLE systems. If the device tree provides a dynamic power
>> coefficient for the CPUs then the bound cooling device will support
>> the extensions that allow it to be used with all the existing thermal
>> governors including the power allocator governor.
>> 
>> A cooling device will be created per individual frequency domain and
>> can be bound to thermal zones via the thermal DT bindings.
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
>> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
>> Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/cpufreq/arm_big_little.c | 52 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 50 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
>> index f1e42f8..72a2777 100644
>> --- a/drivers/cpufreq/arm_big_little.c
>> +++ b/drivers/cpufreq/arm_big_little.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/cpu.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/cpumask.h>
>> +#include <linux/cpu_cooling.h>
>>  #include <linux/export.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> @@ -55,6 +56,10 @@ static bool bL_switching_enabled;
>>  #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
>>  #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
>>  
>> +struct private_data {
>> +	struct thermal_cooling_device *cdev;
>> +};
>
> I think we need to be consistent within the driver, and so this must
> be stored in a similar way to what we do for other structures. We have
> static arrays for them, please do it that way only OR first change all
> of them to be part of a bigger private_data structure.

Sure, I'll switch to using static arrays. There seem to be a lot of
assumptions that might be easily broken in moving all the data into a
single structure. I'll leave that as a later change.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
