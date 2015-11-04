From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] s5pv210-cpufreq: fix wrong do_div() usage
Date: Wed, 4 Nov 2015 07:20:33 +0530
Message-ID: <20151104015033.GN3685@ubuntu>
References: <alpine.LFD.2.20.1511031706460.630@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33334 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbbKDBui (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2015 20:50:38 -0500
Received: by pabfh17 with SMTP id fh17so35739416pab.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2015 17:50:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1511031706460.630@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 03-11-15, 17:13, Nicolas Pitre wrote:
> It is wrong to use do_div() with 32-bit dividends (unsigned long is
> 32 bits on 32-bit architectures).
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 9e231f5215..051a8a8224 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -212,11 +212,11 @@ static void s5pv210_set_refresh(enum s5pv210_dmc_port ch, unsigned long freq)
>  	/* Find current DRAM frequency */
>  	tmp = s5pv210_dram_conf[ch].freq;
>  
> -	do_div(tmp, freq);
> +	tmp /= freq;
>  
>  	tmp1 = s5pv210_dram_conf[ch].refresh;
>  
> -	do_div(tmp1, tmp);
> +	tmp1 /= tmp;
>  
>  	__raw_writel(tmp1, reg);
>  }

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
