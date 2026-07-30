Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466339CCE5;
	Thu, 30 Jul 2026 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454893; cv=pass; b=D9HJJ8eQD0gT0d8HIWX6Q8h9KnHSTtPBdS5kRKJjRY5W1nWmLm+9TSkak9HaItFK2H2CZ/2wzrFPu+IpMii0VjNkYCWBU9vr35VY4QqJHkxXOKo5cLFnkEEG3xRhgUHDiLgme1o4NcZKi4Nxn3k5qaAlc23fo1PipzofjKDqjMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454893; c=relaxed/simple;
	bh=oLQYuKE38jcgsS5ThDcoHsNvKTIaz5l9N4F1A1H9Gxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEfSdIxz0AEge9xp4MUfVJbiHNG6zRqDTSe9pK+DQlnwzRb1/+N56Ww83D+CX29HVnFyW8iD2wIVnam0ncZJKhVIYItUDvB0Wc3R+bqWYEk7AANl4AeU4fqpprSu1Gs5q/SYwMH8PSe0aKnpFJXulu5b3C0y+qbbn7xhxfekOsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=P+KWYH6L; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="P+KWYH6L"
ARC-Seal: i=1; a=rsa-sha256; t=1785454882; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BGA/cuKZ/NObUsRq8y5EYv7ngn9TCbAPQCIC5gHafbdgxIucCgI3vpD8ZFO2FxWXASCREtL87aWF9qq46X+qawvPwOhYC2JJ9VxSqLwu5P2x5WnL7JnQQLwhxvnzvNboD2/Rpo/KYdj6ada0sbmnUBzgkpjLuXSxspcP6ehWu5M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785454882; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9TvsT4PTpzXggBCoMy4275PD5lLUjt4C3WtoHynNpQ0=; 
	b=W8ZMuRPc1rsn6WY86AJ++Bn21Vp8WmsMkouUge3ZzzoIIi+3I9X0KOYDn1EutKOdiPLo4UpRgXaW07ZjCfAx/od/JMv6AImxjXo2Fmbxe8sJPjOYdah84GLvXjfcj++4169qzW62yXjPjZGl4OJXGP4E3mcAuYGRl8Kq8a4ShvQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785454881;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=9TvsT4PTpzXggBCoMy4275PD5lLUjt4C3WtoHynNpQ0=;
	b=P+KWYH6LbSCN1hGW5lBHMRcFVGX+8VZsIUrHSAC6x4+VxDsWxzAMsgyJnJk/KskN
	rzekm/5CoEqLpTxwtyO1p2bOdQEgFxUmzw8z/wem4XQ1uO5JmcRq54jgXfsu7wRekUz
	rhGlODoFO4E+WTIkhCZesKnywIVK/imntV1TBxkU=
Received: by mx.zohomail.com with SMTPS id 1785454879855104.59399258235612;
	Thu, 30 Jul 2026 16:41:19 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 1CAC818029A; Fri, 31 Jul 2026 01:41:17 +0200 (CEST)
Date: Fri, 31 Jul 2026 01:41:17 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: pali@kernel.org, Hongyan Xu <getshell@seu.edu.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] power: supply: isp1704_charger: cancel work on remove
Message-ID: <amvgh9Z8_HKXEPT1@venus>
References: <20260728123423.781-5-getshell@seu.edu.cn>
 <178544907138.238864.16061378690960655968.b4-ty@b4>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oh7owv3iarzywso6"
Content-Disposition: inline
In-Reply-To: <178544907138.238864.16061378690960655968.b4-ty@b4>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.439.57
X-ZohoMailClient: External


--oh7owv3iarzywso6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: isp1704_charger: cancel work on remove
MIME-Version: 1.0

Hi,

On Fri, Jul 31, 2026 at 12:04:31AM +0200, Sebastian Reichel wrote:
> On Tue, 28 Jul 2026 20:33:39 +0800, Hongyan Xu wrote:
> > The USB notifier and initial VBUS detection can schedule isp->work. The
> > remove path unregisters the notifier and power supply, but does not wait
> > for queued or running work before tearing down the power supply state.
> >=20
> > Cancel the work after unregistering the notifier. Do this before
> > unregistering the power supply.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/1] power: supply: isp1704_charger: cancel work on remove
>       commit: 60c5b8a9ef4dbc5d69bbc1a960fe55826cb3b643

I've added a Fixes tag while applying. But considering nobody cared
in the last 15 years (bug was in this driver since it exists), it
goes the normal route through the next merge window.

Greetings,

-- Sebastian

--oh7owv3iarzywso6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpr4RkACgkQ2O7X88g7
+pr4tg/8CmhGEf0PJIWCSsau9aZQI+Db34QzNvkGFuidrk77Jx67Z6ynS8J3XxrB
7MvOQgcyu1NK/HrJKCdH318HGJFLj0yhNpjm4kfKJ7DevBrayWwT7K9uMbP0Gtb2
GkIOv/PBYxIRtcaVxPcSNKXGUgq8CEHawqNYsKwWJMlqIuApg3xlZueuBSJcUk0h
J4XWRwRpnyxM6sbJf1DNZ+fSHVISHl6LUFmYTM9zNUwxY/9JuU8+bP8l36hktke/
SD11Ge/oLJ5nbJL4OQxPR/UG6zg7PAm+KAiWabR1jUB+mfd8HL/9xDe6vFmwytYj
Rs/poy/9ijtyWvUMLU4RH8ZyoHCKdjeugBkPQQNdKAJ/1RqJ6GoupYC5pzsp9//N
SZEwRUY94HueYFS67MnWrU6g+Uyaaf/KRUrSeTYTiyTxrou39FwJhv/kq+YPn+gf
+5DmByhEnzbCt5KnH8KOONb9PY1dKqOReIN4HcHXHWz9H2123hlPC9Gd4F4ONxjW
9DzWPPd/8Um2USKD7R8lw9o9DutZ5jsAbFhu/k5OUUny3Wy4GC837bb9Sg5Bg2F3
H30krdCUICmM1TBYxumFTY2Vx5Ga0KSVetxd4J0mBUHXUsKTixS7bRvfvMP/GW9z
o5d1ddi7tcRD9t6G/ruO3tQSy9fzatrffilDxzY29DHNnzm3h0I=
=uHBp
-----END PGP SIGNATURE-----

--oh7owv3iarzywso6--
