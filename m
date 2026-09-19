Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4B23D297;
	Sat, 19 Sep 2026 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789801072; cv=pass; b=VEClowDxuWg2xOEBaBXxVZ8545/WfvvZxNLxbrs5iCBrYFkcLHJqz7UqgdYGAnZKK11AF4f4BahyMn0Xam8dsNShyZmhDoeNQdmsnHIuwV8S8nYK4+2In4H7oDWQMSIBUo52IAhG7WZV5DBZZJK/EFrCm9NN/MYP56fSbfTSHzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789801072; c=relaxed/simple;
	bh=IdHUg8gZsKG1eK8ddv1bf9KJVpCAWuDGitsqS71bHqY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPAUNhixeE7FaRZK26V6ACHEwRvlBl6km8z6rTgxoAgA8F4bFV6BihzIo/Yym30CWAj1pXZ6rOXxrSzRsM+RhbMNJ70KJVzep+/ghzsvtWuwnsHpBrJsHcM5pQlB/I68eqLfcfoNhydIN1VOUreBdG/TJ5kxVxP0xWzCcDDdOC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=ii9TMd7W; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="ii9TMd7W"
ARC-Seal: i=1; a=rsa-sha256; t=1789801056; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n0F7k2w7VW6EWRhehL503C5goS+g4WXzxQE1Q4WSeMcZ+SQl7TquN8jk00yDaVGfLMt3jcgxPkMCYT6epgtsum8G+FleBEB6sfNASLvZlI7J0xwExrn5RfPKD5Co/m+AJhu3ctQnekwVCx+wbCqWDYXIduZDDmJrGJEczDy3BaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789801056; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IdHUg8gZsKG1eK8ddv1bf9KJVpCAWuDGitsqS71bHqY=; 
	b=ThHCOdSDW8ZX5mkA+xL47/XC7XYpL4AAmOIDWiiFybZoQzXC/GpScqKEh2XcyEIMR0NLnEnzajJvO0datpLfesDwUZCjZuQLA3Xg5cTF7J8ATHEq+0CqcPOLnUOf+FUauSwN1ZTPd977GgONqIN2kLTvC5mtK0qqkpA/JP5G0no=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789801056;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=IdHUg8gZsKG1eK8ddv1bf9KJVpCAWuDGitsqS71bHqY=;
	b=ii9TMd7W+t3husvchZhqJ+OsMxmnNSPDkkHH35pmcrXxz1jtG0VBgw04RG/CPffG
	EtF2EUDlWt3+eSLSRsK3pfz3Lkaci+ytI9aJnRMgVa+r5CyreYK3T15dNet90fxsrMG
	47vnjaI8QVajUlMYCIPGILNj66aJMJmxYjHTJ9UwPF5CWP8QKkvDcnbdW/vF1XFxQC2
	x8zMxNuZl6a3gN/eFMXGhbexkCAIqx0fAYFeLlvJHEdGmzmFw5y4w1H5ZBv2G9lp5n2
	7UNQEErodd2Q9XoQdKxbVI+i/M62M1htkrjo3VQK2FN0DRgZOz2kS4Wsrj6zNNuZPW/
	vy0rGsNWbg==
Received: by smtp.zohomail.com with SMTPS id 1789801054439855.651129720259;
	Fri, 18 Sep 2026 23:57:34 -0700 (PDT)
Message-ID: <33b33b2b79763d410bc2e5b4ef46c305aaf6f7c8.camel@icenowy.me>
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
From: Icenowy Zheng <uwu@icenowy.me>
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Date: Sat, 19 Sep 2026 14:57:28 +0800
In-Reply-To: <20260918230107-GKC297024@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
	 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
	 <a4359efeee2220903a05a2383a651ec8ec7284b7.camel@icenowy.me>
	 <20260918230107-GKC297024@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2026-09-18=E4=BA=94=E7=9A=84 23:01 +0000=EF=BC=8CYixun Lan=E5=86=
=99=E9=81=93=EF=BC=9A
> Hi Icenowy,=20
>=20
> On 17:00 Fri 18 Sep=C2=A0=C2=A0=C2=A0=C2=A0 , Icenowy Zheng wrote:
> > =E5=9C=A8 2026-09-18=E4=BA=94=E7=9A=84 02:40 +0000=EF=BC=8CYixun Lan=E5=
=86=99=E9=81=93=EF=BC=9A
> > > =C2=A0 SpacemiT's PMU (Power Management Unit) consist of several powe=
r
> > > domains
> > > which can be managed independently, depending on different
> > > application
> > > scenario, each domain can be powered on/off for saving power.
> > >=20
> > > =C2=A0 The driver is implemented based on Linux Generic PM Domain
> > > framework.
> > > From a hardware perspective, either of two distinct power-on
> > > sequences
> > > are supported, in software mode (SW mode), the driver is
> > > responsible
> > > for
> > > controlling the states of bits such as sleep1, sleep2, isolation
> > > and
> > > pwr_state, while in hardware mode (HW mode), the PMU hardware
> > > will
> > > complete
> > > the sequence automatically without requiring software
> > > intervention.
> >=20
> > I think there also exists solutions for K3 that uses RPMI power
> > domains, and let their ESOS firmware to access the hardware.
> >=20
> Yes, I'm aware of that
>=20
> > What's the relationship of this implementation with the ESOS
> > implementation? Should the ESOS part be disabled to use this
> > implementation?
> >=20
> I should say, it's a mutually exclusive solution, so yes, the ESOS
> part
> should be disabled in order to use this version
>=20
> The motivation of this patch is trying to support drm/display
> driver's
> PM requirement, while avoid going with vendor's complicated RPMI
> solution
> which isn't mainline ready

Is this a long-term solution, or a temporary one?

If it's a temporary conflicting one, I don't think it's worth picking
at all.

Thanks,
Icenowy

