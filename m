From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Tue, 03 Mar 2015 11:34:35 +0100
Message-ID: <54F58E3B.9040302@free-electrons.com>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com> <4892716.Bf612zPN6E@vostro.rjw.lan> <54F03B51.1010708@free-electrons.com> <54F58D2F.2010907@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36911 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754488AbbCCKfE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 05:35:04 -0500
In-Reply-To: <54F58D2F.2010907@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, fbf@libero.it

Hi Rafael,



On 03/03/2015 11:30, Daniel Lezcano wrote:
> On 02/27/2015 10:39 AM, Gregory CLEMENT wrote:
>> Hi Rafael,
>>
>> On 26/02/2015 22:55, Rafael J. Wysocki wrote:
>>> On Thursday, February 26, 2015 06:20:48 PM Gregory CLEMENT wrote:
>>>> As stated in kernel/cpu_pm.c, "Platform is responsible for ensuring
>>>> that cpu_pm_enter is not called twice on the same CPU before
>>>> cpu_pm_exit is called.". In the current code in case of failure when
>>>> calling mvebu_v7_cpu_suspend, the function cpu_pm_exit() is never
>>>> called whereas cpu_pm_enter() was called just before.
>>>>
>>>> This patch moves the cpu_pm_exit() in order to balance the
>>>> cpu_pm_enter() calls.
>>>>
>>>> Reported-by: Fulvio Benini <fbf@libero.it>
>>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>
>>> Should that go to "stable" too?  Which "stable" series it should go to if so?
>>
>> Yes as it fixes a potential issue, you're right it should go
>> to "stable". The bug was here since the introduction of the driver
>> in 3.16.
> 
> Hi Gregory,
> 
> actually the 'stable' rules state clearly:
> 
> "- It must fix a real bug that bothers people (not a, "This could be a 
> problem..." type thing)."
> 
> You say "it fixes a potential issue", so no bug has been raise yet, right ?

Indeed nobody claimed yet having a bug related to this issue.

Gregory


> 
>>>> ---
>>>>   drivers/cpuidle/cpuidle-mvebu-v7.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
>>>> index 38e68618513a..cefa07438ae1 100644
>>>> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
>>>> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
>>>> @@ -37,11 +37,11 @@ static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
>>>>   		deepidle = true;
>>>>
>>>>   	ret = mvebu_v7_cpu_suspend(deepidle);
>>>> +	cpu_pm_exit();
>>>> +
>>>>   	if (ret)
>>>>   		return ret;
>>>>
>>>> -	cpu_pm_exit();
>>>> -
>>>>   	return index;
>>>>   }
>>>>
>>>>
>>>
>>
>>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
