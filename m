From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Tue, 03 Mar 2015 16:20:26 +0100
Message-ID: <54F5D13A.1020002@linaro.org>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com> <4892716.Bf612zPN6E@vostro.rjw.lan> <54F03B51.1010708@free-electrons.com> <54F58D2F.2010907@linaro.org> <54F58E3B.9040302@free-electrons.com> <54F59285.5060306@libero.it> <54F5AE5C.6060006@free-electrons.com> <54F5CC0D.6060509@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:45250 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbbCCPUa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 10:20:30 -0500
Received: by wgha1 with SMTP id a1so40691180wgh.12
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2015 07:20:29 -0800 (PST)
In-Reply-To: <54F5CC0D.6060509@libero.it>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fulvio <fbf@libero.it>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On 03/03/2015 03:58 PM, Fulvio wrote:
>
>> I didn't know you experimented random kernel panics and that you tho=
ught
>> it was related to the CPU Idle driver.
>>
>>> All i can say is that the system use the "armadaxp_idle" driver and
>>> works fine when running "stress --cpu 8" in background.
>>> I asked Netgear to provide a firmware without the idle driver to
>>> confirm if it's the cause of the problem, but they did not answered=
=2E
>>
>> I think that if you disable all the state using by doing an
>>
>> echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/stateNUM/disable
>>
>> where NUM is the nuymbert of the state. Then it should disable the
>> cpuidle on the fly.
> Thanks, i'll try that as soon as possible (i gave back the unit to my
> client) and report back.
>
> However, the description of the cpu_pm_enter function state:
> "Must be called on the affected CPU with interrupts disabled.  Platfo=
rm
> is responsible for ensuring that cpu_pm_enter is not called twice on =
the
> same CPU before cpu_pm_exit is called. Notified drivers can include V=
=46P
> co-processor, interrupt controller and its PM extensions, local CPU
> timers context save/restore which shouldn't be interrupted. Hence it
> must be called with interrupts disabled."
>
> and the point is: it that an invariant? Do current code and future co=
de
> safely assume that cpu_pm_enter is not called twice?

The fix is correct. The cpu_pm_enter/exit symmetry must be kept because=
=20
we don't know what the notifier clients are doing.

The point is : can we send it to stable@ as a bug fix or not ?

> For example if cpu_pm_enter do "context save" and cpu_pm_exit do
> "context restore", calling twice cpu_pm_enter will overwrite the
> previous saved context: is that safe in all circumstances?

That is the drawback of the notifiers: the kernel provides a service an=
d=20
everyone plug something on it. The cpu_pm notifier are very low level=20
functions, so the answer of your question is not obvious. I already=20
checked all the cpuidle drivers if the potential bug you reported is=20
there or not but apparently everything else is fine, cpu_pm_exit is=20
always called after cpu_pm_enter.

As you stated, the API description implies cpu_pm_exit must be called=20
after cpu_pm_enter. So the fix is right.

> I assume the rule " It must fix a real bug that bothers people (not a=
,
> "This could be a problem..." type thing)." is to avoid committing
> useless changes that may introduce new bugs, but i do not think that
> apply to this case: a bug report from an unknown user (me) should cha=
nge
> nothing.

It would be perfect if we can succeed to reproduce the bug you are=20
facing and check the patch fixes it. In this case, it goes to stable@=20
automatically.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

