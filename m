From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct
 rq
Date: Fri, 31 Jan 2014 16:37:30 +0100
Message-ID: <52EBC33A.6080101@linaro.org>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org> <1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org> <20140130153150.GD5002@laptop.programming.kicks-ass.net> <52EA7D8A.6080604@linaro.org> <20140130163501.GG5002@laptop.programming.kicks-ass.net> <52EA8B07.6020206@linaro.org> <CAM4v1pPwmRUOtNeGh5sZmj+wAsC8RstofNA5Gx862SEECvW-Lg@mail.gmail.com> <20140131090230.GM5002@laptop.programming.kicks-ass.net> <52EB6F65.8050008@linux.vnet.ibm.com> <52EBBC23.8020603@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:39236 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbaAaPhd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2014 10:37:33 -0500
Received: by mail-wg0-f48.google.com with SMTP id x13so9201509wgg.27
        for <linux-pm@vger.kernel.org>; Fri, 31 Jan 2014 07:37:32 -0800 (PST)
In-Reply-To: <52EBBC23.8020603@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>
Cc: Preeti Murthy <preeti.lkml@gmail.com>, nicolas.pitre@linaro.org, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On 01/31/2014 04:07 PM, Arjan van de Ven wrote:
>>>>
>>>> Hence I think this patch would make sense only with additional
>>>> information
>>>> like exit_latency or target_residency is present for the scheduler=
=2E
>>>> The idle
>>>> state index alone will not be sufficient.
>>>
>>> Alternatively, can we enforce sanity on the cpuidle infrastructure =
to
>>> make the index naturally ordered? If not, please explain why :-)
>>
>> The commit id 71abbbf856a0e70 says that there are SOCs which could h=
ave
>> their target_residency and exit_latency values change at runtime. Th=
is
>> commit thus removed the ordering of the idle states according to the=
ir
>> target_residency/exit_latency. Adding Len and Arjan to the CC.
>
> the ARM folks wanted a dynamic exit latency, so.... it makes much mor=
e
> sense
> to me to store the thing you want to use (exit latency) than the numb=
er
> of the state.
>
> more than that, you can order either by target residency OR by exit
> latency,
> if you sort by one, there is no guarantee that you're also sorted by =
the
> other

IMO, it would be preferable to store the index for the moment as we are=
=20
integrating cpuidle with the scheduler. The index allows to access more=
=20
informations. Then when everything is fully integrated we can improve=20
the result, no ?

> (for example, you can on a hardware level make a "fast exit" state, a=
nd
> burn power for this faster exit,
> which means your break even gets longer to recoup this extra power
> compared to the same state without
> the fast exit)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

