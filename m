Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F73C7E19
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273804; cv=none; b=jJbvp09hu1lwciNWA0mzNWF+RjxiWfPxlA81clU1NB1yerpFqy2QHOmJQcThFtVuPeSOC+kuL7fBg7s/EXRziQWPQ6z4PcYHO3MkvtwUBzJAkMdvG94tFOwTr0eZWvJJgxpp5HeDCYVWSgRIYXYjNhOF9WIXgD42joVH9OWFWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273804; c=relaxed/simple;
	bh=nPvPw7A9YAIxMjZ4/b6RvdHVeDmDsPUX45cjSQ90p/0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNrtTcx4skt0FH6/eRmv6tp7LK6CQvaJSH4dEsb2P6JL2yDeuHb0kZ0MWIAdArkCRy6c+6hCx2mL8789+V4XHSVO+BiN3ZxtiwFsqFfkTaBdVvt2UPrIWksu0sSuG14eyAFsOKRjKdZPjF7s1anK/j/y4i+7+fANnI1I0xwfD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaNa3tt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaNa3tt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4DE1F00898
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 08:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791273800;
	bh=r+KgD9DoUrWu5arzVLlDs3fSXX52ocXw8x+r8c9Z1cw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=CaNa3tt4uTwfPlcLhPdln6QJYXq+DP9tyPKPke9OHd/6cACMGxqPmf28yD9Hdupgg
	 MfloJhes60g10D4cKYMXig6Llvow7IQBSVlg0Ng9S4ESqVnANgTwhUWFedjRzGdy1A
	 yQjini86leUZHV3bHOjvrVtwVX74DMIS/UqSbCkPDdFg1CZsN+1L7w6lhkK3QwRe1t
	 q82nXvzKMwgZajTmrtvhGR+vGSA8/URn6WxKXigKDM0xUTXRCRDh2DssmEu7HNLV1X
	 iRQdEtgPlbszuE59FOYYJat3v4+3RHRBSxw0A7vqomOc4bceJtLwr/DDCIs+p4/V+C
	 x8JQptANGSq5g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba4180a65aso206836e87.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 01:03:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxORHk966K63xdcnotcZ/skJJFVe8btpDwD/jfTYA4SEbbbJoL2XqxFALTvp4NvhMWVV2w+N2o2yg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJI5ysYFH8WBjNe0pin5W/+Sh+UsCA+qZygnlwO++5AE6FMbHh4
	lvK9XqlmNc/6ZgyBqyuV5OQQgyjPz508hqIOWer+sprvEQq/LN/F6mz1JuzU9zkeVuQsqlUpWB9
	suhZFR/8LXa7Aq7LS5LyjxoqSB8u/OMbP5UZFAetSgw==
X-Received: by 2002:a05:6512:683:b0:5bb:a4ba:8ded with SMTP id
 2adb3069b0e04-5bccc718dd2mr276015e87.44.1791273799477; Tue, 06 Oct 2026
 01:03:19 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 11:03:17 +0300
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 11:03:17 +0300
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261004165124.4277-1-franzelfranzel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004165124.4277-1-franzelfranzel@gmail.com>
Date: Tue, 6 Oct 2026 11:03:17 +0300
X-Gmail-Original-Message-ID: <CAMRc=Mf_szZhsZEB8pmZkGh5pB6AEims68rc1tXE=XGAcMuEvg@mail.gmail.com>
X-Gm-Features: AclHuK9nmK19llwqJ_oPdR-YeWv5o1OfhU6oMZraAD3H4lY4H8sCG9gdf0YepLk
Message-ID: <CAMRc=Mf_szZhsZEB8pmZkGh5pB6AEims68rc1tXE=XGAcMuEvg@mail.gmail.com>
Subject: Re: [PATCH v2] power: sequencing: qcom-wcn: power off WLAN at probe
To: Manivannan Sadhasivam <mani@kernel.org>, =?UTF-8?Q?Fran=C3=A7ois_Roux?= <franzelfranzel@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Oct 2026 18:51:24 +0200, "Fran=C3=A7ois Roux"
<franzelfranzel@gmail.com> said:
> The WLAN enable GPIO is requested with GPIOD_ASIS and then kept at its
> current level, so that a WLAN module left powered on by the firmware is
> not switched off. The FIXME explains why: toggling it would take the
> PCIe link down, and the controller driver could not recover from that.
>
> That reasoning held while the PCIe link was trained before the
> sequencer probed. Since commit b921aa3f8dec ("PCI/pwrctrl: Switch to
> pwrctrl create, power on/off, destroy APIs"), qcom_pcie_host_init()
> powers the endpoint through pwrctrl before it starts link training, and
> defers until the pwrctrl driver is bound. That driver cannot bind
> before this sequencer has probed. Power-on therefore always comes
> before link training, and keeping the firmware state is now harmful.
>
> On the Microsoft Surface Pro 11 (X1E80100), the WCN7850 sits on a
> PCIe port without a PERST# GPIO. While pci-pwrctrl-pwrseq is not yet
> bound, the host init is deferred about ten times, and each attempt
> powers the PHY and controller back down. The later power-on only sets
> a GPIO that is already high, so the chip is never reset and the link
> never comes up:
>
>   qcom-pcie 1c08000.pcie: Device found, but not active
>
> The endpoint is not enumerated and ath12k never probes. Bluetooth on
> the same chip fails too ("QCA Failed to send TLV segment (-110)").
>
> Request the GPIO as GPIOD_OUT_LOW. The chip is then off when the
> sequencer probes, and pwrctrl powers it up cleanly right before link
> training. Drop the FIXME and the code that preserved the firmware
> state.
>
> Tested on a Surface Pro 11:
>  - b921aa3f8dec plus a one-line version of this change: endpoint
>    enumerated at 2.4 s, ath12k and Bluetooth working.
>  - next-20260929 plus this patch: "PCIe Gen.3 x2 link up" at 3.4 s,
>    ath12k and Bluetooth working, Wi-Fi connected.
> Without the change, neither kernel enumerates the endpoint.
>
> The culprit was found by bisecting v6.17..v7.1, with the DTB and
> .config held constant.
>
> Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off=
, destroy APIs")
> Closes: https://lore.kernel.org/all/CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw=
5cQt8HiV3sUtxA@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Fran=C3=A7ois Roux <franzelfranzel@gmail.com>
> ---

Mani: this looks good to me, any objections to me queuing it for v7.3?

Bart
