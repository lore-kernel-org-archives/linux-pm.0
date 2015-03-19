From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 7/8] ARM: cpuidle: Register per cpuidle device
Date: Thu, 19 Mar 2015 12:27:20 +0100
Message-ID: <550AB298.6040907@linaro.org>
References: <1426704372-20406-1-git-send-email-daniel.lezcano@linaro.org> <1426704372-20406-8-git-send-email-daniel.lezcano@linaro.org> <20150319110806.GE24556@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319110806.GE24556@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 03/19/2015 12:08 PM, Lorenzo Pieralisi wrote:
> On Wed, Mar 18, 2015 at 06:46:11PM +0000, Daniel Lezcano wrote:
>> Some architectures have some cpus which does not support idle states=
=2E
>>
>> Let the underlying low level code to return -ENOSYS when it is not
>> possible to set an idle state.
>
> http://www.spinics.net/lists/linux-acpi/msg55550.html
>
> -ENXIO ?

Ack, it makes more sense.

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/cpuidle/cpuidle-arm.c | 45 +++++++++++++++++++++++++++++++=
++++++++++--
>>   1 file changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle=
-arm.c
>> index 1c94b88..0682ed0 100644
>> --- a/drivers/cpuidle/cpuidle-arm.c
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>> @@ -17,11 +17,14 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/slab.h>
>>
>>   #include <asm/cpuidle.h>
>>
>>   #include "dt_idle_states.h"
>>
>> +static DEFINE_PER_CPU(struct cpuidle_device, *cpuidle_arm_dev);
>> +
>>   /*
>>    * arm_enter_idle_state - Programs CPU to enter the specified stat=
e
>>    *
>> @@ -94,6 +97,7 @@ static int __init arm_idle_init(void)
>>   {
>>   	int cpu, ret;
>>   	struct cpuidle_driver *drv =3D &arm_idle_driver;
>> +	struct cpuidle_device *dev;
>>
>>   	/*
>>   	 * Initialize idle states data, starting at index 1.
>> @@ -105,18 +109,55 @@ static int __init arm_idle_init(void)
>>   	if (ret <=3D 0)
>>   		return ret ? : -ENODEV;
>>
>> +	ret =3D cpuidle_register_driver(drv);
>> +	if (ret) {
>> +		pr_err("Failed to register cpuidle driver\n");
>> +		return ret;
>> +	}
>> +
>>   	/*
>>   	 * Call arch CPU operations in order to initialize
>>   	 * idle states suspend back-end specific data
>>   	 */
>>   	for_each_possible_cpu(cpu) {
>>   		ret =3D arm_cpuidle_init(cpu);
>> +
>> +		/* This cpu does not support any idle states */
>> +		if (ret =3D=3D -ENOSYS)
>> +			continue;
>> +
>>   		if (ret) {
>>   			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
>> -			return ret;
>> +			goto out_fail;
>> +		}
>> +
>> +		dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>> +		if (!dev) {
>> +			pr_err("Failed to allocate cpuidle device\n");
>> +			goto out_fail;
>> +		}
>> +
>> +		dev->cpu =3D cpu;
>> +		per_cpu(cpuidle_arm_dev, cpu) =3D dev;
>> +
>> +		ret =3D cpuidle_register_device(dev);
>> +		if (ret) {
>> +			pr_err("Failed to register cpuidle device for CPU %d\n",
>> +			       cpu);
>> +			kfree(dev);
>> +			goto out_fail;
>>   		}
>>   	}
>> +out:
>> +	return ret;
>
> return 0;
>
>>
>> -	return cpuidle_register(drv, NULL);
>> +out_fail:
>> +	for (cpu--; cpu <=3D 0; cpu--) {
>
> This loop is wrong.

Why is it wrong ? We have to initialize at cpu - 1 to unregister the=20
previous registered cpu, not the current one, no ?

>> +		dev =3D per_cpu(cpuidle_arm_dev, cpu);
>> +		cpuidle_unregister_device(dev);
>> +		kfree(dev);
>> +	}
>> +	cpuidle_unregister_driver(drv);
>> +	goto out;
>
> You just:
>
> return ret;
>
> little point in jumping around to just return.

Ok.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
