From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: tegra114: cpuidle: add powered-down state
Date: Fri, 31 May 2013 15:18:35 +0200
Message-ID: <51A8A32B.6080303@linaro.org>
References: <1369912782-30663-1-git-send-email-josephl@nvidia.com>  <1369912782-30663-4-git-send-email-josephl@nvidia.com>  <51A763BD.6070001@linaro.org>  <1369991550.7804.37.camel@jlo-ubuntu-64.nvidia.com>  <51A86D11.8060305@linaro.org>  <1369997278.7804.73.camel@jlo-ubuntu-64.nvidia.com>  <1369999870.7804.78.camel@jlo-ubuntu-64.nvidia.com> <1370000680.7804.83.camel@jlo-ubuntu-64.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370000680.7804.83.camel-yx3yKKdKkHfc7b1ADBJPm0n48jw8i0AO@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux PM mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 05/31/2013 01:44 PM, Joseph Lo wrote:
> On Fri, 2013-05-31 at 19:31 +0800, Joseph Lo wrote:
>> On Fri, 2013-05-31 at 18:47 +0800, Joseph Lo wrote:
>>> On Fri, 2013-05-31 at 17:27 +0800, Daniel Lezcano wrote:
>>>> On 05/31/2013 11:12 AM, Joseph Lo wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> Thanks for your review.
>>>>>
>>>>> On Thu, 2013-05-30 at 22:35 +0800, Daniel Lezcano wrote:
>>>>>> On 05/30/2013 01:19 PM, Joseph Lo wrote:
>>>>>>> This supports CPU core power down on each CPU when CPU idle. Wh=
en CPU go
>>>>>>> into this state, it saves it's context and needs a proper confi=
guration
>>>>>>> in flow controller to power gate the CPU when CPU runs into WFI
>>>>>>> instruction. And the CPU also needs to set the IRQ as CPU power=
 down idle
>>>>>>> wake up event in flow controller.
>>>>>>>
>>>>>>> Signed-off-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>>>>> ---
>>>>>>
>>>>>> Hi Joseph,
>>>>>>
>>>>>> a new flag has been added in the cpuidle framework to let this o=
ne to
>>>>>> handle the timer broadcast : CPUIDLE_FLAG_TIMER_STOP
>>>>>>
>>>>>> It is the commit b60e6a0eb0273132cbb60a9806abf5f47a4aee1c
>>>>>>
>>>>>> You can get rid of the clockevent notify stuff by adding this fl=
ag to
>>>>>> the state.
>>>>>>
>>>>>
>>>>> I just tested this flag on Tegra20, 30 and 114. It is only OK on
>>>>> Tegra20. It caused a warning message below on Tegra30/114 at boot=
 time.
>>>>>
>>>>> I gave it a quick check I found it can't clean
>>>>> tick_broadcast_pending_mask sometimes if apply the flag. But I ke=
ep the
>>>>> code right now it's always OK. Not sure why?=20
>>>>
>>>> Is it possible you didn't intialized the timer broadcast with
>>>> CLOCK_EVT_NOTIFY_BROADCAST_ON in the driver and then this one is
>>>> actually disabled for you driver ?
>>>>
>>> I found if I don't apply the CPUIDLE_FLAG_TIMER_STOP flag, the func=
tion
>>> "cpuidle_setup_broadcast_timer" (drivers/cpuidle/driver.c) would no=
t be
>>> called. Then it's OK.
>>>
>>> If I apply this flag (with no CONFIG_CPU_IDLE_MULTIPLE_DRIVERS), th=
e
>>> cpuidle_register_driver only register for CPU0. Then the
>>> "cpuidle_setup_broadcast_timer" only turn on for CPU0. I think this
>>> might be the root cause. Not sure this also can reproduce on the ot=
her
>>> SoCs?
>>>
>> Looks it's not related to CLOCK_EVT_NOTIFY_BROADCAST_ON. I still saw=
 the
>> warning message even enable CONFIG_CPU_IDLE_MULTIPLE_DRIVERS. But if=
 I
>> move the clockevent_notify of CLOCK_EVT_NOTIFY_BROADCAST_EXIT from i=
dle
>> framework back to driver, then everything is OK.
>>
> Once I move the clockevent_notify of CLOCK_EVT_NOTIFY_BROADCAST_EXIT
> right after "local_irq_enable" in the
> "cpuidle_enter_state" (drivers/cpuidle/cpuidle.c). Then the warning
> message shows up.

Is it possible you pastebin you kernel config file ? I would like to
check a couple of things before investigating the code.

Thanks


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
