From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: armada-37xx: fix clock parenting
Date: Mon, 11 Mar 2019 11:01:30 +0530
Message-ID: <20190311053130.qrobxd2wn75nrgbf@vireshk-i7>
References: <20190308164710.10597-1-gregory.clement@bootlin.com>
 <20190308164710.10597-2-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308164710.10597-2-gregory.clement@bootlin.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Christian Neubert <christian.neubert.86@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08-03-19, 17:47, Gregory CLEMENT wrote:
> From: Christian Neubert <christian.neubert.86@gmail.com>
> 
> The clock parenting was not setup properly when DVFS was enabled. It was
> expected that the same clock source was used with and without DVFS which
> was not the case.
> 
> This patch fixes this issue, allowing to make the cpufreq support work
> when the CPU clock source are not the default ones.
> 
> Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> Cc: <stable@vger.kernel.org>
> [gregory: extract from a larger patch, modify comments and commit log]
> Signed-off-by: Christian Neubert <christian.neubert.86@gmail.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index 75491fc841a6..ad4463e4266e 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -162,11 +162,25 @@ static void __init armada37xx_cpufreq_dvfs_setup(struct regmap *base,
>  	}
>  
>  	/*
> -	 * Set cpu clock source, for all the level we keep the same
> -	 * clock source that the one already configured. For this one
> -	 * we need to use the clock framework
> +	 * Set CPU clock source, for all the level we keep the same
> +	 * clock source that the one already configured with DVS

                                                             DVFS ?

> +	 * disabled. For this one we need to use the clock framework

Please add a full-stop (.) at the end.

>  	 */
>  	parent = clk_get_parent(clk);
> +
> +	/*
> +	 * Unset parent clock to force the clock framework setting again
> +	 * the clock parent
> +	 */
> +	clk_set_parent(clk, NULL);
> +
> +	/*
> +	 * For the Armada 37xx CPU clocks, setting the parent will
> +	 * actually configure the parent when DVFS is enabled. At
> +	 * hardware level it will be a different register from the one
> +	 * read when doing clk_get_parent that will be set with
> +	 * clk_set_parent.
> +	 */
>  	clk_set_parent(clk, parent);
>  }

Maybe this should be done right from the clock driver instead? As cpufreq may or
maynot be enabled by default (Surely most of the people will always enable it,
but I am just trying to find the right place for doing this). The way we are
setting the clock parent isn't that great, and looks a bit hacky just because of
the way clock framework is. Maybe doing it directly, without getting clock
framework in between, from the clock driver may look sane ?

-- 
viresh
