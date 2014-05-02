From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 1/2] sched: idle: Encapsulate the code to compile it
 out
Date: Fri, 02 May 2014 10:59:11 +0200
Message-ID: <53635E5F.8070100@linaro.org>
References: <1398859263-7632-1-git-send-email-daniel.lezcano@linaro.org> <2783362.8r7SvVhudq@vostro.rjw.lan> <2735426.75qSjG3M6Y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:37742 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaEBI7J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 May 2014 04:59:09 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so3338596wes.37
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2014 01:59:08 -0700 (PDT)
In-Reply-To: <2735426.75qSjG3M6Y@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: peterz@infradead.org, mingo@elte.hu, amit.kucheria@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On 05/01/2014 12:56 AM, Rafael J. Wysocki wrote:
> On Thursday, May 01, 2014 12:47:25 AM Rafael J. Wysocki wrote:
>> On Wednesday, April 30, 2014 02:01:02 PM Daniel Lezcano wrote:
>>> Encapsulate the large portion of cpuidle_idle_call inside another
>>> function so when CONFIG_CPU_IDLE=3Dn, the code will be compiled out=
=2E
>>> Also that is benefitial for the clarity of the code as it removes
>>> a nested indentation level.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Well, this conflicts with
>>
>> https://patchwork.kernel.org/patch/4071541/
>>
>> which you haven't commented on and I still want cpuidle_select() to =
be able to
>> return negative values because of
>>
>> https://patchwork.kernel.org/patch/4089631/
>>
>> (and I have one more patch on top of these two that requires this).
>
> Moreover (along the lines of Nico said) after https://patchwork.kerne=
l.org/patch/4071541/
> we actually don't need the #ifdef CONFIG_CPU_IDLE in your patch, beca=
use cpuidle_select()
> for CONFIG_CPU_IDLE unset is a static inline returning a negative num=
ber and the compiler
> should optimize out the blocks that depend on it being non-negative.

Thanks for the head up.

Actually that was to solve a compilation issue with the next patch when=
=20
adding the cpuidle state in the struct rq.

When the option CPU_IDLE is not set, the code assinging the cpu idle=20
state in the rq is still there while in the struct rq the field is=20
compiled out with the ifdef macro. If I rely on the compiler=20
optimization, the compilation error will happen.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

