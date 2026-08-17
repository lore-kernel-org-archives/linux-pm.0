Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C88415F03
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970114; cv=none; b=O/cQ+josdQM6BG2J+O+Kh4+IDinfx+aMlctbnqdt0IqrfVmML12YY6prRCizTo4W2YEd7Q1zDAOQydmWBpugbjJ9XUsRRbfw1CYH50X0tqPxFDtrkh7bv3HGPHcXFhoJCDRoIQ2QStK/j3lInRIEmXUsYAFLph+S3OCpYs8tqoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970114; c=relaxed/simple;
	bh=1A6ly4O2qy9jX3fh5J0Jn7vpphCQE+kxQ2Yqd7sJMh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuTtNKuTMpRNWDRkVJVNsy0viOJUuFGcw2Wg70W4KFpytdWwb8dkAMmKlVLjA1m2I6GkGl3qjiUdgOVmRO2MzT1dJBb60kiA7eiIlgwXCLswhB+E1+wOuD4SbeJ34E/FLVwC2BIKVP19R7tcyOvKuzv2+vC7hoW+cgOdXSA5FAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FApa7rTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FApa7rTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89EB1F00A3D
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786970112;
	bh=F0BoI1B2SW1Gn2SrMpAVpRAmC4OHC4tZa8DJdUfqO2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FApa7rTjLPV+mstCVxbykgPEzDQ0jPgeAsEvGkxeEvaSgD6EwYPLBYAO0aUQNnUJA
	 8/ssUXhQ8Vt93ZNQF4WukWXzLdWuqvcS5qBGJo0s7f3/Q5zgnQEvLnHsg4EGFKLwud
	 GHLO07KfNewgovXS0XdBkTW/ODnMI8IijaL634o8vnve6GXv4uhHWi3siNllJkweva
	 NUMLL3iAxwHUq5DlnTdTr0dVop/JoryLUU3iUHDpj1p6JXMGP7qSY5g8WsvUGcmXJS
	 r6bPHgwyZydh9nVDQK4vOgk0yudoB6xRQmHI/+7RyZwh7D3chRwCX1/DtQdypOc1kK
	 3R/lumUSKOSLg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b01146b205so2453169e87.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 05:35:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoG9lv7TFE+usCCbAHpMYZpCPISbobIUtUgAJyJAMS8Y30JE9fEfjRmrwFF91hacAE5KqqUjtzHrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZbOo8kelPJTzUrT/PIwICSiuS/xWe7d/Mpsuw8Xxw9AKrqizr
	E90P0Gc28dJjOoeAAdfEKISB4uFALL1kJPc7J1zsgFTRMLmAba+LXR6vhDtFnzIbVpDIjlN/JpV
	tBTNoiqZiokIj2cyw6mLu5lYuNqlu2/M=
X-Received: by 2002:a05:6512:66cf:b0:5b2:e956:b459 with SMTP id
 2adb3069b0e04-5b45915e1e5mr2876859e87.12.1786970111723; Mon, 17 Aug 2026
 05:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:34:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLkjDSQMBZGmDwhqzsvF-vds8ynxDgAwNe4QTtpf2mUuvA@mail.gmail.com>
X-Gm-Features: AcwNN1VfwHAQiclbXAp71Kv0t_X4ZrB4Vq7QuyBm6v6ehpWFekFj-AwEo8Rc4XI
Message-ID: <CAD++jLkjDSQMBZGmDwhqzsvF-vds8ynxDgAwNe4QTtpf2mUuvA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Add initial support for Qualcomm Kuno SoC
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 9:32=E2=80=AFAM Hardeep Sharma
<hardeep.sharma@oss.qualcomm.com> wrote:

> This series adds initial support for the Qualcomm Kuno SoC and the Kuno
> IDP reference board.
>
> Kuno is a 32-bit ARM (Cortex-A7) Qualcomm platform. This series brings up
> the essential SoC infrastructure required to boot to a serial console:
>
>   - Global Clock Controller (GCC) and RPMh clock controller
>   - RPMh power domains
>   - Interconnect (NoC) provider
>   - TLMM pin controller
>   - PDC interrupt controller and SCM firmware interface
>   - Devicetree for the SoC and the Kuno IDP board
>
> The soc: qcom: geni-se patch allows the GENI serial engine driver to be
> selected on 32-bit ARM Qualcomm SoCs, which the debug UART console
> depends on.
>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

I understand if you wanna be a bit Greta Garbo mysterious about this
SoC but patch 10 gives the hardware away:

/* GCC clocks */
+#define GCC_EMAC0_AXI_CLK                                      7

Aha it has an ethernet interface.

+#define GCC_PCIE_0_CLKREF_EN                                   22

Aha it has PCI.

+#define GCC_SDCC4_AHB_CLK                                      53

Aha it has SD/MMC cards.

+#define GCC_USB20_MASTER_CLK                                   58

Aha it has USB2.

+#define GCC_USB3_PRIM_CLKREF_EN                                        65

And USB 3.

Other files give away that it also has a modem.

Etc.

So what about writing a bit more about the platform in the commit message?
For a surprising brand new ARM32 platform we (the SoC maintainers) are goin=
g to
be curious to know why this is happening in 2026.

Yours,
Linus Walleij
