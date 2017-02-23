From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
Date: Thu, 23 Feb 2017 15:53:14 +0000
Message-ID: <df07e546-34a3-b03f-7c9d-248b8d7fb756@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com>
 <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
 <1975396.x0czmkNPOW@aspire.rjw.lan>
 <35840771-e16f-d6fe-3a89-1b3f51f4a8f3@arm.com>
 <CAMuHMdXpKrJn9NrkAarvMtytk9gHEFcRoZLCsWBFgriUCeWo=Q@mail.gmail.com>
 <f649d707-8b0a-5ca9-b021-93ae8cf66b33@arm.com>
 <CAMuHMdVTEbqEocYwu=KW_uXpykYkVwUgSJBnLvQp_Epn8Pjp1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdVTEbqEocYwu=KW_uXpykYkVwUgSJBnLvQp_Epn8Pjp1g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Len Brown <len.brown@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 23/02/17 15:26, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Wed, Feb 22, 2017 at 3:32 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 22/02/17 13:38, Geert Uytterhoeven wrote:
>>> On Wed, Feb 22, 2017 at 12:03 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>> On 22/02/17 01:14, Rafael J. Wysocki wrote:
>>>>> On Tuesday, February 21, 2017 06:45:13 PM Sudeep Holla wrote:
>>>> Geert, so far you have failed to explain what's different from the new
>>>> state you are adding and the existing s2idle.
>>>
>>> I did explain, cfr.:
>>>   1. The power consumption figures in the cover letter:
>>>       - shallow:    8.4 W   6.2 W   (secondary CPU cores off)
>>
>> That's because your CPU_SUSPEND implementation is incomplete. You can
>> enter the same state as secondary CPU core off even with idle. It's just
>> that we can save by not entering and exiting the CPU hotplug state
>> machine. So this "shallow" state can be achieved if your CPU_SUSPEND
>> implements that state.
> 
> Does that include power areas?
> 

OK, I first I didn't understand what you are referring here but I see
some reference further in the email.

>>>   2. The description for patch 3/6:
>>>         As secondary CPU cores are taken offline, "shallow" suspend mode saves
>>>         slightly more power than "s2idle", but less than "deep" suspend mode.
>>>         However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>>>         regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>>>         an optional API in PSCI v1.0.
>>
>> Yes I understood that, you need to add an extra idle states to get that
>> shallow state. We have discussed this in past to depth. On ARM64/PSCI,
>> we will that support "shallow" system suspend mode which can't be
>> defined generically. Also we can support this shallow state with s2idle.
>>
>> Your system probably not supporting all the CPU idle states. E.g.: it
>> may just support CPU ON/OFF/RET and not cluster ON/OFF/RET. Please add
>> that state to CPU_SUSPEND implementation in the firmware.
> 
> I can find CPU_ON and CPU_OFF in the PSCI specification, but not
> CPU_RET?
> 

No, they were just examples of idle states that CPU_SUSPEND call might
support based on what h/w can support on a particular platform.

> How is the cluster ON/OFF/RET called exactly? I can't find any CLUSTER_*
> calls in the PSCI specification.
> 

CPU_SUSPEND with different parameters, just look at the details on
suspend parameters in Section 5.4.2 CPU_SUSPEND parameters: power_state


> From a quick glance in the PSCI sources, there's some support for powering
> down clusters.
> 

Yes, the above section should provide some insight on the same.

>>> Perhaps, I didn't make myself clear. Let's summarize:
>>>   1. On Renesas R-Car Gen3 platforms, PSCI SYSTEM_SUSPEND is implemented,
>>
>> OK got that.
>>
>>>   2. On these platforms, PSCI SYSTEM_SUSPEND powers down the SoC, and supports
>>>      wake-up from PMIC only,
>>
>> OK
>>
>>>   3. If the user wants to use a different wake-up source, these other
>>> wake-up sources fail to wake up the system from PSCI SYSTEM_SUSPEND.
>>
>> In that case don't enter PSCI SYSTEM_SUSPEND
> 
> Or prevent the system from doing that...
> 

Agreed.

>>>   4. Patch 3/6 adds a new "shallow" state, as it allows to save more
>>> power (the difference may be due to suboptimal cpuidle platform support on R-Car Gen3, though),
>>
>> Why can't you do that in s2idle mode. Please give me the difference
>> between your shallow state and s2idle state, not just power numbers
>> but the actual state of CPUs and the devices in the system.
> 
> From the Linux side, there's not much difference, except that the secondary
> CPU cores are disabled.  As that is handled by PSCI, the difference may be
> in the PSCI implementation.  I will have to check that...
> 

Yes it's better to check. I am afraid that both these states will be
same if PSCI implementation is correct and hence we don't want to
support standby suspend mode.

> On these SoCs, the individual CPU cores and the SCU/L2 are in separate
> (nested) power areas.  Perhaps these power areas are turned off when
> disabling the CPU cores, but not when suspending them.
> 

Yes that's what I suspect and hence I said it's incomplete
implementation of CPU_SUSPEND

>>> E.g. on non-PSCI platforms with an Ethernet driver that supports
>>> Wake-on-LAN, I can do:
>>>
>>>         ethtool -s eth0 wol g
>>>         echo mem > /sys/power/state
>>>
>>> and be sure that the system can be woken up by sending a WoL MagicPacket.
>>
>> Still possible with s2idle if CPU_SUSPEND is correctly implemented by
>> the platform.
> 
> Sure. But not automatic, as it needs fiddling with mem_sleep.
> 

Yes that's true form any thing other than "deep" state. i.e. s2idle or
standby. If you are OK to choose standby why not s2idle ?

>>> On PSCI systems, the above may work, or may not work. And there's no way to
>>> find out (in an automated way) whether it will work or not.
>>>
>>> If it doesn't work, the user has to configure his system (manually) to
>>> not use "mem" state.
>>> Since v4.10-rc1, that can be done using e.g.
>>>
>>>     echo s2idle > /sys/power/mem_sleep
>>>
>>> and my patches make that automatic (for a new "shallow" state instead
>>> of "s2idle", though).
>>
>> How is that ? If "deep" is available as in your case too, why will
>> shallow become default. IIUC the user still have to write "shallow"
>> to mem_sleep.
> 
> After patch 4, if needed (DT property + extra wake-up sources configured),
> psci_system_suspend_enter() will call cpu_do_idle() instead of
> psci_system_suspend(). No need to fiddle with mem_sleep manually.
> 

I understand your intentions and but I have NACKed it with sufficient
reasoning. I don't want to repeat them again here.

>> Does this platform use generic arm64 DT cpuidle driver ? I don't see so
>> from the DT.
> 
> I think that task isn't complete yet.
>

So, all these hacks are just to cope up with that ? Sorry that's
non-sense. Working around a firmware bug is different from working
around the incomplete firmware implementation. We may consider former
but for me latter is just insane.

-- 
Regards,
Sudeep
