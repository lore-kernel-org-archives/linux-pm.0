From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Fix the CPU stuck at C0 for 2-3s after PM_QOS
 back to DEFAULT
Date: Thu, 14 Aug 2014 13:14:49 +0200
Message-ID: <53EC9A29.8090408@linaro.org>
References: <1407982309-4863-1-git-send-email-chuansheng.liu@intel.com> <CAKnoXLw3DrBAxCUWEkXtvCTf+E1w0xTHJSiSUY6Qd6xHXeGaoQ@mail.gmail.com> <20140814110040.GI16043@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:62536 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbaHNLOy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Aug 2014 07:14:54 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so2111676wiv.9
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2014 04:14:51 -0700 (PDT)
In-Reply-To: <20140814110040.GI16043@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chuansheng Liu <chuansheng.liu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, changcheng.liu@intel.com, xiaoming.wang@intel.com, souvik.k.chakravarty@intel.com

On 08/14/2014 01:00 PM, Peter Zijlstra wrote:
> On Thu, Aug 14, 2014 at 12:29:32PM +0200, Daniel Lezcano wrote:
>> Hi Chuansheng,
>>
>> On 14 August 2014 04:11, Chuansheng Liu <chuansheng.liu@intel.com> w=
rote:
>>
>>> We found sometimes even after we let PM_QOS back to DEFAULT,
>>> the CPU still stuck at C0 for 2-3s, don't do the new suitable C-sta=
te
>>> selection immediately after received the IPI interrupt.
>>>
>>> The code model is simply like below:
>>> {
>>>          pm_qos_update_request(&pm_qos, C1 - 1);
>>>                  < =3D=3D Here keep all cores at C0
>>>          ...;
>>>          pm_qos_update_request(&pm_qos, PM_QOS_DEFAULT_VALUE);
>>>                  < =3D=3D Here some cores still stuck at C0 for 2-3=
s
>>> }
>>>
>>> The reason is when pm_qos come back to DEFAULT, there is IPI interr=
upt to
>>> wake up the core, but when core is in poll idle state, the IPI inte=
rrupt
>>> can not break the polling loop.
>
> So seeing how you're from @intel.com I'm assuming you're using x86 he=
re.
>
> I'm not seeing how this can be possible, MWAIT is interrupted by IPIs
> just fine, which means we'll fall out of the cpuidle_enter(), which
> means we'll cpuidle_reflect(), and then leave cpuidle_idle_call().
>
> It will indeed not leave the cpu_idle_loop() function and go right ba=
ck
> into cpuidle_idle_call(), but that will then call cpuidle_select() wh=
ich
> should pick a new C state.
>
> So the interrupt _should_ work. If it doesn't you need to explain why=
=2E

I think the issue is related to the poll_idle state, in=20
drivers/cpuidle/driver.c. This state is x86 specific and inserted in th=
e=20
cpuidle table as the state 0 (POLL). There is no mwait for this state.=20
It is a bit confusing because this state is not listed in the acpi /=20
intel idle driver but inserted implicitly at the beginning of the idle=20
table by the cpuidle framework when the driver is registered.

static int poll_idle(struct cpuidle_device *dev,
                 struct cpuidle_driver *drv, int index)
{
         local_irq_enable();
         if (!current_set_polling_and_test()) {
                 while (!need_resched())
                         cpu_relax();
         }
         current_clr_polling();

         return index;
}


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

