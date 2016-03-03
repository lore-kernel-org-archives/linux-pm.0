From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 3 Mar 2016 16:38:17 +0100
Message-ID: <20160303153817.GO6344@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <1842158.0Xhak3Uaac@vostro.rjw.lan>
 <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
 <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
 <CAJZ5v0gC_S+a43FvgpB25WnpAANkDQk7agwSx4gRJvdmnPFkeQ@mail.gmail.com>
 <CAKfTPtDRvM9PAwQQ2KjUjPjnMmKkdi6sCoX4YisKaunDBqLf-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36366 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770AbcCCPi0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 10:38:26 -0500
Content-Disposition: inline
In-Reply-To: <CAKfTPtDRvM9PAwQQ2KjUjPjnMmKkdi6sCoX4YisKaunDBqLf-A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>

On Thu, Mar 03, 2016 at 03:01:15PM +0100, Vincent Guittot wrote:
> > In case a more formal derivation of this formula is needed, it is
> > based on the following 3 assumptions:
> >
> > (1) Performance is a linear function of frequency.
> > (2) Required performance is a linear function of the utilization ratio
> > x = util/max as provided by the scheduler (0 <= x <= 1).
> 
> Just to mention that the utilization that you are using, varies with
> the frequency which add another variable in your equation

Right, x86 hasn't implemented arch_scale_freq_capacity(), so the
utilization values we use are all over the map. If we lower freq, the
util will go up, which would result in us bumping the freq again, etc..

