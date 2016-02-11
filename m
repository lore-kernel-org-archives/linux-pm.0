From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Thu, 11 Feb 2016 16:29:35 +0100
Message-ID: <20160211152935.GN6357@twins.programming.kicks-ass.net>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan>
 <20160211115157.GH6357@twins.programming.kicks-ass.net>
 <CAJZ5v0ju1vSf4moYmpPZu2dyhPaLpn++P6PBwCVN1tupp1_jFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33785 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbcBKP3l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 10:29:41 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ju1vSf4moYmpPZu2dyhPaLpn++P6PBwCVN1tupp1_jFg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Feb 11, 2016 at 01:08:28PM +0100, Rafael J. Wysocki wrote:
> > Not really pretty though. It blows a bit that you require this callback
> > to be periodic (in order to replace a timer).
> 
> We need it for now, but that's because of how things work on the cpufreq side.

Right, maybe stick a big comment on cpufreq_trigger_update() noting its
a big ugly hack and will go away 'soon'.

> The last version is here:
> 
> https://patchwork.kernel.org/patch/8275271/
> 
> but it has the additional hooks for RT/DL which you seem to be
> thinking are a mistake.

As long as we make sure everbody knows they're a band-aid and will be
taken out back and shot that should be fine for a little while I
suppose.
