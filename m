From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
Date: Tue, 19 Jun 2018 14:24:07 +0530
Message-ID: <20180619085407.nmos7tix77vnaqre@vireshk-i7>
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-3-git-send-email-tdas@codeaurora.org>
 <20180606060119.yzl24vhqff6btvrk@vireshk-i7>
 <3cd5944b-d2ca-e7d7-f315-c3e5f230701b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3cd5944b-d2ca-e7d7-f315-c3e5f230701b@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, robh@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, skannan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Sorry for being late..

On 07-06-18, 12:48, Taniya Das wrote:
> On 6/6/2018 11:31 AM, Viresh Kumar wrote:
> > On 04-06-18, 16:16, Taniya Das wrote:

> > > +static struct cpufreq_driver cpufreq_qcom_fw_driver = {
> > > +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> > > +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> > > +	.verify		= cpufreq_generic_frequency_table_verify,
> > > +	.target_index	= qcom_cpufreq_fw_target_index,
> > > +	.get		= qcom_cpufreq_fw_get,
> > > +	.init		= qcom_cpufreq_fw_cpu_init,
> > 
> > What about CPU hotplug ? We can still do that, right ? So what will happen if
> > all CPUs of a freq-domain are removed (hence cpufreq policy is removed) and then
> > someone calls qcom_cpufreq_fw_get() ? You should really work on cpufreq_policy
> > there to get 'c'.
> > 
> 
> You want the _get to do something as below.
> Please correct me if my understanding is wrong.
> ....
> 
>  policy = cpufreq_cpu_get_raw(cpu);
>  if (!policy)
>     return 0;
> 
>  c = policy->driver_data;
> 
>  index = readl_relaxed(c->perf_base);
>  index = min(index, LUT_MAX_ENTRIES - 1);
> 
>  return c->table[index].frequency;
> 
> ....

Right.

> > > +static int qcom_read_lut(struct platform_device *pdev,
> > > +			 struct cpufreq_qcom *c)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
> > > +
> > > +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> > > +				sizeof(*c->table), GFP_KERNEL);
> > > +	if (!c->table)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> > > +		data = readl_relaxed(c->lut_base + i * LUT_ROW_SIZE);
> > > +		src = ((data & GENMASK(31, 30)) >> 30);
> > > +		lval = (data & GENMASK(7, 0));
> > > +		core_count = CORE_COUNT_VAL(data);
> > > +
> > > +		if (!src)
> > > +			c->table[i].frequency = INIT_RATE / 1000;
> > > +		else
> > > +			c->table[i].frequency = XO_RATE * lval / 1000;
> > > +
> > > +		cur_freq = c->table[i].frequency;
> > > +
> > > +		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
> > > +			i, c->table[i].frequency, core_count);
> > > +
> > > +		if (core_count != c->max_cores)
> > > +			cur_freq = CPUFREQ_ENTRY_INVALID;
> > > +
> > > +		/*
> > > +		 * Two of the same frequencies with the same core counts means
> > > +		 * end of table.
> > > +		 */
> > > +		if (i > 0 && c->table[i - 1].frequency ==
> > > +		   c->table[i].frequency && prev_cc == core_count) {
> > > +			struct cpufreq_frequency_table *prev = &c->table[i - 1];
> > > +
> > > +			if (prev_freq == CPUFREQ_ENTRY_INVALID)
> > > +				prev->flags = CPUFREQ_BOOST_FREQ;
> > > +			break;
> > > +		}
> > > +		prev_cc = core_count;
> > > +		prev_freq = cur_freq;
> > > +	}
> > > +
> > > +	c->table[i].frequency = CPUFREQ_TABLE_END;
> > > +
> > > +	return 0;
> > > +}
> > 
> > Looks like there are many problems here.
> > - You are assigning prev_freq with cur_freq (which may be uninitialized local
> >    variable here).
> > - In this version, you never write CPUFREQ_ENTRY_INVALID to table[i].frequency,
> >    which looks wrong as well.
> > 
> 
> - The code to detect boost, would only enter for i > 0 and the prev_freq
> would be initialized with the cur_freq.
> - In the case where the core_count != max_cores, the cur_freq is marked
> INVALID, and when both prev_freq == cur_freq && prev_cc && cur_cc match,
> that is the time the prev table flags need to be updated. Marking the
> table[i].frequency as INVALID is not required as cur_freq is already marked
> with the same. Please correct me if you think otherwise.

Yeah but the value of cur_freq isn't written to the table entries now. This
wasn't the case in the earlier version. Have a look at that one.

-- 
viresh
