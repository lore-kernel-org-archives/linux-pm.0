From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 05/16] blackfin idle: delete pm_idle
Date: Wed, 20 Feb 2013 20:53:38 +0100
Message-ID: <512529C2.4050909@metafoo.de>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org> <8408629d64626937a5202751703dae7f41941f7a.1360475150.git.len.brown@intel.com> <512256A3.6050100@metafoo.de> <1656351.lki82jZfSs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:60760 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934361Ab3BTTvv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 14:51:51 -0500
In-Reply-To: <1656351.lki82jZfSs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, uclinux-dist-devel@blackfin.uclinux.org

On 02/20/2013 08:52 PM, Rafael J. Wysocki wrote:
> On Monday, February 18, 2013 05:28:19 PM Lars-Peter Clausen wrote:
>> On 02/10/2013 06:58 AM, Len Brown wrote:
>>> From: Len Brown <len.brown@intel.com>
>>>
>>> pm_idle is dead code on blackfin.
>>>
>>> Signed-off-by: Len Brown <len.brown@intel.com>
>>> Cc: uclinux-dist-devel@blackfin.uclinux.org
>>> ---
>>>  arch/blackfin/kernel/process.c | 7 -------
>>>  1 file changed, 7 deletions(-)
>>>
>>> diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/=
process.c
>>> index 3e16ad9..8061426 100644
>>> --- a/arch/blackfin/kernel/process.c
>>> +++ b/arch/blackfin/kernel/process.c
>>> @@ -39,12 +39,6 @@ int nr_l1stack_tasks;
>>>  void *l1_stack_base;
>>>  unsigned long l1_stack_len;
>>> =20
>>> -/*
>>> - * Powermanagement idle function, if any..
>>> - */
>>> -void (*pm_idle)(void) =3D NULL;
>>> -EXPORT_SYMBOL(pm_idle);
>>> -
>>>  void (*pm_power_off)(void) =3D NULL;
>>>  EXPORT_SYMBOL(pm_power_off);
>>> =20
>>> @@ -81,7 +75,6 @@ void cpu_idle(void)
>>>  {
>>>  	/* endless idle loop with no priority at all */
>>>  	while (1) {
>>> -		void (*idle)(void) =3D pm_idle;
>>
>> Hi,
>>
>> This results in the following error:
>>
>> arch/blackfin/kernel/process.c: In function =E2=80=98cpu_idle=E2=80=99=
:
>> arch/blackfin/kernel/process.c:83: error: =E2=80=98idle=E2=80=99 und=
eclared (first use in
>> this function)
>> arch/blackfin/kernel/process.c:83: error: (Each undeclared identifie=
r is
>> reported only once
>> arch/blackfin/kernel/process.c:83: error: for each function it appea=
rs in.)
>> arch/blackfin/kernel/process.c:88: error: implicit declaration of fu=
nction
>> =E2=80=98idle=E2=80=99
>>
>>
>> This change on top of your patch, fixes it.
>=20
> Lars, I need your sign-off for the patch below.  May I add it?
>=20
> Rafael

Sure, I didn't realize the patches had already been merged, otherwise I=
'd have
sent a proper patch.

- Lars


>> diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/p=
rocess.c
>> index 8061426..9782c03 100644
>> --- a/arch/blackfin/kernel/process.c
>> +++ b/arch/blackfin/kernel/process.c
>> @@ -80,12 +80,10 @@ void cpu_idle(void)
>>  		if (cpu_is_offline(smp_processor_id()))
>>  			cpu_die();
>>  #endif
>> -		if (!idle)
>> -			idle =3D default_idle;
>>  		tick_nohz_idle_enter();
>>  		rcu_idle_enter();
>>  		while (!need_resched())
>> -			idle();
>> +			default_idle();
>>  		rcu_idle_exit();
>>  		tick_nohz_idle_exit();
>>  		preempt_enable_no_resched();
>>
>>
