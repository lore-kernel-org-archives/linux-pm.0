From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] sched: cpufreq_cfs: pelt-based cpu frequency scaling
Date: Thu, 7 May 2015 08:23:51 +0200
Message-ID: <20150507062351.GC23123@twins.programming.kicks-ass.net>
References: <1430777441-15087-1-git-send-email-mturquette@linaro.org>
 <1430777441-15087-5-git-send-email-mturquette@linaro.org>
 <20150505090042.GC21418@twins.programming.kicks-ass.net>
 <20150505182347.16410.16338@quantum>
 <20150506122240.GY23123@twins.programming.kicks-ass.net>
 <20150507041725.16410.58417@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40146 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbEGGYM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 02:24:12 -0400
Content-Disposition: inline
In-Reply-To: <20150507041725.16410.58417@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org

On Wed, May 06, 2015 at 09:17:25PM -0700, Michael Turquette wrote:
> Are you thinking of placing the hook somewhere such as
> update_entity_load_avg?

Nah, I was more thinking of Morten's series where we already compute the
utilization for the energy aware scheduling reasons.
