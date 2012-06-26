From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] acpi,
 cpuidle: Register with cpuidle even if cpu is onlined after boot
 (beyond maxcpus)
Date: Tue, 26 Jun 2012 12:42:14 +0200
Message-ID: <4FE99206.8060109@linaro.org>
References: <4FDB549F.1020002@linaro.org> <201206251553.55867.trenn@suse.de>
	<4FE88BDE.1050406@linux.vnet.ibm.com>
	<201206261129.45591.trenn@suse.de> <4FE983E0.2050802@linaro.org>
	<4FE987BB.4020508@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FE987BB.4020508@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 06/26/2012 11:58 AM, Srivatsa S. Bhat wrote:
> On 06/26/2012 03:11 PM, Daniel Lezcano wrote:
>> On 06/26/2012 11:29 AM, Thomas Renninger wrote:
>>> On Monday, June 25, 2012 06:03:42 PM Srivatsa S. Bhat wrote:
>>>> On 06/25/2012 07:23 PM, Thomas Renninger wrote:
>>>>
>>>>> On Monday, June 25, 2012 01:25:43 PM Srivatsa S. Bhat wrote:
>>>>>>
>>>>>> Daniel Lezcano noticed that after booting with maxcpus=3DX, if we =
online the
>>>>>> remaining cpus by writing: echo 1 > /sys/devices/system/cpu/cpuY/o=
nline, then
>>>>>> for the newly onlined cpus, the cpuidle directory is not found und=
er
>>>>>> /sys/devices/system/cpu/cpuY.
>>>>>>
>>>>>> Partly, the reason for this is that acpi restricts the initializat=
ion to cpus
>>>>>> within the maxcpus limit. (See commit 75cbfb9 "ACPI: Do not try to=
 set up acpi
>>>>>> processor stuff on cores exceeding maxcpus=3D"). The maxcpus=3D ke=
rnel parameter is
>>>>>> used to restrict the number of cpus brought up during boot. That d=
oesn't mean
>>>>>> that we should hard restrict the bring up of the remaining cpus la=
ter on.
>>>>>
>>>>> Sorry, but IMO it exaclty does mean that (adding more general lists=
 for
>>>>> further comments).
>>>>>
>>>>> If you can online more cores than maxcpus=3D via sysfs, this sounds=
 like a bug.
>>>>> Not the other way around.
>>>>>
>>>>> Compare with Documentation/kernel-parameters.txt:
>>>>>         maxcpus=3D        [SMP] Maximum number of processors that a=
n SMP kernel
>>>>>                         should make use of.  maxcpus=3Dn : n >=3D 0=
 limits the
>>>>>                         kernel to using 'n' processors.  n=3D0 is a=
 special case,
>>>>>                         it is equivalent to "nosmp", which also dis=
ables
>>>>>                         the IO APIC.
>>>>>
>>>>> Chances that you run into more problems are high.
>>>>
>>>>
>>>> Right, I agree on that. So, IMHO, maxcpus=3DX doesn't mean that the =
kernel must and
>>>> should forbid any new cpus from coming online, but in the interest o=
f avoiding
>>>> problems/complications in some obscure paths, I guess it makes sense=
 to avoid
>>>> onlining new cpus beyond maxcpus.
>>>
>>> Yep, for such reasons:
>>>    - That nobody realizes this to be useful and makes use of it in a =
productive
>>>      environment
>>>    - If I see maxcpus=3DX in a bugreport's dmesg command line,
>>>      I want to be sure that's true.
>>>    - To enforce that things work as documented
>>>
>>>
>>> Wow, after looking a bit into this I found (Documentation/cpu-hotplug=
.txt):
>>>
>>> maxcpus=3Dn    Restrict boot time cpus to n. Say if you have 4 cpus, =
using
>>>              maxcpus=3D2 will only boot 2. You can choose to bring th=
e
>>>              other cpus later online, read FAQ's for more info.
>>>
>>> Looks like someone already documented this (IMO broken) behavior.
>>> I didn't find further info in the FAQs.
>>>
>>>> In any case, I was just trying to see why the simple removal of the =
setup_max_cpus
>>>> check in acpi_processor_add() wasn't enough to expose the cpuidle di=
rectories under
>>>> the new cpus.. and while debugging that, I came up with this patch. =
I don't mind
>>>> if this doesn't get picked up.
>>>
>>>> Right, the usecase of why somebody would like to online new cpus bey=
ond maxcpus
>>>> doesn't look all that solid anyway. So I am OK with leaving the code=
 as it is now.
>>>
>>> In the end this is a debug option, I expect everybody is aware of tha=
t.
>>> Yep, let's just leave it...
>>
>> In this case, let's remove the intel_idle_cpu_init stuff in
>> acpi_cpu_soft_notify, no ?
>>
>=20
> Why? And how would that help? The intel_idle_cpu_init() call is essenti=
al if intel_idle
> driver is being used instead of acpi idle.

AFAIU, this code is not called after onlining a cpu greater than maxcpus
and Thomas thinks that system with cpu hotplug at runtime are not sold.

The problem I see with this code is acpi and intel-idle are tied
together now. I would like to break this dependency and use the notifier
to handle the cpu hotplug directly in intel-idle.

It is hard to test my patch as there is not such system and maxcpus is
not correctly handled here. I can use your patch to test my patch but
anyway ... I am just asking if that would make sense to remove this
portion of code instead :)

If we want to keep this code untouched, I can try my patch and maybe
Thomas will agreed to test it also on a cpu-online-runtime-system if he
has one.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
