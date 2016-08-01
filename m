From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 4/7] cpufreq / sched: Add flags argument to cpufreq_update_util()
Date: Tue, 02 Aug 2016 01:44:41 +0200
Message-ID: <3202429.X9nACUOoOm@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <1874381.hHx7HlTjB3@vostro.rjw.lan> <20160801195930.GZ19455@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54713 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755407AbcHAXqZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2016 19:46:25 -0400
In-Reply-To: <20160801195930.GZ19455@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Monday, August 01, 2016 12:59:30 PM Steve Muckle wrote:
> On Mon, Aug 01, 2016 at 04:57:18PM +0200, Rafael J. Wysocki wrote:
> > On Monday, August 01, 2016 09:33:12 AM Dominik Brodowski wrote:
> > > On Mon, Aug 01, 2016 at 01:36:46AM +0200, Rafael J. Wysocki wrote:
> > > > +#define UUF_RT	0x01
> > > 
> > > What does UUF stand for?
> > 
> > "Utilization upadte flag".
> 
> I had wondered the same - in my patchset I used CPUFREQ_SCHED_UPDATE_* for the
> prefixes, though I guess some may object to the length.

Well, OK.

I guess something like SCHED_CPUFREQ_RT etc would be sufficient?

Thanks,
Rafael

