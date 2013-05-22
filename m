From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [RFC v2 0/3] LAB: Support for Legacy Application Booster governor
Date: Wed, 22 May 2013 14:05:50 +0200
Message-ID: <20130522140550.3fa3b4b3@amdc308.digital.local>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <CAKohpokXNUmMbk0KOh58-0=sAs7yzD=cQe24eaoArpRSwM__Gg@mail.gmail.com>
 <20130522122700.104ca5cd@amdc308.digital.local>
 <CAKohpo=9dRXb1jjauvhzuje9rOgH82k-3DeL2zqiwHDHOwSo4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:29899 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab3EVMGI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2013 08:06:08 -0400
In-reply-to: <CAKohpo=9dRXb1jjauvhzuje9rOgH82k-3DeL2zqiwHDHOwSo4g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jonghwa Lee <jonghwa3.lee@samsung.com>, "Rafael J. Wysocky" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vicent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>

Hi Viresh,

> On 22 May 2013 15:57, Lukasz Majewski <l.majewski@samsung.com> wrote:
> >> On 3 May 2013 19:37, Jonghwa Lee <jonghwa3.lee@samsung.com> wrote:
> 
> > I think, that overclocking support is crucial here. As you pointed
> > out
> > - ondemand and conservative benefit from it. Therefore, I would urge
> >   for its mainline acceptance.
> >
> > (code for reference)
> > http://thread.gmane.org/gmane.linux.kernel/1484746/match=cpufreq
> >
> > In this RFC (patch 1/3), I've decided to put the burden of
> > overclocking support to platform code (cpufreq/exynos-cpufreq.c and
> > cpufreq/exynos4x12-cpufreq.c).
> >
> > Those changes aren't intrusive for other boards/archs. Moreover
> > overclocking is closely related to processor clocking/power
> > dissipation capabilities, so SoC specific code is a good place for
> > it.
> >
> >
> > What DO need a broad acceptance is the overclocking API proposed at:
> > include/linux/cpufreq.h
> >
> > This introduces interface to which others will be bind. It
> > shouldn't be difficult to implement overclocking at other SoCs (as
> > it was proposed for Exynos).
> >
> > Feedback is welcome, since I might have overlooked oddities present
> > at other SoCs.
> 
> Hi..
> 
> I am not talking about the minute details here... for example I
> didn't like the way overclocking support is implemented... It has to
> be a bit more framework oriented then driver...

Presented implementation is only RFC. As I've written, I'm open for
suggestion.

> 
> What I am thinking right now is if it is worth to add both the
> features you are trying. i.e. overclocking and LAB..
> 
> So, requested you to give some figures... of ondemand with and without
> overclocking... 

I will provide test results for ondemand with overclocking enabled and
disabled. Thanks for clarification on this matter.

> Leave LAB for now...

Seems fair. One step on a time. Lets focus on overclocking.

> 
> Then we can give LAB a try with above...



-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
