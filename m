From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] cpufreq: Use sorted frequency tables
Date: Wed, 01 Jun 2016 18:40:36 +0200
Message-ID: <1514420.VAnFJF0vi6@vostro.rjw.lan>
References: <cover.1464694144.git.viresh.kumar@linaro.org> <CAJZ5v0ig61Q+EDjjcyHef5e9B4dKY+BhF802uV61w-G5CdRQvA@mail.gmail.com> <20160601010856.GM9864@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51751 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751206AbcFAQgu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 12:36:50 -0400
In-Reply-To: <20160601010856.GM9864@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, May 31, 2016 06:08:56 PM Steve Muckle wrote:
> On Wed, Jun 01, 2016 at 12:50:41AM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 31, 2016 at 1:36 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > Hi Guys,
> > >
> > > This work in inspired by some of the concerns raised by Steve in one of
> > > his patchset.
> > >
> > > Currently, the cpufreq drivers aren't required to provide a sorted list
> > > of frequencies to the cpufreq-core and so traversing that list match a
> > > target frequency is very inefficient.
> > >
> > > This is not bearable by, for example, the fast-switch path of schedutil
> > > governor and so we have moved the traversing logic local to the
> > > acpi-cpufreq driver for now. That is better handled in the core, but it
> > > has to be efficient.
> > >
> > > OTOH, even for traditional governors without a fast-switch path, it
> > > would be much better to be able to traverse this table quickly.
> > >
> > > The ideal solution would be to keep a single freq-table in struct
> > > cpufreq_policy, that will be sorted as well. But there are few
> > > dependencies due to which it can't be done today (Hint: cpufreq drivers
> > > are abusing the 'index' passed to them, to refer to multiple arrays).
> > >
> > > And so for now, lets create a separate table local to the cpufreq-core
> > > only.
> > >
> > > To use that, another API cpufreq_find_target_index() is created as well
> > > and few users are migrated to it.
> > >
> > > Lightly tested on Exynos board, frequencies were getting selected as
> > > expected.
> > 
> > I'm not particularly liking this due to the possible confusion that
> > may result from it.
> > 
> > Perhaps we can require drivers implementing ->fast_switch to sort
> > their frequency tables to start with?  Or maybe make the core check
> > whether or not the table is sorted and in what order and handle it
> > accordingly?
> > 
> > Let's just think about the design here for a while, OK?
> 
> This would be required beyond drivers implementing fast_switch -
> cpufreq_driver_resolve_freq() (which started this discussion) is called
> for slow path transitions as well.
> 
> Checking the table type and performing the associated lookup seems
> workable to me though it adds a bit of complexity.
> 
> Also what about leaving it as is? I didn't fully catch the concern with
> abuse in the series I posted, and it pushes this complexity of dealing
> with the freq table efficiently down into the driver, which is best
> suited for that IMO.

The concern is that all drivers using frequency tables would probably
implement the callbacks in question in a very similar way, leading to
quite a bit of code duplication.  That's rarely a good thing.

> Another thought is that it'd be nice to eventually reduce
> cpufreq_driver_{fast_switch,resolve_freq} into simple inline functions
> so that we could jump to the driver directly from schedutil, eliminating
> a function call.

Well, let's do one thing at a time. :-)

Thanks,
Rafael

