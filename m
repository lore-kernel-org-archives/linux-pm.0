Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1843AB0;
	Mon, 21 Sep 2026 03:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962103; cv=pass; b=IdjR4GalhkPKiWSzU1f9yRUOKovJs/neYh68NUH3/IIS5HUovGYD2hoYaRwrd8gmV0nWjT+jn3fT5sBeDF5zITZ+e8mRnqATMnnlZYiIlUASWgcpeMo+2t0v3nmgPH7F0tUsSPqQnKC79XdzjJ4SgtQBKNBR2m+516j7Xd+aM7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962103; c=relaxed/simple;
	bh=ct1Y8laxYTB/3w6Vg9zeWZ4IUgz1j3gsDtqDeWDoQhE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AI8RYqkqMHb/9z4clPe/bldSDgXXNZnKfrfIGdMmDZRJgB5FtqRDsTgmT8QdkwqFnFCI09OeLNl/wwO4o6WwjGZ0R/u3aDxj44afnC8XnaMTtZpdirn2mTGR1QXGTGka2LT/nmRomCWxj9njfBdu5awRTl0i59YHIqSm1aUhVm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=KKyxMWkr; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="KKyxMWkr"
ARC-Seal: i=1; a=rsa-sha256; t=1789962091; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eUpZbo6UGPiXN2S6WVP1wk0hx+PmToMYHyOYTTguBgJ4H9sVslZFlrxBnfQT4mM3Z5AZ7UOy3rZNvo17i3UdqfpsEgNaqu68X0/0JwomkhLkf2qjtxxXiGRxn37yIBJqRx2YqxUALC17XGIE2yqpJRIJ5jxeOc4Nu3E1+uny24o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789962091; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ct1Y8laxYTB/3w6Vg9zeWZ4IUgz1j3gsDtqDeWDoQhE=; 
	b=LlH1IOfz33DnRYAxx9I6GoXSqRBEmqI9o/RsJEmtsUKDnGaWqGJBG906d7dSp2Dj+BzNXlBX47SKvktceUb4Bzku5DCFlQn9RA02jMAwb8sNqFnlQdzNyNDPMBI4QM4pNsCCRKnx6aiBFxkdKiwrp0sPigjFXChVV/AedprbU9Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789962091;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=ct1Y8laxYTB/3w6Vg9zeWZ4IUgz1j3gsDtqDeWDoQhE=;
	b=KKyxMWkr1Oqh8lrvqaWs7m1N6FzlBaoLhknnkzLltncc3AkkgB5WY2M96m6WIter
	mYQMF5NjtFKuGpzN60dP7oDOTxsApCfGkLIJqLFG1nRZk/hDxeqtXJS8ZiYTSCdTslQ
	m2rNeSh56U+5rJfMkxZpQnKZOzu83HvQDklD0/IPXjBGk/xm99NGA3HMl7CWXzC5B3R
	wbMoy4euTn/gbWJYViQdBwhypOZCc/k9a3XHxwL/gWYQUQCAwZNFDLOtFKGmGyb7yHY
	WpJKF0cvTBInpl0ITZfI6jSAncFGxZ+qI7g3Y+FaCzxwtFsWE0MUm995EQvAbc7AlWr
	545ZoCVD/w==
Received: by smtp.zohomail.com with SMTPS id 1789962090652102.41171456130746;
	Sun, 20 Sep 2026 20:41:30 -0700 (PDT)
Message-ID: <e96ddd73ca83f0d8b6f08ff63a14b5f0d1bcee57.camel@icenowy.me>
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
Date: Mon, 21 Sep 2026 11:41:25 +0800
In-Reply-To: <20260921033540-GKG297024@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
	 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
	 <56e5f32102c67575ded8af9e81a06dc9f1dcf0ee.camel@icenowy.me>
	 <20260921033540-GKG297024@kernel.org>
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

=E5=9C=A8 2026-09-21=E4=B8=80=E7=9A=84 03:35 +0000=EF=BC=8CYixun Lan=E5=86=
=99=E9=81=93=EF=BC=9A
> Hi Icenowy,
>=20
> On 20:56 Sun 20 Sep=C2=A0=C2=A0=C2=A0=C2=A0 , Icenowy Zheng wrote:
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
> > This driver is tested to be able to power up the GPU on SpacemiT
> > K3,
> > however the following warning appears in the kernel log:
> >=20
> > ```
> > genpd_provider audio: Fail to power-off domain: 2
> > ```
> >=20
> This is kind of an expected issue, due to hardware design, the audio
> power switch is coupled with rcpu core, which means power off it will
> also shut down the rcpu, so the power switch currently is configured
> as always on from software perspective, it's unable to power-off even
> in Linux or rcpu once system up.
>=20
> I will drop audio power domain control in next version
>=20
> > (BTW I built it as a module to prevent whole kernel being rebuilt)
> >=20
> that's fine

In this case, do you consider to make the Kconfig option in your patch
tristate instead of bool?

Thanks,
Icenowy
