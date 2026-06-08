Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7F3CC31F
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929291; cv=none; b=IZb70Q2wMQ/B3tEZSQXFCFPPeVvsDVcCtaKM248uxrKwRCLTTo+5OSe6QNTCN1SYFKCp4CLPNgVb8ah7HLeyMN2pHTxBeSzViBHR3zfuV8E2TVHOh841HhanqFkWWzaGQUVTAF+iay7/2MTrN3IUCE1yOqd7ysmQVOxXa0ZY3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929291; c=relaxed/simple;
	bh=OIalH9+6YMcuHzFN1EBtFcDVHixy1D++idho68g2OA4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InzQuqcG8fuzSBVdoH2zpL++ExT613yqh6MyMaD54n4CXgu19jKaABcgZWogFmEWWzRkK2Y/IjyX4wxUWyaLB7BPcS9gysMbkq0qOHEOlsjuPIecRNuSwXPIu5S2u4ZkWH91cMSkizyAoGSE0pXkcqw/1aQglwfesPKvaLJMohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrsiZrhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrsiZrhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C701F0089A
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780929290;
	bh=3n333W9uuX999VQSw8XPT67sii0JB3oXgtv5iZ8Z2UY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=SrsiZrhzyVnrJ+VY9f7kpNryvx6H0NREol6ZRwN+n4GdNcKONyAZXFIY2ywhG98lO
	 wAc7i6k3yGXIcDVhCKhbmySD9e+0UjGLC8ekivOH9Y9W44ZEuHrOL1c/X/l9lmsRkO
	 e8MUvA0JHFpOp3eGO5xT/juzbKMP0so59ZaEKjvBw/Tza5f2RJxb/U1KBWvhnotv0l
	 4vuzjliWg0NPuBAeKYja/OBRBkUifVSJLh9+3ybQLx91yqUx6eIswAki6PhohG/UQc
	 aviuXLKL0HFy/mNNi9+bqFpmui2dRKQENEO2dB3xfANZP4cvnJ3JX/XnhhoQ0ws8nj
	 RpWc9hjrki4Kw==
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65eb226b1ceso3699944d50.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 07:34:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/CAMJRKpSVuhWqDEkpT87JJ2u3S9+pJBQdj2fh+x7pKJxuhVaTl6JGeCQbAvCaufx5+lh1p/YDng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQU1JOtYamCcOneJB0wBjhhmP/+jaQG7lfrkqj+8K1LXXB+X3E
	kXsfD/XYkYihFHqjrtiBqa+s4iC6isFt7BXX+oBPSNbmvlmxn2mvjy48wHZMAsxaWMQiM2x2vh/
	lT9NxqFS6Y037JhQx8GW8st8q5TIEi8Y=
X-Received: by 2002:a05:690e:2621:b0:65e:41dc:e8de with SMTP id
 956f58d0204a3-66107010a7emr11442181d50.61.1780929289702; Mon, 08 Jun 2026
 07:34:49 -0700 (PDT)
Received: from 922524751902 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 07:34:48 -0700
Received: from 922524751902 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 07:34:48 -0700
From: Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20260608091702.3797437-2-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com> <20260608091702.3797437-2-wei.deng@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 07:34:48 -0700
X-Gmail-Original-Message-ID: <CAGyK6cqHM9HtEPLpJqGf8y7wg=en-uA7v=5biU-ZEDLV_6tugA@mail.gmail.com>
X-Gm-Features: AVVi8CdVpeaaRdhY2oHmyy11kxC7QbyPzyAR-EsnZ7mu0yJ5qIqXjfdDURfEjqU
Message-ID: <CAGyK6cqHM9HtEPLpJqGf8y7wg=en-uA7v=5biU-ZEDLV_6tugA@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: sequencing: pcie-m2: Add PCI ID 0x1103 for
 WCN6855 Bluetooth
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, quic_chezhou@quicinc.com, 
	cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 11:17:01 +0200, Wei Deng <wei.deng@oss.qualcomm.com> sai=
d:
> WCN6855 is a Qualcomm Wi-Fi/BT combo chip that uses PCI device ID
> 0x1103. Add it to pwrseq_m2_pci_ids[] alongside the existing 0x1107
> (WCN7850) entry, so that the pwrseq-pcie-m2 driver creates a Bluetooth
> serdev device for WCN6855 cards inserted into PCIe M.2 Key E connectors.
>
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index efeb25ba9c79..b3af14464314 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -188,6 +188,8 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device =
*pwrseq,
>  static const struct pci_device_id pwrseq_m2_pci_ids[] =3D {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>  	  .driver_data =3D (kernel_ulong_t)"qcom,wcn7850-bt" },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
> +	  .driver_data =3D (kernel_ulong_t)"qcom,wcn6855-bt" },
>  	{ } /* Sentinel */
>  };
>
> --
> 2.34.1
>
>

--
=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=E0=
=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=E0=
=AF=8D
