From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH] cpuidle/coupled: Handle broadcast enter failures
Date: Thu, 7 Dec 2017 14:03:41 +0100
Message-ID: <48d2e450-f580-9fca-b31a-f60d96796e0d@linaro.org>
References: <20171205225536.21516-1-james.hogan@mips.com>
 <d74c6e8b-3020-6bed-4cf1-132f41a2c5ff@linaro.org>
 <20171207114706.GO5027@jhogan-linux.mipstec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207114706.GO5027@jhogan-linux.mipstec.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@mips.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-pm@vger.kernel.org

On 07/12/2017 12:47, James Hogan wrote:
> On Thu, Dec 07, 2017 at 12:17:25PM +0100, Daniel Lezcano wrote:
>> On 05/12/2017 23:55, James Hogan wrote:
>>> From: James Hogan <jhogan@kernel.org>
>>>
>>> If the hrtimer based broadcast tick device is in use, the enabling of
>>> broadcast ticks by cpuidle may fail when the next broadcast event is
>>> brought forward to match the next event due on the local tick device,
>>> This is because setting the next event may migrate the hrtimer based
>>> broadcast tick to the current CPU, which then makes
>>> broadcast_needs_cpu() fail.
>>>
>>> This isn't normally a problem as cpuidle handles it by falling back to
>>> the deepest idle state not needing broadcast ticks, however when coupled
>>> cpuidle is used it can happen after the coupled CPUs have all agreed on
>>> a particular idle state, resulting in only one of the CPUs falling back
>>> to a shallower state, and an attempt to couple two completely different
>>> idle states which may not be safe.
>>>
>>> Therefore extend cpuidle_enter_state_coupled() to be able to handle the
>>> enabling of broadcast ticks directly, so that a failure can be detected
>>> at the higher level, and all coupled CPUs can be made to fall back to
>>> the same idle state.
>>>
>>> This takes place after the idle state has been initially agreed. Each
>>> CPU will then attempt to enable broadcast ticks (if necessary), and upon
>>> failure it will update the requested_state[] array before a second
>>> coupled parallel barrier so that all coupled CPUs can recognise the
>>> change.
>>>
>>> Signed-off-by: James Hogan <jhogan@kernel.org>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: Paul Burton <paul.burton@mips.com>
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-mips@linux-mips.org
>>> ---
>>> Is this an acceptable approach in principle?
>>>
>>> Better/cleaner ideas to handle this are most welcome.
>>>
>>> This doesn't directly address the problem that some of the time it won't
>>> be possible to enter deeper idle states because of the hrtimer based
>>> broadcast tick's affinity. The actual case I'm looking at is on MIPS
>>> with cpuidle-cps, where the first core cannot (currently) go into a deep
>>> idle state requiring broadcast ticks, so it'd be nice if the hrtimer
>>> based broadcast tick device could just stay on core 0.
>>> ---
>>
>> Before commenting this patch, I would like to understand why the couple
>> idle state is needed for the MIPS, what in the architecture forces the
>> usage of the couple idle state?
> 
> Hardware multithreading.
> 
> Each physical core may have more than one hardware thread (VPE or VP in
> MIPS lingo), each of which appears as a separate CPU to Linux. The lower
> power states are all effective at the core level though:
> - non-coherent wait - the hardware threads share physical caches, so
>   coherency can only be turned off when all hardware threads are in a
>   safe state, else they (1) wouldn't be coherent with the rest of the
>   system and (2) could bring stuff into the cache which isn't kept
>   coherent, requiring I presume a second cache flush.
> - clock gated - must go non-coherent first, and applies to the whole
>   core and all the physical resources shared by the VP(E)s.
> - power gated - again must go non-coherent first, and applies to the
>   whole core and all the physical resources shared by the VP(E)s.

The couple idle state was introduced to compensate hardware mis-design.

There are a couple of examples omap4 and exynos4 where only CPU0 can do
some PM operations. AFAICT, from the feedbacks I got, couple idle state
consume more energy than it saves (very likely because of the busy loop
sync mechanism).

I did some tests with a 4 cores system and the overhead was so high the
system had a very bad response time, so dropped the cluster idle state.

So before going further in the couple idle path, I suggest you
investigate first a sync mechanism which may be implemented by the
hardware. One good example is the cpuidle-ux500.c.

With a proper last man standing sync, we can then take care of the timer
broadcast thing. I can give you a hand for that if you need.

>> The hrtimer broadcast mechanism is only needed if there isn't a backup
>> timer outside of the idle state's power domain. That's the case on this
>> platform?
> 
> I believe there is an external timer, and I believe we recommend
> customers implement one for use as a clocksource anyway (in case of
> frequency scaling), but on this particular platform the driver isn't
> upstream yet.

Perhaps, you can upstream the external timer driver first?

> If its something that shouldn't be supported in Linux, perhaps a simple
> WARN_ON is the better approach (i.e. if the broadcast tick can't be
> enabled in the current place and its a coupled idle state), though it
> does at least seem to work now with this and a couple of other patches
> (though I haven't been able to take any power measurements yet).




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
