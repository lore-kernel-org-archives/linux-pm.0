From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Tue, 17 Dec 2013 15:45:52 +0800
Message-ID: <20131217074548.GB7172@S2101-09.ap.freescale.net>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
 <20131217025616.GC6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131217025616.GC6691@S2101-09.ap.freescale.net>
Sender: cpufreq-owner@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 17, 2013 at 10:56:18AM +0800, Shawn Guo wrote:
> > +	rcu_read_lock();
> > +	val = prop->value;
> 
> What is this assignment used for?

Sorry.  This is a brain-dead comment.  Ignore it.

Shawn

> 
> > +
> > +	min_volt = max_volt = 0;
> > +	for (i = 0; i < nr / 2; i++) {
> > +		unsigned long freq = be32_to_cpup(val++);
> > +		unsigned long volt = be32_to_cpup(val++);
> > +
> > +		if (i == 0)
> > +			min_volt = max_volt = volt;
> > +		if (volt < min_volt)
> > +			min_volt = volt;
> > +		if (volt > max_volt)
> > +			max_volt = volt;
> > +		opp = dev_pm_opp_find_freq_exact(cpu_dev, freq * 1000, true);
> > +		imx6_soc_opp[i].arm_freq = freq;
> > +		imx6_soc_opp[i].soc_volt = volt;
> > +		soc_opp_count++;
> > +	}
> > +	rcu_read_unlock();

