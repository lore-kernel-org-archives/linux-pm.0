Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0850364E98
	for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642833; cv=none; b=StI0Fs0UAssYgaUZZU1olBatMCo7hE07AhrmBkXvZxTxA8zkI0WZ3e3fcH03s5Y4cXqGfH/lK/AKjivSWATBbnxq4TmaxNQOudQ2VauqmvFiNDj77b/6RIUd8nJ00tSodn16hkxFFaWgkh7CEnEOnFYH7SxKjd17DuTOFpCIrXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642833; c=relaxed/simple;
	bh=n7gDfNG9Q+MVjqXjB4TtsbF2Yo4JB2nCAH6pKIZSPB8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9A4Xc3cmWRfkzISdJUthdHg6xxNdHyBoPW8DnDX0oKN1Bpb9vPA4jgLT1HJ74R/5CIyZyLqgtx+j9pfGbUoKKcc8BuoSo4yvZAQmFg/6l+cca4JGfqG/dgUutdsDG03zuXZLeBryAiP5gOWT/RBWLzTvbfgB4o8c9HBV+sSSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ECUTovuc; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ECUTovuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791642829; x=1791902029;
	bh=PXVc4olALIrNTwac4TDJs0rZIRrcHlvzXNA+n2MLKCI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ECUTovuc0jfWnWjs7GzXRrDNf3fxOEZCGFMQvj1UDhOV8AKxr5k2IxzRm/gZ2MDpz
	 ywg+ug9/UOl3DWKUe+/vpzaI16IoiXh7LlQhSvmztr0RddOTugcmmyikS30CCrlgsR
	 QyWSKtFA9a1jkDYkBntcMCSJ1t1QQGfRWM9a8HQG5v/lVK7S/Ti5fky3I2sQOaulOa
	 ZREAnewXKZNImSGmGAsebly6wbVCPcD/oNtT+hVTwUDwJsrxd+bcfh6K79SgAxcbFc
	 JPWioybFUGHiR/xcXuD/YlXS6AFbirwWY8KOfYZGOdBsnG94/cQX3cW9/ZVWziac2i
	 VVWaUKl7hfbuA==
Date: Sat, 10 Oct 2026 14:33:44 +0000
To: sashiko-bot@kernel.org
From: Birk Skyum <birk.skyum@pm.me>
Cc: Bjorn Andersson <andersson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pinctrl: qcom: Restore the pin configuration after hibernation
Message-ID: <179164282189.97158.2443151927663474607@pm.me>
In-Reply-To: <sashiko-outbox-166471@kernel.org>
References: <179163141354.18006.80461347454353634@pm.me> <sashiko-outbox-166471@kernel.org>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: dea882c62d25aa2543fb2ce342a1e0d933d4401c
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Will this result in a NULL pointer dereference on kernels built with
> CONFIG_HIBERNATION=3Dn but CONFIG_HIBERNATE_CALLBACKS=3Dy?

Yes, the two conditions do not match. The only other option that
selects HIBERNATE_CALLBACKS is XEN_SAVE_RESTORE on x86, where no TLMM
exists, but nothing in the driver says so. In v2 the array and the
callbacks depend on the same option:

=09.freeze_noirq =3D PTR_IF(IS_ENABLED(CONFIG_HIBERNATE_CALLBACKS),
=09=09=09       msm_pinctrl_freeze_noirq),
=09.restore_noirq =3D PTR_IF(IS_ENABLED(CONFIG_HIBERNATE_CALLBACKS),
=09=09=09=09msm_pinctrl_restore_noirq),

and in msm_pinctrl_probe():

=09if (IS_ENABLED(CONFIG_HIBERNATE_CALLBACKS)) {
=09=09pctrl->saved =3D devm_kcalloc(&pdev->dev, pctrl->chip.ngpio,

> Will unconditionally clearing the interrupt status here drop legitimately
> latched edge wakeups?

Yes. The kernel that loads the image can have set a pin up the same
way, and an edge that is latched there is a real one. The commit message
says the patch does what msm_gpio_irq_set_type() does, but that function
clears the status only where it changed the register. v2 does that too:

=09=09val =3D msm_readl_intr_cfg(pctrl, g);
=09=09msm_writel_intr_cfg(s->intr_cfg, pctrl, g);
=09=09if (val !=3D s->intr_cfg)
=09=09=09msm_ack_intr_status(pctrl, g);

> Could blindly restoring the saved intr_cfg cause missed dual-edge interru=
pts?
> [...]
> Should this re-evaluate the line level and update the polarity by calling
> msm_gpio_update_dual_edge_pos() for pins marked in pctrl->dual_edge_irqs
> during resume?

Not with the drivers that use these ops today. The polarity is flipped
only for pins with one-bit detection (intr_detection_width =3D=3D 1), which
apq8064, ipq8064, mdm9615, msm8660 and msm8960 have. sc7180, sc7280,
sdm845, sm7150 and x1e80100 detect both edges in hardware. Where the
parent emulates both edges (wakeirq_dual_edge_errata), the polarity is
in the parent, and this patch does not touch it.

I would not call msm_gpio_update_dual_edge_pos() for it either. It
flips the polarity before it compares the levels, so for a line that
did not change it would leave the opposite of what was primed. A driver
with such pins would need the polarity set from the level instead. I
have no such SoC to test that on, so v2 only gets a comment that says
these pins are not primed again.

Both changes ran on the Yoga Slim 7x before I wrote this, on the same
kernel as before with v2 of the patch. pm_test=3Dcore and test_resume
pass, and after a hibernation with a power-off the TLMM part of
/sys/kernel/debug/gpio again differs only in the level read on gpio93
and gpio153.

I will hold v2 until a maintainer has had a look at the RFC question.

