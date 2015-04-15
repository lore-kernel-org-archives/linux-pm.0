From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] cpuidle: Store the idle start time stamp
Date: Wed, 15 Apr 2015 14:50:33 +0200
Message-ID: <552E5E99.6060901@linaro.org>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org> <20150415102057.GR5029@twins.programming.kicks-ass.net> <552E5992.2050404@linaro.org> <20150415124246.GW5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33787 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbbDOMud (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 08:50:33 -0400
Received: by wgin8 with SMTP id n8so45639604wgi.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2015 05:50:32 -0700 (PDT)
In-Reply-To: <20150415124246.GW5029@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org

On 04/15/2015 02:42 PM, Peter Zijlstra wrote:
> On Wed, Apr 15, 2015 at 02:29:06PM +0200, Daniel Lezcano wrote:
>> On 04/15/2015 12:20 PM, Peter Zijlstra wrote:
>>> On Wed, Apr 15, 2015 at 12:00:22PM +0200, Daniel Lezcano wrote:
>>>> +	target_state->idle_stamp =3D ktime_to_us(ktime_get());
>>>
>>> ktime_get_ns();
>>>
>>
>> Hmm, sounds like I missed we are dealing with different units (us / =
ns) in
>> cpuidle / sched.
>>
>> Would it make sense to store the time into a ktime structure instead=
 and use
>> the relevant function depending on the place we are inspecting the v=
alue
>> from ?
>
> Why would you ever want to use us? Does ARM enjoy calculating /1000?
>
> Ah, I see the !scalar ktime got whacked, good! At which point the u64=
 ns
> and ktime are the same. That said I prefer the u64 over ktime because
> its easier to manipulate.

Ok. I was trying to save one variable on the stack by reusing the=20
idle_stamp value but if we store it in a different unit, then we have t=
o=20
keep it in order to have usecond for the governors.

I was thinking about converting to nanosecond the cpuidle framework but=
=20
it is not worth to do that as the resolution is too high for the idle=20
states.




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

