From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 5/6] cpufreq: schedutil: relax rate-limiting while
 running RT/DL tasks
Date: Thu, 30 Nov 2017 17:06:27 +0100
Message-ID: <20171130160627.GJ9903@localhost.localdomain>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-6-patrick.bellasi@arm.com>
 <20171130133642.GE9903@localhost.localdomain>
 <20171130155403.GE31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130155403.GE31247@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 30/11/17 15:54, Patrick Bellasi wrote:
> On 30-Nov 14:36, Juri Lelli wrote:

[...]

> > I wonder if we would also need some way to trigger a back to back update
> > as soon as a currently running one finishes and an RT/DL task asked for
> > an update (without waiting for the next tick).
> 
> Good point, I think that would actually be an interesting
> optimization. We already discussed that in the past, but refrained by
> adding more on top of this already "substantial" set of changes.
> 
> Can we think about that once we decided about some patches of this
> series?

Definitely yes for me. One bit at a time. :)

Best,

Juri
