From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 6/7] cpufreq: schedutil: Add iowait boosting
Date: Wed, 03 Aug 2016 01:03:23 +0200
Message-ID: <1808398.B5hOCmgoWi@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <1572483.euTsoFDNE9@vostro.rjw.lan> <20160802013531.GC9332@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58258 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756546AbcHBW6N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2016 18:58:13 -0400
In-Reply-To: <20160802013531.GC9332@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Monday, August 01, 2016 06:35:31 PM Steve Muckle wrote:
> On Mon, Aug 01, 2016 at 01:37:59AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Modify the schedutil cpufreq governor to boost the CPU frequency
> > if the UUF_IO flag is passed to it via cpufreq_update_util().
> > 
> > If that happens, the frequency is set to the maximum during
> > the first update after receiving the UUF_IO flag and then the
> > boost is reduced by half during each following update.
> 
> Were these changes to schedutil part of the positive test results
> mentioned in patch 5? Or are those just from intel pstate?
> 
> I was nervous about the effect of this on power and tested a couple low
> power usecases. The platform is the Hikey 96board (8 core ARM A53,
> single CPUfreq domain) running AOSP Android and schedutil backported to
> kernel 4.4. These tests run mp3 and mpeg4 playback for a little while,
> recording total energy consumption during the test along with frequency
> residency.
> 
> As the results below show I did not measure an appreciable effect - if
> anything things may be slightly better with the patches.
> 
> The hardcoding of a non-tunable boosting scheme makes me nervous but
> perhaps it could be revisited if some platform or configuration shows
> a noticeable regression?

That would be my approach. :-)

I'm not a big fan of tunables in general, as there are only a few people
who actually set them to anything different from the default and then they
get a lot of focus (even though they are after super-corner cases sometimes).

Thanks,
Rafael

