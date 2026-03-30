Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11C236453
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877462; cv=pass; b=kQ5E0RzAVgidFbjOS7tC3OGZdu3Wlw6j4VysX6GWqdztZUdJxxfjdLv/7Psngwvk2Pssb0VuoMjcxYrHBYGfmdqzL/CDRGLnM7fUg0SR0DjmjSedW6ks+965ZVVu2s7pvo/wcwvxIcKfzonZv82nZ+vNcRp2+26/ErBoulCyWoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877462; c=relaxed/simple;
	bh=+f86aptz6kGleDvD+k6/qwObYTMGXDubfN/1s0UBaG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPJuHEHiWBtdCPq79hUMH2GdJNkckw2qlgiBlHC6OB3h/3Esv5zHzBvpqrr0u2Yzn0LWYEIj7kJVoeI0ew8yaRlA+d9phvszdfQdVkwaCwPuj3M2wa6qaOVD8InGQqMJ+9LO4RwKVs16hx/h9918d11B0z0NhNZyrFWEatj93qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Croj3a+8; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Croj3a+8"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a279ce9475so4924540e87.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 06:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774877459; cv=none;
        d=google.com; s=arc-20240605;
        b=akPJm1aW1h2UsjuosvlGh2BSnFd4nALbMRjLZV7iUgPP1D88EHQeodKpxix8H+z5eZ
         O9woG0kKpJBpOrpEvVGGhh3C4M+wSknP9jeOjggHO1EKx0bspBmVuMkJoNIUJU5XDIQh
         rCsgLLXyx+Va8uh3eepSIos9M4+Ifl5BCt4dEOYe/1AkO5ZOx/iggQymo/pKEbQCviCc
         0sKYkjSawATsqtac28z1Fn0TnZMfE+EobGdnMjQIzxN8D3P4Zl5u4WAApWEufEThI0En
         3fwIjj+RFWl/XBT6jpmqhRKRmsWZxIjk8oRAseNTHMebSM6x8El5yQ1lJIkE3EIKooZm
         qUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+f86aptz6kGleDvD+k6/qwObYTMGXDubfN/1s0UBaG4=;
        fh=mvs92qUmZCSTkgIJZd1utz1t9I5/s/BHF1kd4xic//w=;
        b=e4MXCbHJNtzGyN9GHL+40cSQjtFsv/WP7gXrpH2p82fb2jckeEt4tsb6vf4jE2d02s
         sEhPkQPUFPWZqs626w98LQV8jqHLCG4duJe7hSdPeknHo9hc6Ub5BvbnMOGPoKeZSCNe
         vzsOHH9bUz7SFYW1B7Zog28nb55iq2yNIn0/oZH1SQeWdhroIG5SyDZ2V9zODeRHbsbr
         weUEenSKCViGGkyNUhRw+/RRDcaBWyos1+XFSCPHIybwmYjDTmBZ8rumAwC0avlzPhRJ
         upsxkYRTAg2wU6K31gmtA2wc4nan1tCITPtM2AHASDyxobGngaLmvnbuuBkTS5dgSWaF
         g0Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774877459; x=1775482259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+f86aptz6kGleDvD+k6/qwObYTMGXDubfN/1s0UBaG4=;
        b=Croj3a+8UtvUdHkgC59tEsHCKEIBGayyEiLbJldkZF5UjNDq7Rarec4j3Wqw6EtEhK
         aSlIdh5cSDwhT7w6ox3PfBquGvRMY4yVLrmXOlLlol67ycK5LLeC1fuew6cObf15vJxo
         7CQ6F7vTDgJpGRHofy6VgYrsvAzdeoJJR2XULBWdWPp0sLFJsBcIILaJxj66R2P2J5OT
         /kQJRGcIxTcUO9L5LEWnM7oMlIeNqIwqbK0+uGSU4Vh6eNloSk7itNYJtsw7/bOvv2yg
         FsYMQn0M973awbacU1b8ZSZKE8pfLpWV/ESIWNVZusYkhaoUzuDG12nLTxB8XO1fQ2Cn
         PFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877459; x=1775482259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f86aptz6kGleDvD+k6/qwObYTMGXDubfN/1s0UBaG4=;
        b=iCtin8Pm3GhwwQ0PwMusBl9XZDH/LiT+49IPeyQ7qHDRBRppKKhiqXi4j4TSO+wJyU
         JgXb1ZCZez8Tu+JVfngpcscQ+4wYV25aat7thIuuUaGxJbV7M0Lx9NFnA2k5OCjeyGfS
         Gp9DzTj7jrQWk7o+IZrojsS2Oy/Zp0JLVMHt2eU0W2EWCApx7+raTqqyhjuUgZMJmHeV
         K+XcfcOuHSpaPramJ6hQA9Kj05w8SKxmbXYBEFK7+It1iaQcp2Fw+qqbdalYrP1RACzH
         OD/pZ6LLozEhNai1PZQMbNwkoXyc8DDxM/h2xVacrRowBfCOdtD2pyAjBjRaY/Xs/uFh
         3STA==
X-Forwarded-Encrypted: i=1; AJvYcCXE5zxMBX35PmXqIEshq6p1xIkb+C8BAKXTHTI2aEuTfwGKdNaqFIcxRqmYRuDRCzDxIUedS0GRlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0cgPAb+rMPCtsT7OIhTKRyqcZsrG9yFKnbt+7K/cWmLYriIHO
	Eky68WYDlIsSYjtR7cNtIlVZTkOwNxxoR3UGisisAAVnZsxkcIVEaL2+GUv23/gy475Yo5z9HA9
	Gs6RcJr8UFgoJfPMdAMmUHQ9F9bj0gH3MQwGQkMNHvA==
X-Gm-Gg: ATEYQzwqSJOQiuVvbhOzu/vq73wdjy+0QXsYYrImOu11PbEY6jEvnubhcKXydduwbfp
	ZCSWAHsCf1RxEzq8iDIck64MM9fUOPtLu1WAsSIh9XIHhKdsAERqqpmvpsiy2fHVoU8HClh5dz5
	RiZUBt0nvL+YgY0mQSxO3vnkYpBrhe3gEha1y4jX4Flutn5fBvKhY3sFH9nN1zLe/eAbSccNnA5
	UcYfCWzd9qcZ/oCDYztvBjSvjV6CPt9SQZ1zt52e3/MNk0aUMvVwiX9useGl4m0NLBGfPrUuSaW
	PFsLZjb0
X-Received: by 2002:a05:6512:3c9d:b0:5a1:334a:dd62 with SMTP id
 2adb3069b0e04-5a2a507d3d1mr3968354e87.13.1774877459019; Mon, 30 Mar 2026
 06:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
 <177409907930.268981.5882592990447577348.b4-ty@b4> <CAPDyKFoz-sm0pfvn5iSYFY0mrW38vaGRZsFvrVPqsv7BsYxeWQ@mail.gmail.com>
 <1fbf5c54-8793-4585-be33-ded77019adb2@kernel.org> <CAPDyKFrK3NLwaii-9FEmyaTzUAuVkMkLL3rWBQwQvT-M+PzEHA@mail.gmail.com>
 <3bb6b71e-947b-4248-95ba-79852f743c1d@kernel.org> <CAPDyKFpOPC2stAJ262jdap-=ByY09AeQ0kj6p_9FTGJBx+Tu-Q@mail.gmail.com>
 <a417e45b-1632-4b14-9e3c-f7110db53190@kernel.org>
In-Reply-To: <a417e45b-1632-4b14-9e3c-f7110db53190@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 30 Mar 2026 15:30:22 +0200
X-Gm-Features: AQROBzA5SAYARTKyaLHNnERZZZYbnz3WOu73801Fy7BgMdtg8e2xQDHWAeoVpQw
Message-ID: <CAPDyKFomzokuF+UL8d0+Syk1FCG3jnUfy7rVr+3iC1GPZmH1UQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v8 00/10] pmdomain: samsung: add support for
 Google GS101
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Juan Yescas <jyescas@google.com>, Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Mar 2026 at 13:24, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 30/03/2026 13:12, Ulf Hansson wrote:
> >
> >>
> >>>
> >>> Although, as I said, if you think it's best to funnel them through
> >>> your tree, please do and then share them via an immutable branch, so I
> >>> can apply the pmdomain driver changes.
> >>
> >> soc must go via my tree, but there is no reason to take the pmdomain
> >> binding patch. So I did not take.
> >
> > Yes, they belong to soc/platform, which is common for most
> > power-domain providers.
>
> What does belong to soc/platform? pmdomain changes? No, they do not...

I think you may have misunderstood me here. I was referring to the DT
bindings that describe power domain providers.

Generally speaking, these are often provided via some
SOC/platform-specific hardware (like a PMU for example).

>
> >
> > To allow us to merge/maintain power-domain provider *driver* changes
> > separately, we needed a way to manage the corresponding DT bindings.
>
> Nothing stops that, there is no dependency. For a week I am saying there
> are no dependencies. If there are, please provide any sort of
> argument/proof, otherwise there is nothing to do here.
>
> > That's why I am hosting the immutable "dt" branch for these, which
> > soc/platform maintainers can pull-in when they need it.
> >
> > Of course, doing it the other way around is also possible. Just let me
> > know what you prefer.
>
> Nothing like that is necessary.

Usually we want bindings to go along with their respective drivers on
a subsystem basis.

Both patch2 and patch4 updates DT bindings for the power-domain providers.

Why shouldn't the bindings go along with the driver changes here?

Kind regards
Uffe
