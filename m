Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD43D7A15
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789084; cv=none; b=XfM5vlood1oKOFXoAo7W1uN2g/kMYueAm5MBmnAFS/k0xzzPjD6r5kALjYUGYaZUkqk/3ynx9H3X88vQhL9VqcsPR91wE6t3xFNHngnMH14MrcXjtq7ECnsdrTjNbeV2tEOjwNjhiEnFoSVAen0GI1HqS/8SYSvQNXKJIg9VqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789084; c=relaxed/simple;
	bh=iySBZO3gZGsmPPE7G/Lxu66GNzdQ4kIBkhoEeoFyAn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPnbtQ/Mz8YOmUE7pjyvz17+kvg561Doeyf51rsBpL4BdmsolCofbhnakA/ypo90KLOClw029nW7j1Z3ryE57jlbNMDMwyT/7z7Nsoa0wSZuNvfW3Zxz4qAEb45tci8qhoHCbyTHWpuraRM+68b/5WFd1baU9RSJ1WtgKtKRoV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDJR4+ga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDJR4+ga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6091F00ADE
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779789082;
	bh=ItILktCjSqBdLFQDvgGDSe/Q3g3jKUXXzbWuBU60bu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TDJR4+gazt1aWtvKoEMFu+ZBsbDiNZJqClY7+BBQ0pPCaMomUOFVRh3S57m/G5s+N
	 Ggt0jDzT91L+U3exqNd/+X8rxB+tYRfszYpjstL16DZ/bl4+mRYWmsX3Ci7H6XgfMS
	 LlbbcjmfnPM8EbIGqNOEtBSrF8K0j6uOfbtYKA9voTJ4U+MvItgWLOxkxh/feDHyB4
	 1DOQOv9+4M9v37pNfIFv4n2NIDNR2aul8aHSgXo8B2VFy5A75eHNSPnweYTZXr6sqb
	 aNOrAzSsVZ9makkYcvv2Pj0z1dWmzMOi6yAwmeiaHuVjU9LMMVpINNDsyZ1Vwuki1d
	 /q3sLsY45buJg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso12948982e87.2
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 02:51:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/L/H9MeDxPJgnRX+GChwLcT4zMcq4D5VDfVgXUmX7b3V93r2VMJilPIW4oDlgXnxX//agMG02sCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLDSyDggC2bHIVSnHZM4sY1rGaMTWUrscrshoC7LfAjT89aZb6
	Ylq3xmyOWGqNOPhwfdi2Lg1ZtsfxXwtY5tDLcjkIR8VpbNSCicDw46p3BEpAoE/yv4S8RK04iGL
	zUm2/tbKJQ/dTaaRDCU8cooElXB+yU3eXXLoTpXd80A==
X-Received: by 2002:a05:6512:114c:b0:5a8:ee4b:7011 with SMTP id
 2adb3069b0e04-5aa323707efmr6009063e87.17.1779789081566; Tue, 26 May 2026
 02:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523085102.51000-1-clamor95@gmail.com> <20260523085102.51000-2-clamor95@gmail.com>
In-Reply-To: <20260523085102.51000-2-clamor95@gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 26 May 2026 11:51:09 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfXVwD2u0e115RapnyLzf5JRjWMs=2PSNzMnm0GDd7aaQ@mail.gmail.com>
X-Gm-Features: AVHnY4Kg_SzPxJUQZgrJt30L-V21Z1ehA4lpewoLD8xyp6l37gbtbsdMvoBpOQ4
Message-ID: <CAMRc=MfXVwD2u0e115RapnyLzf5JRjWMs=2PSNzMnm0GDd7aaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: tegra: Document Nvidia Tegra
 modem pwrseq
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 10:51=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
>
> Document the Tegra modem pwseq used by various devices based on the Nvidi=
a
> Tegra SoC, describing its usage. The power sequence provides interaction
> between the modem and SoC-specific interface configurations.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---

...

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    pwrseq-modem {
> +        compatible =3D "nvidia,tegra-modem-pwrseq";
> +
> +        enable-gpios =3D <&gpio 165 GPIO_ACTIVE_HIGH>;
> +        power-supply =3D <&vdd_3v3_vbat>;
> +
> +        nvidia,usb-bus =3D <&usb2>;
> +    };
> --
> 2.51.0
>

I assume there's no such component as the tegra modem *pwrseq*? What
is the relationship between this node and the "infineon,xmm6260"
compatible node?

Bart
