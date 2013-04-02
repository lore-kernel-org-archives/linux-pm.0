From: jonghwa3.lee@samsung.com
Subject: Re: [RFC PATCH 1/2] cpuidle: Add idle enter/exit time stamp for
 notifying current idle state.
Date: Tue, 02 Apr 2013 15:17:32 +0900
Message-ID: <515A77FC.70008@samsung.com>
References: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com>
 <1364804657-16590-2-git-send-email-jonghwa3.lee@samsung.com>
 <515A65DB.8070803@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <515A65DB.8070803@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, sw0312.kim@samsung.com, m.szyprowski@samsung.com
List-Id: linux-pm@vger.kernel.org

On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 14:00, Daniel Lezcano wrote:

> On 04/01/2013 10:24 AM, Jonghwa Lee wrote:
>> This patch adds idle state time stamp to cpuidle device structure to
>> notify its current idle state. If last enter time is newer than last
>> exit time, then it means that the core is in idle now.
>>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> ---
>=20
> The patch description does not explain what problem you want to solve=
,
> how to solve it and the patch itself shows nothing.
>=20
> Could you elaborate ?


I'm sorry for lacking description. I supplement more.

This patch does add time-stamp for idle enter/exit only nothing more.
The reason why I needed them is that I wanted to know current cpu idle
state. It is hard to know whether cpu is in idle or not now.
When I check the cpuidle state usage, sometimes the information is wron=
g.
Because it is updated only when the cpu exits the idle state. So while =
the
cpu is idling, the cpuidle state usage holds past one. Therefore I put
the time-stamp for cpuidle enter/exit for checking current idling and
calculating idle state usage correctly.

I just make this patch temporary for my cpufreq governor work. So, it j=
ust
use time-stamp for all idle state together. After RFC working, I have a=
 plan
to update this patch to use timestamp for each idle state.

Thanks,


And it also can be used to calculate cpuidle state usage even the cpu i=
s idling.
I knew the code looks worthless, but as this patchset is just
suggesting idea,


>=20
> Thanks
>   -- Daniel
>=20
>>  drivers/cpuidle/cpuidle.c |    8 ++++----
>>  include/linux/cpuidle.h   |    4 ++++
>>  2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index eba6929..1e830cc 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -233,18 +233,18 @@ int cpuidle_wrap_enter(struct cpuidle_device *=
dev,
>>  				int (*enter)(struct cpuidle_device *dev,
>>  					struct cpuidle_driver *drv, int index))
>>  {
>> -	ktime_t time_start, time_end;
>>  	s64 diff;
>> =20
>> -	time_start =3D ktime_get();
>> +	dev->last_idle_start =3D ktime_get();
>> =20
>>  	index =3D enter(dev, drv, index);
>> =20
>> -	time_end =3D ktime_get();
>> +	dev->last_idle_end =3D ktime_get();
>> =20
>>  	local_irq_enable();
>> =20
>> -	diff =3D ktime_to_us(ktime_sub(time_end, time_start));
>> +	diff =3D ktime_to_us(ktime_sub(dev->last_idle_end,
>> +				dev->last_idle_start));
>>  	if (diff > INT_MAX)
>>  		diff =3D INT_MAX;
>> =20
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 480c14d..d1af05f 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -16,6 +16,7 @@
>>  #include <linux/kobject.h>
>>  #include <linux/completion.h>
>>  #include <linux/hrtimer.h>
>> +#include <linux/ktime.h>
>> =20
>>  #define CPUIDLE_STATE_MAX	8
>>  #define CPUIDLE_NAME_LEN	16
>> @@ -74,6 +75,9 @@ struct cpuidle_device {
>>  	struct kobject		kobj;
>>  	struct completion	kobj_unregister;
>> =20
>> +	ktime_t			last_idle_start;
>> +	ktime_t			last_idle_end;
>> +
>>  #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>>  	int			safe_state_index;
>>  	cpumask_t		coupled_cpus;
>>
>=20
>=20


