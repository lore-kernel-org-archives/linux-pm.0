Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B542D777;
	Fri,  7 Aug 2026 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099013; cv=none; b=KdavyqCXEJIjy1M4op4CVP0nLOF+FEk6eKYFLSdG3ZBqCyaVP1jLUUttUlt6ZFwCrtnD8HbURY7Zj3ESjdFKDl/WDBdhzuzcOeR+nFNUyUosvMtuMrqJ0zkf6+I8GaZdaiPepIAqUFo2QiVylv5CPOVWsliLA/TCAt5TlSCGIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099013; c=relaxed/simple;
	bh=MA8tGMGXrwHcXlwOTOPvyb9m4xBzGAvwD4AEB5gK0ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC/KbS1azebUL9IQmlKHs/osiZCtjV+TGwrY82DBTeH0HtJsDdJoDnpmYZGHw5QSizxm7CNWycxoCniOtVM5B5xLnXYNGoXjxsyEreFoP8RpvH3Yoz/hPSYk2Y+6SKA+7Xe3vUy9iBaNXbWF5avLNtEWoJstPo4LscIVCg4cHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=OOcpDe/t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CpRsfHIl; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="OOcpDe/t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CpRsfHIl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CE4CDEC0139;
	Fri,  7 Aug 2026 06:36:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 07 Aug 2026 06:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786099007;
	 x=1786185407; bh=kv5Gw0RyssW0l4PPEmycjQlZWXkmi9/Opd01nGEEwxQ=; b=
	OOcpDe/t+T6tjrOBLNk2nRrww6MOjJ5bzxqhrh/T11ALQ+jc8Q+n026Z3wwHNxM1
	JJ6np98IKMWgrsfWw+XDx9iHwNvf4lyZ4hn2zRrqyovCEc4WojZgGwK7lVHOvnCI
	wRsS1QQvuQl/loEj/LK1sPcAJMwi+x28v1Ox5LMk6qtCRldHxJdA2J740F8wLmPE
	ZrFdDULdYep6V3wHM42wkD+ygVQp6HxKrrBkF08cgC2IGQB1gxWRdFsaFPuxpJn7
	JTUniFDd0+YvJBpg9Z/c5tawwWuSVfzo2zf1m1PSIn+ZLaTB7tPvvFvTzXQmfOYJ
	COiyIOugqfLf8DoN3fyGzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786099007; x=
	1786185407; bh=kv5Gw0RyssW0l4PPEmycjQlZWXkmi9/Opd01nGEEwxQ=; b=C
	pRsfHIl1DGEjLHCei6Dd8k1QM2hjNsTQln7Bno4sYaIEnIDXjWLLvwdIM5ke/AZO
	AjLRGbZeJDyq9qbiBqAC9WhX9idVqrTFyLSa2ztIONCdSMDSlgZ9t/l2z3O6ziMZ
	mW3MasfjOSjYN3Xbc54zVByocBg0V/y8vTSStYeZZ7a5IbBlw21KRE+IX1SRIGWI
	NFaZMwTEJswuqI/XwVAj0NsvfVcPz0YwStCckQeVRtnaG61FznwKn1lJCq8/z4xH
	Z2kUi6xOZXHPaQYbHGJduPHfZFdJyLyCRQJi24/B4x8eE9+T8+QQWWL8UmpbMfgo
	IDYlT1yVxcOzB8ElsBo0w==
X-ME-Sender: <xms:P7V1ai568EfOt7a-83H6ohJ9I3i3k7_yf9KZSZeemofjjlor31KPBA>
    <xme:P7V1asXMO2meg7UQfZvozI5dyLKqMFtU1Nmqt480TlRQ9xN0QDLXr3Jjg5MXCv83R
    7nLZfO8rEG72OaxQnTPLn4_o8iVM9dOW8Tz0U5NCdfWSAGnaUV2qfw5>
X-ME-Received: <xmr:P7V1ahOe7oQrAJGi3U_KhJt3SFrH2dqJ7wyqhgMPOBGFkzRQ4pPx41s1A9d7baQUKeI3pRBRXmbW0aLr2OI_Cp-0b0UuBaU>
X-ME-Proxy-Cause: dmFkZTFci/dH1JCbv9AfP7TRe8QxwtPwefa5BCWgd28SMx0En1COK20QOjwoQor74t1EWW
    gwnGVqCL5CcS7Zumte3pJlJZCxJBIeJPZVwVrDZwe0sDMm+NxFy7v1h6s991Mrw+2wRBXy
    a9Gu/0+N+OeW3YPUkzWhivgDddkA5XFZzoClYart8KLaecRTt9l9eCUPYrmQI4w9Rc6PqU
    OHdXT/nxP3tNMNlsaOFmYyNWVBHJhndqR6/uoCIkW8z+F/IRA2t1G1T0eMyyelowla3OC5
    X7z9/PpfkB9TbbW/Olq+BktktK8FmFeM+2Usbz3WmpL1dGGvMnyLd7GftWE8t7kk53PcbL
    /gSw8GmujsNceOZQws4jsjTQ4t9rZ7Wq9lJVU4KLGNQsOYkgQ0kT8EqcsbbR1NDvJXffyY
    rpO6BemIwmZY4HgB4qb9EQm0Spk1cgxRGUSMIiVc/rpZmuIKTewL+Qhtb4J5FTZzYmEuvH
    BBBe/tCNedffPYKMfC9Y1EmkYIIc5aHarLf6+YkI75sRXMhbj/4bSpN9me+NcqqUmhGWdd
    BxkXxgUwvugxF5CMW7yhNTNic3eeg1THsvTcvxvvR/MX52ienZ7jZ0WsxfNx5qY4wAmW1U
    +dbDPNA0bADX2SqlwuZ2iqtPhzW/SK1LIwVxmlqcLxqpgCzW1volA0owotgg
X-ME-Proxy: <xmx:P7V1argvtIXsd8r-Pq3JhjETKsnxZmZhTMwJHmapF3ywKdr6v5-mEQ>
    <xmx:P7V1av6r4nhDCoLl1G2QBqMmFfuOxrUDUvmROePkXX8_bPkl0_OKpw>
    <xmx:P7V1aqfO5KRUbP8S-AKbDI52mwLT32-7hBbiMyf9sZsdfCRREnRQrg>
    <xmx:P7V1agCPWy9raK0hQbBufAR3RBHTpAg87TxcV7EdY7DdyiX9tvWbCg>
    <xmx:P7V1ahtue3FFqClKrDJF26gWePhBZhspkMOkY9BNSWtXmob_k40BwWfn>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 06:36:46 -0400 (EDT)
Date: Fri, 7 Aug 2026 12:36:45 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	rafael@kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] thermal/drivers/rcar_gen3: Handle -ENXIO from
 optional IRQ lookup
Message-ID: <20260807103645.GE1316230@ragnatech.se>
References: <20260807093058.42840-1-phucduc.bui@gmail.com>
 <CAMuHMdWJ3W2JKmxaKaa-A-Zk633cf4UwbESi+F1_h4tX1AhRng@mail.gmail.com>
 <CAABR9nF7sAT4C+W_qE8GVKhrtTjdm=DcpJH548RzFaYLuED+3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABR9nF7sAT4C+W_qE8GVKhrtTjdm=DcpJH548RzFaYLuED+3A@mail.gmail.com>

On 2026-08-07 17:11:44 +0700, Bui Duc Phuc wrote:
> Hi Geert,
> 
> Thank you for your feedback.
> 
> > >                 irq = platform_get_irq_optional(pdev, i);
> > > -               if (irq < 0)
> > > +               if (irq < 0 && irq != -ENXIO)
> > >                         return irq;
> > >
> >
> > So the code may continue using -ENXIO as an interrupt number (and fail)?
> >
> 
> Yes, you are right. We should probably handle it similarly to:
> https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/thermal/renesas/rcar_thermal.c#L422
> and only assign the IRQ when the return value is positive:
> if (ret > 0)
>    irq = ret;
> 
> > Why is this change needed at all?
> > The caller of rcar_gen3_thermal_request_irqs() knows how to handle
> > failures, as IRQs are optional.
> >
> 
> Regarding the caller, I only found rcar_gen3_thermal_request_irqs()
> being called here:
> https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/thermal/renesas/rcar_gen3_thermal.c#L530
> It does not appear to handle the error return there, so I don't think
> the caller currently handles these failures explicitly.

Yes it does. If it can't get the optional interrupts the driver does not 
support setting trip-points in hardware. No?

> 
> Best regards,
> Phuc

-- 
Kind Regards,
Niklas Söderlund
