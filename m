Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD193BF660
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791580081; cv=none; b=kCLBC2qEDq5P/wWJ/PwIqlnUrOgOWDC+fCO9iutqafQBVuRrngNSCVewF4QZXSx6KtwFwUYnHvbTPfiaF5Hm+R7fcmdeBwkunnmf1bynsp7Ou6/3d7K17ZAtC1+yTRBegoUhTyyKukle/bOxJx7IdsKSYt0cKd+zy/ECN9Qyzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791580081; c=relaxed/simple;
	bh=5sMHZk4Hc88OhXhjJkqjDNeV6rinFGuPqsbkYItAWz0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jgm+BSWhHhCzgFqw3N2EfTi20b4RS67b+wm8JV5Vel9D79Z8/Be6DdTjBbI82KpiVDjoxLEv11CYDX8m7dGmbHg8hout1nbt406yI06q8KFSJYKX+UD7qjv4w0m6tPE3nvso2PHj6qSiDHAsBtFf+44UvK18448rSnBE/MOvJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=EcgIALZD; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="EcgIALZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791580076; x=1791839276;
	bh=8mepSe62s0ugerwpFuXic0aCmj871cPqnta8q4WTVwc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EcgIALZDakrxXNkCM/5aUw8DLoDg4bDNi/NqhDKyCh7SYpJN+NswgIxAPS/SJhsVc
	 yKuSiRTw6+bDTvXRsZyupu2Ech353t/irzazx6llMjKcJDMC8+yzONohxNFucrOM++
	 TQwjiggKgiATDwYUCARn/jXfbLvYmgTbPPNVJohBJTR70rBuWe8cxZg8vuQbIBKFU7
	 JoBhf7jLZf/rlVGGGb2VnnwYmW038rqL9kSzpzt7+FF1HyyKgTw/L0pZe3uErLpO+i
	 a7zAlJgrHp7mAH9/c2qrGJ1iMDkLIUddcmGq1CPtCKAEugdpx2ZqlrJhLUzSuOqXez
	 ZcvQ2OT2isp5A==
Date: Fri, 09 Oct 2026 21:07:53 +0000
To: sashiko-bot@kernel.org
From: Birk Skyum <birk.skyum@pm.me>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: dwc: Power the controller down when hibernating
Message-ID: <179158007085.33373.10495486250879471249@pm.me>
In-Reply-To: <sashiko-outbox-166041@kernel.org>
References: <179157746908.73485.2343672865542690797@pm.me> <sashiko-outbox-166041@kernel.org>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 97b4da40f43a418c58b48886561281d9e2d8eeff
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Does this short-circuiting && operator cause issues during hibernation?
> [...]
> Since pme_capable is unconditionally false, pci_pwrctrl_power_off_devices=
()
> will force cutting auxiliary power.

That part is right. At poweroff_noirq the devices are in D3hot, the
helper would have reported PME from D3cold, and with this patch a
wake-enabled device loses its power anyway. In v2 I will call the
helper first and ignore only its verdict, not its PME result:

=09if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable) &&
=09    pm_suspend_in_progress())
=09=09return 0;

At freeze_noirq the devices are in D0, so the helper stops at the first
one and pme_capable stays false, which is what the image needs. I ran
this version on the Yoga Slim 7x before writing, and a hibernation with
a power-off resumes as it does with v1.

> wipes endpoint hardware state during the freeze phase, violating the
> core PM contract that thaw operates on preserved hardware state.

The reset between freeze and thaw is real, and it is the price of this
approach. pci_pm_thaw_noirq() returns the device to D0 and restores its
config space before the driver's thaw runs, so that much is covered,
and a driver whose thaw is its resume copes. NVMe did here. A driver
with a lighter thaw that expects the device's own state to be intact
would not.

I did it at freeze because I do not see how to do it at restore. The
image says the clocks, regulators and PHY of the controller are on, so
restore_noirq cannot bring them up without first taking them down, and
that means writing to a PHY that may have no power, the same kind of
access that resets the machine today. If there is a way to do this on
the restore side, or if it belongs in pcie-qcom only, I would rather do
that.

I will hold v2 until a maintainer has had a look.

