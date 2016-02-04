From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 2/6] drivers/cpufreq: implement init_cpu_capacity_default()
Date: Thu, 4 Feb 2016 13:03:07 +0100
Message-ID: <CAKfTPtB4G3bP5N0hU6zWXJTddO34x3RnyGpp-4_otc8O=Wq2hw@mail.gmail.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-3-git-send-email-juri.lelli@arm.com> <CAKfTPtDGk5BC25WqHdhDYDOBgUsuidAMhrXS=eDi6wJPZjfrwA@mail.gmail.com>
 <20160204093559.GA14099@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33247 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbcBDMD2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 07:03:28 -0500
Received: by mail-lb0-f177.google.com with SMTP id x4so30321304lbm.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 04:03:27 -0800 (PST)
In-Reply-To: <20160204093559.GA14099@e105550-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

On 4 February 2016 at 10:36, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> On Wed, Feb 03, 2016 at 10:04:37PM +0100, Vincent Guittot wrote:
>> On 3 February 2016 at 12:59, Juri Lelli <juri.lelli@arm.com> wrote:

[snip]

>> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> > index 9e63fb1..c4025fd 100644
>> > --- a/drivers/cpufreq/Makefile
>> > +++ b/drivers/cpufreq/Makefile
>> > @@ -1,5 +1,5 @@
>> >  # CPUfreq core
>> > -obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
>> > +obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o cpufreq_capacity.o
>>
>> Do you really want to have the calibration of capacity dependent of
>> cpufreq ? It means that we can't use it without a cpufreq driver.
>> IMHO, this creates a unnecessary dependency. I understand that you
>> must ensure that core runs at max fequency if a driver is present but
>> you should be able to calibrate the capacity if cpufreq is not
>> available but you have different capacity because micro architecture
>
> We could remove the dependency on cpufreq, but it would make things more
> complicated for systems which do have frequency scaling as we would have
> to either:
>
> 1) Run the calibration again once cpufreq has been initialized.

or wait and let time for a driver to initialize and trig the
calibration. If calibration has not been done at the end of the boot,
you can force a calibration. If the cpufeq driver is a module and is
loaded far later for any good or bad reason, we will have to run the
calibration once again but at least the capacity will reflect he
current capacity of the CPUs.
I'm mainly worried that the compilation of the calibration is
dependent of CONFIG_CPU_FREQ not that cpufreq can trig the calibration
sequence

>
> 2) Know the frequency of all cpus at calibration time so we can
> determine the correct micro-archicture difference. This option would
> however mean that we have to provide a frequency scaling factor even for
> systems that don't have cpufreq.
>
> 3) Find a way to do the calibration anyway if cpufreq doesn't
> initialize. I'm not sure how that would work though.
