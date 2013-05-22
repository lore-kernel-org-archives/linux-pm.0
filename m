From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [RFC v2 0/3] LAB: Support for Legacy Application Booster governor
Date: Wed, 22 May 2013 12:27:00 +0200
Message-ID: <20130522122700.104ca5cd@amdc308.digital.local>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <CAKohpokXNUmMbk0KOh58-0=sAs7yzD=cQe24eaoArpRSwM__Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpokXNUmMbk0KOh58-0=sAs7yzD=cQe24eaoArpRSwM__Gg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jonghwa Lee <jonghwa3.lee@samsung.com>, "Rafael J. Wysocky" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vicent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

Thanks for reply.

> On 3 May 2013 19:37, Jonghwa Lee <jonghwa3.lee@samsung.com> wrote:
> > From: Lukasz Majewski <l.majewski@samsung.com>
> 
> > 2. New LAB governor.
> > It calculates number of idle CPUs (based on scheduler data). On
> > this basis it chose proper first level polynomial function for
> > approximation. Moreover it enables overclocking when single, heavy
> > loaded CPU is running.
> 
> Hi Lukasz,
> 
> I am still not sure about this governor. Do you have some results
> with which you can tell how is it better than ondemand/conservative?

I will provide proper test results. As a test platform I've used
Exynos4 CPU (4 cores) with TIZEN OS on it.

> 
> With or without overclocking. i.e. Apply only overclocking support to
> ondemand/conservative..

I think, that overclocking support is crucial here. As you pointed out
- ondemand and conservative benefit from it. Therefore, I would urge
  for its mainline acceptance.

(code for reference)
http://thread.gmane.org/gmane.linux.kernel/1484746/match=cpufreq

In this RFC (patch 1/3), I've decided to put the burden of overclocking
support to platform code (cpufreq/exynos-cpufreq.c and
cpufreq/exynos4x12-cpufreq.c). 

Those changes aren't intrusive for other boards/archs. Moreover
overclocking is closely related to processor clocking/power dissipation
capabilities, so SoC specific code is a good place for it.


What DO need a broad acceptance is the overclocking API proposed at:
include/linux/cpufreq.h 

This introduces interface to which others will be bind. It shouldn't be
difficult to implement overclocking at other SoCs (as it was proposed
for Exynos).

Feedback is welcome, since I might have overlooked oddities present at
other SoCs.



> 
> If you are using Android, maybe check Interactive too (Though it
> itsn't mainlined yet).

I will also delve into "Interactive" governor.




As a side note:

The "core" cpufreq code modification (patch 3/3) counts only 22 lines,
so this patch series definitely is not intrusive.

> 
> @Rafael: What do you think about this patchset?
> 
> --
> viresh

-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
