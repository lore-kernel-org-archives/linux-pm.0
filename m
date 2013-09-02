From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] x86: cpuidle: remove broadcast timer initialization
Date: Mon, 02 Sep 2013 16:02:20 +0200
Message-ID: <52249A6C.4030205@linaro.org>
References: <1375192468-2255-1-git-send-email-daniel.lezcano@linaro.org> <1375192468-2255-2-git-send-email-daniel.lezcano@linaro.org> <4496036.lOTuXedAKS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:64051 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758310Ab3IBOCY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2013 10:02:24 -0400
Received: by mail-bk0-f47.google.com with SMTP id mx12so1607507bkb.6
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2013 07:02:23 -0700 (PDT)
In-Reply-To: <4496036.lOTuXedAKS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Len Brown <len.brown@intel.com>

On 08/20/2013 04:11 PM, Rafael J. Wysocki wrote:
> On Tuesday, July 30, 2013 03:54:28 PM Daniel Lezcano wrote:
>> Commit 89878baa73f0f1c679355006bd8632e5d78f96c2 introduced the flag
>> CPUIDLE_FLAG_TIMER_STOP where we specify a specific idle state stops=
 the local
>> timer.
>>
>> Commit a06df062a189a8d5588babb8bf0bb78672497798 introduced the initi=
alization
>> of the timer broadcast framework depending of the flag presence.
>>
>> We have now a way to set a flag for a specific state to tell if the =
local timer
>> will be down in deep idle state or not and we have cpu hotplug suppo=
rt to setup
>> the broadcast timer.
>=20
> So this depends on [1/2], right?

Yes, that's correct.

>> Remove the timer broadcast initialization from init and at the cpu h=
otplug
>> time.
>>
>> Remove the timer broadcast activation in the idle loop.
>>
>> Remove the bitmap LAPIC_TIMER_ALWAYS_RELIABLE.
>>
>> Set the CPUIDLE_FLAG_TIMER_STOP on the states when they are greater =
than C1 and
>> the cpu has not X86_FEATURE_ARAT.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> I generally like the changes made by this patch, but I wonder how muc=
h it
> has been tested?

Well it has been tested on my laptop which is an i5-3317.

With lapic_tsc_reliable_states 0xffffffff

> The subject is slightly misleading too, because it's about the intel_=
idle
> driver.  Please put intel_idle in the subject.

Ok, sure.

>> ---
>>  drivers/idle/intel_idle.c |   41 ++++------------------------------=
-------
>>  1 file changed, 4 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index fa6964d..a975868 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -55,7 +55,6 @@
>> =20
>>  #include <linux/kernel.h>
>>  #include <linux/cpuidle.h>
>> -#include <linux/clockchips.h>
>>  #include <trace/events/power.h>
>>  #include <linux/sched.h>
>>  #include <linux/notifier.h>
>> @@ -77,10 +76,6 @@ static int max_cstate =3D CPUIDLE_STATE_MAX - 1;
>> =20
>>  static unsigned int mwait_substates;
>> =20
>> -#define LAPIC_TIMER_ALWAYS_RELIABLE 0xFFFFFFFF
>> -/* Reliable LAPIC Timer States, bit 1 for C1 etc.  */
>> -static unsigned int lapic_timer_reliable_states =3D (1 << 1);	 /* D=
efault to only C1 */
>> -
>>  struct idle_cpu {
>>  	struct cpuidle_state *state_table;
>> =20
>> @@ -356,9 +351,6 @@ static int intel_idle(struct cpuidle_device *dev=
,
>>  	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
>>  		leave_mm(cpu);
>> =20
>> -	if (!(lapic_timer_reliable_states & (1 << (cstate))))
>> -		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
>> -
>>  	if (!need_resched()) {
>> =20
>>  		__monitor((void *)&current_thread_info()->flags, 0, 0);
>> @@ -367,23 +359,9 @@ static int intel_idle(struct cpuidle_device *de=
v,
>>  			__mwait(eax, ecx);
>>  	}
>> =20
>> -	if (!(lapic_timer_reliable_states & (1 << (cstate))))
>> -		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
>> -
>>  	return index;
>>  }
>> =20
>> -static void __setup_broadcast_timer(void *arg)
>> -{
>> -	unsigned long reason =3D (unsigned long)arg;
>> -	int cpu =3D smp_processor_id();
>> -
>> -	reason =3D reason ?
>> -		CLOCK_EVT_NOTIFY_BROADCAST_ON : CLOCK_EVT_NOTIFY_BROADCAST_OFF;
>> -
>> -	clockevents_notify(reason, &cpu);
>> -}
>> -
>>  static int cpu_hotplug_notify(struct notifier_block *n,
>>  			      unsigned long action, void *hcpu)
>>  {
>> @@ -393,10 +371,6 @@ static int cpu_hotplug_notify(struct notifier_b=
lock *n,
>>  	switch (action & 0xf) {
>>  	case CPU_ONLINE:
>> =20
>> -		if (lapic_timer_reliable_states !=3D LAPIC_TIMER_ALWAYS_RELIABLE)
>> -			smp_call_function_single(hotcpu, __setup_broadcast_timer,
>> -						 (void *)true, 1);
>> -
>>  		/*
>>  		 * Some systems can hotplug a cpu at runtime after
>>  		 * the kernel has booted, we have to initialize the
>> @@ -524,16 +498,9 @@ static int intel_idle_probe(void)
>>  	icpu =3D (const struct idle_cpu *)id->driver_data;
>>  	cpuidle_state_table =3D icpu->state_table;
>> =20
>> -	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer =
*/
>> -		lapic_timer_reliable_states =3D LAPIC_TIMER_ALWAYS_RELIABLE;
>> -	else
>> -		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
>> -
>>  	pr_debug(PREFIX "v" INTEL_IDLE_VERSION
>>  		" model 0x%X\n", boot_cpu_data.x86_model);
>> =20
>> -	pr_debug(PREFIX "lapic_timer_reliable_states 0x%x\n",
>> -		lapic_timer_reliable_states);
>>  	return 0;
>>  }
>> =20
>> @@ -594,6 +561,10 @@ static int intel_idle_cpuidle_driver_init(void)
>>  			mark_tsc_unstable("TSC halts in idle"
>>  					" states deeper than C2");
>> =20
>> +		if (cstate > 1 && !boot_cpu_has(X86_FEATURE_ARAT))
>> +			cpuidle_state_table[cstate].flags |=3D
>> +				CPUIDLE_FLAG_TIMER_STOP;
>> +
>>  		drv->states[drv->state_count] =3D	/* structure copy */
>>  			cpuidle_state_table[cstate];
>> =20
>> @@ -705,10 +676,6 @@ static void __exit intel_idle_exit(void)
>>  {
>>  	intel_idle_cpuidle_devices_uninit();
>>  	cpuidle_unregister_driver(&intel_idle_driver);
>> -
>> -
>> -	if (lapic_timer_reliable_states !=3D LAPIC_TIMER_ALWAYS_RELIABLE)
>> -		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
>>  	unregister_cpu_notifier(&cpu_hotplug_notifier);
>> =20
>>  	return;
>>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

