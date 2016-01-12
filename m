From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 16/19] cpufreq: hold policy->rwsem across
 CPUFREQ_GOV_POLICY_EXIT
Date: Tue, 12 Jan 2016 16:39:55 +0530
Message-ID: <20160112110955.GH1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-17-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452533760-13787-17-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 11-01-16, 17:35, Juri Lelli wrote:
> There are no good reasons why policy->rwsem cannot be hold across calls to
> __cpufreq_governor with CPUFREQ_GOV_POLICY_EXIT event.
> 
> Remove {up,down}_write across such call sites. This also verify assertion
> that policy->rwsem is always hold when calling into __cpufreq_governor.

Test on X86 with prove_locking etc enabled.. and try running tests
from my cpufreq-test repo. There were real concerns. Over that, I have
identified the issue completely, as to why the ABBA dependency I
mentioned earlier is there. You can find that in the branch I shared
with you earlier.

commit 57714d5b1778 ("cpufreq: Access governor's sysfs attributes without 'policy->rwsem'")

-- 
viresh
