From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: schedutil: remove redundant code from
 sugov_next_freq_shared()
Date: Mon, 6 Mar 2017 10:15:53 +0530
Message-ID: <20170306044553.GE8206@vireshk-i7>
References: <cover.1488437503.git.viresh.kumar@linaro.org>
 <639aad743bac7f3292146738f44dbd1480169c8e.1488437503.git.viresh.kumar@linaro.org>
 <1772276.4tCnP8C0XV@aspire.rjw.lan>
 <1668614.4zDQWLsnmH@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1668614.4zDQWLsnmH@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 04-03-17, 01:11, Rafael J. Wysocki wrote:
> So one idea is that if SCHED_CPUFREQ_RT_DL is set in flags, we don't even
> need to start the loop which is quite a cost to simply notice that there's
> nothing to do.

Hmm. Isn't the probability of this flag being set, same for all CPUs in the
policy? If yes, then why do we need to handle the current CPU specially?

> Also I don't quite agree with adding an extra pair of integer multiplications
> to that loop just to get rid of the extra args.

But that should be cheap enough as we would be multiplying with 1 in one of them
and with 0 on the other.

Isn't that better then keeping same code at two places?

Also as I mentioned in the commit log, the number of extra comparisons for the
current CPU will be balanced if we have three CPUs in the policy and with every
other CPU in the policy, we will end up doing one comparison less. With
Quad-core policies, we reduce the number of comparisons by 1 and for octa-core
ones, we reduce it by 5.

-- 
viresh
