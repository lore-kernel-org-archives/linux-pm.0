From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [RFCv7 PATCH 00/10] sched: scheduler-driven CPU frequency
 selection
Date: Thu, 31 Mar 2016 04:22:18 +0800
Message-ID: <20160330202218.GC22689@intel.com>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <20160330004506.GB22689@intel.com>
 <56FC7EDB.707@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:23692 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbcCaEFP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 31 Mar 2016 00:05:15 -0400
Content-Disposition: inline
In-Reply-To: <56FC7EDB.707@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

Hi Steve,

On Wed, Mar 30, 2016 at 06:35:23PM -0700, Steve Muckle wrote:
> This series was dropped in favor of Rafael's schedutil. But on the
> chance that you're still curious about the test setup used to quantify
> the series I'll explain below.
 
I will catch up and learn both.

> These results are meant to show how the governors perform across varying
> workload intensities and periodicities. Higher overhead (OH) numbers
> indicate that the completion times of each period of the workload were
> closer to what they would be when run at fmin (100% overhead would be as
> slow as fmin, 0% overhead would be as fast as fmax). And as described
> above, overruns (OR) indicate that the governor was not responsive
> enough to finish the work in each period of the workload.
> 
> These are just performance metrics so they only tell half the story.
> Power is not factored in at all.
> 
> This provides a quick sanity check that the governor under test (in this
> case, the now defunct schedfreq, or sched for short) performs similarly
> to two of the most commonly used governors, ondemand and interactive, in
> steady state periodic workloads. In the data above sched looks good for
> the most part with the second test case being the biggest exception.
 
Yes, it is indeed a quick sanity check.

Thanks,
Yuyang
