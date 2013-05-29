From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [RFC v2 0/3][TESTS] LAB: Support for Legacy Application Booster
 governor - tests results
Date: Wed, 29 May 2013 15:45:23 +0200
Message-ID: <20130529154523.60a3cb5b@amdc308.digital.local>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <2272781.tC3OqoQmKI@vostro.rjw.lan>
 <20130528152625.1b7833e5@amdc308.digital.local>
 <76114024.UaPHgm94jK@vostro.rjw.lan>
 <CAKohpon8CScv_GgXL4eTvKqPo1oC67TujMH4WdOQCit7jz+FeQ@mail.gmail.com>
 <20130529090902.66c29c26@amdc308.digital.local>
 <CAKohpo=xuasNEaOBajze2nGVX48_8AE+3eWwbmhXcG9r7PG+EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54896 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759457Ab3E2Np7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2013 09:45:59 -0400
In-reply-to: <CAKohpo=xuasNEaOBajze2nGVX48_8AE+3eWwbmhXcG9r7PG+EA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jonghwa Lee <jonghwa3.lee@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vicent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>

Hi Viresh,

> On 29 May 2013 12:39, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > I also agree. Moreover, I think that there should be only one set of
> > "boost" sysfs entries either it is supported by HW (Intel) or SW
> > (ARM).
> 
> Yes, you need to change acpi-cpufreq driver too to use this common
> infrastructure.

Ok, thanks for pointing out.

> 
> > I can think of two "basic" one:
> > - max_turbo_freq (ro)
> 
> This is surely per policy as two separate clusters can have separate
> values. And probably a better one would be scaling_boost_frequencies,
> that will list all boost frequencies.

Ok,

> 
> > - turbo_mode/boost (rw)
> 
> I am confused with these two names: boost and turbo.. Probably we
> should use a single name everywhere. Because acpi-cpufreq is already
> using boost, we might shift to that.
> 
> > - /sys/devices/system/cpu/cpufreq/boost
> 
> Obviously this one.
> 
> > On the other hand first option would be used with systems, where
> > per-core (or core sets) frequency setting is possible (b.L,
> > Snapdragon S4)
> 
> For now this feature would be enabled on all clusters and controlled
> by cpu/cpufreq/boost.

This will simplify considerably the driver code.

> 
> > To sum up - the idea is as follow:
> >
> > 1. cpufreq_driver exports turbo_mode=1 when it supports overclocking
> > (this support can be hardcoded or read from device tree)
> >
> > 2. Then proper entries are exported to sysfs.
> >
> > 3. User via sysfs (at [*]) can enable/disable the feature on demand
> 
> Bingo!!

Thanks for suggestions. I'm now working on a prototype code. I plan to
post it at the beginning of next week.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
