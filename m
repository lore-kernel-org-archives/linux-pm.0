From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 6/7][Update] cpufreq: Support for fast frequency
 switching
Date: Thu, 17 Mar 2016 12:40:37 +0100
Message-ID: <20160317114037.GB6356@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <4088601.C2vItRYpQn@vostro.rjw.lan>
 <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <4785370.no59v8qjgi@vostro.rjw.lan>
 <20160317113507.GH18212@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57304 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbcCQLkj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 07:40:39 -0400
Content-Disposition: inline
In-Reply-To: <20160317113507.GH18212@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Thu, Mar 17, 2016 at 11:35:07AM +0000, Juri Lelli wrote:

> > +		pr_warn("cpufreq: CPU%u: Fast freqnency switching not enabled\n",
> 
> Ultra-minor nit: s/freqnency/frequency/
> 
> Also, is this really a warning or just a debug message? (everything
> seems to work fine on Juno even if this is printed :-)).

I would consider it a warn; this _should_ not happen. If your platform
supports fast_switch, then you really rather want to use it.
