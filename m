From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/9] CPUFreq: governors: further cleanups
Date: Fri, 04 Sep 2015 16:47:45 +0200
Message-ID: <22905868.SRC4lAzIy1@vostro.rjw.lan>
References: <cover.1437999691.git.viresh.kumar@linaro.org> <20150903044454.GH13140@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58427 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758990AbbIDOUA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 10:20:00 -0400
In-Reply-To: <20150903044454.GH13140@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com

On Thursday, September 03, 2015 10:14:54 AM Viresh Kumar wrote:
> On 27-07-15, 17:58, Viresh Kumar wrote:
> > Hi Rafael,
> > 
> > This series fixes few more possible race conditions. Over that there is
> > some non-trivial cleanup, in order to simplify code.
> > 
> > Preeti did review some of them before she left and shared concerns on
> > others, all that is sorted out now.
> > 
> > V1->V2:
> > - Dropped 2/10 from V1 as it wasn't required
> > - 3/10 saw some changes due to above patch being dropped
> > - 7/10 changed a bit as we check for pending work items by looking at
> >   shared->policy, rather than calling delayed_work_pending. We wanted to
> >   check if governor is operational or not and the new check is enough
> >   for that.
> > 
> > Viresh Kumar (9):
> >   cpufreq: Use __func__ to print function's name
> >   cpufreq: conservative: remove 'enable' field
> >   cpufreq: ondemand: only queue canceled works from
> >     update_sampling_rate()
> >   cpufreq: governor: Drop __gov_queue_work()
> >   cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
> >   cpufreq: ondemand: queue work for policy->cpus together
> >   cpufreq: ondemand: update sampling rate immidiately
> >   cpufreq: governor: Quit work-handlers early if governor is stopped
> >   cpufreq: Get rid of ->governor_enabled and its lock
> 
> I thought you had some review comment for this series?

Yes, I did.  I'll send them later today if all goes well.

Thanks,
Rafael

