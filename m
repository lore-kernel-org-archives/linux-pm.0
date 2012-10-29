From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: add missing header include
Date: Mon, 29 Oct 2012 07:27:21 +0100
Message-ID: <508E21C9.9020004@linaro.org>
References: <001401cdb332$93ffe450$bbffacf0$%han@samsung.com> <508DA864.8020503@linaro.org> <002101cdb572$fcc4d670$f64e8350$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <002101cdb572$fcc4d670$f64e8350$%han@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/29/2012 02:16 AM, Jingoo Han wrote:
> On Monday, October 29, 2012 6:49 AM Marek Vasut wrote
>>
>> On 10/26/2012 06:30 AM, Jingoo Han wrote:
>>> This patch adds missing device.h header to fix build warnings as be=
low:
>>>
>>> drivers/cpuidle/cpuidle.h:26:41: warning: 'struct device' declared =
inside parameter list [enabled by
>> default]
>>> drivers/cpuidle/cpuidle.h:26:41: warning: its scope is only this de=
finition or declaration, which is
>> probably not what you want
>>> [enabled by default]
>>> drivers/cpuidle/cpuidle.h:27:45: warning: 'struct device' declared =
inside parameter list [enabled by
>> default]
>>> In file included from drivers/cpuidle/driver.c:15:0:
>>> drivers/cpuidle/cpuidle.h:26:41: warning: 'struct device' declared =
inside parameter list [enabled by
>> default]
>>> drivers/cpuidle/cpuidle.h:26:41: warning: its scope is only this de=
finition or declaration, which is
>> probably not what you want
>>> [enabled by default]
>>> drivers/cpuidle/cpuidle.h:27:45: warning: 'struct device' declared =
inside parameter list [enabled by
>> default]
>>>
>>> This build warning is introduced by commit efeca1b
>>> "cpuidle / sysfs: change function parameter".
>>>
>>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>
>> Jingoo, could you copy-pastebin your config file. I don't have this
>> warning and I would like to understand why.
>=20
> Hi Daniel Lezcano,
>=20
> Could you build the code by using GCC 4.6.x?
> In my opinion, it would be better.

That was the case.

 =3D> gcc (Ubuntu/Linaro 4.6.1-9ubuntu3) 4.6.1

> Also, my config option is as below:
>     make exynos4_defconfig + CONFIG_CPU_IDLE

Ok, I got the warning with this arch.

Let's see why this is not happening with x86 ...

Thanks
  -- Daniel

> Best regards,
> Jingoo Han
>=20
>=20
>>
>> Thanks
>>   -- Daniel
>>
>>>  drivers/cpuidle/cpuidle.h |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
>>> index a5bbd1c..2120d9e 100644
>>> --- a/drivers/cpuidle/cpuidle.h
>>> +++ b/drivers/cpuidle/cpuidle.h
>>> @@ -5,6 +5,8 @@
>>>  #ifndef __DRIVER_CPUIDLE_H
>>>  #define __DRIVER_CPUIDLE_H
>>>
>>> +#include <linux/device.h>
>>> +
>>>  /* For internal use only */
>>>  extern struct cpuidle_governor *cpuidle_curr_governor;
>>>  extern struct list_head cpuidle_governors;
>>
>>
>> --
>>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software =
for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
