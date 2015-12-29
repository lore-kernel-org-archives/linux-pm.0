From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] PM/OPP: Set cpu_dev->id in cpumask first
Date: Tue, 29 Dec 2015 09:20:54 +0530
Message-ID: <20151229035054.GA6351@ubuntu>
References: <20151228031123.GB3598@ubuntu>
 <1451307977-7427-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33942 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbbL2Du6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2015 22:50:58 -0500
Received: by mail-pa0-f49.google.com with SMTP id uo6so96261389pac.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Dec 2015 19:50:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1451307977-7427-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 28-12-15, 21:06, Pi-Cheng Chen wrote:
> Set cpu_dev->id in cpumask first when setting up cpumask for CPUs that
> share the same OPP table. This might be helpful when handling cpumask
> without the original CPU bitfield set.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
> v1->v2:
> - Set cpu_dev->id in cpumask at the top instead of skip it in the loop
> ---
>  drivers/base/power/opp/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> index 7b445e8..9f0c155 100644
> --- a/drivers/base/power/opp/cpu.c
> +++ b/drivers/base/power/opp/cpu.c
> @@ -214,7 +214,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
>  /*
>   * Works only for OPP v2 bindings.
>   *
> - * cpumask should be already set to mask of cpu_dev->id.
>   * Returns -ENOENT if operating-points-v2 bindings aren't supported.
>   */
>  int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
> @@ -230,6 +229,8 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask
>  		return -ENOENT;
>  	}
>  
> +	cpumask_set_cpu(cpu_dev->id, cpumask);
> +
>  	/* OPPs are shared ? */
>  	if (!of_property_read_bool(np, "opp-shared"))
>  		goto put_cpu_node;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
