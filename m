From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [RFC v2 0/3][TESTS] LAB: Support for Legacy Application Booster
 governor - tests results
Date: Fri, 24 May 2013 13:34:42 +0200
Message-ID: <20130524133442.7e065145@amdc308.digital.local>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <CAKohpokXNUmMbk0KOh58-0=sAs7yzD=cQe24eaoArpRSwM__Gg@mail.gmail.com>
 <20130522122700.104ca5cd@amdc308.digital.local>
 <CAKohpo=9dRXb1jjauvhzuje9rOgH82k-3DeL2zqiwHDHOwSo4g@mail.gmail.com>
 <20130522164453.29cd3a7d@amdc308.digital.local>
 <20130524075640.0a5b80ff@amdc308.digital.local>
 <CAKohpoksymD76rDvg_+PwU7r3JXp1oydHBbJE4-y6TBHOomZHg@mail.gmail.com>
 <20130524103007.7bb206ee@amdc308.digital.local>
 <CAKohponbX7u_k9ZYQ7KyBeyKh93Qu+niGZj60t9c1n+AmaA6pg@mail.gmail.com>
 <519F2D89.5030602@linaro.org>
 <CAKohpom+wsGj=1nurNtoiRaZCD7KRbx0BO+tNXpoqO+FmmzehA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51877 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab3EXLey (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 May 2013 07:34:54 -0400
In-reply-to: <CAKohpom+wsGj=1nurNtoiRaZCD7KRbx0BO+tNXpoqO+FmmzehA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, "Rafael J. Wysocky" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vicent Guittot <vincent.guittot@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>

Hi Viresh,

> On 24 May 2013 14:36, Daniel Lezcano <daniel.lezcano@linaro.org>
> wrote:
> > I agree with Viresh, a new governor is not necessary here for that.
> 
> Their patchset had two parts.. One is LAB and other is overclocking.
> We are trying to solve overclocking for which they never wanted a
> new governor. :)

Overclocking can be uses as a standalone feature. However it is crucial
for effective LAB operation.

> 
> > There is the /sys/devices/system/cpufreq/boost option existing for
> > x86 platform, why do not reuse it ? It is supposed to do exactly
> > what you want to achieve.
> 
> The problem is that it was added at the wrong place.. It should have
> been at cpu/cpuX/cpufreq/boost...
> 
> Consider how will we achieve it for big LITTLE.. We know we can
> go to overdrive only for a single core in big but for two cores in
> LITTLE at the same time.. So, we need that in the location I just
> mentioned...

I think that power/thermal envelope here is a key. We can overclock as
many cores as we want if we don't exceed limits :-)

Scheduler assignment of tasks to cores and core type decision on which
it would run is a different story for b.L. 

> 
> Over that.. I believe it is governor specific too.. It shouldn't be
> part of conservative as it should be conservative rather then
> aggressive :)
> 
> > IMO, the logic of boosting one core when the other are idle should
> > be in the driver itself and certainly not setup by the user, except
> > if we consider acceptable the user can burn its board ... :)

Sysfs entry can be read only and governor code can be responsible for
enabling overclocking.

Overclocking patch provides API implemented at cpufreq.h file to allow
in-kernel overclocking.

> 
> I didn't get it completely.. So, with the options I gave user can only
> say.. boost if required and only when few cores are active. User
> can't just set max freq continuously if he wishes..



-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
