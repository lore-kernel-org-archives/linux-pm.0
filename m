From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Tue, 17 Dec 2013 15:02:21 +0800
Message-ID: <20131217070219.GK6691@S2101-09.ap.freescale.net>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
 <20131217025616.GC6691@S2101-09.ap.freescale.net>
 <20131217165257.GA27607@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:13030 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752390Ab3LQHBW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 02:01:22 -0500
Content-Disposition: inline
In-Reply-To: <20131217165257.GA27607@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 17, 2013 at 11:52:57AM -0500, Anson Huang wrote:
> > > @@ -63,29 +68,48 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
> > >  	rcu_read_unlock();
> > >  	volt_old = regulator_get_voltage(arm_reg);
> > >  
> > > -	dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
> > > +	/* Find the matching VDDSOC/VDDPU operating voltage */
> > > +	while (soc_opp_index < soc_opp_count) {
> > > +		if (new_freq == imx6_soc_opp[soc_opp_index].arm_freq)
> > > +			break;
> > > +		soc_opp_index++;
> > > +	}
> > 
> > I'm not comfortable with this lookup every time imx6q_set_target() is
> > called.  I think we can use the 'index' variable to find VDDSOC/VDDPU
> > operating voltage from imx6_soc_opp table directly, if we sort the table
> > in the same order that freq_table is sorted.
> >
> 
> yes, we can use the index passed from OPP, then I will add some comments that
> the freq/volt table of vddsoc should be sorted in same order.

It's not as easy as adding some comments.  I think we need to ensure the
order in probe function, probably sorting them in code.  Otherwise, it's
dangerous if we're running at a frequency with a wrong voltage.

Also, if we sort the table in the same order as freq_table, we do not
even need to have arm_freq in the soc_opp table.

<snip>

> > > +	dev_dbg(cpu_dev, "%u MHz, arm %ld mV, soc-pu %d mV --> %u MHz, arm %ld mV, soc-pu %d mV\n",
> > >  		old_freq / 1000, volt_old / 1000,
> > > -		new_freq / 1000, volt / 1000);
> > > +		imx6_soc_opp[soc_opp_index].soc_volt / 1000,
> > > +		new_freq / 1000, volt / 1000,
> > > +		imx6_soc_opp[soc_opp_index].soc_volt / 1000);
> > 
> > You print the same soc_volt for both old and new ones?
> 
> this is my mistake, maybe I can leave the original code here to only
> print out vddarm's voltage? Otherwise, I have to add variable to keep
> old vddsoc/pu's voltage.

Yea, that's okay with leaving it as the existing code.

<snip>

> > > +	/*
> > > +	 * Each OPP is a set of tuples consisting of frequency and
> > > +	 * voltage like <freq-kHz vol-uV>.
> > > +	 */
> > > +	nr = prop->length / sizeof(u32);
> > > +	if (nr % 2) {
> > > +		dev_err(cpu_dev, "Invalid fsl-soc-operating-points list!\n");
> > 
> > fsl,soc-operating-points
> > 
> > and
> > 
> > 		ret = -EINVAL;
> 
> no need to free freq table here?

We're only populating the error code here, and will still goto
free_freq_table below.

> > > +		goto free_freq_table;
> > > +	}

<snip>

> > > +	min_volt = max_volt = 0;
> > > +	for (i = 0; i < nr / 2; i++) {
> > > +		unsigned long freq = be32_to_cpup(val++);
> > > +		unsigned long volt = be32_to_cpup(val++);
> > > +
> > > +		if (i == 0)
> > > +			min_volt = max_volt = volt;
> > > +		if (volt < min_volt)
> > > +			min_volt = volt;
> > > +		if (volt > max_volt)
> > > +			max_volt = volt;
> > > +		opp = dev_pm_opp_find_freq_exact(cpu_dev, freq * 1000, true);
> > > +		imx6_soc_opp[i].arm_freq = freq;
> > > +		imx6_soc_opp[i].soc_volt = volt;
> > > +		soc_opp_count++;
> > > +	}
> > > +	rcu_read_unlock();
> > 
> > We may need another sanity check to see if soc_opp_count == num (arm opp
> > count) here.
> 
> yes, will add it, need to make sure soc_opp_count is same as arm opp count,
> but since we did NOT have 1G2 check, so the soc_opp_count will ">=" arm opp
> count.

Hmm, this is another problem with the for-loop above.  The soc_volt
should be added into imx6_soc_opp table and soc_opp_count increases,
only when dev_pm_opp_find_freq_exact() succeeds (IOW, the freq can be
found in arm opp table).

Shawn

