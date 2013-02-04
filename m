From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v5] cpufreq: add imx6q-cpufreq driver
Date: Mon, 4 Feb 2013 13:09:11 +0800
Message-ID: <20130204050909.GD26233@S2101-09.ap.freescale.net>
References: <1359946302-25953-1-git-send-email-shawn.guo@linaro.org>
 <20130204160622.GB5209@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:41928 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750927Ab3BDFJA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 00:09:00 -0500
Content-Disposition: inline
In-Reply-To: <20130204160622.GB5209@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org

On Mon, Feb 04, 2013 at 11:06:22AM -0500, Anson Huang wrote:
> > +	/*
> > +	 * The setpoints are selected per PLL/PDF frequencies, so we need to
> > +	 * reprogram PLL for frequency scaling.  The procedure of reprogramming
> > +	 * PLL1 is as below.
> > +	 *
> > +	 *  - Enable pll2_pfd2_396m_clk and reparent pll1_sw_clk to it
> > +	 *  - Disable pll1_sys_clk and reprogram it
> > +	 *  - Enable pll1_sys_clk and reparent pll1_sw_clk back to it
> > +	 *  - Disable pll2_pfd2_396m_clk
> > +	 */
> > +	clk_prepare_enable(pll2_pfd2_396m_clk);
> > +	clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> > +	clk_set_parent(pll1_sw_clk, step_clk);
> > +	clk_prepare_enable(pll1_sys_clk);
> > +	if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
> > +		clk_disable_unprepare(pll1_sys_clk);
> > +		clk_set_rate(pll1_sys_clk, freqs.new * 1000);
> > +		clk_prepare_enable(pll1_sys_clk);
> > +		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> > +		clk_disable_unprepare(pll2_pfd2_396m_clk);
> > +	} else {
> > +		/*
> > +		 * Disable pll1_sys_clk if pll2_pfd2_396m_clk is sufficient
> > +		 * to provide the frequency.
> > +		 */
> > +		clk_disable_unprepare(pll1_sys_clk);
> > +	}
> Seems like we will get pll2_pfd2_396m_clk's use count mismatch? As every time cpu freq is changed, pll2_pfd2_396m_clk will be added at the beginning of this code piece, but only decreased when cpu freq > 396M, so everytime cpu freq changed to 396M, this pll2_pfd2_396m_clk will in increased?

Ah, good catch.  And pll1_sys_clk has the same problem.  Since it's
been verified by FSL kernel that we do not necessarily need to disable
pll1_sys_clk before reprogramming it, I would choose to rewrite the
code as below to make it cleaner and correct on clock usage.

        /*
         * The setpoints are selected per PLL/PDF frequencies, so we need to
         * reprogram PLL for frequency scaling.  The procedure of reprogramming
         * PLL1 is as below.
         *
         *  - Enable pll2_pfd2_396m_clk and reparent pll1_sw_clk to it
         *  - Reprogram pll1_sys_clk and reparent pll1_sw_clk back to it
         *  - Disable pll2_pfd2_396m_clk
         */
        clk_prepare_enable(pll2_pfd2_396m_clk);
        clk_set_parent(step_clk, pll2_pfd2_396m_clk);
        clk_set_parent(pll1_sw_clk, step_clk);
        if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
                clk_set_rate(pll1_sys_clk, freqs.new * 1000);
                /*
                 * If we are leaving 396 MHz set-point, we need to enable
                 * pll1_sys_clk and disable pll2_pfd2_396m_clk to keep
                 * their use count correct.
                 */
                if (freqs.old * 1000 <= clk_get_rate(pll2_pfd2_396m_clk)) {
                        clk_prepare_enable(pll1_sys_clk);
                        clk_disable_unprepare(pll2_pfd2_396m_clk);
                }
                clk_set_parent(pll1_sw_clk, pll1_sys_clk);
                clk_disable_unprepare(pll2_pfd2_396m_clk);
        } else {
                /*
                 * Disable pll1_sys_clk if pll2_pfd2_396m_clk is sufficient
                 * to provide the frequency.
                 */
                clk_disable_unprepare(pll1_sys_clk);
        }

> > +
> > +	/* Ensure the arm clock divider is what we expect */
> > +	ret = clk_set_rate(arm_clk, freqs.new * 1000);
> > +	if (ret) {
> > +		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
> > +		regulator_set_voltage_tol(arm_reg, volt_old, 0);
> > +		return ret;
> > +	}
> > +
> > +	/* scaling down?  scale voltage after frequency */
> > +	if (freqs.new < freqs.old) {
> > +		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> > +		if (ret)
> > +			dev_warn(cpu_dev,
> > +				 "failed to scale vddarm down: %d\n", ret);
> > +
> > +		if (freqs.old == FREQ_1P2_GHZ / 1000) {
> > +			regulator_set_voltage_tol(pu_reg,
> > +					PU_SOC_VOLTAGE_NORMAL, 0);
> > +			regulator_set_voltage_tol(soc_reg,
> > +					PU_SOC_VOLTAGE_NORMAL, 0);
> > +		}
> > +	}
> > +
> > +	for_each_online_cpu(cpu) {
> > +		freqs.cpu = cpu;
> > +		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> > +	}
> > +
> Should we need to update the percpu loops_per_jiffy variable and global loops_per_jiffy? As the udelay and mdelay will rely on this global loops_per_jiffy? Or the latest kernel has handle it in other place such as cpufreq common driver? I remembered that common cpufreq driver only handle the noSMP case.

No, it's not needed since commit ec971ea (ARM: add cpufreq transiton
notifier to adjust loops_per_jiffy for smp) is in place.

Shawn

