From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Tue, 18 Apr 2017 16:08:18 +0530
Message-ID: <20170418103818.GQ28191@vireshk-i7>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
 <20170417173431.GA10447@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36228 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdDRKiW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 06:38:22 -0400
Received: by mail-pf0-f179.google.com with SMTP id 194so39862046pfv.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2017 03:38:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170417173431.GA10447@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 17-04-17, 10:34, Eduardo Valentin wrote:
> Hey,
> 
> On Mon, Apr 17, 2017 at 11:31:45AM +0530, Viresh Kumar wrote:
> > Hi Guys,
> > 
> > The cpu_cooling driver is designed to use CPU frequency scaling to avoid
> > high thermal states for a platform. But it wasn't glued really well with
> > cpufreq core.
> > 
> > This series tries to improve interactions between cpufreq core and
> > cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
> > driver.
> 
> 
> Can you please be more specific of what exactly is not gluing
> properly/really well? I like refactoring, as long as well justified.
> 
> Do you see anything broken currently?

It wasn't broken really but the same information is scattered around
and it wasn't clear on which one is the best one refer. For example,
clipped-cpus is copied from the policy structure, but the policy->cpus
thing can get updated later on, while the clipped-cpus never got
updated. It makes more sense to get rid of the copies we are keeping
and reuse the real fields, i.e. use the cpufreq policy directly in
cpu_cooling.

And then it caused lots of cleanups as well..

> > I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards and have
> > pushed them for 0-day build bot and kernel CI testing as well. We should
> > know if something is broken with these.
> 
> Nice. What governors did you try? Have you checked "power_allocator" by
> any chance?

I tried setting all the governors including power_allocator on my
exynos board, and didn't see anything broken. My branch also got
tested by kernel CI bot for build and boot tests on a wide range of
ARM boards and I didn't see any bad reports due to this set. So it
should be okay.

> > 
> > @Javi: It would be good if you can give them a test, specially because
> > of your work on the "power" specific bits in the driver.
> > 
> 
> 
> @Javi, are you still around? This needs to be validated in terms of how
> the cdev states and power models are computed. Just to make sure we are
> in one piece. Copying the ARM folks too, Punit?.

And yes, I specifically wanted Javi (or some other ARM guy) to test
this stuff out. Looks like Lukasz will help out now.

Thanks to all of you :)

-- 
viresh
