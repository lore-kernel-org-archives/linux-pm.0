From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC][PATCH 4/7] cpufreq / sched: Add flags argument to
 cpufreq_update_util()
Date: Mon, 1 Aug 2016 18:36:49 -0700
Message-ID: <20160802013649.GD9332@graphite.smuckle.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <1874381.hHx7HlTjB3@vostro.rjw.lan>
 <20160801195930.GZ19455@graphite.smuckle.net>
 <3202429.X9nACUOoOm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35881 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510AbcHBBqk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2016 21:46:40 -0400
Received: by mail-pa0-f46.google.com with SMTP id pp5so57904385pac.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2016 18:44:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3202429.X9nACUOoOm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Tue, Aug 02, 2016 at 01:44:41AM +0200, Rafael J. Wysocki wrote:
> On Monday, August 01, 2016 12:59:30 PM Steve Muckle wrote:
> > On Mon, Aug 01, 2016 at 04:57:18PM +0200, Rafael J. Wysocki wrote:
> > > On Monday, August 01, 2016 09:33:12 AM Dominik Brodowski wrote:
> > > > On Mon, Aug 01, 2016 at 01:36:46AM +0200, Rafael J. Wysocki wrote:
> > > > > +#define UUF_RT	0x01
> > > > 
> > > > What does UUF stand for?
> > > 
> > > "Utilization upadte flag".
> > 
> > I had wondered the same - in my patchset I used CPUFREQ_SCHED_UPDATE_* for the
> > prefixes, though I guess some may object to the length.
> 
> Well, OK.
> 
> I guess something like SCHED_CPUFREQ_RT etc would be sufficient?

Yeah I think that would work.

thanks,
Steve
