From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 2/6] drivers/cpufreq: implement init_cpu_capacity_default()
Date: Thu, 4 Feb 2016 16:44:28 +0100
Message-ID: <CAKfTPtDWP-AgqXsSuxCfVj33dh+i7oqDTkL=gUy7n-AB1anoow@mail.gmail.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-3-git-send-email-juri.lelli@arm.com> <CAKfTPtDGk5BC25WqHdhDYDOBgUsuidAMhrXS=eDi6wJPZjfrwA@mail.gmail.com>
 <20160204093559.GA14099@e105550-lin.cambridge.arm.com> <CAKfTPtB4G3bP5N0hU6zWXJTddO34x3RnyGpp-4_otc8O=Wq2hw@mail.gmail.com>
 <20160204121620.GB29586@e106622-lin> <CAKfTPtDVasamRtG2kLxP0HsohmVQTPrXRgx36e+jb3gozDoo6g@mail.gmail.com>
 <20160204141345.GD29586@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:32965 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966143AbcBDPot (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 10:44:49 -0500
Received: by mail-lb0-f169.google.com with SMTP id x4so34146356lbm.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 07:44:48 -0800 (PST)
In-Reply-To: <20160204141345.GD29586@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

On 4 February 2016 at 15:13, Juri Lelli <juri.lelli@arm.com> wrote:
> On 04/02/16 13:35, Vincent Guittot wrote:
>> On 4 February 2016 at 13:16, Juri Lelli <juri.lelli@arm.com> wrote:
>> > Hi Vincent,
>> >
>> > On 04/02/16 13:03, Vincent Guittot wrote:
>> >> On 4 February 2016 at 10:36, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>> >> > On Wed, Feb 03, 2016 at 10:04:37PM +0100, Vincent Guittot wrote:
>> >> >> On 3 February 2016 at 12:59, Juri Lelli <juri.lelli@arm.com> wrote:
>> >>
>> >> [snip]
>> >>
>> >> >> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> >> >> > index 9e63fb1..c4025fd 100644
>> >> >> > --- a/drivers/cpufreq/Makefile
>> >> >> > +++ b/drivers/cpufreq/Makefile
>> >> >> > @@ -1,5 +1,5 @@
>> >> >> >  # CPUfreq core
>> >> >> > -obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
>> >> >> > +obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o cpufreq_capacity.o
>> >> >>
>> >> >> Do you really want to have the calibration of capacity dependent of
>> >> >> cpufreq ? It means that we can't use it without a cpufreq driver.
>> >> >> IMHO, this creates a unnecessary dependency. I understand that you
>> >> >> must ensure that core runs at max fequency if a driver is present but
>> >> >> you should be able to calibrate the capacity if cpufreq is not
>> >> >> available but you have different capacity because micro architecture
>> >> >
>> >> > We could remove the dependency on cpufreq, but it would make things more
>> >> > complicated for systems which do have frequency scaling as we would have
>> >> > to either:
>> >> >
>> >> > 1) Run the calibration again once cpufreq has been initialized.
>> >>
>> >> or wait and let time for a driver to initialize and trig the
>> >> calibration. If calibration has not been done at the end of the boot,
>> >> you can force a calibration. If the cpufeq driver is a module and is
>> >> loaded far later for any good or bad reason, we will have to run the
>> >> calibration once again but at least the capacity will reflect he
>> >> current capacity of the CPUs.
>> >> I'm mainly worried that the compilation of the calibration is
>> >> dependent of CONFIG_CPU_FREQ not that cpufreq can trig the calibration
>> >> sequence
>> >>
>> >
>> > Yes, I guess we can make this work in some way. Out of curiosity,
>> > though, are out there heterogenous platforms that don't use cpufreq?
>>
>> At least, you can find several heterogeneous platforms without OPP
>> table for CPUs in the kernel. That's probably a temporary situation
>> but which can become a permanent one. It means that we can't calibrate
>> the CPUs for these platforms.
>>
>
> Sorry, can you make some examples so that I'm sure I understand what you
> are referring to?

As an example, the uniphier arm64 Soc doesn't have a cpufreq driver so far

>
> Anyway, don't these platform still make use of cpufreq (even if without
> an OPP table) so that we can still control policy->max and min?

AFAICT, They don't have a dedicated cpufreq driver.

More generally speaking, it can take time before having

>
> Thanks,
>
> - Juri
