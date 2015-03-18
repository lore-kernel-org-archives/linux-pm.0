From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/6] ARM: cpuidle: Add a cpuidle ops structure to be used
 for DT
Date: Wed, 18 Mar 2015 09:13:27 +0100
Message-ID: <550933A7.9030401@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org> <1425385777-14766-3-git-send-email-daniel.lezcano@linaro.org> <55075453.2070503@codeaurora.org> <20150317112905.GA14984@red-moon> <5508D160.6090205@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36566 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbbCRINd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 04:13:33 -0400
Received: by wgra20 with SMTP id a20so28204314wgr.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2015 01:13:32 -0700 (PDT)
In-Reply-To: <5508D160.6090205@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>

On 03/18/2015 02:14 AM, Stephen Boyd wrote:
> On 03/17/15 04:29, Lorenzo Pieralisi wrote:
>> On Mon, Mar 16, 2015 at 10:08:19PM +0000, Stephen Boyd wrote:
>>> On 03/03/15 04:29, Daniel Lezcano wrote:
>>>> The code is optimized to use the __init section intensively in ord=
er to reduce
>>>> the memory footprint after the driver is initialized and unify the=
 function
>>>> names with ARM64.
>>>>
>>>> In order to prevent multiple declarations and the specific cpuidle=
 ops to be
>>>> spread across the different headers, a mechanism, similar to the c=
group subsys,
>>>> has been introduced.
>>>>
>>>> A new platform willing to add its cpuidle ops must add an entry in=
 the file
>>>> cpuidle_ops.h in the current form:
>>>>
>>>>   #if IS_ENABLED(CONFIG_ARM_FOO_CPUIDLE)
>>>>   CPUIDLE_OPS(foo)
>>>>   #endif
>>>>
>>>> ... and use the variable name in the specific low level code:
>>>>
>>>> struct cpuidle_ops foo_cpuidle_ops;
>>>>
>>>> The CPUIDLE_OPS macro will be processed in different way in the cp=
uidle.c file,
>>>> thus allowing to keep untouched the arm cpuidle core code in the f=
uture when
>>>> a new platform is added.
>>> [...]
>>>> diff --git a/arch/arm/include/asm/cpuidle_ops.h b/arch/arm/include=
/asm/cpuidle_ops.h
>>>> new file mode 100644
>>>> index 0000000..be0a612
>>>> --- /dev/null
>>>> +++ b/arch/arm/include/asm/cpuidle_ops.h
>>>> @@ -0,0 +1,3 @@
>>>> +/*
>>>> + * List of cpuidle operations
>>>> + */
>>>> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
>>>> index 45969f8..25e9789c 100644
>>>> --- a/arch/arm/kernel/cpuidle.c
>>>> +++ b/arch/arm/kernel/cpuidle.c
>>>> @@ -10,8 +10,29 @@
>>>>    */
>>>>
>>>>   #include <linux/cpuidle.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_device.h>
>>>>   #include <asm/cpuidle.h>
>>>>
>>>> +#define CPUIDLE_OPS(__x) extern struct cpuidle_ops __x ## _cpuidl=
e_ops;
>>>> +#include <asm/cpuidle_ops.h>
>>>> +#undef CPUIDLE_OPS
>>>> +
>>>> +#define CPUIDLE_OPS(__x) __x ## _cpuidle_ops_id,
>>>> +enum cpuidle_ops_id {
>>>> +#include <asm/cpuidle_ops.h>
>>>> +        CPUIDLE_OPS_COUNT,
>>>> +};
>>>> +#undef CPUIDLE_OPS
>>>> +
>>>> +#define CPUIDLE_OPS(__x) [__x ## _cpuidle_ops_id ] =3D &__x ## _c=
puidle_ops,
>>>> +static struct cpuidle_ops *supported_cpuidle_ops[] __initconst =3D=
 {
>>>> +#include <asm/cpuidle_ops.h>
>>>> +};
>>>> +#undef CPUIDLE_OPS
>>>> +
>>>> +static struct cpuidle_ops cpuidle_ops[NR_CPUS];
>>> Is there any reason why we aren't putting these structures into a l=
inker
>>> section like we do for the smp operations structures?
>> I think it can be done with an OF_TABLE, it is a bit of shame cpuidl=
e_ops
>> should work on UP too otherwise they could have been merged in
>> smp_ops to create cpu_ops, like arm64 does.
>
> We should merge the two and remove the SMP dependency on arm32.

I will be happy to do that but right now it would be nice to keep=20
focused on bringing the cpuidle ops first, even if we have a bit of cod=
e=20
duplicated, in order to unblock the cpuidle drivers awaiting for this=20
code to be merged.

>>> The nice thing about using the linker is it makes it clearer at the
>>> location where we define the structure that it's actually used by
>>> something. Right now the structures are defined non-static in a fil=
e and
>>> then we have to know that a CPUIDLE_OPS() define has been made in
>>> another architecture specific asm header file so that this macro ma=
gic
>>> works. The commit text says something about multiple declarations a=
nd
>>> ops spread across header files, which shouldn't apply if we're usin=
g the
>>> linker to find these ops and merge them into an array we can iterat=
e over.
>> It makes sense, see above for UP vs SMP. I wonder if we can't find
>> something to overcome the UP limitation nicely, the init code in
>> arch/arm/kernel/devtree.c is identical for smp_ops and cpuidle_ops,
>> apart from the CONFIG_SMP ifdeffery.
>
> It should be possible to replace the arm32 smp_operations structure w=
ith
> something like the arm64 cpu_operations structure. Yes we would have =
to
> drop the SMP dependency, but that will be ok. It would require some w=
ork
> to make arm32 and arm64 the same, but for these purposes that isn't
> really required as long as we can put the cpu idle hook there.
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

