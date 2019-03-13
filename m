From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Update performance state when freq == old_freq
Date: Wed, 13 Mar 2019 10:56:44 +0100
Message-ID: <12337613.44RoPr5aty@aspire.rjw.lan>
References: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, jorge.ramirez-ortiz@linaro.org, "v5 . 0" <stable@vger.kernel.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 12, 2019 5:57:18 AM CET Viresh Kumar wrote:
> At boot up, CPUfreq core performs a sanity check to see if the system is
> running at a frequency defined in the frequency table of the CPU. If so,
> we try to find a valid frequency (lowest frequency greater than the
> currently programmed frequency) from the table and set it. When the call
> reaches dev_pm_opp_set_rate(), it calls _find_freq_ceil(opp_table,
> &old_freq) to find the previously configured OPP and this call also
> updates the old_freq. This eventually sets the old_freq == freq (new
> target requested by cpufreq core) and we skip updating the performance
> state in this case.
> 
> Fix this by also updating the performance state when the old_freq ==
> freq.
> 
> Fixes: ca1b5d77b1c6 ("OPP: Configure all required OPPs")
> Cc: v5.0 <stable@vger.kernel.org> # v5.0
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index d7f97167cac3..0420f7e8ad5b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -760,7 +760,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		old_freq, freq);
>  
>  	/* Scaling up? Configure required OPPs before frequency */
> -	if (freq > old_freq) {
> +	if (freq >= old_freq) {
>  		ret = _set_required_opps(dev, opp_table, opp);
>  		if (ret)
>  			goto put_opp;
> 

Applied, thanks!
