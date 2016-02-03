From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/5] cpufreq: Get rid of ->governor_enabled and its lock
Date: Wed, 3 Feb 2016 16:38:21 +0530
Message-ID: <20160203110821.GB3469@vireshk>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <48d24fd180e1fdf1c06a6992748c6365be43e937.1454410226.git.viresh.kumar@linaro.org>
 <20160202164937.GK3947@e106622-lin>
 <20160203060554.GS31828@vireshk>
 <20160203110512.GR3947@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160203110512.GR3947@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03-02-16, 11:05, Juri Lelli wrote:
> It should be easy to rebase that set (or a part of it) on top of your
> and/or Rafael changes. I realize that there are multiple sets of changes
> under discussion; so, please tell me how do you, and Rafael, want to
> proceed about this.

Yeah, please wait for a bit for Rafael to apply both the series (if
they pass the litmus test) to PM tree :)

> But, I guess any other governor that will bypass cpufreq_governor.c, it
> will also have to implement such checks. I was just proposing to state
> this somewhere, so that we don't forget.

We can surely add a comment for that.

But I would like to review the state after these patches are applied,
as we may be able to guarantee that from cpufreq-core instead.

-- 
viresh
