From: Fulvio <fbf@libero.it>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Tue, 03 Mar 2015 15:58:21 +0100
Message-ID: <54F5CC0D.6060509@libero.it>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com> <4892716.Bf612zPN6E@vostro.rjw.lan> <54F03B51.1010708@free-electrons.com> <54F58D2F.2010907@linaro.org> <54F58E3B.9040302@free-electrons.com> <54F59285.5060306@libero.it> <54F5AE5C.6060006@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-18.italiaonline.it ([212.48.25.146]:34159 "EHLO
	smtp-18.italiaonline.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbbCCO63 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 09:58:29 -0500
In-Reply-To: <54F5AE5C.6060006@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>


> I didn't know you experimented random kernel panics and that you thought
> it was related to the CPU Idle driver.
>
>   
>> All i can say is that the system use the "armadaxp_idle" driver and 
>> works fine when running "stress --cpu 8" in background.
>> I asked Netgear to provide a firmware without the idle driver to confirm 
>> if it's the cause of the problem, but they did not answered.
>>     
>
> I think that if you disable all the state using by doing an
>
> echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/stateNUM/disable
>
> where NUM is the nuymbert of the state. Then it should disable the
> cpuidle on the fly.
>   
Thanks, i'll try that as soon as possible (i gave back the unit to my 
client) and report back.

However, the description of the cpu_pm_enter function state:
"Must be called on the affected CPU with interrupts disabled.  Platform 
is responsible for ensuring that cpu_pm_enter is not called twice on the 
same CPU before cpu_pm_exit is called. Notified drivers can include VFP  
co-processor, interrupt controller and its PM extensions, local CPU  
timers context save/restore which shouldn't be interrupted. Hence it  
must be called with interrupts disabled."

and the point is: it that an invariant? Do current code and future code 
safely assume that cpu_pm_enter is not called twice?
For example if cpu_pm_enter do "context save" and cpu_pm_exit do 
"context restore", calling twice cpu_pm_enter will overwrite the 
previous saved context: is that safe in all circumstances?

I assume the rule " It must fix a real bug that bothers people (not a, 
"This could be a problem..." type thing)." is to avoid committing 
useless changes that may introduce new bugs, but i do not think that 
apply to this case: a bug report from an unknown user (me) should change 
nothing.

Bye,
Fulvio


