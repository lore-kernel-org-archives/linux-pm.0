From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH V2 0/7] CPU cooling device new strategies
Date: Mon, 26 Mar 2018 22:30:46 +0800
Message-ID: <20180326143046.GA18782@leoy-ThinkPad-X240s>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <20180307170923.GA6543@localhost.localdomain>
 <1c07a155-d8e8-480f-937a-6022cda15d0b@linaro.org>
 <20180308120352.mko2b775ppquverb@oak.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308120352.mko2b775ppquverb@oak.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, kevin.wangtao@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, linux-kernel@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 08, 2018 at 12:03:52PM +0000, Daniel Thompson wrote:
> On Wed, Mar 07, 2018 at 07:57:17PM +0100, Daniel Lezcano wrote:
> > >> The preliminary benchmarks show the following changes:
> > >>
> > >> On the hikey6220, dhrystone shows a throughtput increase of 40% for an
> > >> increase of the latency of 16% while sysbench shows a latency increase
> > >> of 5%.
> > > 
> > > I don't follow these numbers. Throughput increase while injecting idle?
> > > compared to what? percentages of what? Please be more specific to better
> > > describer your work..
> > 
> > The dhrystone throughput is based on the virtual timer, when we are
> > running, it is at max opp, so the throughput increases. But regarding
> > the real time, it takes obviously more time to achieve as we are
> > artificially inserting idle cycles. With the cpufreq governor, we run at
> > a lower opp, so the throughput is less for dhrystone but it takes less
> > time to achieve.
> > 
> > Percentages are comparing cpufreq vs cpuidle cooling devices. I will
> > take care of presenting the results in a more clear way in the next version.
> 
> I think we should also note that the current hikey settings for cpufreq
> are very badly tuned for this platform. It has a single temp threshold
> and it jumps from max freq to min freq.
> 
> IIRC Leo's work on Hikey thermals correctly it would be much better if 
> it used the power-allocator thermal governor or if if copied some of 
> the Samsung 32-bit platform by configuring the step governor with a 
> graduated with a slightly lower threshold that moves two stops back in 
> the OPP table (which is still fairly high clock speed... but it
> thermally sustainable).

I think Daniel L. is working on this patch set with 'power-allocator'
governor, and the parameters 'sustainable-power = <3326>' and
'dynamic-power-coefficient = <311>' are profiling value on Hikey
platform.  Now we only consider dynamic power and skip static leakage
for 'power-allocator' governor.  And all these parameters are merged
into Linux mainline kernel.

Daniel L. could correct me if I misunderstand the testing conditions.

Thanks,
Leo Yan
