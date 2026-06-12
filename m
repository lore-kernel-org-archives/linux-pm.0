Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAB73DDDB9
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249953; cv=none; b=XpATvVa02386QyGcDLe18b5XKxSgTzdRfJDMcgEOxRPqM4H7iOMcXJPKhSzlwEeAKlDtlObydUTOApXlH2fwYsdEPxGEKJwwfun5M2HypAiuhBm9eDms07cT16qdlLtLBNguBccpHizB+mVo4VGmth43F4MW8vadzUyS1w4uHUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249953; c=relaxed/simple;
	bh=z9QRWjpF4mbZ5QQNhCSkNyl2RjyVBn8VQoPBXaspdM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiwaWXeQLVQCrC6y4CCrrRMkhJ6MP4C0SVx179tc+QXuEA8a4PNkgUk0oMCeN4Hng7tFsAzObG0WHqaGgnUYwJRe8sIfD13cS4e6+AXfE6Bek8IBtPCAJBszJ85GYxeMN+7yJ7uljoxV4cuy5EpqqVLolkNepywqSxcd56atvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O/46NIXP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/46NIXP"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-372b4330deeso492318a91.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 00:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781249949; x=1781854749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwAzsKuG98i0XaLphIm9C7P5riFyScOebLVPU4KDGKQ=;
        b=O/46NIXPIFSAZHb7jNQrMvppvNiOQZwIAB5jiTJ25Vv3MMvN7bKgZ0EqcWJhTwtyMc
         7Rdq+EafzLlEi+CvFWnoLLvoK8uDJo2GBdOduHAmibHj6EA6mgm+l8xyte9xlWqO+7zn
         O/WPQD55VC0xcdDxxYUsfyV6h55I6TG2fjzfdpN5IPopPglKPVo6eYXYWCOpTnhTzOpI
         2rxhKPDXxbrXcZ72RutUzTA9dDJJgUKd1PQ7Bb5tP4lN9518tTV+/t+jMBNGxAU56bvl
         SpLkzLJincEoLalt6aYjcq+OfBQW5S0fV3cYbD1CMCqKWoK6yosF0IpWNRFTP7JkqMoY
         Erbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249949; x=1781854749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwAzsKuG98i0XaLphIm9C7P5riFyScOebLVPU4KDGKQ=;
        b=Hg0xv6Fp9eKRE1Hil9IpQy1eHLsh6yC2R6lJKyximV8QqBdr91fvsr4WBkUF30Xh/o
         ogNjhD5c10YOfyQRX1vuWNQbCATJl85KWwQ69MzdIfDxVQJO/OjzTc99CtbGyEYVNXbM
         40eNha10C8R8IQQPBVblTGg7u54Q8DBjP4tT9wkRcGFY1qiTpys4o2NkDnt0TTXsgKnA
         98EL44datfpnbQxiaV83cmm4rmWEfbyw0Xan4otxqaNDSAKhZ2EoGLiTvPPitlC08nYR
         zi/h0q+c1dmN3cCWPVZSiN3DYwB0axTz134FRPW5aTIjJe+CSZbHXu8ugD0l2X3sTg5p
         6aiw==
X-Forwarded-Encrypted: i=1; AFNElJ9Lt4ruAhlVHAgQtT0mcn/4bthX3V6rHnTiUCDpeX7Za4HzuMT+noMMIwGA54kgUi6jE3jIHpFdsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJ/02YRNLhOxG/SVVDpbjUGMA6KJW8ZXAd6zgWUrqqX/wdnmo
	8V1+hZGPBiLUnMjXhnmpC3yU0raLM8fWbGtnZvg/HvasaMOK0oHXVBw5n27SrqWC1uAyYwW3gMm
	73n6Z
X-Gm-Gg: Acq92OFIGm/hIj+WqVscekCtGfkTRmUpGKdcTrHeFQkzfSEdiLT39JQVGnKYHYQvRPH
	QCMIexCRScf7DmrC34cFOcVagbsWP9mHfQfp6rAP8MoFG4joyEnt/byuyrSAo4jEtt+oHYYIzNR
	WOrImxS+WAFcOo9GqoyBYBuK8scsOV+sFr1iBylKBWlVoHn0AYR+wNCQVUV5p2qnTpbEhSnMbue
	zfJTwu9GW/eqdo3UODKXBXwxjuuX7WLI1DZjhenmc8P/CIipqA6rbZ6oVEzihrdnmlIfrQvTQSR
	roPWuugQb3SUKxnKmffdXlPDk7LLuXN09bdgnthIiNtMrVctDPbGQ3EXYAIj3Ch4ixjHHHKG463
	taV7CuobAJepxoJYFaa0ih4wMQPY+DEldk1SlJY0T6cyDhWjZ1zpW8YnjnhbZbuY95UAqvZp7fu
	QmGsl4thdbalbU5CdIW6FKS1w=
X-Received: by 2002:a17:90b:2f4b:b0:36a:6ac2:8bc8 with SMTP id 98e67ed59e1d1-37a037e2876mr1910045a91.14.1781249948578;
        Fri, 12 Jun 2026 00:39:08 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c474sm1268869b3a.2.2026.06.12.00.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:39:07 -0700 (PDT)
Date: Fri, 12 Jun 2026 13:09:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: add ACPM-based CPU DVFS driver for Exynos
 SoCs
Message-ID: <xruckzvdmox4ewgc4shrhrfrq3a3rjl4zqa3rh46oaqezbmir2@yt7oxm2sy4q2>
References: <20260612-acpm-fast-xfer-v1-0-1aa6cd2268ba@linaro.org>
 <20260612-acpm-fast-xfer-v1-2-1aa6cd2268ba@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-acpm-fast-xfer-v1-2-1aa6cd2268ba@linaro.org>

On 12-06-26, 05:34, Alexey Klimov wrote:
> Exynos-based SoCs (e.g., Exynos850, gs101) manage CPU DVFS via an
> ACPM co-processor (sometimes co-processor specifically called APM).
> Historically, routing CPU frequencies through the clock framework
> breaks fast frequency switching as it is implemented in cpufreq-dt.
> The clk_set_rate() uses mutexes, which prevents the scheduler to
> utilize schedutil's fast path.

The OPP core can be configured with a "config_clks" helper, which can let you
call a custom callback instead of clk_set_rate(). With that you can still use
cpufreq-dt ? This may need minor update in OPP core though, as we don't allow
the custom callback for single clocks for now.

> Introduce a dedicated ACPM-based cpufreq driver that bypasses the clock
> framework and communicates directly with the ACPM firmware protocol.
> It implements ->fast_switch() to rely on acpm_dvfs_set_rate_fast(),
> enabling faster frequency transitions.
> 
> Add Google gs101 and Samsung exynos850 to the cpufreq-dt-platdev
> blocklist to prevent driver cpufreq-dt initialisation.
> 
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm          |   8 ++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/acpm-cpufreq.c       | 195 +++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
>  4 files changed, 207 insertions(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index a441668f9e0c..891ff4b6ec22 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -24,6 +24,14 @@ config ARM_AIROHA_SOC_CPUFREQ
>  	help
>  	  This adds the CPUFreq driver for Airoha EN7581 SoCs.
>  
> +config ARM_ACPM_CPUFREQ
> +	tristate "ACPM based CPUFreq support"
> +	depends on ARCH_EXYNOS || (COMPILE_TEST && 64BIT)
> +	select PM_OPP
> +	help
> +	  This adds the CPUFreq driver for Exynos-based machines
> +	  with ACPM firmware.
> +
>  config ARM_APPLE_SOC_CPUFREQ
>  	tristate "Apple Silicon SoC CPUFreq support"
>  	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 6c7a39b7f8d2..c54d2dd6629d 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
>  ##################################################################################
>  # ARM SoC drivers
>  obj-$(CONFIG_ARM_AIROHA_SOC_CPUFREQ)	+= airoha-cpufreq.o
> +obj-$(CONFIG_ARM_ACPM_CPUFREQ)		+= acpm-cpufreq.o
>  obj-$(CONFIG_ARM_APPLE_SOC_CPUFREQ)	+= apple-soc-cpufreq.o
>  obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
>  obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
> diff --git a/drivers/cpufreq/acpm-cpufreq.c b/drivers/cpufreq/acpm-cpufreq.c
> new file mode 100644
> index 000000000000..20fb79169993
> --- /dev/null
> +++ b/drivers/cpufreq/acpm-cpufreq.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Exynos ACPM-based CPUFreq DVFS driver
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +#include <linux/firmware/samsung/exynos-acpm-protocol.h>

Add this within the earlier list in alphabetic order.

> +#define ACPM_DVFS_TRANSITION_TIMEOUT 400
> +
> +struct acpm_cpu_priv {
> +	struct device *cpu_dev;
> +	struct acpm_handle *handle;
> +	unsigned int acpm_chan_id;
> +	unsigned int clk_id;
> +};
> +
> +static unsigned int acpm_soc_cpufreq_get_rate(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> +	struct acpm_cpu_priv *priv;
> +
> +	if (unlikely(!policy))
> +		return 0;
> +
> +	priv = policy->driver_data;
> +
> +	/* return priv->handle->ops->dvfs.get_rate(priv->handle, priv->acpm_chan_id,
> +	 *					priv->clk_id) / 1000;
> +	 */

Wrong multiline comment format.

> +
> +	/* TODO: FIXME. Exynos850 doesn't return rate via ACPM */

:(

> +	return policy->cur;
> +}
> +
> +static int acpm_soc_cpufreq_set_target(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	struct acpm_cpu_priv *priv = policy->driver_data;
> +	unsigned long freq_khz = policy->freq_table[index].frequency;
> +
> +	/* standard slow path */
> +	return priv->handle->ops->dvfs.set_rate(priv->handle, priv->acpm_chan_id,
> +						priv->clk_id, freq_khz * 1000);
> +}
> +
> +static unsigned int acpm_soc_cpufreq_fast_switch(struct cpufreq_policy *policy,
> +						 unsigned int target_freq)
> +{
> +	struct acpm_cpu_priv *priv = policy->driver_data;
> +	int ret;
> +
> +	ret = priv->handle->ops->dvfs.set_rate_fast(priv->handle, priv->acpm_chan_id,
> +						    priv->clk_id, target_freq * 1000);
> +	if (ret < 0)
> +		return 0;
> +
> +	return target_freq;
> +}
> +
> +static int acpm_soc_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> +	struct cpufreq_frequency_table *freq_table;
> +	struct acpm_cpu_priv *priv;
> +	struct of_phandle_args args;
> +	unsigned int transition_latency;
> +	int ret;
> +
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ret = of_parse_phandle_with_args(cpu_dev->of_node, "clocks",
> +					 "#clock-cells", 0, &args);
> +	if (ret) {
> +		dev_err(cpu_dev, "failed to parse clocks property\n");
> +		goto out_free_priv;
> +	}
> +
> +	priv->clk_id = args.args[0];
> +
> +	/*
> +	 * DVFS communication is expected to happen only via channel 0
> +	 * for now for known SoCs with ACPM firmware. Hardcoding.
> +	 */
> +	priv->acpm_chan_id = 0;
> +
> +	priv->handle = devm_acpm_get_by_node(cpu_dev, args.np);

devm on CPU node is incorrect. The resource won't be freed if you remove this
driver's module.

> +	of_node_put(args.np);
> +
> +	if (IS_ERR(priv->handle)) {
> +		ret = PTR_ERR(priv->handle);
> +		goto out_free_priv;
> +	}
> +
> +	priv->cpu_dev = cpu_dev;
> +
> +	ret = dev_pm_opp_of_add_table(cpu_dev);
> +	if (ret < 0) {
> +		dev_err(cpu_dev, "failed to add OPP table: %d\n", ret);
> +		goto out_free_priv;
> +	}
> +
> +	dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);

Check count before this ?

> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (ret <= 0) {
> +		ret = -EPROBE_DEFER;
> +		goto out_remove_table;
> +	}
> +
> +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> +	if (ret) {
> +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> +		goto out_remove_table;
> +	}
> +
> +	policy->driver_data = priv;
> +	policy->freq_table = freq_table;
> +
> +	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
> +	if (!transition_latency)
> +		transition_latency = ACPM_DVFS_TRANSITION_TIMEOUT * NSEC_PER_USEC;
> +
> +	policy->cpuinfo.transition_latency = transition_latency;
> +	policy->dvfs_possible_from_any_cpu = true;
> +	policy->fast_switch_possible = true;
> +	policy->suspend_freq = freq_table[0].frequency;
> +
> +	/* TODO: FIXME. Exynos850 doesn't expose rate of clocks via ACPM  (get_rate doesn't work) */

This makes the driver broken. I don't think we can merge with this.

> +	policy->cur = freq_table[0].frequency;
> +
> +	return 0;
> +
> +out_remove_table:
> +	dev_pm_opp_of_remove_table(cpu_dev);
> +out_free_priv:
> +	kfree(priv);
> +	return ret;
> +}
> +
> +static void acpm_soc_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	struct acpm_cpu_priv *priv = policy->driver_data;
> +
> +	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
> +	dev_pm_opp_of_remove_table(priv->cpu_dev);
> +	kfree(priv);
> +}
> +
> +static struct cpufreq_driver acpm_soc_cpufreq_driver = {
> +	.name		= "acpm-cpufreq",
> +	.flags		= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> +			  CPUFREQ_NEED_INITIAL_FREQ_CHECK | CPUFREQ_IS_COOLING_DEV,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.get		= acpm_soc_cpufreq_get_rate,
> +	.init		= acpm_soc_cpufreq_init,
> +	.exit		= acpm_soc_cpufreq_exit,
> +	.target_index	= acpm_soc_cpufreq_set_target,
> +	.fast_switch	= acpm_soc_cpufreq_fast_switch,
> +	.register_em	= cpufreq_register_em_with_opp,
> +	.set_boost	= cpufreq_boost_set_sw,
> +	.suspend	= cpufreq_generic_suspend,
> +};
> +
> +static int __init acpm_soc_cpufreq_module_init(void)
> +{
> +	if (!of_machine_is_compatible("google,gs101") &&
> +	    !of_machine_is_compatible("samsung,exynos850"))
> +		return -ENODEV;
> +
> +	return cpufreq_register_driver(&acpm_soc_cpufreq_driver);
> +}
> +module_init(acpm_soc_cpufreq_module_init);
> +
> +static void __exit acpm_soc_cpufreq_module_exit(void)
> +{
> +	cpufreq_unregister_driver(&acpm_soc_cpufreq_driver);
> +}
> +module_exit(acpm_soc_cpufreq_module_exit);
> +
> +MODULE_AUTHOR("Alexey Klimov <alexey.klimov@linaro.org>");
> +MODULE_DESCRIPTION("ACPM-based CPUfreq DVFS driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index ff1204c666b1..ae58aa92fc40 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -186,6 +186,9 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,sm8550", },
>  	{ .compatible = "qcom,sm8650", },
>  
> +	{ .compatible = "google,gs101", },
> +	{ .compatible = "samsung,exynos850", },
> +
>  	{ .compatible = "st,stih407", },
>  	{ .compatible = "st,stih410", },
>  	{ .compatible = "st,stih418", },
> 
> -- 
> 2.51.0

-- 
viresh
