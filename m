Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F73BE638;
	Sat, 19 Sep 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789811981; cv=none; b=fSV6+G/L0oXlbCLr5gDE6hH18XXFHYolxnjjV84mHCG31W0QppP88l0vQUa3Osdtnpm15fozNVecdODuWUF0naTZZuCOLh/uFjUtyp+7lxyqsccUw1ESf2OUYWYFz7cZz/ZMIxjwceQamXziGHxNC6RAu+Pq2nCDQbSbbafKDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789811981; c=relaxed/simple;
	bh=ssNEyxGXQkQs0rNaotxOxorm+VIKeLoll2fzgjI1lpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7LEgrtQVx/3kXxjm5rz91E6h711xZTOCWcEkDTFgkqgjGTGkpnbCQII6JvMPDd1jIvNBixYAcsBH/8zT6HuYDYuFhIYzAuf8xBjZKgG9iqJ/wfD0ICEyL7tiWJYLL3UpUdG7Y+tzbulJ1i5JpW8Qbhq/wUBMncJVbVyUxKWVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S94yuSIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S94yuSIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7001F000FF;
	Sat, 19 Sep 2026 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789811979;
	bh=/juClfc4zjT8s6+Co2KTVBIDitHQE/UNTvknaxZvdOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S94yuSIUbbRQq28E4TYRleHABaLUUTRhLwQH2EtuoP9MYA9wsvlhSoauVUCUjXbCI
	 VjNnHRaPzNiwD3CxTtVH87PEPbRQgUHutJBuunGsRT9EWCAZ+H2z1RNBSz+tZ5vVUN
	 nFesC2vONliha9KN9j0Iaf1FubzEEHpRxH9GDxOfAhoGaqbcxnmQ9i2UAUh8lRfsiR
	 yQhQqs0ddj4bauxUA87ii9I0JmEDTzBTaMqiliBY/cixpZuG9TsU6SlgEgBzV68Qou
	 0L2XBtzs9SIhC8+7adEM2nBi2aZAZxwGcqVGnLxxZnMX3Mafzsp0uLKyh5lGCYaBEy
	 ksIvHim59WWwQ==
Date: Sat, 19 Sep 2026 09:59:36 +0000
From: Yixun Lan <dlan@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
Message-ID: <20260919095936-GKA322102@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
 <a4359efeee2220903a05a2383a651ec8ec7284b7.camel@icenowy.me>
 <20260918230107-GKC297024@kernel.org>
 <33b33b2b79763d410bc2e5b4ef46c305aaf6f7c8.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33b33b2b79763d410bc2e5b4ef46c305aaf6f7c8.camel@icenowy.me>

Hi Icenowy,

On 14:57 Sat 19 Sep     , Icenowy Zheng wrote:
> 在 2026-09-18五的 23:01 +0000，Yixun Lan写道：
> > Hi Icenowy, 
> > 
> > On 17:00 Fri 18 Sep     , Icenowy Zheng wrote:
> > > 在 2026-09-18五的 02:40 +0000，Yixun Lan写道：
> > > >   SpacemiT's PMU (Power Management Unit) consist of several power
> > > > domains
> > > > which can be managed independently, depending on different
> > > > application
> > > > scenario, each domain can be powered on/off for saving power.
> > > > 
> > > >   The driver is implemented based on Linux Generic PM Domain
> > > > framework.
> > > > From a hardware perspective, either of two distinct power-on
> > > > sequences
> > > > are supported, in software mode (SW mode), the driver is
> > > > responsible
> > > > for
> > > > controlling the states of bits such as sleep1, sleep2, isolation
> > > > and
> > > > pwr_state, while in hardware mode (HW mode), the PMU hardware
> > > > will
> > > > complete
> > > > the sequence automatically without requiring software
> > > > intervention.
> > > 
> > > I think there also exists solutions for K3 that uses RPMI power
> > > domains, and let their ESOS firmware to access the hardware.
> > > 
> > Yes, I'm aware of that
> > 
> > > What's the relationship of this implementation with the ESOS
> > > implementation? Should the ESOS part be disabled to use this
> > > implementation?
> > > 
> > I should say, it's a mutually exclusive solution, so yes, the ESOS
> > part
> > should be disabled in order to use this version
> > 
> > The motivation of this patch is trying to support drm/display
> > driver's
> > PM requirement, while avoid going with vendor's complicated RPMI
> > solution
> > which isn't mainline ready
> 
> Is this a long-term solution, or a temporary one?
> 
For upstream, I'd say we probably will stick to this solution for
long time, won't say it 'forever', see comment below..

> If it's a temporary conflicting one, I don't think it's worth picking
> at all.
> 
Well, checked current Linux kernel status, there is no RPMI PM solution 
implemented although there is documentation in riscv-rpmi spec[1]

On the other hand, I see no problem to switch to RPMI solution once it
became mature, it's very similar to two solution of clock CLK_CCU vs CLK_RPMI.. 

Link: https://github.com/riscv-non-isa/riscv-rpmi/blob/main/src/srvgrp-device-power.adoc [1]
-- 
Yixun Lan (dlan)
