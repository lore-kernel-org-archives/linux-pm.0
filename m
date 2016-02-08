From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 03/13] cpufreq: governor: New sysfs show/store
 callbacks for governor tunables
Date: Mon, 8 Feb 2016 22:28:32 +0100
Message-ID: <CAJZ5v0gJCD4_0j=JA+ogEhp4_QmtoX0G2i4_0d1czCbc19xQjg@mail.gmail.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
	<89c003851ca3be77cf3656805303bf4f36d585ea.1454931188.git.viresh.kumar@linaro.org>
	<20160208170736.GT8294@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160208170736.GT8294@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 8, 2016 at 6:07 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-02-16, 17:09, Viresh Kumar wrote:
>> +gov_show_one(sampling_rate);
>> +gov_show_one(sampling_down_factor);
>> +gov_show_one(up_threshold);
>> +gov_show_one(ignore_nice_load);
>> +gov_show_one(min_sampling_rate);
>> +gov_show_one_tunable(cs, down_threshold);
>> +gov_show_one_tunable(cs, freq_step);
>
> Based on the review comments on 1/13, I will do:
> - s/gov_show_one/gov_show_one_common
> - s/gov_show_one_tunable/gov_show_one

OK
