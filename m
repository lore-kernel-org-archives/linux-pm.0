From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Tue, 03 Mar 2015 14:00:51 +0100
Message-ID: <54F5B083.5010601@linaro.org>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com> <4892716.Bf612zPN6E@vostro.rjw.lan> <54F03B51.1010708@free-electrons.com> <54F58D2F.2010907@linaro.org> <54F58E3B.9040302@free-electrons.com> <54F59285.5060306@libero.it> <54F5AE5C.6060006@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34821 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbbCCNA4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 08:00:56 -0500
Received: by wivz2 with SMTP id z2so3169240wiv.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2015 05:00:54 -0800 (PST)
In-Reply-To: <54F5AE5C.6060006@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Fulvio <fbf@libero.it>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On 03/03/2015 01:51 PM, Gregory CLEMENT wrote:
> Hi Fulvio,
>
> On 03/03/2015 11:52, Fulvio wrote:
>> Gregory CLEMENT wrote:
>>> Hi Rafael,
>>>
>>>
>>>
>>> On 03/03/2015 11:30, Daniel Lezcano wrote:
>>>
>>>> On 02/27/2015 10:39 AM, Gregory CLEMENT wrote:
>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> On 26/02/2015 22:55, Rafael J. Wysocki wrote:
>>>>>
>>>>>> On Thursday, February 26, 2015 06:20:48 PM Gregory CLEMENT wrote=
:
>>>>>>
>>>>>>> As stated in kernel/cpu_pm.c, "Platform is responsible for ensu=
ring
>>>>>>> that cpu_pm_enter is not called twice on the same CPU before
>>>>>>> cpu_pm_exit is called.". In the current code in case of failure=
 when
>>>>>>> calling mvebu_v7_cpu_suspend, the function cpu_pm_exit() is nev=
er
>>>>>>> called whereas cpu_pm_enter() was called just before.
>>>>>>>
>>>>>>> This patch moves the cpu_pm_exit() in order to balance the
>>>>>>> cpu_pm_enter() calls.
>>>>>>>
>>>>>>> Reported-by: Fulvio Benini <fbf@libero.it>
>>>>>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.=
com>
>>>>>>>
>>>>>> Should that go to "stable" too?  Which "stable" series it should=
 go to if so?
>>>>>>
>>>>> Yes as it fixes a potential issue, you're right it should go
>>>>> to "stable". The bug was here since the introduction of the drive=
r
>>>>> in 3.16.
>>>>>
>>>> Hi Gregory,
>>>>
>>>> actually the 'stable' rules state clearly:
>>>>
>>>> "- It must fix a real bug that bothers people (not a, "This could =
be a
>>>> problem..." type thing)."
>>>>
>>>> You say "it fixes a potential issue", so no bug has been raise yet=
, right ?
>>>>
>>>
>>> Indeed nobody claimed yet having a bug related to this issue.
>>>
>>> Gregory
>>>
>>>
>> I reported the issue, but i cannot say if it's a real bug.
>> I had random kernel panics with a Netgear ReadyNAS RN102 (armada 370=
 cpu):
>> http://www.readynas.com/forum/viewtopic.php?f=3D20&t=3D78697&sid=3D1=
4747617286d55ac27296cdee7a3f420&start=3D210#p452214
>
> I didn't know you experimented random kernel panics and that you thou=
ght
> it was related to the CPU Idle driver.
>
>>
>> All i can say is that the system use the "armadaxp_idle" driver and
>> works fine when running "stress --cpu 8" in background.
>> I asked Netgear to provide a firmware without the idle driver to con=
firm
>> if it's the cause of the problem, but they did not answered.
>
> I think that if you disable all the state using by doing an
>
> echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/stateNUM/disable
>
> where NUM is the nuymbert of the state. Then it should disable the
> cpuidle on the fly.
>
> Daniel, is it correct?

Yes, it is correct.

Make sure it is done on all cpus.

> Or if you can modify your bootargs, then just add cpuidle.off=3D1 to =
the kernel
> command line.
>
> Thanks,
>
> Gregory
>
>> Bye,
>> Fulvio
>>
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

