From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq: Upstream Android's Interactive governor
Date: Thu, 30 Jun 2016 13:30:22 -0700
Message-ID: <20160630203022.GN12473@ubuntu>
References: <cover.1463723328.git.viresh.kumar@linaro.org>
 <CAJZ5v0hW1yYD7FhOaK5Hkj7956jtQThzqY=OmCr38q_zDCjmog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35647 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbcF3Ua7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2016 16:30:59 -0400
Received: by mail-pa0-f45.google.com with SMTP id hl6so31503127pac.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2016 13:30:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hW1yYD7FhOaK5Hkj7956jtQThzqY=OmCr38q_zDCjmog@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, mike@android.com, toddpoynor@google.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kandoiruchi@google.com, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On 20-05-16, 13:26, Rafael J. Wysocki wrote:
> On Fri, May 20, 2016 at 8:39 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Hi Rafael et. al.,
> >
> > We had some discussions [1] last week on the PM mailing about
> > upstreaming the cpufreq governor most widely used on Andoid Mobile
> > phones and tablets: Interactive governor. People (including Rafael)
> > mostly agreed that we better get it upstreamed and here is an attempt to
> > upstream most of it (idle notifiers aren't included in this series).
> >
> > I picked the latest code spread over 70-80 patches from [2].  The
> > unmodified code, based over mainline is pushed [4] for reference.
> >
> > I have updated the governor to align it with the current practices
> > followed with mainline governors, like using utilization hooks from the
> > scheduler and handling kobject (for governor's sysfs directory) in a
> > race free manner. And of course this included general cleanup of the
> > governor as well. This version is pushed here [3] for testing.
> >
> > The Android version of interactive governor also uses idle EXIT
> > notifiers, but that code isn't part of this series and will be sent
> > separately later. For people interested in looking at that, those are 3
> > minor patches on top of this series and are pushed here [5].
> >
> > I haven't changed the core logic of the governor intentionally, as that
> > rather requires more in-depth knowledge of the use case for which the
> > optimizations have been done. So, we should do any such thing later on
> > with new patches, so that people can find things easily.
> >
> > I also haven't tried to change the userspace interface as that may have
> > broken the userspace that already exists and uses this governor.
> >
> > This has been lightly tested on my Exynos board (dual ARM A15), where
> > the governor gets inserted/removed multiple times, the sysfs files are
> > all functional. The frequency gets changed with load, etc.
> >
> > This series is based of pm/bleeding-edge branch + few patches from
> > Rafael [6] & [7] and few minor cleanups from me [8].
> 
> OK, thanks!
> 
> This may take some time to review, though.

Ping !!

-- 
viresh
