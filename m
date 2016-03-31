From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v7 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Thu, 31 Mar 2016 14:10:58 +0200
Message-ID: <56FD13D2.1050300@samsung.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
 <1459415165-32613-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1459415165-32613-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/31/2016 11:05 AM, Chanwoo Choi wrote:

> +static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
> +{

> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
> +	if (IS_ERR_OR_NULL(new_opp)) {
> +		dev_err(dev, "failed to get recommed opp instance\n");

s/recommed/recommended/

> +		rcu_read_unlock();
> +		return PTR_ERR(new_opp);
> +	}

> +}

> +static int exynos_bus_probe(struct platform_device *pdev)
> +{

> +	bus->devfreq = devm_devfreq_add_device(dev, profile, "simple_ondemand",
> +						ondemand_data);
> +	if (IS_ERR_OR_NULL(bus->devfreq)) {
> +		dev_err(dev, "failed to add devfreq device\n");
> +		return  PTR_ERR(bus->devfreq);
> +	}

> +}

You should use IS_ERR() instead of IS_ERR_OR_NULL(), since functions
of which the return value is being tested return only ERR_PTR() values.
IS_ERR_OR_NULL() suggest NULL values are possible and then constructs
like
	if (IS_ERR_OR_NULL(result))
		return PTR_ERR(result);

are not correct anyway.

-- 
Regards,
Sylwester
