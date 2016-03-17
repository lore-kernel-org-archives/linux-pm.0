From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v5 6/7][Update] cpufreq: Support for fast frequency
 switching
Date: Thu, 17 Mar 2016 11:35:07 +0000
Message-ID: <20160317113507.GH18212@e106622-lin>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <4088601.C2vItRYpQn@vostro.rjw.lan>
 <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <4785370.no59v8qjgi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4785370.no59v8qjgi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 17/03/16 00:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: Support for fast frequency switching
> 

[...]

> +void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
> +{
> +	lockdep_assert_held(&policy->rwsem);
> +
> +	mutex_lock(&cpufreq_fast_switch_lock);
> +	if (policy->fast_switch_possible && cpufreq_fast_switch_count >= 0) {
> +		cpufreq_fast_switch_count++;
> +		policy->fast_switch_enabled = true;
> +	} else {
> +		pr_warn("cpufreq: CPU%u: Fast freqnency switching not enabled\n",

Ultra-minor nit: s/freqnency/frequency/

Also, is this really a warning or just a debug message? (everything
seems to work fine on Juno even if this is printed :-)).

Best,

- Juri
