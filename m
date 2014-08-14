From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Fix the CPU stuck at C0 for 2-3s after PM_QOS
 back to DEFAULT
Date: Thu, 14 Aug 2014 15:29:49 +0200
Message-ID: <53ECB9CD.9040705@linaro.org>
References: <1407982309-4863-1-git-send-email-chuansheng.liu@intel.com> <CAKnoXLw3DrBAxCUWEkXtvCTf+E1w0xTHJSiSUY6Qd6xHXeGaoQ@mail.gmail.com> <20140814110040.GI16043@twins.programming.kicks-ass.net> <53EC9A29.8090408@linaro.org> <20140814124135.GJ16043@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:53041 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbaHNN3y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Aug 2014 09:29:54 -0400
Received: by mail-wi0-f169.google.com with SMTP id n3so9792987wiv.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2014 06:29:52 -0700 (PDT)
In-Reply-To: <20140814124135.GJ16043@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chuansheng Liu <chuansheng.liu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, changcheng.liu@intel.com, xiaoming.wang@intel.com, souvik.k.chakravarty@intel.com

On 08/14/2014 02:41 PM, Peter Zijlstra wrote:
> On Thu, Aug 14, 2014 at 01:14:49PM +0200, Daniel Lezcano wrote:
>> On 08/14/2014 01:00 PM, Peter Zijlstra wrote:
>>> On Thu, Aug 14, 2014 at 12:29:32PM +0200, Daniel Lezcano wrote:
>>>> Hi Chuansheng,
>>>>
>>>> On 14 August 2014 04:11, Chuansheng Liu <chuansheng.liu@intel.com>=
 wrote:
>>>>
>>>>> We found sometimes even after we let PM_QOS back to DEFAULT,
>>>>> the CPU still stuck at C0 for 2-3s, don't do the new suitable C-s=
tate
>>>>> selection immediately after received the IPI interrupt.
>>>>>
>>>>> The code model is simply like below:
>>>>> {
>>>>>          pm_qos_update_request(&pm_qos, C1 - 1);
>>>>>                  < =3D=3D Here keep all cores at C0
>>>>>          ...;
>>>>>          pm_qos_update_request(&pm_qos, PM_QOS_DEFAULT_VALUE);
>>>>>                  < =3D=3D Here some cores still stuck at C0 for 2=
-3s
>>>>> }
>>>>>
>>>>> The reason is when pm_qos come back to DEFAULT, there is IPI inte=
rrupt to
>>>>> wake up the core, but when core is in poll idle state, the IPI in=
terrupt
>>>>> can not break the polling loop.
>>>
>>> So seeing how you're from @intel.com I'm assuming you're using x86 =
here.
>>>
>>> I'm not seeing how this can be possible, MWAIT is interrupted by IP=
Is
>>> just fine, which means we'll fall out of the cpuidle_enter(), which
>>> means we'll cpuidle_reflect(), and then leave cpuidle_idle_call().
>>>
>>> It will indeed not leave the cpu_idle_loop() function and go right =
back
>>> into cpuidle_idle_call(), but that will then call cpuidle_select() =
which
>>> should pick a new C state.
>>>
>>> So the interrupt _should_ work. If it doesn't you need to explain w=
hy.
>>
>> I think the issue is related to the poll_idle state, in
>> drivers/cpuidle/driver.c. This state is x86 specific and inserted in=
 the
>> cpuidle table as the state 0 (POLL). There is no mwait for this stat=
e. It is
>> a bit confusing because this state is not listed in the acpi / intel=
 idle
>> driver but inserted implicitly at the beginning of the idle table by=
 the
>> cpuidle framework when the driver is registered.
>>
>> static int poll_idle(struct cpuidle_device *dev,
>>                  struct cpuidle_driver *drv, int index)
>> {
>>          local_irq_enable();
>>          if (!current_set_polling_and_test()) {
>>                  while (!need_resched())
>>                          cpu_relax();
>>          }
>>          current_clr_polling();
>>
>>          return index;
>> }
>
> Ah, well, in that case there's a ton more broken than just this.
> kick_all_cpus_sync() won't work either, and cpuidle_reflect() pretty
> much expects to be called after each interrupt.

Agree.

> Then again, not reflecting properly isn't really a problem, its not l=
ike
> not accounting interrupts is going to safe power much.

I think the main issue here is to exit the poll_idle loop when an IPI i=
s=20
received. IIUC, there is a pm_qos user, perhaps a driver (Chuansheng ca=
n=20
give more details), setting a very short latency, so the cpuidle=20
framework choose a shallow state like the poll_idle and then the driver=
=20
sets a bigger latency, leading to the IPI to wake all the cpus. As the=20
CPUs are in the poll_idle, they don't exit until an event make them to=20
exit the need_resched() loop (reschedule or whatever). This situation=20
can let the CPUs to stand in the infinite loop several seconds while we=
=20
are expecting them to exit the poll_idle and enter a deeper idle state,=
=20
thus with an extra energy consumption.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

