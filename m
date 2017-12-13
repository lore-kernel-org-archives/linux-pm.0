From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Wed, 13 Dec 2017 16:59:22 +0530
Message-ID: <20171213112922.GG3322@vireshk-i7>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
 <20171213112639.GD30887@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171213112639.GD30887@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13-12-17, 12:26, Juri Lelli wrote:
> This flag doesn't do much, does it? I mean RT/DL/IOWAIT are used to bump
> up frequency, while you are adding CFS for the sake of simmetry, right?
> And with my patches DL will hopefully soon be in the same situation.
> If my understanding is correct, maybe add a comment?

Symmetry yes, plus it can be useful to know when there is nothing queued on the
CPU, i.e. no flags are set. Then the CPU is probably going into idle and we may
want to do some tricky stuff there later on.

-- 
viresh
