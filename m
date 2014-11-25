From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v11 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Tue, 25 Nov 2014 16:32:10 +0530
Message-ID: <CAKohpo=CovQ0h_7yyhPg2AVrC+SDZm3+N-_WNWZXfowKFNdrDw@mail.gmail.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-4-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
	<546CEF61.4050105@arm.com>
	<CAKohponEHqHYCLibVc8OHN49+4YW5qw89ny4ycTBL1xN-p9qtA@mail.gmail.com>
	<5473364C.3010102@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:46043 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbaKYLCL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 06:02:11 -0500
Received: by mail-oi0-f52.google.com with SMTP id h136so210285oig.39
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 03:02:10 -0800 (PST)
In-Reply-To: <5473364C.3010102@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On 24 November 2014 at 19:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 20/11/14 03:48, Viresh Kumar wrote:
>> - I believe CPUs boot in the order they are present in DT except for the
>> boot CPU. So, the first node for every cluster should have it.
>>
>> Correct ? Then we can update the fixme.
>>
>
> No, I disagree as you trying to implicitly depend on the logic Linux uses to
> assign logical index. It can be changed any time, and depending
> on it might break things in future which can't be fixed easily later
> especially if it's DT related.

Yeah, correct.

>> Hmm, I never thought about it. But yes the CPU with the OPPs should
>> be the first one to come back.
>>
>
> How can you assume that ? I can write a simple test which hot-plugs out
> all the CPUs in the (esp. multi-cluster) system in ascending order of
> logical index and hot-plug back in descending order. Then the above
> logic fails.

What I said is: Yes the CPU with the OPPs should be the first one to come
back, if this has to work correctly. Otherwise it will break..

And you repeated the same :)

> The platforms needing it have to get involved in such discussions to
> make any progress.

Yes there were people involved. I hope I cc'd you as well...
