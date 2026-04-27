Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0AA3C3449
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295624; cv=pass; b=YgmJp7PVMyujXx86X2XKksYi3MdR4u+BrsPLagsxmornjQUJop1EoTYE0A3ldLHDWC6HZPwPlDlT5xhlPQEaB1tRR93qYXhu+Z1PzMYhIg0uograbrgqxwHv6/VNTtikzhjO+BDwb8ie6y5RxLuVfiJmYZMym0XpRgg/6WeRn2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295624; c=relaxed/simple;
	bh=Zb8vYbMD9IRjw8Jcfa3NNa6YpDZ3/otQveWTR1RGHIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qshGG0dBMratnCG3h/O2qjgJeo/cD3Uf6KvUxjRRLp1/dlsH64SdRLsB9Nt+Asu6qQvJ4/hNye9S8Br0fBABqOd6X3YrZDfIlv6T3gtEo+D79H5dlMiz7LQY9OPjf+6uFrH4cJHPq4HhRQY2XJ1PROLi9uGJWxi7lTcpgJi2+hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fjU22mZF; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjU22mZF"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a1307438ddso9082411e87.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 06:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777295621; cv=none;
        d=google.com; s=arc-20240605;
        b=VAUd20LqadbPKYEsXnMD9s71d1e/UWZUHHc66Rc/87qVE5M/LeQciZtWfZMfnH84U3
         z6BcbvU7kcAV4aLsvsfXIvkPvfo5C89CjQRnRwtZ8nLyyC/P4my8VQoJEtRQQGjBn9Nz
         3UrvlQaCwfLTWGeHNOZXDsu9hgfnZ3KYL/pt/CXjCSw5VIV7RL65qKIcl0nXJFuB9vtG
         u1DAQRB3zIS4dsYqkp2T7MCx0CgxSkC8tp83W7DsxRRxhL1lcGhgtVXr8im27AXW/CxQ
         wmkYoyGhGfKUbAFzcPzrSVWusD518AvTwfJiB9w3ef408z66mvi4LW4HOTAJoDB9Dact
         08ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4zTEZOstYQ1Ndkmbxb0gXIziFqMiC9RX7BP1ekAY2J0=;
        fh=rNpQl80O16QaQA5bEnOQBIR5C3R5QDnsxl+1pANFkUY=;
        b=OqYw8frW9VfJGUS/skgp1ouSRg35e/Zm7mH8ylPWGaEUMzgVrs8X2qR6yVJkDGT95h
         NE3Z6FBXn6GPx6wO0xwTY6wa0C+e3+uLXHjMWzkqGVVukQj6D1w2Ot6CEbVKVKbF5JB6
         rDa4/eVCK5gV76FXEtL9EuTAhQ8OxVHYwWK549BN07Nwwn7JER+w4in1KnPO6D+Fwkko
         wngyfE9lq0OVZA4ThU9AYcuqKpCY/jamsiaIIHk0CHezJktDAU4XGy1r8T7eJGHkuHVI
         DKc2v1ZR8fzq2t0ny3NbmDWDgSsFXxs5Op+gU0//SJtqywDbuSX0D6xkHuLfbqtEc98A
         RzqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777295621; x=1777900421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4zTEZOstYQ1Ndkmbxb0gXIziFqMiC9RX7BP1ekAY2J0=;
        b=fjU22mZFiFH8BPivB4f4hAuRn+Thear+i03qWKC7xdG2unGqshyPFLigZ6bwqTlztL
         7nEarz1LI7sAqEkMFCYrVZXCmfwppckkOjtLyTVsHgVydsnkpJQwA7znjLbOXQgkuREJ
         bWPpQXNVHRdkWD7uhasEgqshkkHcPP3GrU/cCFfsvfF4jxgbsQV7mJSejtML2p2Tt/VM
         4sbCQeFKG8P039G5T49QGy4i5y+axe17ygKxyIEuMHMDzYv8nBWAzgFeMCYV0GawT3HB
         bmhxFmIJmCsgmB9iurGWww5Z3p6Su8Y9+1Le9DRi9AQB+Z10kbecZX/8ctgcxZYot7Cs
         UD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295621; x=1777900421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zTEZOstYQ1Ndkmbxb0gXIziFqMiC9RX7BP1ekAY2J0=;
        b=c1+uZ49JlBovhepM0QEsyEXmuM3sFjxuzw23BUFQoaETZM9w9n276WhtgLkE9THxkj
         bQ+tIgJek2iZ8FSE8N/FwCLvGvP5hL1Sjo/YO7jGREzvBfwzwT7xkK1+DfC0xcRSynTN
         UY9a+jAAFefABpzDBrfo+wnWb9ICLPtlZALrJkGL8+Z6IE9Kgvwrzgd8zAkhLQ/386Hr
         yiGnPZUACaaQlgIW9tvhi7YxhwuForuVDqX7A8t1IKwTHTdP/7eP/rz69HbXXs9CYF4V
         ijzp9Ny3+HSkQqTXE2mbB24bG9FU+FwdmUp3FOOTRnTSNZsnZb4uq+2KexmeYs+WjuS8
         1WWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ps8HYD+Nq/TcpZ+OQ8yF89/nQYYrcLpuVlegefo9EX6R8LE5+ABd8bN/9CuQKuDMBMS24MtgbHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvBeraS02OEk2gG5lLZ4kqSzKewFgoQOPd11os7Rb+AuBd9Ns
	7nWhvhOb0kAP3eL7tAmV+NN2hD84QChUv+YUuWoHjeVi3gPo/sj3/GkytmUPOdwgLzOVgDHhozk
	78AqpDoM9lDGO3aYv0Z6CoRd1ElaIECWOINlhKD8zhg==
X-Gm-Gg: AeBDiesIZfL/xXnkzQmH427Tj8mjRSdDTdfr+JhWHyuQ/5UZPydJUVv9uNNkJUjyeEy
	OCJ2IcU1RpKFQbgv/a/QMBHCqlAFBGOKD2gOrZiDgHGrfVldtIndYbMj6EMuAO5l3b4H+ftea85
	Ag1+PoYGvmEVfgoFCjeBwyQQZ/H7S9E42gCf4Q50fOUi5lTMjnn+2CSQ10SwvpoM7RwooANDO+w
	MYGqGFeHIGlSrlbEg+Cu+DiRhvL+uRdpR1LWfWTEd2ok+ejb5c6LGMUXp+U0d6nODPD8ZBERQXO
	EI2bR0D7tFVh6iB83TU=
X-Received: by 2002:a05:6512:3193:b0:5a4:1310:473a with SMTP id
 2adb3069b0e04-5a4172ca11dmr12799424e87.10.1777295621120; Mon, 27 Apr 2026
 06:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417111331.158190-1-ulf.hansson@linaro.org> <CAMuHMdVr-dzRUruue0XEky_6fCt+v3AHp3G+Zv_N7S2_TpC7yg@mail.gmail.com>
In-Reply-To: <CAMuHMdVr-dzRUruue0XEky_6fCt+v3AHp3G+Zv_N7S2_TpC7yg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Apr 2026 15:13:05 +0200
X-Gm-Features: AVHnY4LaoKv-9zR1nRT5b_JUXnSu76zcBHdPRCqIMP_MLLpQF4ZFC_5gwPwYYIM
Message-ID: <CAPDyKFrZvNsURsK+jmeorDmaN1icXnC8e4tDTk0A42UmtVSTcA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Fix detach procedure for virtual devices
 in genpd
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Apr 2026 at 20:36, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, 17 Apr 2026 at 13:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > If a device is attached to a PM domain through genpd_dev_pm_attach_by_id(),
> > genpd calls pm_runtime_enable() for the corresponding virtual device that
> > it registers. While this avoids boilerplate code in drivers, there is no
> > corresponding call to pm_runtime_disable() in genpd_dev_pm_detach().
> >
> > This means these virtual devices are typically detached from its genpd,
> > while runtime PM remains enabled for them, which is not how things are
> > designed to work. In worst cases it may lead to critical errors, like a
> > NULL pointer dereference bug in genpd_runtime_suspend(), which was recently
> > reported. For another case, we may end up keeping an unnecessary vote for a
> > performance state for the device.
> >
> > To fix these problems, let's add this missing call to pm_runtime_disable()
> > in genpd_dev_pm_detach().
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
> > Cc: stable@vger.kernel.org
> > Closes: https://lore.kernel.org/all/CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com/
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks for your patch!
>
> This survived more than 160000 bind/unbind attempts[1] on R-Car M3-W
> and M3-N, so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for testing! I have queued the patch for fixes.

>
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -3089,6 +3089,7 @@ static const struct bus_type genpd_bus_type = {
> >  static void genpd_dev_pm_detach(struct device *dev, bool power_off)
> >  {
> >         struct generic_pm_domain *pd;
> > +       bool is_virt_dev;
> >         unsigned int i;
> >         int ret = 0;
> >
> > @@ -3098,6 +3099,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
> >
> >         dev_dbg(dev, "removing from PM domain %s\n", pd->name);
> >
> > +       /* Check if the device was created by genpd at attach. */
> > +       is_virt_dev = dev->bus == &genpd_bus_type;
> > +
> > +       /* Disable runtime PM if we enabled it at attach. */
> > +       if (is_virt_dev)
> > +               pm_runtime_disable(dev);
> > +
> >         /* Drop the default performance state */
> >         if (dev_gpd_data(dev)->default_pstate) {
> >                 dev_pm_genpd_set_performance_state(dev, 0);
> > @@ -3123,7 +3131,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>
> Above, out of context, there is an error return.
> Should we call pm_runtime_enable() again, to keep the reference count
> balanced? Or can we just ignore this? It's probably futile anyway.

Good point. I considered it, but I think it's safer to keep runtime PM
disabled, if we encounter an error.

If we end up converting genpd_dev_pm_detach() to return an int instead
of void, then we could revisit this.

>
> >         genpd_queue_power_off_work(pd);
> >
> >         /* Unregister the device if it was created by genpd. */
> > -       if (dev->bus == &genpd_bus_type)
> > +       if (is_virt_dev)
> >                 device_unregister(dev);
> >  }
> >

Kind regards
Uffe
