From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] cpuidle / menu: Return error code if there are no
 suitable states
Date: Fri, 02 May 2014 15:19:55 +0200
Message-ID: <53639B7B.2040209@linaro.org>
References: <2471963.urOyfY8mOG@vostro.rjw.lan> <1516317.nEvPfS8aZ7@vostro.rjw.lan> <53635BB4.30900@linaro.org> <1684440.TX1lbQesgE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1684440.TX1lbQesgE@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 05/02/2014 02:20 PM, Rafael J. Wysocki wrote:
> On Friday, May 02, 2014 10:47:48 AM Daniel Lezcano wrote:
>> On 04/30/2014 01:16 AM, Rafael J. Wysocki wrote:
>>> On Tuesday, April 29, 2014 01:28:03 AM Rafael J. Wysocki wrote:
>>>> On Monday, April 28, 2014 01:14:32 PM Daniel Lezcano wrote:
>>>>> On 04/27/2014 02:55 PM, Rafael J. Wysocki wrote:
>>
>> [ ... ]
>>
>>> ---
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Subject: cpuidle / menu: Return (-1) if there are no suitable state=
s
>>>
>>> If there is a PM QoS latency limit and all of the sufficiently shal=
low
>>> C-states are disabled, the cpuidle menu governor returns 0 which on
>>> some systems is CPUIDLE_DRIVER_STATE_START and shouldn't be returne=
d
>>> if that C-state has been disabled.
>>>
>>> Fix the issue by modifying the menu governor to return (-1) in such
>>> situations.
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
>>> +	data->last_state_idx =3D CPUIDLE_DRIVER_STATE_START - 1;
>>
>> In case of x86, CPUIDLE_DRIVER_STATE_START will be 1, so the select
>> function could return 0 even this one is disabled and this is not wh=
at
>> you want to happen, no ?
>
> OK, so that's a choice.  We can choose to do the above or to return a=
n error
> code if the 0 state is disabled too.  The above is arguably simpler a=
nd
> matches the idea that 0 is a "fallback" state on x86.
>
> Of course, it also is confusing, because user space *can* set "disabl=
e" for
> the 0 state on x86, but that actually has no effect today AFAICS.

Yes, the poll state is very rarely selected.

Regarding the description of this patch, I think it would make sense to=
=20
move the duplicate pm qos checks to the cpuidle_idle_call function=20
directly and pass the latency req to the select function, so the zero=20
latency check could be done by the caller before entering select.

> I'm mostly worried about systems where CPUIDLE_DRIVER_STATE_START is =
0
> and where menu_select() explicitly checks "disabled" and then it retu=
rns
> 0 anyway if it cannot find any other suitable state.

=46or the ARM platform, the state0 and the default idle function are th=
e=20
same, so disabling this state will result in calling the same idle func=
tion.

> In my opinion that needs to be made consistent, but I don't care too =
much about
> which way as long as the change is not too intrusive.

I think we can live with this patch until we remove the=20
CPUIDLE_DRIVER_STATE_START macro. It was introduced to factor out a=20
couple of drivers and now it results in a confusing-hard-to-fix-code.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
