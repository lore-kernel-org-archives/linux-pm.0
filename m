From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 8/8] sched: prefer cpufreq_scale_freq_capacity
Date: Wed, 16 Mar 2016 22:32:46 +0100
Message-ID: <6960637.XgeniQrqfM@vostro.rjw.lan>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com> <56E9B7A1.5030806@arm.com> <20160316200752.GJ6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42005 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754487AbcCPVao (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 17:30:44 -0400
In-Reply-To: <20160316200752.GJ6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Wednesday, March 16, 2016 09:07:52 PM Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 07:44:33PM +0000, Dietmar Eggemann wrote:
> > intel_pstate (setpolicy()) is an exception but my humble guess is that
> > systems with intel_pstate driver have X86_FEATURE_APERFMPERF support.
> 
> A quick browse of the Intel SDM says you're right. It looks like
> everything after Pentium-M; so Core-Solo/Core-Duo and onwards have
> APERF/MPERF.
> 
> And it looks like P6 class systems didn't have DVFS support at all,
> which basically leaves P4 and Pentium-M as the only chips to have DVFS
> support lacking APERF/MPERF.
> 
> And while I haven't got any P4 based space heaters left, I might still
> have a Pentium-M class laptop somewhere (if it still boots).

intel_pstate depends on APERF/MPERF, so it won't work with anything
without them.

