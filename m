From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 1/2] sched/fair: Add cumulative average of load_avg_contrib
 to a task
Date: Tue, 11 Nov 2014 18:29:11 +0100
Message-ID: <20141111172911.GO10501@worktop.programming.kicks-ass.net>
References: <1415598358-26505-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1415598358-26505-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20141110134911.GG29390@twins.programming.kicks-ass.net>
 <546222C7.2030000@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38517 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbaKKR3P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 12:29:15 -0500
Content-Disposition: inline
In-Reply-To: <546222C7.2030000@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mturquette@linaro.org, amit.kucheria@linaro.org, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Morten.Rasmussen@arm.com, efault@gmx.de, nicolas.pitre@linaro.org, dietmar.eggemann@arm.com, pjt@google.com, bsegall@google.com, mingo@kernel.org, linaro-kernel@lists.linaro.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>

On Tue, Nov 11, 2014 at 08:22:55PM +0530, Shilpasri G Bhat wrote:
> Cumulative load was our initial attempt at overcoming this. It is true
> that this is not the best solution. We wanted the community's suggestion
> on how to get around this issue. What do you propose?

Shoot cpufreq in the head basically :-) We're looking at completely
reworking the way we do things.

We basically want to integrate cpufreq into the scheduler and effect
frequency changes from the scheduler context where possible, only
reverting to schedulable context (kworker) where there is no other
possibility.
