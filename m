Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140856;
	b=ckDbCFriktCgO9e3hB4XHphwkYNZ4x1fn1XsPvjqCji7muApmvbYWJGrUMu33JM8PIRm
	 rkMivl+AxPyOMgMJlbicrT+lbo4VRPOm1DPKplC+sMambqYoQHz8ZKKcBUyWetf1cRYeu
	 KqjqosttiVsnHUaYSeT15rOOo9Wv9Yzcnj8Efs71Py2MkI65/616klUftp0T+XmtH5qG7
	 aJXmFqNCTj6VZnq/bgQyf6fzBYtmUxr89PhCSx8Duef2VmM3+/0sWCCm1AsSN/KGC8zhn
	 So8b0MWZfI98hsBeXVAD1imSzPhth8OpKTRr/aVp0JcpZtLwmGWjXmzK/Pwyi6hREHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140856;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=22Rzk6jQbC4L0N68Dcfos841pyMRoC1pkyU1FbZfLp4=;
	b=wfyYE9i1TrhRTXr7WbSZST9wnvZk4/c8yExLD/s+VYLyIF5ygjViB08QEuKLRJXBrMUq
	 mD+sjO9K0TO6xVsCDp9pnTpNiA8DhmAq/QVNaDb/f1RhvNhULVqKiitZbHGTbbZJ/Rxed
	 vh1yqfcN1KbNKSPFytI2a4EndSE5MMkfp1NCh6meuJUntFUWSbLFHr2wdtgQFrsFwImfk
	 0+K+dvcqF9rSXhtK1VpPefkFrLa+J1g6EbxPYtmnzseBvcqbdyfB0PuQKwGKpnI4OtjoF
	 aTItn2eIDbdziEFvDVlqTSndEpwpg3rFxVrJ7fVEBR+evqetPlDm1RblSBDpBKvmLnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=NsmCa2B1;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B32606A31A;
	Tue, 27 Oct 2026 22:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B32606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=NsmCa2B1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=22Rzk6jQbC4L0N68Dcfos841pyMRoC1pkyU1FbZfLp4=; b=NsmCa2B1j0WdarKn94uha7zOPI
	Tzv6VxzFHc9ogPPJqrRrgY4DOZJfpoXpLYU0xX2/B8jHvmfgVFDdSoXHiHtFm8RvHhG/3E2gQ29Vf
	GOT0xvdNFc7aV5HrBPFYzM7VJdMw4LTdNMXxLC8Giu0GERV6hctYmHec4JZtG+yq4SXZzi8I41W+g
	4hTHcmGVvA6BRdJaKIs6eAEz/PSAmJGDw3pjPnOHMWw08gSnzKPdF9tVQ0reWEq2Z6MQxq+OcRIOz
	nG4yup/oL/GNnC8MhF7nItCK6jkUgEksxYd/WwQJaGYZVHR18kQ0MRxVhKKA8hDCiHwKDNeCFSiZF
	agzxIH4w==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: linux-pm@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 maccraft123mc@gmail.com, zhangqing@rock-chips.com, zyw@rock-chips.com,
 sre@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lee@kernel.org, Zetarancio <zetarancio@users.noreply.github.com>
Subject:
 Re: [PATCH 4/5] dt-bindings: power: supply: rk817-charger: Add
 rockchip,gate-function-disable
Date: Tue, 27 Oct 2026 23:40:46 +0100
Message-ID: <2849967.uZKlY2gecq@diego>
In-Reply-To:
 <PH0PR19MB997338FA74EFF7CD338356EB88A5602@PH0PR19MB997338.namprd19.prod.outlook.com>
References:
 <20261026174834.1652309-1-macroalpha82@gmail.com> <15875856.JCcGWNJJiE@diego>
 <PH0PR19MB997338FA74EFF7CD338356EB88A5602@PH0PR19MB997338.namprd19.prod.outlook.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 27. Oktober 2026, 16:53:10 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Chris Morgan:
> On Mon, Oct 26, 2026 at 08:23:40PM +0100, Heiko St=C3=BCbner wrote:
> > Hi Chris,
> >=20
> > Am Montag, 26. Oktober 2026, 18:48:33 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Chris Morgan:
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > >=20
> > > Add a boolean attribute for the rk817-charger to control whether or n=
ot
> > > the system power is shutdown in battery off mode. The BSP kernel sets
> > > this value unless a device-tree attribute is present, and this attrib=
ute
> > > is to replicate that behavior.
> >=20
> > Devicetree is supposed to describe the hardware, so your description ne=
eds
> > to describe the per-board property this represents.
> >=20
> > Just because it's in a vendor-BSP is generally not enough justification=
 :-) .
> >=20
> > This is especially true as you wrote in the cover-letter that no known
> > board actually needs this right now.
> >=20
> >=20
> > Heiko
>=20
> The datasheet describes this as "Whether the system voltage can be
> shutdown in Bat_off mode" and the register itself is described as
> SYS_CAN_SD. Maybe call it "rockchip,can-shutdown-bat-off"? Or given the
> fact that I'm not aware of any boards that would need it today, should
> I even bother with adding the devicetree override? The only reason I
> am adding it is in case this "fix" introduces a regression it will
> allow someone to set this flag, just like the BSP does.

=46irst of all, I guess defining the terms better would be helpful, i.e.
I don't know what that "battery off" mode is plus the whole enviroment
this happens in.

Secondly, this new flag would cause a regression, because a board needing
the old way would need to add that flag. But when a board actually
requiring this turns up with an older devicetree without that new flag
this breaks backwards compatiblity.

So if we have a function flag for the pmic, it would need to be the other
way around.

As you said this is specific to battery powered devices, of which we don't
have that many - especially in-tree. Can you maybe look in the vendor-tree
if any board actually uses that?


Heiko


