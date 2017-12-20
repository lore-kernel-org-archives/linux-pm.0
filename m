From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Wed, 20 Dec 2017 15:51:20 +0100
Message-ID: <20171220145120.vzu5aam5bzw445n5@hirez.programming.kicks-ass.net>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <20171220125546.GI19821@e110439-lin>
 <20171220132826.kcu5zqkva5h6nmfk@hirez.programming.kicks-ass.net>
 <5156588.pkDhmtr2np@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:46732 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755215AbdLTOvb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 09:51:31 -0500
Content-Disposition: inline
In-Reply-To: <5156588.pkDhmtr2np@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org

On Wed, Dec 20, 2017 at 03:47:23PM +0100, Rafael J. Wysocki wrote:
> > Well, we still need flags for crap like IO-WAIT IIRC. That's sugov
> > internal state and not something the scheduler actually already knows.
> 
> Not only sugov to be precise, but yes.

Oh, right, intel_pstate also consumes that one..
