From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 3 Feb 2016 12:03:42 +0530
Message-ID: <20160203063342.GT31828@vireshk>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
 <20160202154717.GI3947@e106622-lin>
 <CAJZ5v0h3k_CVDkmc8QKczr0MxCuGd+Rm_wSMXO=UHBvOjae0Uw@mail.gmail.com>
 <20160202170144.GL3947@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160202170144.GL3947@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02-02-16, 17:01, Juri Lelli wrote:
> Hi Rafael,
> 
> On 02/02/16 17:35, Rafael J. Wysocki wrote:
> > On Tue, Feb 2, 2016 at 4:47 PM, Juri Lelli <juri.lelli@arm.com> wrote:

> > > This patch cleans things up a lot, that's good.
> > >
> > > One thing I'm still concerned about, though: don't we need some locking
> > > in place for some of the store operations on governors attributes? Are
> > > store_{ignore_nice_load, sampling_down_fact, etc} safe without locking?
> > 
> > That would require some investigation I suppose.

Yeah, that protection is required. Sorry about that.

> > > It seems that we can call them from different cpus concurrently.
> > 
> > Yes, we can.
> > 
> > One quick-and-dirty way of dealing with that might be to introduce a
> > "sysfs lock" into struct dbs_data and hold that around the invocation
> > of gattr->store() in the sysfs_ops's ->store callback.

s/dirty/sane ? :)

> Can't we actually try to use the policy->rwsem (or one of the core
> locks) + wait_for_completion approach as we do in cpufreq core?

policy->rwsem will defeat the purpose of this change as it will
reintroduce the ABBA issue.

-- 
viresh
