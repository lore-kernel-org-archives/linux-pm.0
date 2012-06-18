From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: cpuidle future and improvements
Date: Mon, 18 Jun 2012 14:55:58 +0200
Message-ID: <4FDF255E.3080402@linaro.org>
References: <4FDEE98D.7010802@linaro.org> <4FDF16DB.6080004@linux.vnet.ibm.com> <4FDF209E.7070803@linaro.org> <20120618125327.GB32111@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120618125327.GB32111@tbergstrom-lnx.Nvidia.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Lists Linaro-dev <linaro-dev@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, "lenb@kernel.org" <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Colin Cross <ccross@android.com>, Rob Lee <rob.lee@linaro.org>, "rjw@sisk.pl" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 06/18/2012 02:53 PM, Peter De Schrijver wrote:
> On Mon, Jun 18, 2012 at 02:35:42PM +0200, Daniel Lezcano wrote:
>> On 06/18/2012 01:54 PM, Deepthi Dharwar wrote:
>>> On 06/18/2012 02:10 PM, Daniel Lezcano wrote:
>>>
>>>>
>>>> Dear all,
>>>>
>>>> A few weeks ago, Peter De Schrijver proposed a patch [1] to allow =
per
>>>> cpu latencies. We had a discussion about this patchset because it
>>>> reverse the modifications Deepthi did some months ago [2] and we m=
ay
>>>> want to provide a different implementation.
>>>>
>>>> The Linaro Connect [3] event bring us the opportunity to meet peop=
le
>>>> involved in the power management and the cpuidle area for differen=
t SoC.
>>>>
>>>> With the Tegra3 and big.LITTLE architecture, making per cpu latenc=
ies
>>>> for cpuidle is vital.
>>>>
>>>> Also, the SoC vendors would like to have the ability to tune their=
 cpu
>>>> latencies through the device tree.
>>>>
>>>> We agreed in the following steps:
>>>>
>>>> 1. factor out / cleanup the cpuidle code as much as possible
>>>> 2. better sharing of code amongst SoC idle drivers by moving commo=
n bits
>>>> to core code
>>>> 3. make the cpuidle_state structure contain only data
>>>> 4. add a API to register latencies per cpu
>>>
>>> On huge systems especially  servers, doing a cpuidle registration o=
n a
>>> per-cpu basis creates a big overhead.
>>> So global registration was introduced in the first place.
>>>
>>> Why not have it as a configurable option or so ?
>>> Architectures having uniform cpuidle state parameters can continue =
to
>>> use global registration, else have an api to register latencies per=
 cpu
>>> as proposed. We can definitely work to see the best way to implemen=
t it.
>>
>> Absolutely, this is one reason I think adding a function:
>>
>> cpuidle_register_latencies(int cpu, struct cpuidle_latencies);
>>
>> makes sense if it is used only for cpus with different latencies.
>> The other architecture will be kept untouched.
>>
>> IMHO, before adding more functionalities to cpuidle, we should clean=
up
>> and consolidate the code. For example, there is a dependency between
>> acpi_idle and intel_idle which can be resolved with the notifiers, o=
r
>> there is intel specific code in cpuidle.c and cpuidle.h, cpu_relax i=
s
>> also introduced to cpuidle which is related to x86 not the cpuidle c=
ore,
>> etc ...
>>
>> Cleanup the code will help to move the different bits from the arch
>> specific code to the core code and reduce the impact of the core's
>> modifications. That should let a common pattern to emerge and will
>> facilitate the modifications in the future (per cpu latencies is one=
 of
>> them).
>>
>> That will be a lot of changes and this is why I proposed to put in p=
lace
>> a cpuidle-next tree in order to consolidate all the cpuidle
>> modifications people is willing to see upstream and provide better t=
esting.
>=20
> Sounds like a good idea. Do you have something like that already?

Yes but I need to cleanup the tree before.

http://git.linaro.org/gitweb?p=3Dpeople/dlezcano/linux-next.git;a=3Dsum=
mary

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
