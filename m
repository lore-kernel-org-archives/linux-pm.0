From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Tue, 03 Mar 2015 11:30:07 +0100
Message-ID: <54F58D2F.2010907@linaro.org>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com> <4892716.Bf612zPN6E@vostro.rjw.lan> <54F03B51.1010708@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:44902 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbbCCKaN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 05:30:13 -0500
Received: by wiwl15 with SMTP id l15so21518129wiw.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2015 02:30:11 -0800 (PST)
In-Reply-To: <54F03B51.1010708@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, fbf@libero.it

On 02/27/2015 10:39 AM, Gregory CLEMENT wrote:
> Hi Rafael,
>
> On 26/02/2015 22:55, Rafael J. Wysocki wrote:
>> On Thursday, February 26, 2015 06:20:48 PM Gregory CLEMENT wrote:
>>> As stated in kernel/cpu_pm.c, "Platform is responsible for ensuring
>>> that cpu_pm_enter is not called twice on the same CPU before
>>> cpu_pm_exit is called.". In the current code in case of failure whe=
n
>>> calling mvebu_v7_cpu_suspend, the function cpu_pm_exit() is never
>>> called whereas cpu_pm_enter() was called just before.
>>>
>>> This patch moves the cpu_pm_exit() in order to balance the
>>> cpu_pm_enter() calls.
>>>
>>> Reported-by: Fulvio Benini <fbf@libero.it>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> Should that go to "stable" too?  Which "stable" series it should go =
to if so?
>
> Yes as it fixes a potential issue, you're right it should go
> to "stable". The bug was here since the introduction of the driver
> in 3.16.

Hi Gregory,

actually the 'stable' rules state clearly:

"- It must fix a real bug that bothers people (not a, "This could be a=20
problem..." type thing)."

You say "it fixes a potential issue", so no bug has been raise yet, rig=
ht ?

>>> ---
>>>   drivers/cpuidle/cpuidle-mvebu-v7.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/c=
puidle-mvebu-v7.c
>>> index 38e68618513a..cefa07438ae1 100644
>>> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
>>> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
>>> @@ -37,11 +37,11 @@ static int mvebu_v7_enter_idle(struct cpuidle_d=
evice *dev,
>>>   		deepidle =3D true;
>>>
>>>   	ret =3D mvebu_v7_cpu_suspend(deepidle);
>>> +	cpu_pm_exit();
>>> +
>>>   	if (ret)
>>>   		return ret;
>>>
>>> -	cpu_pm_exit();
>>> -
>>>   	return index;
>>>   }
>>>
>>>
>>
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

