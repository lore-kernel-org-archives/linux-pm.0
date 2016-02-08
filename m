From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 03/13] cpufreq: governor: New sysfs show/store
 callbacks for governor tunables
Date: Mon, 8 Feb 2016 22:37:36 +0530
Message-ID: <20160208170736.GT8294@vireshk>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
 <89c003851ca3be77cf3656805303bf4f36d585ea.1454931188.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <89c003851ca3be77cf3656805303bf4f36d585ea.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08-02-16, 17:09, Viresh Kumar wrote:
> +gov_show_one(sampling_rate);
> +gov_show_one(sampling_down_factor);
> +gov_show_one(up_threshold);
> +gov_show_one(ignore_nice_load);
> +gov_show_one(min_sampling_rate);
> +gov_show_one_tunable(cs, down_threshold);
> +gov_show_one_tunable(cs, freq_step);

Based on the review comments on 1/13, I will do:
- s/gov_show_one/gov_show_one_common
- s/gov_show_one_tunable/gov_show_one

-- 
viresh
