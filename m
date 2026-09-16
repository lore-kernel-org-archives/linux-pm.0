Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2E4A68A1
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551611; cv=none; b=B4ZCGqwSPxFuhgjz5WEL+9Gsm+h6AU5CmQRw/RcWpBZf7Ku1TWIbxhfOxQgIMK4ehaxfxtOgPNMJDSpM/vGRnfGoEqMcMTNPhmu/nb2iXO2mF9bRKV72k6xGc2bfOdmo7pH5d2fClMwBHClVF3ynq55iHKvXyN7cobWMlg0sLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551611; c=relaxed/simple;
	bh=2yuKCjIDyK/x4MOE4g5o5qI7ddhrFfbRopnIqh1iLi0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWvvffF/2mYgQu2+3pxNBD5cTGLDwlA6SE2tt29vAqRwUsMAix+Ay8VidP3Q/XAAjQMXvNUb0GrBi9kiCQAGOMuV1k/ehktBJqlMsQvQRVotWJBCNRoIoD6QJ3+o+ewnZ7XifnxilzbFNqO8EbKCNCTwZoXtbdCVU7orK1AtyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEa7+TAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEa7+TAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B8B1F0089A
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789551595;
	bh=2yuKCjIDyK/x4MOE4g5o5qI7ddhrFfbRopnIqh1iLi0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=kEa7+TACmQw9LLtOKBXcr9+yyNyOsC76QAKqMJLa5QYBQgs1P38YkG2xbJwqH0Z0v
	 F/biy0p2Go6mXtf9m9RtdBuyc4v6VevPJqTGYqMxZzcZ2GHQsphNwBJHzxbjU2o0I1
	 cs1uaMTRAqTSs0X1LckGEtVGXBMo2OaDflQ0RLRiVAe2Lih6/A+DaM07Xxb117pcUU
	 gZrV0rZ1TjCEh1Nmp2U7L0+X6JkNN5hLxa05isdVkvKBIoBhWbGayHExVo7TjfSzzm
	 QEY0PmQ2SKX0GkatvrL89n3HvaTRnRB8yGSneD01ZhNdTPRPzoY3cGfc1FGKs88Tz6
	 vmSepgBDmXi+A==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a47f740839so5721631fa.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 02:39:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw85V7IraleNCODf8jDveRfa21uz7HfURGXLt/3lEoTggsnIio74/hSPl/jm4OjF+nFTD4lhn2uVg==@vger.kernel.org
X-Gm-Message-State: AFuF++lxoRk6O1VBsqrwWjYbUl5NUD62Cc2roIaHJW2t2LR+0SJorh42
	ZR0Gu3DgQD48dQ0+JkPIRSt2G46dtZPqbCafo8NkqJTHm9aDpSuDAi8Kmaik16bmy2vB0BFeRu3
	O7AKo75AMl0jfd0u8Bof8WpXGPA+0otCsBJuL3U/vvQ==
X-Received: by 2002:a05:6512:1107:b0:5b7:de2d:191a with SMTP id
 2adb3069b0e04-5b8b6616213mr571469e87.23.1789551594053; Wed, 16 Sep 2026
 02:39:54 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Sep 2026 04:39:51 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Sep 2026 04:39:51 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260915-pci-m2-bt-rework-v1-1-3c7d9cf9c010@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com> <20260915-pci-m2-bt-rework-v1-1-3c7d9cf9c010@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 04:39:51 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mdt7+xYGJTDpYfLf+aKT1-h05qznuuz5eCwLQUa3WU1ug@mail.gmail.com>
X-Gm-Features: AcwNN1UHyIe_E1G_6fwzRWv11gNibMjjztMru9LJ8H2caU7qReugLOq9coLS8D8
Message-ID: <CAMRc=Mdt7+xYGJTDpYfLf+aKT1-h05qznuuz5eCwLQUa3WU1ug@mail.gmail.com>
Subject: Re: [PATCH 1/5] Bluetooth: hci_qca: Add auxiliary driver for PCIe M.2 modules
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, Rahul Samana <rahul.samana@oss.qualcomm.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	Neeraj Kale <neeraj.sanjaykale@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sep 2026 16:24:02 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> The QCA2066, WCN6855 and WCN7850 combo modules expose Bluetooth over
> UART. Since these modules are attached over PCIe, these are not described
> in firmware like devicetree. So these modules are discovered at runtime
> over PCIe by the power sequencing driver, which allocates the UART serdev
> and creates an auxiliary device carrying that transport and the power
> sequencing target to power up the Bluetooth function.
>
> Add an auxiliary driver that binds to this device. It reuses the serdev
> provided by the producer, brings up the controller through the existing
> UART transport with hci_uart_register_device() and drives power through
> the sequencer obtained with devm_pwrseq_get().
>
> Add a shared header describing the auxiliary device so that the power
> sequencing driver and hci_qca agree on its layout.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
