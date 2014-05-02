From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 1/2] sched: idle: Encapsulate the code to compile it
 out
Date: Fri, 02 May 2014 15:29:45 +0200
Message-ID: <53639DC9.2000701@linaro.org>
References: <1398859263-7632-1-git-send-email-daniel.lezcano@linaro.org> <2735426.75qSjG3M6Y@vostro.rjw.lan> <53635E5F.8070100@linaro.org> <5985714.f7hh9Ej59L@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37862 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaEBN3o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 May 2014 09:29:44 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so2229814wiw.3
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2014 06:29:43 -0700 (PDT)
In-Reply-To: <5985714.f7hh9Ej59L@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: peterz@infradead.org, mingo@elte.hu, amit.kucheria@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On 05/02/2014 02:09 PM, Rafael J. Wysocki wrote:
> On Friday, May 02, 2014 10:59:11 AM Daniel Lezcano wrote:
>> On 05/01/2014 12:56 AM, Rafael J. Wysocki wrote:
>>> On Thursday, May 01, 2014 12:47:25 AM Rafael J. Wysocki wrote:
>>>> On Wednesday, April 30, 2014 02:01:02 PM Daniel Lezcano wrote:
>>>>> Encapsulate the large portion of cpuidle_idle_call inside another
>>>>> function so when CONFIG_CPU_IDLE=3Dn, the code will be compiled o=
ut.
>>>>> Also that is benefitial for the clarity of the code as it removes
>>>>> a nested indentation level.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>
>>>> Well, this conflicts with
>>>>
>>>> https://patchwork.kernel.org/patch/4071541/
>>>>
>>>> which you haven't commented on and I still want cpuidle_select() t=
o be able to
>>>> return negative values because of
>>>>
>>>> https://patchwork.kernel.org/patch/4089631/
>>>>
>>>> (and I have one more patch on top of these two that requires this)=
=2E
>>>
>>> Moreover (along the lines of Nico said) after https://patchwork.ker=
nel.org/patch/4071541/
>>> we actually don't need the #ifdef CONFIG_CPU_IDLE in your patch, be=
cause cpuidle_select()
>>> for CONFIG_CPU_IDLE unset is a static inline returning a negative n=
umber and the compiler
>>> should optimize out the blocks that depend on it being non-negative=
=2E
>>
>> Thanks for the head up.
>>
>> Actually that was to solve a compilation issue with the next patch w=
hen
>> adding the cpuidle state in the struct rq.
>>
>> When the option CPU_IDLE is not set, the code assinging the cpu idle
>> state in the rq is still there while in the struct rq the field is
>> compiled out with the ifdef macro. If I rely on the compiler
>> optimization, the compilation error will happen.
>
> I see.
>
> If you don't put the new idle_state field in struct_rq under the #ifd=
ef,
> you won't need to worry about the build problem.
>
> Alternatively, you can define
>
> #ifdef CONFIG_CPU_IDLE
> static inline void rq_set_idle_state(struct rq *rq, struct cpuidle_st=
ate *state)
> {
> 	rq->idle_state =3D state;
> }
> #else
> static inline void rq_set_idle_state(struct rq *rq, struct cpuidle_st=
ate *state) {}
> #endif
>
> and use rq_set_idle_state() to set that field.

Thanks, I will look at one or another solution.




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

