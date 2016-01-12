From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 02/19] cpufreq: merge governor lock and mutex
Date: Tue, 12 Jan 2016 14:30:24 +0530
Message-ID: <20160112090024.GS1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-3-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452533760-13787-3-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 11-01-16, 17:35, Juri Lelli wrote:
> From: Michael Turquette <mturquette@baylibre.com>
> 
> Commit 95731ebb114c ("cpufreq: Fix governor start/stop race condition")
> introduced cpufreq_governor_lock. This was actually overkilling, as the
> same can be achieved by using the existing cpufreq_governor_mutex.
> Removing cpufreq_governor_lock cleans things up and makes deadlocks less
> likely to happen.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> ---
>  drivers/cpufreq/cpufreq.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)


Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
