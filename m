Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552B3BA220
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225943; cv=none; b=i9SXtneVKT+AgNwhUQTOK5WlUYDVRoFSXLI69tO5LANymTtmtP7uJeEBnT3mZ0bnH4KunikNN/228pRUbSjX4bowE55q8DNXGoStA2M5ula1idNvWryRscyobVwKhSh2uTGBiixm4Uh13g0VjnIbDFI1dj8UaL38S/GXTNOert0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225943; c=relaxed/simple;
	bh=eEFHBqJT+RReJ9ZSPerJx1NfMLiuLSYgMadexvWP1+Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1MFwI1838/mK8GBtovKAdBrD3P3iPf7AdTUxRGh9nnC9sUBGg3ICbfSQxuS9/Sx/vg0ZtBIhwCoZR5S587Wx3R/3iW2GDRyh6lgGS7AhYHlNT6ZXEJ8qFJhxGWKrpqM5rnR6hD/K2Iin6KW7VDjS7okTBuriV2TNmAHtXWOwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNh0rEiT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNh0rEiT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A491F00ADB
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785225942;
	bh=qFXoxMwiLC66zE5rWKLkgZqjyAJVRru43sf2qVOCC1s=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=aNh0rEiTKr2AFUqf31DOkal9T3d04yOXBQCdmdxcAw50Ju6F97AwtEZ7/4jKZBrG2
	 pbfef6C/UlttogxZf3zqj4bWMKd3bRToK4fpnkLi/GMhWgCR6rA7ikgZHMHmf0s1o2
	 qNpHDQ/E7K49HzBdVcwO+N+gXq8qvVIP6TZqTKMn0GuOsZBiHZNdTs8rC8+NfPx23C
	 DG57TL1uW+tcFZQCc4P9Rv8zuSuOq8eI8g2FOpmNYTMXZ+UDuea44eBiiqrUtsTJU6
	 yVcl3EJImvM9FGZHb+LzOF4YJZZw8ml4rdaKio/xYbpK53uhtzls9g1EB/Y9hhbzSj
	 b1yI7+O8mGiww==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so31226871fa.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 01:05:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr155Z7ta6jjilZk+lWBqfDY9vxwO1T9DwXIUtd50c4IGzIyJEtj8UFgeDHLu3kbyP1TVS1DSZ5bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHr5rUjrx8B0dkgVw/Ist+4BhoZCm+ZuEd71ahs+QSufvXzWxk
	89/OsdxzK63PAJXp/KTLU8Tb/6wvfmOKMPFrHu+L7zrVxrK9Tc68iX7qtVMPoNpkgMquOQV8lU/
	BmdRmQ00+Un30LEV9TWMTdvnZw/AO33jJeK4MSinGyA==
X-Received: by 2002:a05:6512:3d1e:b0:5ae:c239:f052 with SMTP id
 2adb3069b0e04-5b2d027bbf1mr244999e87.62.1785225940614; Tue, 28 Jul 2026
 01:05:40 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 01:05:39 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 01:05:39 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 01:05:39 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdqPZbh2F37y0gqm=ZWSvXNO0Cv1A-jQPDe4jDnCHnyVg@mail.gmail.com>
X-Gm-Features: AUfX_mwdaGAangc4QCj84WzfcOxjgpYof-aSFbUg9hHW4nmNeRjHZhj6nf99Hg4
Message-ID: <CAMRc=MdqPZbh2F37y0gqm=ZWSvXNO0Cv1A-jQPDe4jDnCHnyVg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and
 PCIe1 with M.2 and TC9563 switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 09:06:12 +0200, Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> said:
> This series enables PCIe for the Eliza EVK board (CQS SoM on EVK carrier).
>
> The Eliza EVK exposes two PCIe ports:
>
> - PCIe0 drives an M.2 E key connector. The 3.3V supply is GPIO-controlled
>   via a TCA9538 I/O expander on I2C4. The slot hosts a WLAN module
>   (connected over PCIe) and a Bluetooth device (connected over UART5),
>   modelled with the pcie-m2-e-connector binding.
>
> - PCIe1 (8GT/s x2) connects to a Toshiba TC9563 PCIe switch, whose
>   management interface sits on I2C4 (address 0x77). The TC9563 RESX# and
>   PERST# lines are OR-ed internally; reset is driven via a TLMM GPIO on
>   the RESX# pin. The iommu-map covers all downstream switch ports
>   (SID range 0x1400-0x1408).
>
> The M.2 WLAN module carries a Qualcomm QCC2072 Bluetooth chip. A device-ID
> entry is added to the M.2 power sequencer so the serdev node for the BT
> UART interface is created on PCI enumeration.
>
> This seris Depends-on:
>   https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
>   https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v4:
> - Added new line and used pcie port names as pcieN_portM (Konrad).
> - Link to v3: https://patch.msgid.link/20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com
>
> Changes in v3:
> - Clubbed pcie nodes to this series (Bjorn A)
>   (https://lore.kernel.org/all/20260708-eliza_dt-v2-1-e6281da26408@oss.qualcomm.com/)
> - Added comment for PERST (Mani).
> - Extended ranges property for pcie1 (Konrad).
> - Link to v2: https://patch.msgid.link/20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com
>
> Changes in v2:
> - Drop patch 3, as this is already applied
> - Rebase on top of https://lore.kernel.org/all/20260708055017.A90C91F000E9@smtp.kernel.org/
>   and remove pincntrl as pincntrl is added in the eliza.dtsi patch and also remove
>   pinctrl for resx as this is covered in pcie1_default_state as perst gpio.
> - Link to v1: https://patch.msgid.link/20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com
>
> ---
> Krishna Chaitanya Chundru (3):
>       arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes
>       arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
>       arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch
>
>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 229 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/eliza.dtsi     | 415 +++++++++++++++++++++++++++++++-
>  2 files changed, 642 insertions(+), 2 deletions(-)
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260629-eliza_evk-6f30686b161f
> prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
> prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
> prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
> prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
> prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53
>
> Best regards,
> --
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
