From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] cpuidle / menu: Return error code if there are no
 suitable states
Date: Wed, 30 Apr 2014 14:40:31 +0200
Message-ID: <5360EF3F.1040003@linaro.org>
References: <2471963.urOyfY8mOG@vostro.rjw.lan> <6832089.A5AOPipfbA@vostro.rjw.lan> <535E3818.2040905@linaro.org> <2000825.kO1es8ShkW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2000825.kO1es8ShkW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 04/29/2014 01:28 AM, Rafael J. Wysocki wrote:
> On Monday, April 28, 2014 01:14:32 PM Daniel Lezcano wrote:
>> On 04/27/2014 02:55 PM, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> If there is a PM QoS latency limit and all of the sufficiently shal=
low
>>> C-states are disabled, the cpuidle menu governor returns 0 which on
>>> some systems is CPUIDLE_DRIVER_STATE_START and shouldn't be returne=
d
>>> if that C-state has been disabled.
>>>
>>> Fix the issue by modifying the menu governor to return an error cod=
e
>>> in such situations.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>    drivers/cpuidle/governors/menu.c |    2 +-
>>>    include/linux/cpuidle.h          |    2 ++
>>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> Index: linux-pm/drivers/cpuidle/governors/menu.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
>>> +++ linux-pm/drivers/cpuidle/governors/menu.c
>>> @@ -296,7 +296,7 @@ static int menu_select(struct cpuidle_dr
>>>    		data->needs_update =3D 0;
>>>    	}
>>>
>>> -	data->last_state_idx =3D 0;
>>> +	data->last_state_idx =3D CPUIDLE_DRIVER_STATE_POLL;
>>>
>>>    	/* Special case when user has set very strict latency requireme=
nt */
>>>    	if (unlikely(latency_req =3D=3D 0))
>>> Index: linux-pm/include/linux/cpuidle.h
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-pm.orig/include/linux/cpuidle.h
>>> +++ linux-pm/include/linux/cpuidle.h
>>> @@ -217,8 +217,10 @@ static inline int cpuidle_register_gover
>>>
>>>    #ifdef CONFIG_ARCH_HAS_CPU_RELAX
>>>    #define CPUIDLE_DRIVER_STATE_START	1
>>> +#define CPUIDLE_DRIVER_STATE_POLL	0
>>>    #else
>>>    #define CPUIDLE_DRIVER_STATE_START	0
>>> +#define CPUIDLE_DRIVER_STATE_POLL	(-ENXIO)
>>>    #endif
>>>
>>>    #endif /* _LINUX_CPUIDLE_H */
>>
>> Hi Rafael,
>>
>> CPUIDLE_DRIVER_STATE_START is only for x86. It introduces some confu=
sion
>> in the code.
>
> I won't disagree with that.
>
>> As only two drivers are concerned by it, wouldn't make
>> sense to add the poll state to those driver directly instead of havi=
ng
>> the code hacked around ? (eg. insert the poll state in the common
>> cpuidle code).
>
> Well, what about initializing data->last_state_idx to
> (CPUIDLE_DRIVER_STATE_START - 1) in menu_select() instead of introduc=
ing the
> new symbol for the time being and getting rid of CPUIDLE_DRIVER_STATE=
_START
> separately?

+1


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
