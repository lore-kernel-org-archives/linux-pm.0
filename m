From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [RFCv7 PATCH 00/10] sched: scheduler-driven CPU frequency
 selection
Date: Wed, 30 Mar 2016 08:45:06 +0800
Message-ID: <20160330004506.GB22689@intel.com>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18917 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928AbcC3I2S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Mar 2016 04:28:18 -0400
Content-Disposition: inline
In-Reply-To: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

Hi Steve,

On Mon, Feb 22, 2016 at 05:22:40PM -0800, Steve Muckle wrote:
> The number of times the busy
> duration exceeds the period of the periodic workload (an "overrun") is
> also recorded.

Could you please explain more about overrun?

> SCHED_OTHER workload:
>  wload parameters	  ondemand        interactive     sched	
> run	period	loops	OR	OH	OR	OH	OR	OH
> 1	100	100	0	62.07%	0	100.02%	0	78.49%
> 10	1000	10	0	21.80%	0	22.74%	0	72.56%
> 1	10	1000	0	21.72%	0	63.08%	0	52.40%
> 10	100	100	0	8.09%	0	15.53%	0	17.33%
> 100	1000	10	0	1.83%	0	1.77%	0	0.29%
> 6	33	300	0	15.32%	0	8.60%	0	17.34%
> 66	333	30	0	0.79%	0	3.18%	0	12.26%
> 4	10	1000	0	5.87%	0	10.21%	0	6.15%
> 40	100	100	0	0.41%	0	0.04%	0	2.68%
> 400	1000	10	0	0.42%	0	0.50%	0	1.22%
> 5	9	1000	2	3.82%	1	6.10%	0	2.51%
> 50	90	100	0	0.19%	0	0.05%	0	1.71%
> 500	900	10	0	0.37%	0	0.38%	0	1.82%
> 9	12	1000	6	1.79%	1	0.77%	0	0.26%
> 90	120	100	0	0.16%	1	0.05%	0	0.49%
> 900	1200	10	0	0.09%	0	0.26%	0	0.62%
 
Could you please also explain what we can learn from the wload vs. OH/OR
results?

Or if you have already explained these questions before, could you please
point to the links? Thank you.

Yuyang
