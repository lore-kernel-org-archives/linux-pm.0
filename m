Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9E47DD77
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053388; cv=none; b=T0Y1kb5zVo5vJQTkpvcANjVlm/GWKngZGdt5QZWrgYDYw6V4CzICNKSS7u4ueDdegSrd/10G2YlSaXPkNThd4DLqLNrZk68Yt0WRPWfRvQ7m853ssCEuNWLRfE9kwa11cc4eEmvViP8e859nX0SUcOdophmpGVFrX8vc3DMYkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053388; c=relaxed/simple;
	bh=5MqX8eHZVo9OpafR8fwdCskbkthcFy0oRBvbPUBjcys=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGj8LQ63uFgLSfeNenE0fRMFSeCGovCgqRfrBL7M//Xl1xh6CoWQyyXrmP76ESKGMQPOc82Gf7ET+VpKrpx4qJKeXErZvcBhnYXIUyq5X3Sq+w6K0s4AH+nlyGEb40C48/4Fy93nFCPUoktBvkmHfD2utQtKHs3+0bYxHZ7oit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYbeLhLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYbeLhLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584E31F000CA
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 08:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053386;
	bh=kyqPAP8gbfZgXqYwApY6S2VUSai3hfApMqSsO+21XHY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=TYbeLhLpb810YrkYeati2gHulrEGe4QvJCpwrW5/ty/QUNYmMYDNZqQt9SChof2nl
	 bkqWjAIBxPZPhpQT3l0gh/2bLBaWi5bMYf1TjVSGfIxSc5bUpg40EcDRyYpHoIfa+W
	 43dX/opZQBDnAUqmCy7J5QbVbGJb1Qm0S4Amcc0+x6esxfeZDKRTPwndDvyYCgL3pE
	 iXjXrba4LCCiLoQfwPr4IIl1tW4n4muPMvOaCLl0Hue5+3y5wXRU0Zt+yujHrzUcmg
	 CVm6nptDIZwUAdx0vbS+sNnmPz3kal7XwFoJTetsMGsbg09DzlsIMnOSnxTGnKmsvQ
	 l/L458YlUhQsw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso1759017e87.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 01:36:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz1+MCRnodFA7YKA+wYaUsPVnfj2VXGAqiLz+VIbae774T3VhqjPA4WNV8D5hmo7kkJOIc6ABGM+g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKdKZ0GQn8kyGSjxF0YgIbT4IYEliOEuyMGP3n2wspHT6s2vtP8
	InikS/ay9VAlIZKGEqjT3e4Wv2YwcIYaGFLF6FYs6PmtwI/fehz8CVLNd26fcp9U89EktZ8ohc+
	O4Mrk/bc25HziK/DCvH08P/M7MsuVo/T5vEp6HzKpmw==
X-Received: by 2002:a05:6512:3f01:b0:5ba:3b1c:2f68 with SMTP id
 2adb3069b0e04-5bcde8d5d0emr6645100e87.47.1792053384918; Thu, 15 Oct 2026
 01:36:24 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 08:36:22 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 08:36:22 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <179163141354.18006.80461347454353634@pm.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179163141354.18006.80461347454353634@pm.me>
Date: Thu, 15 Oct 2026 08:36:22 +0000
X-Gmail-Original-Message-ID: <CAMRc=Me8-gMimv0qNNr15JnCzQmoFgf_tVmUQfg-5wQb9GDAMg@mail.gmail.com>
X-Gm-Features: AclHuK98Smx14Zl5Wsew-q1M57A-NdB2f6aZBLBBY3hD4S9pqNn3XhleI05VRAE
Message-ID: <CAMRc=Me8-gMimv0qNNr15JnCzQmoFgf_tVmUQfg-5wQb9GDAMg@mail.gmail.com>
Subject: Re: [RFC PATCH] pinctrl: qcom: Restore the pin configuration after hibernation
To: Birk Skyum <birk.skyum@pm.me>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Oct 2026 13:23:36 +0200, Birk Skyum <birk.skyum@pm.me> said:
> A hibernation image is restored after a power cycle. The TLMM registers
> then hold what the boot firmware and the kernel that loaded the image
> made of them. The restored kernel has the configuration it applied in
> memory only, and nothing writes it to the hardware again, so every pin
> that the loading kernel did not set up the same way stays wrong.
>
> On a Lenovo Yoga Slim 7x (X1E80100) the Bluetooth and Wi-Fi enable lines
> are two of them. Their drivers are loaded from the root file system, so
> the kernel that loads the image never touches the pins. This is
> /sys/kernel/debug/gpio before the hibernation and after the resume:
>
>   gpio116 : out low  func0 2mA no pull
>   gpio117 : out high func0 2mA no pull
>
>   gpio116 : in  low  func0 2mA pull down
>   gpio117 : out high func0 16mA no pull
>
> The driver that owns gpio116 still believes it drives the line.
>
> Save the control, output and interrupt configuration registers of every
> valid pin in freeze_noirq and write them back in restore_noirq, the
> output level first, so that a pin drives the right level from the
> moment it becomes an output. Enabling the raw interrupt status can
> latch an interrupt, so the status is cleared afterwards, as
> msm_gpio_irq_set_type() does.
>
> msm_pinctrl_dev_pm_ops gets the two callbacks and x1e80100 starts using
> these ops. With that x1e80100 also gets their suspend and resume
> callbacks, which apply the sleep and default state of the controller's
> own pins where a board defines them.
>
> Signed-off-by: Birk Skyum <birk.skyum@pm.me>
> ---
> RFC because the two callbacks go into msm_pinctrl_dev_pm_ops, which the
> sc7180, sc7280, sdm845 and sm7150 drivers use as well, and I can only
> test x1e80100. If you would rather have this for x1e80100 alone, or
> done another way, I am happy to redo it.
>

These four use the same TLMM layout so should be safe.

> Tested on a Lenovo Yoga Slim 7x with Arch Linux ARM's v7.2 kernel plus
> this patch. The kernel also carried the PCI change in [1], without
> which this machine does not resume at all, the smp2p change in [2] and
> a GENI serial change that is not ready for the list. The patch is
> based on pinctrl/devel, where it builds without warnings (W=1,
> CONFIG_HIBERNATION=y).
>
> - Without the patch, gpio116 and gpio117 come back as shown above
>   after a hibernation with a real power-off. With it, in four such
>   hibernations, the TLMM part of /sys/kernel/debug/gpio differs only
>   in the level read on two inputs (gpio93 and gpio153).
> - pm_test=core and test_resume pass.
> - A suspend (deep) and wake still works. On x1e80100 it now goes
>   through msm_pinctrl_suspend() and msm_pinctrl_resume().
>
> Not covered here: the LPASS LPI pin controller, whose pins also came
> back at their reset values after a hibernation.
>
> [1] https://lore.kernel.org/r/179157746908.73485.2343672865542690797@pm.me
> [2] https://lore.kernel.org/r/179158127177.70185.5691100900886332545@pm.me
>
>  drivers/pinctrl/qcom/pinctrl-msm.c      | 106 +++++++++++++++++++++++-
>  drivers/pinctrl/qcom/pinctrl-x1e80100.c |   1 +
>  2 files changed, 105 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 27f06bbc1..fba8a4165 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -39,6 +39,14 @@
>  #define MAX_NR_TILES 4
>  #define PS_HOLD_OFFSET 0x820
>
> +/* Register values of one pin, kept across a hibernation. */
> +struct msm_pin_state {
> +	u32 ctl;
> +	u32 io;
> +	u32 intr_cfg;
> +	u32 intr_target;
> +};
> +
>  /**
>   * struct msm_pinctrl - state for a pinctrl-msm device
>   * @dev:            device handle.
> @@ -58,6 +66,7 @@
>   * @soc:            Reference to soc_data of platform specific data.
>   * @regs:           Base addresses for the TLMM tiles.
>   * @phys_base:      Physical base address
> + * @saved:          Pin registers kept while a hibernation image is taken.
>   */
>  struct msm_pinctrl {
>  	struct device *dev;
> @@ -80,6 +89,8 @@ struct msm_pinctrl {
>  	const struct msm_pinctrl_soc_data *soc;
>  	void __iomem *regs[MAX_NR_TILES];
>  	u32 phys_base[MAX_NR_TILES];
> +
> +	struct msm_pin_state *saved;
>  };
>
>  #define MSM_ACCESSOR(name) \
> @@ -1583,9 +1594,93 @@ static __maybe_unused int msm_pinctrl_resume(struct device *dev)
>  	return pinctrl_force_default(pctrl->pctrl);
>  }
>
> -SIMPLE_DEV_PM_OPS(msm_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
> -		  msm_pinctrl_resume);
> +static bool msm_pin_has_own_intr_target(struct msm_pinctrl *pctrl,
> +					const struct msm_pingroup *g)
> +{
> +	return !pctrl->intr_target_use_scm && g->intr_target_reg &&
> +	       g->intr_target_reg != g->intr_cfg_reg;
> +}
> +
> +/* Remember how the pins are set up when a hibernation image is taken. */
> +static int msm_pinctrl_freeze_noirq(struct device *dev)
> +{
> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> +	const struct msm_pingroup *g;
> +	struct msm_pin_state *s;
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
> +	for (i = 0; i < pctrl->chip.ngpio; i++) {

This misses the SDC pads?

> +		if (!gpiochip_line_is_valid(&pctrl->chip, i))
> +			continue;
> +
> +		g = &pctrl->soc->groups[i];
> +		s = &pctrl->saved[i];
> +		s->ctl = msm_readl_ctl(pctrl, g);
> +		s->io = msm_readl_io(pctrl, g);
> +		if (!g->intr_cfg_reg)
> +			continue;
> +
> +		s->intr_cfg = msm_readl_intr_cfg(pctrl, g);
> +		if (msm_pin_has_own_intr_target(pctrl, g))
> +			s->intr_target = msm_readl_intr_target(pctrl, g);
> +	}
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +
> +	return 0;
> +}
> +
> +/*
> + * The image is restored after a power cycle, when the pins are back at what
> + * the firmware and the kernel that loaded the image made of them. Nothing else
> + * writes the configuration again, so put back what was there.
> + */
> +static int msm_pinctrl_restore_noirq(struct device *dev)
> +{
> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> +	const struct msm_pingroup *g;
> +	struct msm_pin_state *s;
> +	unsigned long flags;
> +	unsigned int i;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
> +	for (i = 0; i < pctrl->chip.ngpio; i++) {
> +		if (!gpiochip_line_is_valid(&pctrl->chip, i))
> +			continue;

I'd extend this check to also cover pins that have no GPIO or mux owner or is
an interrupt. See how pinctrl-intel.c does it. Otherwise you can have pins that
are "valid" but are used by firmware.

> +
> +		g = &pctrl->soc->groups[i];
> +		s = &pctrl->saved[i];
> +
> +		/* Set the level before the pin starts driving it. */
> +		val = msm_readl_io(pctrl, g);
> +		val &= ~BIT(g->out_bit);
> +		val |= s->io & BIT(g->out_bit);
> +		msm_writel_io(val, pctrl, g);
> +
> +		msm_writel_ctl(s->ctl, pctrl, g);
> +		if (!g->intr_cfg_reg)
> +			continue;
>
> +		if (msm_pin_has_own_intr_target(pctrl, g))
> +			msm_writel_intr_target(s->intr_target, pctrl, g);
> +		msm_writel_intr_cfg(s->intr_cfg, pctrl, g);
> +
> +		/* Enabling the raw status can latch an interrupt. */
> +		if (s->intr_cfg & BIT(g->intr_raw_status_bit))
> +			msm_ack_intr_status(pctrl, g);
> +	}
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops msm_pinctrl_dev_pm_ops = {
> +	SYSTEM_SLEEP_PM_OPS(msm_pinctrl_suspend, msm_pinctrl_resume)
> +	.freeze_noirq = pm_sleep_ptr(msm_pinctrl_freeze_noirq),
> +	.restore_noirq = pm_sleep_ptr(msm_pinctrl_restore_noirq),
> +};
>  EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
>
>  int msm_pinctrl_probe(struct platform_device *pdev,
> @@ -1663,6 +1758,13 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>  	if (ret)
>  		return ret;
>
> +	if (IS_ENABLED(CONFIG_HIBERNATION)) {
> +		pctrl->saved = devm_kcalloc(&pdev->dev, pctrl->chip.ngpio,
> +					    sizeof(*pctrl->saved), GFP_KERNEL);
> +		if (!pctrl->saved)
> +			return -ENOMEM;
> +	}
> +
>  	platform_set_drvdata(pdev, pctrl);
>
>  	dev_dbg(&pdev->dev, "Probed Qualcomm pinctrl driver\n");
> diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
> index e4c0abcd9..bfe122fc7 100644
> --- a/drivers/pinctrl/qcom/pinctrl-x1e80100.c
> +++ b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
> @@ -1855,6 +1855,7 @@ static struct platform_driver x1e80100_pinctrl_driver = {
>  	.driver = {
>  		.name = "x1e80100-tlmm",
>  		.of_match_table = x1e80100_pinctrl_of_match,
> +		.pm = &msm_pinctrl_dev_pm_ops,
>  	},
>  	.probe = x1e80100_pinctrl_probe,
>  };
> --
> 2.53.0
>
>
>

Bart
