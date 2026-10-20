Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500771;
	b=gTM4vldMuB4ABSbvfhaw9WsExTp6WQYHIlE3jfn7ybZU/JD7mFULEoSIHI4lZanu9Frp
	 I6eeGgcjicWbaFzw+xVO3c6V/JKmKVb/Vn8kNSpQZyXkcHj1g2x7r4t3cqmP1RgtTTvQG
	 usiDb/8KFF9vJ8cLlyw9yQ8ssKTWgGZ4OS+wGT7cMWS42+TmkTyf/Ytt46qT0BqCy1KBt
	 bqlVbiFpIvUcbFqGFt83Qmwls7EmgkS9SgtPmV0KgJfBozuUN1ZwxkhlXYXbDuwTl5cmx
	 +zDYb/aCEur0Kf1MfWZg9kM1c9bTWhnoNx7xlN87P62AG4MOqbcvpM/U5fy/xp/VRAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500771;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=Iog5cj9gQ1VLcQX/ZJ4/JUmApqIRY63Pzim15xBJZA4=;
	b=EiUX2/6SVdbxhujryLtS0GoMrYUMvSVWVnGjQ8DlsLmy3lKn1lAOHibRbdegNFFOiAwG
	 FDZMADLx6e5IXssuv0Gvh3KHs63vbBL9ppULBv5yyf45K5khAEe6T42A+5xWDDhTkpVBw
	 MvG3LAKZ6Rh7CpwJFp2TPOJY10hKRdFII/amX1N3+m+rUC7XochC5m153gS1rcLWZHFtN
	 ZqsA/gQMPAFEs2qt8u+d9vXlqDwZ3hODesJisLRiPjRJltv9Va1J3unEcqu+aFnhKjBwn
	 KZdHmN1MhClk79HaAhW/Sy+K+E4M93lA10i+XJShPJe5UWcxJEkvnXzH4zwvI22jXVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tcl8IopX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5395D60A2606
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tcl8IopX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF401F01574
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792500771;
	bh=Iog5cj9gQ1VLcQX/ZJ4/JUmApqIRY63Pzim15xBJZA4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Tcl8IopX5XfgaCedFUCGnnX0qpLjXEfggFrl4g6uF0J9pj2ZByCxfjOKZhvjf29OT
	 jyRZuEMaP+YsyaKXuH7/hX/aY07mqXNVV4LO8+f4vrcvMJBaBHK/vgvD6bqnZQoggG
	 QmsW3kbSDYN4OLZz6SprO/PkstsWSmGXjHfa96tybNAqxlgR6r68ILHZyG8U3skR5p
	 iZfHum1fWwYY7PCqVKD0/TqkffuGi8ZQN9TWachUoSMbvG1ruVtWESZ29ZpqRwRhP/
	 s94Ge/xbVFsRNjGzYNFfkQVJ+9mlgllQjFQLQMDnF++TXXYNRy8qMtFagnQRiqbRW5
	 d1Gt1sKrWNd1Q==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3aae7df0971so21615211fa.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:52:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwQXD9Nr0IgEa9V2XfApv5RZUm5AgPZ1AH7JcVUEwpoU/dA0e8/ecYvy1/s+UAVPTf3AZsZOXVSHA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKfNfMNXhgZCYvGANOxUT9XaRkstHI7pXLs+pMVF6400AoBety
	Sur1uzgLcsZTdXuixMg7B2I0TDrz7QzYDzxWJBz3FxC7vJtuBeBpy6QutYi8x8atCt5Ny/ZFMiN
	Opw5tq+EL+Wmdf+zw2ghhUqR1RIKFndcAco/E+ER4Iw==
X-Received: by 2002:a05:651c:a214:20b0:3a8:d9d5:f9d3 with SMTP id
 38308e7fff4ca-3ab29175de5mr15085321fa.16.1792500769655; Tue, 20 Oct 2026
 05:52:49 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 13:52:48 +0100
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 13:52:48 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <179206391202.36987.1416057976823693032@pm.me>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179206391202.36987.1416057976823693032@pm.me>
Date: Tue, 20 Oct 2026 13:52:48 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mf_93HM8RFq3i3Cuy1_L=VFskt6NcgkcwsyZVH7ymO1Yw@mail.gmail.com>
X-Gm-Features: AclHuK_FLO2OQBomfcZDzAChpS6bYz-U0182uXSwbxihEnP3jdGgRRa6mwaU0dc
Message-ID: <CAMRc=Mf_93HM8RFq3i3Cuy1_L=VFskt6NcgkcwsyZVH7ymO1Yw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: Restore the pin configuration after hibernation
To: Birk Skyum <birk.skyum@pm.me>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 13:31:54 +0200, Birk Skyum <birk.skyum@pm.me> said:
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
> Save the control, output and interrupt configuration registers in
> freeze_noirq and write them back in restore_noirq, the output level
> first, so that a pin drives the right level from the moment it becomes
> an output. Changing the interrupt configuration can latch an interrupt,
> so the status is cleared where the register changed, as
> msm_gpio_irq_set_type() does.
>
> Only the GPIOs the kernel uses are put back: those requested as a GPIO,
> muxed to a function or used as an interrupt, as pinctrl-intel does. A
> valid GPIO without an owner may be in use by firmware. The SDC pads
> after the GPIOs are configured without a mux function, so they never
> have an owner, and their control register is always put back.
>
> msm_pinctrl_dev_pm_ops gets the two callbacks and x1e80100 starts using
> these ops. With that x1e80100 also gets their suspend and resume
> callbacks, which apply the sleep and default state of the controller's
> own pins where a board defines them.
>
> Signed-off-by: Birk Skyum <birk.skyum@pm.me>
> ---
> Changes since the RFC:
> - Put a GPIO back only when the kernel uses it, as a GPIO, through a
>   mux function or as an interrupt, as pinctrl-intel does (Bartosz).
> - Save and restore the SDC pads after the GPIOs as well (Bartosz).
> - Allocate the save area under the same option as the callbacks,
>   CONFIG_HIBERNATE_CALLBACKS (Sashiko).
> - Clear the interrupt status only where the restore changed the
>   interrupt configuration (Sashiko).
> - Say in a comment that a both-edge interrupt emulated by flipping the
>   polarity is not primed again. No SoC with such pins uses these ops.
> - Rebased on pinctrl-qcom/for-next.
> - Link to the RFC: https://lore.kernel.org/r/179163141354.18006.80461347454353634@pm.me
>
> Tested on a Lenovo Yoga Slim 7x with v7.2 plus this patch. The kernel
> also carried the PCI change in [1], without which this machine does
> not resume at all, the smp2p change in [2] and a GENI serial change
> that is not posted. The Bluetooth driver had [3] applied. On
> pinctrl-qcom/for-next the patch builds without warnings with W=1 and
> sparse, with hibernation on, off and without sleep support.
>
> - Before the hibernation 45 TLMM pins have an owner, gpio116 and
>   gpio117 among them (wcn7850-pmu), and four are interrupts.
> - pm_test=core and test_resume pass.
> - After a hibernation with a real power-off the TLMM part of
>   /sys/kernel/debug/gpio differs only in the level read on two inputs
>   (gpio93 and gpio153), as it did with the RFC.
> - A suspend (deep) and wake still works.
>
> The Yoga has no SD card slot and its SDC2 pads have no owner, so this
> only shows that putting them back does no harm. I did not read them
> back.
>
> Not covered here: the LPASS LPI pin controller, whose pins also come
> back at their reset values after a hibernation.
>
> [1] https://lore.kernel.org/r/179181074907.22199.10556821368232442334@pm.me
> [2] https://lore.kernel.org/r/179158127177.70185.5691100900886332545@pm.me
> [3] https://lore.kernel.org/r/179163212446.46972.2306254853726299632@pm.me
>
>  drivers/pinctrl/qcom/pinctrl-msm.c      | 147 +++++++++++++++++++++++-
>  drivers/pinctrl/qcom/pinctrl-x1e80100.c |   1 +
>  2 files changed, 146 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 27f06bbc113c..0dd478e80e30 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -39,6 +39,15 @@
>  #define MAX_NR_TILES 4
>  #define PS_HOLD_OFFSET 0x820
>
> +/* Register values of one pin group, kept across a hibernation. */
> +struct msm_pin_state {
> +	u32 ctl;
> +	u32 io;
> +	u32 intr_cfg;
> +	u32 intr_target;
> +	bool saved;
> +};
> +
>  /**
>   * struct msm_pinctrl - state for a pinctrl-msm device
>   * @dev:            device handle.
> @@ -58,6 +67,7 @@
>   * @soc:            Reference to soc_data of platform specific data.
>   * @regs:           Base addresses for the TLMM tiles.
>   * @phys_base:      Physical base address
> + * @saved:          Pin registers kept while a hibernation image is taken.
>   */
>  struct msm_pinctrl {
>  	struct device *dev;
> @@ -80,6 +90,8 @@ struct msm_pinctrl {
>  	const struct msm_pinctrl_soc_data *soc;
>  	void __iomem *regs[MAX_NR_TILES];
>  	u32 phys_base[MAX_NR_TILES];
> +
> +	struct msm_pin_state *saved;
>  };
>
>  #define MSM_ACCESSOR(name) \
> @@ -1583,9 +1595,133 @@ static __maybe_unused int msm_pinctrl_resume(struct device *dev)
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
> +/*
> + * A GPIO is only put back when the kernel uses it, as a GPIO, through a mux
> + * function or as an interrupt. Other valid pins may be in use by firmware.
> + * The pads after the GPIOs (SDC) have no GPIO and are configured without a
> + * mux function, so they never have an owner and are always put back.
> + */
> +static bool msm_pin_in_use(struct msm_pinctrl *pctrl, unsigned int i)
> +{
> +	const struct pin_desc *desc;
> +
> +	if (i >= pctrl->chip.ngpio)
> +		return true;
> +
> +	if (!gpiochip_line_is_valid(&pctrl->chip, i))
> +		return false;
> +
> +	desc = pin_desc_get(pctrl->pctrl, i);
> +
> +	return desc && (desc->mux_owner || desc->gpio_owner ||
> +			gpiochip_line_is_irq(&pctrl->chip, i));
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
>
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);

Sorry I didn't point it out earlier but can you use a lock guard here?

> +	for (i = 0; i < pctrl->soc->ngroups; i++) {
> +		g = &pctrl->soc->groups[i];
> +		s = &pctrl->saved[i];
> +		s->saved = msm_pin_in_use(pctrl, i);
> +		if (!s->saved)
> +			continue;
> +
> +		s->ctl = msm_readl_ctl(pctrl, g);
> +		if (i >= pctrl->chip.ngpio)
> +			continue;
> +
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
> + *
> + * A both-edge interrupt that is emulated by flipping the polarity gets the
> + * polarity it had, which is not primed for a line that changed meanwhile. No
> + * SoC with such pins (one-bit detection) uses these callbacks.
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

And here?

> +	for (i = 0; i < pctrl->soc->ngroups; i++) {
> +		g = &pctrl->soc->groups[i];
> +		s = &pctrl->saved[i];
> +		if (!s->saved)
> +			continue;
> +
> +		if (i >= pctrl->chip.ngpio) {
> +			msm_writel_ctl(s->ctl, pctrl, g);
> +			continue;
> +		}
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
> +
> +		if (msm_pin_has_own_intr_target(pctrl, g))
> +			msm_writel_intr_target(s->intr_target, pctrl, g);
> +		val = msm_readl_intr_cfg(pctrl, g);
> +		msm_writel_intr_cfg(s->intr_cfg, pctrl, g);
> +
> +		/*
> +		 * Changing the configuration can latch an interrupt. One that
> +		 * is latched with the configuration unchanged is a real one.
> +		 */
> +		if (val != s->intr_cfg)
> +			msm_ack_intr_status(pctrl, g);
> +	}
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops msm_pinctrl_dev_pm_ops = {
> +	SYSTEM_SLEEP_PM_OPS(msm_pinctrl_suspend, msm_pinctrl_resume)
> +	.freeze_noirq = PTR_IF(IS_ENABLED(CONFIG_HIBERNATE_CALLBACKS),
> +			       msm_pinctrl_freeze_noirq),
> +	.restore_noirq = PTR_IF(IS_ENABLED(CONFIG_HIBERNATE_CALLBACKS),
> +				msm_pinctrl_restore_noirq),
> +};
>  EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
>
>  int msm_pinctrl_probe(struct platform_device *pdev,
> @@ -1663,6 +1799,13 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>  	if (ret)
>  		return ret;
>
> +	if (IS_ENABLED(CONFIG_HIBERNATE_CALLBACKS)) {
> +		pctrl->saved = devm_kcalloc(&pdev->dev, pctrl->soc->ngroups,
> +					    sizeof(*pctrl->saved), GFP_KERNEL);
> +		if (!pctrl->saved)
> +			return -ENOMEM;
> +	}
> +
>  	platform_set_drvdata(pdev, pctrl);
>
>  	dev_dbg(&pdev->dev, "Probed Qualcomm pinctrl driver\n");
> diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
> index e4c0abcd95b9..bfe122fc7e79 100644
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
> 2.55.0
>
>
>

Otherwise looks good to me so if there are no objections, I intend to queue
it for v7.5 with guards added.

Bart
