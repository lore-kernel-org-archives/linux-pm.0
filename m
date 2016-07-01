From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] cpufreq: Upstream Android's Interactive governor
Date: Fri, 01 Jul 2016 22:48:15 +0200
Message-ID: <1683879.7aNvap4GvS@vostro.rjw.lan>
References: <cover.1463723328.git.viresh.kumar@linaro.org> <CAJZ5v0hW1yYD7FhOaK5Hkj7956jtQThzqY=OmCr38q_zDCjmog@mail.gmail.com> <20160630203022.GN12473@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42594 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752160AbcGAUoO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 16:44:14 -0400
In-Reply-To: <20160630203022.GN12473@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, mike@android.com, toddpoynor@google.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kandoiruchi@google.com, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Thursday, June 30, 2016 01:30:22 PM Viresh Kumar wrote:
> On 20-05-16, 13:26, Rafael J. Wysocki wrote:
> > On Fri, May 20, 2016 at 8:39 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > Hi Rafael et. al.,
> > >
> > > We had some discussions [1] last week on the PM mailing about
> > > upstreaming the cpufreq governor most widely used on Andoid Mobile
> > > phones and tablets: Interactive governor. People (including Rafael)
> > > mostly agreed that we better get it upstreamed and here is an attempt to
> > > upstream most of it (idle notifiers aren't included in this series).
> > >
> > > I picked the latest code spread over 70-80 patches from [2].  The
> > > unmodified code, based over mainline is pushed [4] for reference.
> > >
> > > I have updated the governor to align it with the current practices
> > > followed with mainline governors, like using utilization hooks from the
> > > scheduler and handling kobject (for governor's sysfs directory) in a
> > > race free manner. And of course this included general cleanup of the
> > > governor as well. This version is pushed here [3] for testing.
> > >
> > > The Android version of interactive governor also uses idle EXIT
> > > notifiers, but that code isn't part of this series and will be sent
> > > separately later. For people interested in looking at that, those are 3
> > > minor patches on top of this series and are pushed here [5].
> > >
> > > I haven't changed the core logic of the governor intentionally, as that
> > > rather requires more in-depth knowledge of the use case for which the
> > > optimizations have been done. So, we should do any such thing later on
> > > with new patches, so that people can find things easily.
> > >
> > > I also haven't tried to change the userspace interface as that may have
> > > broken the userspace that already exists and uses this governor.
> > >
> > > This has been lightly tested on my Exynos board (dual ARM A15), where
> > > the governor gets inserted/removed multiple times, the sysfs files are
> > > all functional. The frequency gets changed with load, etc.
> > >
> > > This series is based of pm/bleeding-edge branch + few patches from
> > > Rafael [6] & [7] and few minor cleanups from me [8].
> > 
> > OK, thanks!
> > 
> > This may take some time to review, though.
> 
> Ping !!

More time needed, sorry.

