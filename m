From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Date: Tue, 17 Jul 2018 10:15:07 +0200
Message-ID: <20180717081507.GS2476@hirez.programming.kicks-ass.net>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717065048.74mmgk4t5utjaa6a@suselix>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 08:50:48AM +0200, Andreas Herrmann wrote:
> I've recently noticed that commit 554c8aa8ecad ("sched: idle: Select
> idle state before stopping the tick") causes severe performance drop
> for systems using pcc-cpufreq driver. Depending on the number of CPUs
> the system might be almost unusable. 

Have you looked at that driver? It features a global lock which is taken
for all cpufreq operations. Once you get past a handful of cpus that
will constrict your system exactly as you say.

What kind of machine are you running this on, and can you configure the
thing to use anything else? If so, do so and never look back.
