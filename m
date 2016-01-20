From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 15/19] cpufreq: remove useless usage of
 cpufreq_governor_mutex in __cpufreq_governor
Date: Wed, 20 Jan 2016 16:00:08 +0530
Message-ID: <20160120103008.GC18097@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-16-git-send-email-juri.lelli@arm.com>
 <20160112110658.GG1084@ubuntu>
 <20160115163031.GU18603@e106622-lin>
 <20160118055034.GC30762@vireshk>
 <20160119164941.GI8573@e106622-lin>
 <20160120072933.GF22443@vireshk>
 <20160120101724.GM8573@e106622-lin>
 <20160120101836.GB18097@vireshk>
 <20160120102712.GP8573@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160120102712.GP8573@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 20-01-16, 10:27, Juri Lelli wrote:
> That is what I expect as well, but you never know ;).

Perhaps not. We are talking about policy->rwsem here being used while
reading the values of governor's sysfs files. And that lock is only
taken for single governor case.

-- 
viresh
