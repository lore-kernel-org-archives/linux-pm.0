Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21BA46F497;
	Mon,  7 Sep 2026 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793834; cv=none; b=I/WsXiGBjuf4WI5DGkGpVbNWOKDnpsu3fckNgKcBItXwZidZ1bjG8faXIgp4H/YeLGM3rafwzP1Ko+GNwNwE5TspmneiWJr9XtmGm/jYUwU1+GEFZfZ/8l/FJ8ePiKCzx8iF8VJgWQNzPbYusDHCUZq2TO89ArYChVwhYAJwDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793834; c=relaxed/simple;
	bh=jZTYCuc/zGOWywEer6WeipUwb3+idhqCGirKdSSSBBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIq6wZCT5KyihkMr+5sBvKfqY7/PwuSeif5t5fryxwM2cSOs5mwJ1z3G2HnezJSdnXL0OQWSM8skU/0AfCZ0KCgx9fPcfuSC6n2ZiwRoMu+qF4gnS81cXW+aQF+Rn4C5lm46fokD+tgseAJYveI25QEb0NbdyF7wH0pDmSnsMq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjyPZ0g5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjyPZ0g5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5691F00A3A;
	Mon,  7 Sep 2026 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788793832;
	bh=3/lY7BMUQRA3BwXQVg4y30v+bJtMtwGIf1Byd8uw+Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HjyPZ0g5VwDFHKcHoisuyxai6D8X7699fjABNrfDfJES+Zpsw+DAc5YJd1jQHlchC
	 n0/Ku+PwqPhtf4kWLiCD1wlm7aiw5HkOAaoLvv0Pol3HftIOW116xRDD4tCqFDhtHj
	 MEVp8bIOL+n5drOD/1Y7G3ica5ZFyl6E9dOrQHHYjo3OM2lo5YJztssxfRaBYACz9Q
	 N2fwx1uUZD42VzzKzbhjt8RvWTOaNDemhcWUiWJnPkfGNN+n7goe0QHTEOHSHw10+J
	 8CzIW2grDUAWjkpf4HhdgUhhLK+baEhqieNV9YEZNXbD7sg2slFwXCkywOU0N4K8Kz
	 ohqz95GUeXZEQ==
Date: Mon, 7 Sep 2026 16:10:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 0/2] Add support for the TI BQ25792 battery charger
 (regulator part)
Message-ID: <7c9d0cfb-361c-424c-9e12-0fb35930576e@sirena.org.uk>
References: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net>
 <CAKTNdwF5yW4YFFmsvDFVY+Q+89Uo=YS79nb4qYrT4WyKOszyvw@mail.gmail.com>
 <CAKTNdwGC=AZ9jmD71tz6JqCWk-00QLWCYb9wiG6RRQ0bO=mC4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5wR5LnJErPNKsZA5"
Content-Disposition: inline
In-Reply-To: <CAKTNdwGC=AZ9jmD71tz6JqCWk-00QLWCYb9wiG6RRQ0bO=mC4Q@mail.gmail.com>
X-Cookie: Who's on first?


--5wR5LnJErPNKsZA5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 05:49:55PM +0400, Alexey Charkov wrote:

> Gentle ping :) This still applies cleanly to -next, so I'd appreciate
> it if this could be applied.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--5wR5LnJErPNKsZA5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqe0+MACgkQJNaLcl1U
h9AmiQf+JL0tMoApD+wVKd3OyVs6YsoPtgWZYFJtFVlnHx1PFcFIfH8spWuxhGm2
MIdF2O5hvKDkWAr8cAjy9jUlY87JNkE+IsGVP+cfIllQjHi1EFJKmbXUVA+vMZkY
w7r8nWYfltNxMvzggTpkJP+vCkb05M6VX/OFxdm6QMU5lT1nqw4hnWEzXxjiqQ6e
YyiRmdoNZxGJyNS6AcCWTcKRGZoRE1L+/fCAtH9wv4DZwnEkBfLMjJrf6dwKaXrz
pQFRDKv/ZYlbdtywh59CRlRQqb7LHnzKrCTBb1H07PYJ9zgIb0R044xlixyRF6oW
8y7bmN0VHEeh43mRliSJ/1YypMptGQ==
=Vo8Y
-----END PGP SIGNATURE-----

--5wR5LnJErPNKsZA5--
