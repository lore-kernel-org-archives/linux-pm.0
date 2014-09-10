From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] cpufreq-dt, platform_data based proposal
Date: Wed, 10 Sep 2014 12:19:41 +0200
Message-ID: <3121183.jngnFR1Zm6@wuerfel>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com> <2947757.7VG6XCG6t9@wuerfel> <20140910121002.148194af@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56200 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaIJKUF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 06:20:05 -0400
In-Reply-To: <20140910121002.148194af@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Lior Amsalem <alior@marvell.com>, Rob Herring <rob.herring@linaro.org>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Tawfik Bayouk <tawfik@marvell.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Rafael Wysocki <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Thomas Abraham <thomas.ab@samsung.com>, Mike Turquette <mike.turquette@linaro.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sachin Kamat <spk.linux@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>

On Wednesday 10 September 2014 12:10:02 Thomas Petazzoni wrote:
> On Wed, 10 Sep 2014 11:53:27 +0200, Arnd Bergmann wrote:
> 
> > > Another approach would be to lift the ban on machine-specific cpufreq
> > > drivers, since the generic driver is not capable of handling all
> > > situations.
> > 
> > Using platform_data works nicely if you register the cpufreq device
> > from the platform code, but that is a particular thing that has
> > been bugging me for a long time and that I really want to get rid
> > of: We don't want to introduce platform-specific files for ARM64,
> > so we have to solve this anyway by just looking at DT, and whatever
> > solution we end up with should work for both ARM32 and ARM64.
> 
> Right. Note that there is a similar issue with cpuidle.
> 
> Maybe each cpufreq/cpuidle driver should simply list of top-level
> compatible strings it is compatible with, so that at boot time, each
> cpufreq/cpuidle driver gets a chance to init itself and see whether it
> is matching the currently running platform.

The main problem I see with that is that it requires updating
the driver for every new platform we want to support. It would
be better to find a way that lets you add new platforms using just
new dts files that work with the existing driver.

This is the main reason why we try to never match the root
compatible property in any driver, and I don't think cpufreq
should be an exception to this just because it can't easily be
mapped to a particular register set.

> > Most of us will be at LCU next week, so I'd suggest we solve this
> > problem using the 'lock everyone into one room without beer until
> > we come up with a working approach' method.
> 
> That does seem like an interesting idea. However, I initially wanted to
> push cpufreq support for Armada XP in 3.17, and everything was pushed
> *except* the cpufreq driver bits. So I was hoping to at least get
> things working for 3.18. If the discussion takes place next week, and
> then the time to finally implement something, we'll also miss 3.18.

I see.

> In the mean time, would it be possible to realize that the existing
> generic cpufreq driver simply isn't generic enough, and that we should
> accept machine-specific cpufreq drivers for the time being?

That would work for me, to get things going for 3.18, but it's really
up to the cpufreq maintainers. Your platform_data based patch set
seems like a better solution to me than separate drivers, but I haven't
looked at the details.

	Arnd
