From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/6] ARM: cpuidle: Add a cpuidle ops structure to be used
 for DT
Date: Tue, 17 Mar 2015 12:01:59 +0100
Message-ID: <550809A7.3020600@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org> <1425385777-14766-3-git-send-email-daniel.lezcano@linaro.org> <20150316181659.GA13335@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150316181659.GA13335@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 03/16/2015 07:16 PM, Lorenzo Pieralisi wrote:
> On Tue, Mar 03, 2015 at 12:29:33PM +0000, Daniel Lezcano wrote:
>> The current state of the different cpuidle drivers is the different =
PM
>
> Nit: "The current state of cpuidle drivers is such that different ...=
"

Ok.

>> operations are passed via the platform_data using the platform drive=
r
>> paradigm.
>>
>> This approach allowed to split the low level PM code from the arch s=
pecific
>> and the generic cpuidle code.
>>
>> Unfortunately there are complains about this approach as, in the con=
text of the
>
> Nit: s/complains/complaints

Ok.

[ ... ]

>> @@ -27,4 +27,14 @@ static inline int arm_cpuidle_simple_enter(struct=
 cpuidle_device *dev,
>>    */
>>   #define ARM_CPUIDLE_WFI_STATE ARM_CPUIDLE_WFI_STATE_PWR(UINT_MAX)
>>
>> +struct cpuidle_ops {
>> +	const char *name;
>> +	int (*suspend)(int cpu, unsigned long arg);
>> +	int (*init)(struct device_node *, int cpu);
>> +};
>> +
>> +extern int arm_cpuidle_suspend(int index);
>> +
>> +extern int arm_cpuidle_init(int cpu);
>
> idle_cpu_suspend()
> idle_cpu_init()
>
> ?
>
> I am really not fussed about the naming.
>
> To make this and x86 driver name compliant (well, function signatures
> are a bit different) we could use:
>
> arm_idle()
> arm_idle_cpu_init()
>
> even though I think the arch prefix is useless.
>
> Side note: why is the x86 driver in drivers/idle ? To have another di=
r :) ?

I believe it is there for historical reasons.

[ ... ]

>> +static struct cpuidle_ops cpuidle_ops[NR_CPUS];
>
> That's because you want platform cpuidle_ops to be __initdata ?

Yes.

> It should not be a big overhead on arm32 to have a number of
> structs equal to NR_CPUS, on arm64 it is the other way around
> there are few cpu_ops, but number of CPUs can be high so it
> is an array of pointers.
>
> I think it is ok to leave it as it is (or probably make cpuidle_ops
> a single struct, I expect enable-method to be common across cpus).

I prefer to keep per cpu because I am not sure of this assumption.

[ ... ]

>> +	cpuidle_ops[cpu] =3D *ops; /* structure copy */
>
> See above.
>
>> +
>> +	pr_notice("cpuidle: enable-method property '%s'"
>> +		  " found operations\n", ops->name);
>> +
>> +	return 0;
>> +}
>> +
>> +int __init arm_cpuidle_init(int cpu)
>> +{
>> +	int ret =3D -EOPNOTSUPP;
>
> Nit: You always assign ret, so there is no point in initializing it.

Ok, I will fix it.

Thanks for reviewing.

   -- Daniel



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
