Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E778F2B;
	Sat, 19 Sep 2026 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789826195; cv=pass; b=bEZnB6+ZzFtK/xoGlYCWaPWSdroZbRY8m3rjlR1RqDmdtPmOdigBrvDhysWDpTOZE7dwSlJYLk8+weuGVnLtHBhmEDuyATPYv92IKdiPU308nYODybk84Zs+SYVMPuTa+UXkmrPw6Ir0Vhc1tHuZMR57fUwiZe4kJkBLMLthvfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789826195; c=relaxed/simple;
	bh=yhX14Zjrs1T1LKc/UQ3XM5yVsTmDWG/q39PuOw4fZkw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MXReRyciGZaeMTnWzbjgo9h6HYnL4zMPpALLRky8cg3cQVKFQ2yHUyjs6DsOSxiu8/HBohUb9PwNGCIbbsClIlYTj/EtiJPMh8z3Tw9fYPy9n2SD4ooZONdNcH3QuZ4C8nB3UpSQKD4+ZLRnq01raL8V8/7RsFavFkzesJ62xBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=e8k+DUqK; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="e8k+DUqK"
ARC-Seal: i=1; a=rsa-sha256; t=1789826181; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lxJtI0f5J52eBI0jkXF+fCjjktZihnJal+2wxXAFeJeMr7hA4MNnFTo6o7kTkRNxQ9sqToreVpEPJMb6lDHMXWiWt/Sn5mBpdBc1J3gk9PEdZSjUnBDNXPKWHqFzKw9omeR5d/bUaRiFN5/hABtXZ21lbuaepN05CPHYQk65/9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789826181; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yhX14Zjrs1T1LKc/UQ3XM5yVsTmDWG/q39PuOw4fZkw=; 
	b=Ni5XsT26yJfRAbsYM5mTkdiCmtEN0MPSyQgGGYkdqtjQGGnc21MbM+O/BVfJ3jYagernbGAQeD5YURO+kitKwVeKiAdJOWWxpUWNo0BSW+8gwsx6A+7EjkikN+lXDdsHV+sOMpr3r5h6Bo0wRXt5s3mFiZ8tvVdKSL1M8n5IrQA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789826181;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=yhX14Zjrs1T1LKc/UQ3XM5yVsTmDWG/q39PuOw4fZkw=;
	b=e8k+DUqK8L0f/XjRqQOdi0HQ/UI5S1Gu7O3c6Lg1eNJdymP25Cp1kkckNIXJ4pr1
	qQueD0jICa932JYSArNLhRFepAzNl6pGdZTXd3w6qJMMSm78hNB94PTGtRILf0Ca2WW
	6Vs7//Uin5WcuhlDsPpYPyp4iteilNXakZ5/Tq/wyJL1wjJl0K9NoM0w2PRem4k8kYg
	Jd04Owgb8RpA96d6og4yDllg9edyQhblplh/pBgVE0Q9/B1Qvio9RdwKVhrUGVSpZGY
	AfLA55XW4Ak/PiTIhfoHKjyxKa5zdkMrzrYRe4/laVg/IN4ov9FipAwjd6YPLxBdP45
	ZL2yKzRZRA==
Received: by smtp.zohomail.com with SMTPS id 1789826179625358.0297920384029;
	Sat, 19 Sep 2026 06:56:19 -0700 (PDT)
Message-ID: <8301abce221e33d827053c54a64aed05f3227f7f.camel@icenowy.me>
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
Date: Sat, 19 Sep 2026 21:56:12 +0800
In-Reply-To: <20260919095936-GKA322102@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
	 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
	 <a4359efeee2220903a05a2383a651ec8ec7284b7.camel@icenowy.me>
	 <20260918230107-GKC297024@kernel.org>
	 <33b33b2b79763d410bc2e5b4ef46c305aaf6f7c8.camel@icenowy.me>
	 <20260919095936-GKA322102@kernel.org>
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

=E5=9C=A8 2026-09-19=E5=85=AD=E7=9A=84 09:59 +0000=EF=BC=8CYixun Lan=E5=86=
=99=E9=81=93=EF=BC=9A
> Hi Icenowy,
>=20
> On 14:57 Sat 19 Sep=C2=A0=C2=A0=C2=A0=C2=A0 , Icenowy Zheng wrote:
> > =E5=9C=A8 2026-09-18=E4=BA=94=E7=9A=84 23:01 +0000=EF=BC=8CYixun Lan=E5=
=86=99=E9=81=93=EF=BC=9A
> > > Hi Icenowy,=20
> > >=20
> > > On 17:00 Fri 18 Sep=C2=A0=C2=A0=C2=A0=C2=A0 , Icenowy Zheng wrote:
> > > > =E5=9C=A8 2026-09-18=E4=BA=94=E7=9A=84 02:40 +0000=EF=BC=8CYixun La=
n=E5=86=99=E9=81=93=EF=BC=9A
> > > > > =C2=A0 SpacemiT's PMU (Power Management Unit) consist of several
> > > > > power
> > > > > domains
> > > > > which can be managed independently, depending on different
> > > > > application
> > > > > scenario, each domain can be powered on/off for saving power.
> > > > >=20
> > > > > =C2=A0 The driver is implemented based on Linux Generic PM Domain
> > > > > framework.
> > > > > From a hardware perspective, either of two distinct power-on
> > > > > sequences
> > > > > are supported, in software mode (SW mode), the driver is
> > > > > responsible
> > > > > for
> > > > > controlling the states of bits such as sleep1, sleep2,
> > > > > isolation
> > > > > and
> > > > > pwr_state, while in hardware mode (HW mode), the PMU hardware
> > > > > will
> > > > > complete
> > > > > the sequence automatically without requiring software
> > > > > intervention.
> > > >=20
> > > > I think there also exists solutions for K3 that uses RPMI power
> > > > domains, and let their ESOS firmware to access the hardware.
> > > >=20
> > > Yes, I'm aware of that
> > >=20
> > > > What's the relationship of this implementation with the ESOS
> > > > implementation? Should the ESOS part be disabled to use this
> > > > implementation?
> > > >=20
> > > I should say, it's a mutually exclusive solution, so yes, the
> > > ESOS
> > > part
> > > should be disabled in order to use this version
> > >=20
> > > The motivation of this patch is trying to support drm/display
> > > driver's
> > > PM requirement, while avoid going with vendor's complicated RPMI
> > > solution
> > > which isn't mainline ready
> >=20
> > Is this a long-term solution, or a temporary one?
> >=20
> For upstream, I'd say we probably will stick to this solution for
> long time, won't say it 'forever', see comment below..
>=20
> > If it's a temporary conflicting one, I don't think it's worth
> > picking
> > at all.
> >=20
> Well, checked current Linux kernel status, there is no RPMI PM
> solution=20
> implemented although there is documentation in riscv-rpmi spec[1]

I have seen pending patch for it with multiple revisions [1], the dt
binding is even already ACKed by Conor, so I think it's not a big
problem here.

Thanks,
Icenowy

[1] 20260903092347.620060-1-joshua.yeong@starfivetech.com

>=20
> On the other hand, I see no problem to switch to RPMI solution once
> it
> became mature, it's very similar to two solution of clock CLK_CCU vs
> CLK_RPMI..=20
>=20
> Link:
> https://github.com/riscv-non-isa/riscv-rpmi/blob/main/src/srvgrp-device-p=
ower.adoc
> =C2=A0[1]
