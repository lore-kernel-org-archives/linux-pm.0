From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 4/5] OPP: Update the bandwidth on OPP frequency changes
Date: Wed, 24 Apr 2019 11:25:12 +0530
Message-ID: <20190424055512.i6hertpilbkdxees@vireshk-i7>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-5-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423132823.7915-5-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, sibis@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23-04-19, 16:28, Georgi Djakov wrote:
> If the OPP bandwidth values are populated, we want to switch also the
> interconnect bandwidth in addition to frequency and voltage.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/opp/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 97ee39ecdebd..91d1c2abfb3e 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -707,7 +707,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  	unsigned long freq, old_freq;
>  	struct dev_pm_opp *old_opp, *opp;
>  	struct clk *clk;
> -	int ret;
> +	int ret, i;
>  
>  	if (unlikely(!target_freq)) {
>  		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
> @@ -780,6 +780,13 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		ret = _generic_set_opp_clk_only(dev, clk, freq);
>  	}
>  
> +	if (!ret && !IS_ERR_OR_NULL(opp_table->paths)) {

Can paths ever have a error value ? I believe only checking for NULL
is sufficient ?

> +		for (i = 0; i < opp_table->path_count; i++) {
> +			icc_set_bw(opp_table->paths[i], opp->bandwidth[i].avg,
> +				   opp->bandwidth[i].peak);
> +		}
> +	}
> +

I will set the path after required_opps are set.

>  	/* Scaling down? Configure required OPPs after frequency */
>  	if (!ret && freq < old_freq) {
>  		ret = _set_required_opps(dev, opp_table, opp);

-- 
viresh
