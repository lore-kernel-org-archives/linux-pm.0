From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
Date: Tue, 25 Feb 2014 15:39:30 +0100
Message-ID: <530CAB22.5030506@linaro.org>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com> <1389794137-11361-10-git-send-email-paul.burton@imgtec.com> <53060496.6000303@linaro.org> <20140220134118.GT25765@pburton-linux.le.imgtec.org> <530608C2.3070507@linaro.org> <20140220140033.GU25765@pburton-linux.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
        format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20140220140033.GU25765@pburton-linux.le.imgtec.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/20/2014 03:00 PM, Paul Burton wrote:
> On Thu, Feb 20, 2014 at 02:53:06PM +0100, Daniel Lezcano wrote:
>> On 02/20/2014 02:41 PM, Paul Burton wrote:
>>> On Thu, Feb 20, 2014 at 02:35:18PM +0100, Daniel Lezcano wrote:
>>>> On 01/15/2014 02:55 PM, Paul Burton wrote:
>>>>> Declaring this allows drivers which need to initialise each struc=
t
>>>>> cpuidle_device at initialisation time to make use of the structur=
es
>>>>> already defined in cpuidle.c, rather than having to wastefully de=
fine
>>>>> their own.
>>>>>
>>>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> Cc: linux-pm@vger.kernel.org
>>>>> ---
>>>>>   include/linux/cpuidle.h | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>>>>> index 50fcbb0..bab4f33 100644
>>>>> --- a/include/linux/cpuidle.h
>>>>> +++ b/include/linux/cpuidle.h
>>>>> @@ -84,6 +84,7 @@ struct cpuidle_device {
>>>>>   };
>>>>>
>>>>>   DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>>>>> +DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
>>>>
>>>>
>>>> Nak. When a device is registered, it is assigned to the cpuidle_de=
vices
>>>> pointer and the backend driver should use it.
>>>>
>>>
>>> Yes, but then if the driver needs to initialise the coupled_cpus ma=
sk
>>> then it cannot do so until after the device has been registered. Du=
ring
>>> registration the cpuidle_coupled_register_device will then see the =
empty
>>> coupled_cpus mask & do nothing. The only other ways around this wou=
ld be
>>> for the driver to define its own per-cpu struct cpuidle_device (whi=
ch as
>>> I state in the commit message seems wasteful when cpuidle already
>>> defined them), or for cpuidle_coupled_register_device to be called =
later
>>> after the driver had a chance to modify devices via the cpuidle_dev=
ices
>>> pointers.
>>
>> Yeah. I understand why you wanted to declare these cpu variables.
>>
>> The mips cpuidle driver sounds like a bit particular. I believe I ne=
ed some
>> clarification on the behavior of the hardware to understand correctl=
y the
>> driver. Could you explain how the couples act vs the cpu ? And why
>> cpu_sibling is used instead of cpu_possible_mask ?
>>
>>
>
> Sure. The CPUs that are coupled are actually VPEs (Virtual Processor
> Elements) within a single core. They share the compute resource (ALUs
> etc) of the core but have their own register state, ie. they're a for=
m
> of simultaneous multithreading.
>
> Coherence within a MIPS Coherent Processing System is a property of t=
he
> core rather than of an individual VPE (since the VPEs within a core
> share the same L1 caches). So for idle states which are non-coherent =
the
> VPEs within the core are coupled. That covers all idle states beyond =
a
> simple "wait" instruction - clock gating or powering down a core
> requires it to become non-coherent first.
>
> cpu_sibling_mask is already setup to indicate which CPUs (VPEs) are
> within the same core as each other, which is why it is simply copied =
for
> coupled_cpus.

Hi Paul,

thanks for the explanation.

   -- Daniel




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
