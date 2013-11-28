From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] cpufreq: suspend governors on system suspend/hibernate
Date: Thu, 28 Nov 2013 21:29:52 +0100
Message-ID: <1781198.iCUX9ZdW7W@vostro.rjw.lan>
References: <28d493f20239a242a7b26dfe1efed40d83bf1e10.1385523340.git.viresh.kumar@linaro.org> <3057132.zHNVNQZ8pP@vostro.rjw.lan> <CAKohpondYbBeObUJJqNZLe04dmN9tLMZv9KrjzqLr2NDorRtLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53961 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753676Ab3K1URD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2013 15:17:03 -0500
In-Reply-To: <CAKohpondYbBeObUJJqNZLe04dmN9tLMZv9KrjzqLr2NDorRtLw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Kgene Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-tegra@vger.kernel.org, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>

On Thursday, November 28, 2013 07:49:29 PM Viresh Kumar wrote:
> On 28 November 2013 19:53, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > I don't think that the Nishanth's issue is fixed by this particular version of
> > the patch, so I modified the changelog and removed a the comment above
> > cpufreq_suspend()
> 
> No, it does fix his issue as we are just stopping the governors from
> dpm_suspend_noirq() and not initiating any new transitions. I said we need
> these calls from dpm_suspend() instead as platforms like exynos and tegra
> do need to change frequency before suspending..
> 
> See:
> 
> https://lkml.org/lkml/2013/11/25/692
> 
> > (which should be a proper kerneldoc one if any, BTW).
> 
> Okay.. I will add that separately..
> 
> > I've also made some minor changes to the conditionals, because I didn't like them
> > the way they were written originally.
> >
> > Please check the result in bleeding-edge.
> 
> Everything else is fine..

So I'm reading this as "the version of the patch in bleeding-edge is OK".

I hope that really is the case. :-)

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
