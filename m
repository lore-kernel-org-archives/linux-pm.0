From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 2/2] cpufreq: schedutil: Force max frequency on busy
 CPUs
Date: Mon, 20 Mar 2017 11:38:15 +0100
Message-ID: <20170320103815.za7bgz4ttz67s746@hirez.programming.kicks-ass.net>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <2185243.flNrap3qq1@aspire.rjw.lan>
 <135462462.sTWZ8TCakW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <135462462.sTWZ8TCakW@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 19, 2017 at 10:24:24PM +0100, Rafael J. Wysocki wrote:

> Honestly, if the processor had been capable of doing per-core P-states, that
> would have been a disaster and there are customers who wouldn't look at
> schedutil again after being confronted with these numbers.

This, I feel, is a bit overstated. We have bug, we fix them.
