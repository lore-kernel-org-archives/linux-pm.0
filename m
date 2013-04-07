From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/9] intel: cpuidle: remove stop/start critical timings
Date: Sun, 07 Apr 2013 22:52:44 +0200
Message-ID: <5161DC9C.3020703@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <1364991322-20585-7-git-send-email-daniel.lezcano@linaro.org> <3375360.P4DAA9Jd5Y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3375360.P4DAA9Jd5Y-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 04/05/2013 12:31 AM, Rafael J. Wysocki wrote:
> On Wednesday, April 03, 2013 02:15:20 PM Daniel Lezcano wrote:
>> The start/stop_critical_timings are called from arch/x86/kernel/proc=
ess.c
>> in the cpu_idle loop function.
>>
>> Remove the ones in the cpuidle driver.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> For this one I need an ACK from Len.
>=20
> Len, any objections?


Len ? ping ...

>> ---
>>  drivers/idle/intel_idle.c |    3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index 5d66750..c99c31e 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -339,7 +339,6 @@ static int intel_idle(struct cpuidle_device *dev=
,
>>  	if (!(lapic_timer_reliable_states & (1 << (cstate))))
>>  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
>> =20
>> -	stop_critical_timings();
>>  	if (!need_resched()) {
>> =20
>>  		__monitor((void *)&current_thread_info()->flags, 0, 0);
>> @@ -348,8 +347,6 @@ static int intel_idle(struct cpuidle_device *dev=
,
>>  			__mwait(eax, ecx);
>>  	}
>> =20
>> -	start_critical_timings();
>> -
>>  	if (!(lapic_timer_reliable_states & (1 << (cstate))))
>>  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
>> =20
>>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

  * English - detected
  * English
  * French

  * English
  * French

 <javascript:void(0);> <#>
