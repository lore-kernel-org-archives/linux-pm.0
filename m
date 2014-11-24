From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v11 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Mon, 24 Nov 2014 13:44:44 +0000
Message-ID: <5473364C.3010102@arm.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>	<1413805281-6269-2-git-send-email-thomas.ab@samsung.com>	<1413805281-6269-3-git-send-email-thomas.ab@samsung.com>	<1413805281-6269-4-git-send-email-thomas.ab@samsung.com>	<1413805281-6269-5-git-send-email-thomas.ab@samsung.com>	<546CEF61.4050105@arm.com> <CAKohponEHqHYCLibVc8OHN49+4YW5qw89ny4ycTBL1xN-p9qtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKohponEHqHYCLibVc8OHN49+4YW5qw89ny4ycTBL1xN-p9qtA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Abraham <thomas.ab@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 20/11/14 03:48, Viresh Kumar wrote:
> Oh, you are still alive? I thought you were about to get married :)
> Just kidding !!
>
> On 20 November 2014 00:58, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Sorry for raising this issue always with Exynos cpufreq drivers. IMO the
>> bindings for "arm-bL-cpufreq-dt" is broken. Currently no one is using it
>> and it's better to fix it before we have a real user of it.
>
> Hmm, yeah if we can. I haven't found a easy way to go ahead and then
> got caught in other activities.
>

Agreed, it's not easy but needs to be fixed :)

>> If you look at the binding document for it[1], it has a fixme which
>> shouldn't have been there at first place. It assumes the ordering of
>> CPU's specified in the DT and the logical index allocation to them.
>
> Ok, I believe the FIXME is a bit outdated. From the code I can see only
> this limitation.
>
> - For every cluster, the cpu which boots up first should carry the OPPs.
> Otherwise there is no restriction on ordering of CPUs.
>

Not entirely true, it assuming the fact that the logical index provided 
by the OS is completely based on the ordering in the DT.

> - I believe CPUs boot in the order they are present in DT except for the
> boot CPU. So, the first node for every cluster should have it.
>
> Correct ? Then we can update the fixme.
>

No, I disagree as you trying to implicitly depend on the logic Linux 
uses to assign logical index. It can be changed any time, and depending
on it might break things in future which can't be fixed easily later
especially if it's DT related.

>> It even breaks for hotplug especially if you hotplug-in back in
>> different order.
>
> Hmm, I never thought about it. But yes the CPU with the OPPs should
> be the first one to come back.
>

How can you assume that ? I can write a simple test which hot-plugs out
all the CPUs in the (esp. multi-cluster) system in ascending order of
logical index and hot-plug back in descending order. Then the above
logic fails.

>> We can work around that probably, but it's better to
>> fix the binding. I failed to grab much attention in my previous attempts
>> to address this[2]. Viresh also started a discussion more recently[3].
>
> They are just stuck and went nowhere :(
>

The platforms needing it have to get involved in such discussions to
make any progress.

Regards,
Sudeep
