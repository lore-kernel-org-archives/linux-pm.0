From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Date: Mon, 21 May 2018 11:54:28 +0100
Message-ID: <20180521105428.GM17671@n2100.armlinux.org.uk>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526898690-4018-1-git-send-email-ilialin@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526898690-4018-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>
Cc: viresh.kumar@linaro.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 21, 2018 at 01:31:30PM +0300, Ilia Lin wrote:
> +#define SILVER_LEAD	0
> +#define GOLD_LEAD	2

Okay, two different values here, but "GOLD_LEAD" appears unused.

> +	cpu_dev_silver = get_cpu_device(SILVER_LEAD);
> +	if (NULL == cpu_dev_silver)
> +		return -ENODEV;
> +
> +	cpu_dev_gold = get_cpu_device(SILVER_LEAD);
> +	if (NULL == cpu_dev_gold)
> +		return -ENODEV;

get_cpu_device() takes the logical CPU number.  So the above gets CPU 0
each time, and so cpu_dev_silver == cpu_dev_gold here.  So what's the
point of the second get_cpu_device() ?  If it's supposed to be:

	cpu_dev_gold = get_cpu_device(GOLD_LEAD);

That would get CPU 2, but in terms of these defines, it doesn't make that
much sense.  What exactly does "silver lead" and "gold lead" refer to in
these definitions?

> +	opp_silver = dev_pm_opp_set_supported_hw(cpu_dev_silver,&versions,1);
> +	if (IS_ERR(opp_silver)) {
> +		dev_err(cpu_dev_silver, "Failed to set supported hardware\n");
> +		ret = PTR_ERR(opp_silver);
> +		goto free_np;
> +	}
> +
> +	opp_gold = dev_pm_opp_set_supported_hw(cpu_dev_gold,&versions,1);
> +	if (IS_ERR(opp_gold)) {
> +		dev_err(cpu_dev_gold, "Failed to set supported hardware\n");
> +		ret = PTR_ERR(opp_gold);
> +		goto free_opp_silver;
> +	}

Given that cpu_dev_silver == cpu_dev_gold, doesn't the second call to
dev_pm_opp_set_supported_hw() always fail, as opp_table->supported_hw
will be set by the first call?

To me, this driver looks completely useless as it will always fail to
initialise, and I question whether this code has even been runtime
tested.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
