From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/4] cpufreq: mt8173: check return value of
 regulator_get_voltage() call
Date: Mon, 30 Nov 2015 10:57:51 +0530
Message-ID: <20151130052751.GK3373@ubuntu>
References: <1448785898-17838-1-git-send-email-pi-cheng.chen@linaro.org>
 <1448785898-17838-3-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36802 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbbK3F2S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 00:28:18 -0500
Received: by pacdm15 with SMTP id dm15so172848665pac.3
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2015 21:28:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448785898-17838-3-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 29-11-15, 16:31, Pi-Cheng Chen wrote:
> Sometimes regulator_get_voltage() call returns negative values for
> reasons(e.g. underlying I2C bus timeout). Add check for the return
> values and fail out early.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
>  drivers/cpufreq/mt8173-cpufreq.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index 750cda7..9d0fe37 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -59,6 +59,10 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>  	int old_vproc, old_vsram, new_vsram, vsram, vproc, ret;
>  
>  	old_vproc = regulator_get_voltage(proc_reg);
> +	if (old_vproc < 0) {
> +		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
> +		return old_vproc;
> +	}
>  	/* Vsram should not exceed the maximum allowed voltage of SoC. */
>  	new_vsram = min(new_vproc + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
>  
> @@ -71,7 +75,17 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>  		 */
>  		do {
>  			old_vsram = regulator_get_voltage(sram_reg);
> +			if (old_vsram < 0) {
> +				pr_err("%s: invalid Vsram value: %d\n",
> +				       __func__, old_vsram);
> +				return old_vsram;
> +			}
>  			old_vproc = regulator_get_voltage(proc_reg);
> +			if (old_vproc < 0) {
> +				pr_err("%s: invalid Vproc value: %d\n",
> +				       __func__, old_vproc);
> +				return old_vproc;
> +			}
>  
>  			vsram = min(new_vsram, old_vproc + MAX_VOLT_SHIFT);
>  
> @@ -116,7 +130,17 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>  		 */
>  		do {
>  			old_vproc = regulator_get_voltage(proc_reg);
> +			if (old_vproc < 0) {
> +				pr_err("%s: invalid Vproc value: %d\n",
> +				       __func__, old_vproc);
> +				return old_vproc;
> +			}
>  			old_vsram = regulator_get_voltage(sram_reg);
> +			if (old_vsram < 0) {
> +				pr_err("%s: invalid Vsram value: %d\n",
> +				       __func__, old_vsram);
> +				return old_vsram;
> +			}
>  
>  			vproc = max(new_vproc, old_vsram - MAX_VOLT_SHIFT);
>  			ret = regulator_set_voltage(proc_reg, vproc,
> @@ -184,6 +208,10 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  	old_freq_hz = clk_get_rate(cpu_clk);
>  	old_vproc = regulator_get_voltage(info->proc_reg);
> +	if (old_vproc < 0) {
> +		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
> +		return old_vproc;
> +	}
>  
>  	freq_hz = freq_table[index].frequency * 1000;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
