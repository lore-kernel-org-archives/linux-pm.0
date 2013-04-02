From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/5] timer: move enum definition out of ifdef section
Date: Tue, 02 Apr 2013 06:43:38 +0200
Message-ID: <515A61FA.6000302@linaro.org>
References: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org> <5116925.ZeoNyu5C6N@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33644 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab3DBEno (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Apr 2013 00:43:44 -0400
Received: by mail-wi0-f181.google.com with SMTP id hj8so18250wib.14
        for <linux-pm@vger.kernel.org>; Mon, 01 Apr 2013 21:43:41 -0700 (PDT)
In-Reply-To: <5116925.ZeoNyu5C6N@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: tglx@linutronix.de, linus.walleij@linaro.org, kernel@pengutronix.de, santosh.shilimkar@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org

On 04/02/2013 01:24 AM, Rafael J. Wysocki wrote:
> Hi,
>=20
> All 5 in this series applied to linux-pm.git/linux-next.
>=20
> What am I supposed to do with patches [6-15/15] in your previous seri=
es?
>=20
> Are you going to resend the ones that have been ACKed?

No, please ignore them. After discussing, people want to see the init
function in the cpuidle framework not in a generic ARM driver. So I am
rewriting the patchset for that.

There are the cleanups before to apply [1], except [4/9] which was
already fixed in the OMAP tree.

Thanks
  -- Daniel

[1] https://patchwork.kernel.org/patch/2365041/

> On Wednesday, March 27, 2013 11:22:09 AM Daniel Lezcano wrote:
>> The next patch will setup automatically the broadcast timer for
>> the different cpuidle driver when one idle state stops its timer.
>> This will be part of the generic code.
>>
>> But some ARM boards, like s3c64xx, uses cpuidle but without the
>> CONFIG_GENERIC_CLOCKEVENTS_BUILD set. Hence the cpuidle framework
>> will be compiled with the code supposed to be generic, that is
>> with clockevents_notify and the different enum.
>>
>> Also the function clockevents_notify is a noop macro, this is fine
>> except the usual code is:
>>
>> 	int cpu =3D smp_processor_id();
>> 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
>>
>> and that raises a warning for the variable cpu which is not used.
>>
>> Move the clock_event_nofitiers enum definition out of the
>> CONFIG_GENERIC_CLOCKEVENTS_BUILD section to prevent a compilation
>> error when these are used in the code.
>>
>> Change the clockevents_notify macro to a static inline noop function
>> to prevent a compilation warning.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  include/linux/clockchips.h |   32 ++++++++++++++++----------------
>>  1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
>> index 6634652..f9fd937 100644
>> --- a/include/linux/clockchips.h
>> +++ b/include/linux/clockchips.h
>> @@ -8,6 +8,20 @@
>>  #ifndef _LINUX_CLOCKCHIPS_H
>>  #define _LINUX_CLOCKCHIPS_H
>> =20
>> +/* Clock event notification values */
>> +enum clock_event_nofitiers {
>> +	CLOCK_EVT_NOTIFY_ADD,
>> +	CLOCK_EVT_NOTIFY_BROADCAST_ON,
>> +	CLOCK_EVT_NOTIFY_BROADCAST_OFF,
>> +	CLOCK_EVT_NOTIFY_BROADCAST_FORCE,
>> +	CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
>> +	CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
>> +	CLOCK_EVT_NOTIFY_SUSPEND,
>> +	CLOCK_EVT_NOTIFY_RESUME,
>> +	CLOCK_EVT_NOTIFY_CPU_DYING,
>> +	CLOCK_EVT_NOTIFY_CPU_DEAD,
>> +};
>> +
>>  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BUILD
>> =20
>>  #include <linux/clocksource.h>
>> @@ -26,20 +40,6 @@ enum clock_event_mode {
>>  	CLOCK_EVT_MODE_RESUME,
>>  };
>> =20
>> -/* Clock event notification values */
>> -enum clock_event_nofitiers {
>> -	CLOCK_EVT_NOTIFY_ADD,
>> -	CLOCK_EVT_NOTIFY_BROADCAST_ON,
>> -	CLOCK_EVT_NOTIFY_BROADCAST_OFF,
>> -	CLOCK_EVT_NOTIFY_BROADCAST_FORCE,
>> -	CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
>> -	CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
>> -	CLOCK_EVT_NOTIFY_SUSPEND,
>> -	CLOCK_EVT_NOTIFY_RESUME,
>> -	CLOCK_EVT_NOTIFY_CPU_DYING,
>> -	CLOCK_EVT_NOTIFY_CPU_DEAD,
>> -};
>> -
>>  /*
>>   * Clock event features
>>   */
>> @@ -173,7 +173,7 @@ extern int tick_receive_broadcast(void);
>>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>>  extern void clockevents_notify(unsigned long reason, void *arg);
>>  #else
>> -# define clockevents_notify(reason, arg) do { } while (0)
>> +static inline void clockevents_notify(unsigned long reason, void *a=
rg) {}
>>  #endif
>> =20
>>  #else /* CONFIG_GENERIC_CLOCKEVENTS_BUILD */
>> @@ -181,7 +181,7 @@ extern void clockevents_notify(unsigned long rea=
son, void *arg);
>>  static inline void clockevents_suspend(void) {}
>>  static inline void clockevents_resume(void) {}
>> =20
>> -#define clockevents_notify(reason, arg) do { } while (0)
>> +static inline void clockevents_notify(unsigned long reason, void *a=
rg) {}
>> =20
>>  #endif
>> =20
>>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

