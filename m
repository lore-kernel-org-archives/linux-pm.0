From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 0/7] cpufreq / sched: cpufreq_update_util() flags
 and iowait boosting
Date: Mon, 8 Aug 2016 13:08:22 +0200
Message-ID: <20160808110822.GC6879@twins.programming.kicks-ass.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <000001d1ec09$254ed840$6fec88c0$@net>
 <2815658.F6xEHcjr3t@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45058 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbcHHLI1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2016 07:08:27 -0400
Content-Disposition: inline
In-Reply-To: <2815658.F6xEHcjr3t@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Doug Smythies <dsmythies@telus.net>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Ingo Molnar' <mingo@kernel.org>

On Mon, Aug 01, 2016 at 06:30:27PM +0200, Rafael J. Wysocki wrote:
> >  CPU_FREQ_GOV_SCHEDUTIL m -> y

> > ERROR: "runqueues" [kernel/sched/cpufreq_schedutil.ko] undefined!

> There are some export_symbol declarations missing, I'll fix that up.

Do you really need that thing to be a module? I would raelly like to not
export runqueues. People have had 'crazy' ideas in the past.
