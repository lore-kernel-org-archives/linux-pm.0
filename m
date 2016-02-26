From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFCv7 PATCH 02/10] cpufreq: introduce cpufreq_driver_is_slow
Date: Fri, 26 Feb 2016 02:16:17 +0100
Message-ID: <2670324.0JtTyvN55A@vostro.rjw.lan>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org> <CAJZ5v0gM56y0+_SCV5RDQzWWJxS_aNWWpi8ZrcGtjZo+fH2uUA@mail.gmail.com> <20160226005029.2278.38972@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63290 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932225AbcBZBOn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 20:14:43 -0500
In-Reply-To: <20160226005029.2278.38972@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Thursday, February 25, 2016 04:50:29 PM Michael Turquette wrote:
> Quoting Rafael J. Wysocki (2016-02-22 17:31:09)
> > On Tue, Feb 23, 2016 at 2:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> > > From: Michael Turquette <mturquette@baylibre.com>
> > >
> > > Some architectures and platforms perform CPU frequency transitions
> > > through a non-blocking method, while some might block or sleep. Even
> > > when frequency transitions do not block or sleep they may be very slow.
> > > This distinction is important when trying to change frequency from
> > > a non-interruptible context in a scheduler hot path.
> > >
> > > Describe this distinction with a cpufreq driver flag,
> > > CPUFREQ_DRIVER_FAST. The default is to not have this flag set,
> > > thus erring on the side of caution.
> > >
> > > cpufreq_driver_is_slow() is also introduced in this patch. Setting
> > > the above flag will allow this function to return false.
> > >
> > > [smuckle@linaro.org: change flag/API to include drivers that are too
> > >  slow for scheduler hot paths, in addition to those that block/sleep]
> > >
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> > > Signed-off-by: Steve Muckle <smuckle@linaro.org>
> > 
> > Something more sophisticated than this is needed, because one driver
> > may actually be able to do "fast" switching in some cases and may not
> > be able to do that in other cases.
> 
> Those drivers can set the flag dynamically when they probe based on
> their ACPI tables.

No, they can't.

Being able to to the "fast" switching is a property of the policy and
the driver together and it may change with CPU going online/offline.

> > 
> > For example, in the acpi-cpufreq case all depends on what's there in
> > the ACPI tables.
> 
> It's all a moot point until the locking in cpufreq is changed.

No, it isn't.  Look at this, for example: https://patchwork.kernel.org/patch/8426741/

> Until those changes are made it is a bad idea to call cpufreq_driver_target()
> from schedule() context, regardless of the underlying hardware, and all
> platforms should kick that work out to the kthread.

Calling cpufreq_driver_target() from the scheduler is a bad idea overall,
not just because of the locking.

But there are other ways to switch frequencies from scheduler paths.  I run
such code on my test box daily without any problems.

Thanks,
Rafael

