From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: cpuidle future and improvements
Date: Mon, 18 Jun 2012 14:35:42 +0200
Message-ID: <4FDF209E.7070803@linaro.org>
References: <4FDEE98D.7010802@linaro.org> <4FDF16DB.6080004@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4FDF16DB.6080004@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Lists Linaro-dev <linaro-dev@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, "lenb@kernel.org" <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Colin Cross <ccross@android.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Rob Lee <rob.lee@linaro.org>, rjw@sisk.pl, Kevin Hilman <khilman@ti.com>, linux-next@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/18/2012 01:54 PM, Deepthi Dharwar wrote:
> On 06/18/2012 02:10 PM, Daniel Lezcano wrote:
>=20
>>
>> Dear all,
>>
>> A few weeks ago, Peter De Schrijver proposed a patch [1] to allow pe=
r
>> cpu latencies. We had a discussion about this patchset because it
>> reverse the modifications Deepthi did some months ago [2] and we may
>> want to provide a different implementation.
>>
>> The Linaro Connect [3] event bring us the opportunity to meet people
>> involved in the power management and the cpuidle area for different =
SoC.
>>
>> With the Tegra3 and big.LITTLE architecture, making per cpu latencie=
s
>> for cpuidle is vital.
>>
>> Also, the SoC vendors would like to have the ability to tune their c=
pu
>> latencies through the device tree.
>>
>> We agreed in the following steps:
>>
>> 1. factor out / cleanup the cpuidle code as much as possible
>> 2. better sharing of code amongst SoC idle drivers by moving common =
bits
>> to core code
>> 3. make the cpuidle_state structure contain only data
>> 4. add a API to register latencies per cpu
>=20
> On huge systems especially  servers, doing a cpuidle registration on =
a
> per-cpu basis creates a big overhead.
> So global registration was introduced in the first place.
>=20
> Why not have it as a configurable option or so ?
> Architectures having uniform cpuidle state parameters can continue to
> use global registration, else have an api to register latencies per c=
pu
> as proposed. We can definitely work to see the best way to implement =
it.

Absolutely, this is one reason I think adding a function:

cpuidle_register_latencies(int cpu, struct cpuidle_latencies);

makes sense if it is used only for cpus with different latencies.
The other architecture will be kept untouched.

IMHO, before adding more functionalities to cpuidle, we should cleanup
and consolidate the code. For example, there is a dependency between
acpi_idle and intel_idle which can be resolved with the notifiers, or
there is intel specific code in cpuidle.c and cpuidle.h, cpu_relax is
also introduced to cpuidle which is related to x86 not the cpuidle core=
,
etc ...

Cleanup the code will help to move the different bits from the arch
specific code to the core code and reduce the impact of the core's
modifications. That should let a common pattern to emerge and will
facilitate the modifications in the future (per cpu latencies is one of
them).

That will be a lot of changes and this is why I proposed to put in plac=
e
a cpuidle-next tree in order to consolidate all the cpuidle
modifications people is willing to see upstream and provide better test=
ing.


>> These four steps impacts all the architecture. I began the factor ou=
t
>> code / cleanup [4] and that has been accepted upstream and I propose=
d
>> some modifications [5] but I had a very few answers.
>>
>> The patch review are very slow and done at the last minute at the me=
rge
>> window and that makes code upstreaming very difficult. It is not a
>> reproach, it is just how it is and I would like to propose a solutio=
n
>> for that.
>>
>> I propose to host a cpuidle-next tree where all these modifications =
will
>> be and where people can send patches against, preventing last minute=
s
>> conflicts and perhaps Lenb will agree to pull from this tree. In the
>> meantime, the tree will be part of the linux-next, the patches will =
be
>> more widely tested and could be fixed earlier.
>>
>> Thanks
>> -- Daniel
>>
>> [1] http://lwn.net/Articles/491257/
>> [2] http://lwn.net/Articles/464808/
>> [3] http://summit.linaro.org/
>> [4]
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67033.html=
,
>> http://www.spinics.net/lists/linux-pm/msg27330.html,
>> http://comments.gmane.org/gmane.linux.ports.arm.omap/76311,
>> http://www.digipedia.pl/usenet/thread/18885/11795/
>>
>> [5] https://lkml.org/lkml/2012/6/8/375
>>
>=20
>=20
> Cheers,
> Deepthi
>=20


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
