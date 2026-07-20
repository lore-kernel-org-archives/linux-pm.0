Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FF3D1715
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537862; cv=none; b=sNSWcwmIJGdX0i4bI8vrMF1cV/3iApunWYtOBd2LtdoeuWdmEfHryOdiZh+/WrpAHkysLsOAsAKkdyYUNFGOiCpx7YS86o6bRk/1N1Lgv4LgMyORNDiZ5MDstYefNKnvG8H+kDrHlU1wa878PcLCRcXQeCsClRF1itqMyNfW/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537862; c=relaxed/simple;
	bh=nQQBke5ZlmzFRj43/CzQQOBfPHV+GhuwHWj4S9VuQl0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tz3k3uXVHG8OcewTGCc4E0Vdpfc22sJEadBj4ZJL3O+9C9JikPGfHeiNC6XDLl5LMzcFPrqp1tWQnPfoOmwq/nM4kAesouIPX4pnYmq3cibkq4UHuEY/NlFzEdYtAp1awBirF9Q8mOtBvC8YNjUtxhCg6S7YnPuSeJMRlbKTn0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl3oQphe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl3oQphe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C04F1F0155A
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537860;
	bh=nQQBke5ZlmzFRj43/CzQQOBfPHV+GhuwHWj4S9VuQl0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Xl3oQpheFYaGYQk57RreIH4xfnrhNHPM53w2UjKmlODtt2/XcrW28Ee7bWLNl2aTB
	 wvP0IjsephxMQoCOh0Ctf+OiItMVr3RKO394KxHoqsjwzZ3BJbtdgDZoRiOTN5O+Hc
	 5nCg8pcHjg07CmiyG5oaUhtbpY7mZhpbYgPNfV6YEWzJ5YMbYCVWmLeHaBTa9W99GS
	 Sp8tRuyyXwMoB0pJQTxv4nmIZixYGDEPcXOPyzBBWS40wzADHRvs7uL3CaD5P1UgyO
	 YiQmvzDOqKvjxVAjA9uYh2Wo3nGjqloOEImmzYUCdOaHWainvHyVIDMM5npS5O4tDu
	 5W7NQ1QFInasA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c7ac9b8c3so61052351fa.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:57:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqHE4Y69gAmYoTHgGPXa7YJARg4eFXd2dWWQqb8/eQUgX0mnhRPK/F2i/1NGSAY2av5nmG+pLMVVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/u/xErcLhN9e+UPUVpkFGe3M+8VSxtuyU8RVm0GJ90N3BV2A
	jyU4TKmmM+de1o6e2xPE5w7CcxwhE2rnFvLCxlh7qre9m0KhGoH+JjXhw6iVwi5/St/tq8VVdTb
	cFMUk9mdtrpcETZifwv/pvPJsghzHvP5g15IKOb6+tQ==
X-Received: by 2002:a05:651c:2212:b0:393:8ba5:3d01 with SMTP id
 38308e7fff4ca-39eb281e893mr26252961fa.22.1784537859272; Mon, 20 Jul 2026
 01:57:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 10:57:37 +0200
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 10:57:37 +0200
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260720-monza-wireless-v5-8-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com> <20260720-monza-wireless-v5-8-69ec6743543c@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:57:37 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mf4s+ZyVVmf30vJTJZxyGUCLc9AnXALGYP6i-JVEiXdSw@mail.gmail.com>
X-Gm-Features: AUfX_myuM7qq3uMxNHkqOgQv6po-w8-z77tzEKymhBeuw6gqAeDSHqCNKCSl7-Y
Message-ID: <CAMRc=Mf4s+ZyVVmf30vJTJZxyGUCLc9AnXALGYP6i-JVEiXdSw@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 10:04:10 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
> controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
> rather than a dedicated BT enable GPIO.
>
> When the serdev controller has an OF graph (indicating it is connected to
> an M.2 connector), acquire the 'uart' pwrseq target from the connector's
> power sequencer and use it to control BT power instead of the bt-enable
> GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
