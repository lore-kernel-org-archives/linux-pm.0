From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Fri, 17 Nov 2017 00:31:41 +0100
Message-ID: <2810372.fJ2vMN0cWO@aspire.rjw.lan>
References: <cover.1510735482.git.viresh.kumar@linaro.org> <65fef2a1-d23f-3de2-bd91-021296c3e2f7@arm.com> <20171116152058.GR3257@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53363 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966086AbdKPXb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 18:31:56 -0500
In-Reply-To: <20171116152058.GR3257@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

On Thursday, November 16, 2017 4:20:58 PM CET Viresh Kumar wrote:
> On 16-11-17, 15:02, Ionela Voinescu wrote:
> > When it was added in lsk 3.18 in what was then a thermal driver for Juno
> > it was believed to have an effect in thermal mitigation, but that was
> > not proven later as to justify posting it upstream, and that is why the
> > code never made it in mainline.
> > The code added there can be found at:
> > https://git.linaro.org/landing-teams/working/arm/kernel-release.git/tree/drivers/thermal/scpi-thermal.c?h=lsk-3.18-armlt#n247
> > 
> > As for removing this code now, I would not want to make that decision without
> > spending more time to check if it impacts other customer codelines.
> >
> > I'll come back with a reply to this in the next couple of days.
> 
> Sure, we can wait for few days definitely :)

While the above certainly is true, it doesn't matter whether or not any
out-of-the-tree code will be affected by removing this from the mainline.

What matters is *only* whether or not anyone is going to add anything
depending on it to the mainline any time soon.  If that's not the case,
the stuff goes away (and may be added back in the future if need be).

To avoid delaying this indefinitely, let's make a deal as follows.

Unless anyone with some changes targeted at the mainline and depending on the
code in question shows up before the end of the merge window currently under
way, I will queue up the patches from Viresh for 4.16.  Then, there will be
8 weeks (or more) of time before the 4.16 merge window opens to drop them if
any new material depending on the code removed by them materializes in the
meantime.

Thanks,
Rafael
