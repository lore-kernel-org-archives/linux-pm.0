Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709033;
	b=dkVsG+L0fjTypQT9LW/FtsyTkUwRQwQ1b8nHPW/UWiW1OhoCWMCGSN/XxGhXmz/cSatW
	 /m8NNeBc+9lKdIWsNWuYkEjCbhXsfSLTLemZo9xWEr03fo7kccipWfUDy19BxO499HtfB
	 ib6uNWAnq+ZA/7ScBG2+8uB0P/aEoJQa6ViU2e5xk9RFysSQ+XmNPyN/f00AY6jRzRbts
	 wNyrT2mT7Pz5WBSomKImcavl2sglGYLftpuo497M44F0j6cQGZcZQVgunsFNgHjNgRa9e
	 Cy8p7TK86Lx2tNp984cKNU11JHBxKCzNCQVbk+sxUQ/U4emMFEwF7WecYQuEspZSeUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709033;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=SeGJXFDra7qt2XaXiZZRyUSJ/hoqsJ5EGUFXiQMsRhA=;
	b=hz5JOelEq83zyqDdqkRUsQ/NXP0F+BZT46wI87TZONjL5m1KH51HFO4q0+UNhgMEVyWL
	 UUm8lbkIgECCaAS8W71ylWCN7bLpND0EoR8G7wCvyBHSgR0afX015f+xtcDA1vWbeJEW6
	 e6eKFJ2Ln/22lGhBzxemd5E07AWOTpToL9EMuy/iCCcAada8XrR67Xf276k9SIBjofk4p
	 KDT1662+7bwCvKTV2y+R81+XVMkCRHMfo4wI6XTIDXEkHIGYEV/fSFPo4wdgmQBQxphWo
	 ohTXRHX7zaZNvIrXFe3R3Ab/7G/AgcoqUX13VwMDsc0M+1iukPEq2VJp0cZE8k+vE+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SX/q+q2q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3EE606A31C;
	Thu, 26 Nov 2026 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SX/q+q2q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CD21F000C6;
	Thu, 26 Nov 2026 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709032;
	bh=SeGJXFDra7qt2XaXiZZRyUSJ/hoqsJ5EGUFXiQMsRhA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=SX/q+q2qRHngQc0aqyzJWZ3k1w6IwSvAPKt5KY+2dxgyhF8uBNBgPuirQje/EobS9
	 DGSBRaKr3/PA3Za2X/wisfGdCduUkPW3gNGzoaDzDvAoYHfk8A8mhAmyX0pMdAK4HN
	 UZ6tppO6WchfgienhUKTxsewmtDMOcVmxSwLkHw6M55mNACoFf/liQ/c36IhSvYPJi
	 I4+HkJvkqmh2CRduCGxAPFmpk2eaBVmj0xJdrEMBV7xYHpYrrFTMtD9JuQVWJks8af
	 uPRBnDSKgb0BS8SvkRoykkONj4/AZ3afaSuI4xNsfRkbmQq8fCt26WOh/ZKX1xqlpq
	 lrlpsGMEK0L4Q==
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 17:03:48 +0100
Message-Id: <DN59Q36YML41.3A4ZDCDQ69O9C@kernel.org>
Subject: Re: [PATCH 2/2] driver core: platform: Allow drivers to skip PM
 domain power-on at probe
Cc: "Beleswar Padhi" <b-padhi@ti.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <johan@kernel.org>, <pavel@kernel.org>,
 <lenb@kernel.org>, <ulfh@kernel.org>, <sid9.karanam@gmail.com>,
 <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
To: "Ulf Hansson" <ulf.hansson@oss.qualcomm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261123084218.673382-1-b-padhi@ti.com>
 <20261123084218.673382-3-b-padhi@ti.com>
 <CAPx+jO9LhihGLHYSFR4Wd8GhOu_AC7tE49OJxrVEVAJyEDHhiw@mail.gmail.com>
In-Reply-To: <CAPx+jO9LhihGLHYSFR4Wd8GhOu_AC7tE49OJxrVEVAJyEDHhiw@mail.gmail.com>

On Wed Nov 25, 2026 at 4:28 PM CET, Ulf Hansson wrote:
> On Mon, Nov 23, 2026 at 9:43=E2=80=AFAM Beleswar Padhi <b-padhi@ti.com> w=
rote:
>> diff --git a/include/linux/platform_device.h b/include/linux/platform_de=
vice.h
>> index 3bd0f1f0d8704..4d1679c4ea78e 100644
>> --- a/include/linux/platform_device.h
>> +++ b/include/linux/platform_device.h
>> @@ -292,6 +292,14 @@ struct platform_driver {
>>          * to setup and manage their own I/O address space.
>>          */
>>         bool driver_managed_dma;
>> +       /*
>> +        * By default the PM domain of a platform device is powered on b=
efore
>> +        * the driver's probe is invoked. Drivers that need to configure=
 the
>> +        * device (e.g. hold it in reset) before its PM domain can be po=
wered
>> +        * on must set this flag, and are then responsible for powering =
on the
>> +        * PM domain themselves.
>> +        */
>
> I would appreciate it if we could be more to the point. We should not
> need an entire book to explain what one variable is for. :-)

Hm...to me the comment seems reasonable. What do you suggest instead?

>> +       bool pm_domain_no_power_on;
>>  };
