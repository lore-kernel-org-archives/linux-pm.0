From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 7/8] ARM: cpuidle: Register per cpuidle device
Date: Thu, 19 Mar 2015 12:44:27 +0100
Message-ID: <550AB69B.8000100@linaro.org>
References: <1426704372-20406-1-git-send-email-daniel.lezcano@linaro.org> <1426704372-20406-8-git-send-email-daniel.lezcano@linaro.org> <20150319110806.GE24556@red-moon> <550AB298.6040907@linaro.org> <20150319113824.GC4449@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319113824.GC4449@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 03/19/2015 12:38 PM, Lorenzo Pieralisi wrote:
> On Thu, Mar 19, 2015 at 11:27:20AM +0000, Daniel Lezcano wrote:
>
> [...]
>
>>>>    	for_each_possible_cpu(cpu) {
>>>>    		ret =3D arm_cpuidle_init(cpu);
>>>> +
>>>> +		/* This cpu does not support any idle states */
>>>> +		if (ret =3D=3D -ENOSYS)
>>>> +			continue;
>>>> +
>>>>    		if (ret) {
>>>>    			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
>>>> -			return ret;
>>>> +			goto out_fail;
>>>> +		}
>>>> +
>>>> +		dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>>>> +		if (!dev) {
>>>> +			pr_err("Failed to allocate cpuidle device\n");
>>>> +			goto out_fail;
>>>> +		}
>>>> +
>>>> +		dev->cpu =3D cpu;
>>>> +		per_cpu(cpuidle_arm_dev, cpu) =3D dev;
>>>> +
>>>> +		ret =3D cpuidle_register_device(dev);
>>>> +		if (ret) {
>>>> +			pr_err("Failed to register cpuidle device for CPU %d\n",
>>>> +			       cpu);
>>>> +			kfree(dev);
>>>> +			goto out_fail;
>>>>    		}
>>>>    	}
>>>> +out:
>>>> +	return ret;
>>>
>>> return 0;
>>>
>>>>
>>>> -	return cpuidle_register(drv, NULL);
>>>> +out_fail:
>>>> +	for (cpu--; cpu <=3D 0; cpu--) {
>>>
>>> This loop is wrong.
>>
>> Why is it wrong ? We have to initialize at cpu - 1 to unregister the
>> previous registered cpu, not the current one, no ?
>
> Yes, but on cpu>=3D0 not cpu<=3D0
>
> while (--cpu >=3D 0)

Ah, yes. Thanks for spotting this.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
