Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E6149365D;
	Tue,  1 Sep 2026 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285855; cv=none; b=jTOFp2kM6z4aO3Ux+NGFKN1ct4FUNyy5uidQGtaBeTCI0+1lbXJ9qhSU+fAHryl/wwF2atSDiCf1Qr1vuJpRWJioVuHjlJEZjdpznByAGrFwKAiCXiMXIgnnI4vkTXKm/aEkC3FQhVKOqfOzCAMfHv7C9Pf+8VN4ne58exVe1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285855; c=relaxed/simple;
	bh=9XjD0EYfPWneuNFnlehAdqsFDUYFqnjfr3Di+F+OBN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoTHioK4lR3O8t5TZGk4W13bpfh4JG9sa0Fqkjv/oMTi4ZWakF935EB6NWxtrWrZgXzf6ydQDUreitNQ/k2zYMjVz3YI3eRlOKQEmorHCNkngZfthyz5tucz4GbMxtcL+UvaVbGy35axi2Anub1i9sraCNCUmn6raD/xBN77IwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8NP9asV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8NP9asV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19321F000E9;
	Tue,  1 Sep 2026 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285853;
	bh=9XjD0EYfPWneuNFnlehAdqsFDUYFqnjfr3Di+F+OBN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W8NP9asVUvyjC8TufOwX0tJ6Gzpo6qzkhdHUx7EHT0k1rpPSKQTBnwPQcz0mSpOX0
	 rgSr5Qw88qqnCHVdU69ZubZ9ySAswPWeSr29C/+NyhnkR/BRZ75djwzWpTdPBTFzZ+
	 gD5eOR2FutGJXglB+vi7F4BRzJUkoox2DFszYEu9PUjSINCHpTaGkd60XCTj2jkY5s
	 eqt6VqxNXk3YMmMeesuSek9mCyZoBCu7E0z8wQcA3UaQuJ4NJnpgJfHREDQS7EOA9x
	 bqjjDpVy8ISQcc5GqrME1jgA5YihVy0JToPD62L//6xyRIamXGfgAhwHzv/J1CaAhA
	 TTz/OgJerr3Rg==
Date: Tue, 1 Sep 2026 19:04:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: tmp102: Document TMP113
Message-ID: <20260901-pavilion-unexposed-80ae9812e77d@spud>
References: <20260901161008.46948-1-marex@nabladev.com>
 <20260901-untimely-wake-578b1a86b9fe@spud>
 <4bbcc5fe-86a1-4299-a0df-e9f44d5c237f@roeck-us.net>
 <2e3f7dab-5f64-4dcf-b995-82fcc3a5e780@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ocFmQVxThrfwbmsg"
Content-Disposition: inline
In-Reply-To: <2e3f7dab-5f64-4dcf-b995-82fcc3a5e780@nabladev.com>

--ocFmQVxThrfwbmsg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 07:58:51PM +0200, Marek Vasut wrote:
> On 9/1/26 7:48 PM, Guenter Roeck wrote:
>=20
> Hello Guenter,
>=20
> > > > @@ -13,11 +13,12 @@ properties:
> > > > =A0=A0=A0 compatible:
> > > > =A0=A0=A0=A0=A0 oneOf:
> > > > =A0=A0=A0=A0=A0=A0=A0 - items:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - enum:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - ti,tmp110
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - ti,tmp113
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: ti,tmp102
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: ti,tmp103
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: ti,tmp110
> > > > -=A0=A0=A0=A0=A0 - enum:
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0 - ti,tmp102
> > > > +=A0=A0=A0=A0=A0 - const: ti,tmp102
> > > > +=A0=A0=A0=A0=A0 - const: ti,tmp103
> > >=20
> > > Should this not be two patches, one fixing the existing stuff and one
> > > adding the 113?
> > >=20
> >=20
> > It is all in -next. Looks like I resolved the conflict when combining
> > "dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml"
> > and "dt-bindings: hwmon: tmp102: Document TMP110" the wrong way.
> > Sorry for that.
>=20
> No worries, I hope V3 I just sent fixes it up.
>=20
> > Instead of adding more patches on top of it, how about providing a
> > single patch moving tmp103 and adding tmp110 as well as tmp113
> > together ? Alternatively, I could drop "dt-bindings: hwmon: tmp102:
> > Document TMP110", apply the original (non-conflicting version) of
> > "dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml=
",
> > and then tmp110 and tmp113 could be added in a single patch.
> >=20
> > Please let me know.
> I think the broken commit is d67ec24d3f07 ("dt-bindings: hwmon: tmp102: m=
ove
> ti,tmp103 out of trivial-devices.yaml") and v3 1/2 is the fix for that
> broken commit. V3 2/2 only adds the missing TMP113 .
>=20
> So I think there are two options:
> - The complicated one -- squash d67ec24d3f07 ("dt-bindings: hwmon: tmp102:
> move ti,tmp103 out of trivial-devices.yaml") and V3 1/2 (and either do it=
 in
> tree, or drop d67ec24d3f07 ("dt-bindings: hwmon: tmp102: move ti,tmp103 o=
ut
> of trivial-devices.yaml") and ask for it to be updated and resent), then
> apply that, and apply V3 2/2 (or newer) .
> - The simple one -- apply both V3 patches (or whatever newer version is g=
ood
> enough) and move on.
>=20
> Just let me know what you like better.

Either works for me fwiw, v3 looks fine.

--ocFmQVxThrfwbmsg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapcTmQAKCRB4tDGHoIJi
0hljAP924o57OfGqzoPZITJoOHl9SJdN2DnhzyPYE05QkyxZ2QD/eUSQDsVYrxuZ
iVN2Y/fSzy/dZmPqkKLmExhsRJ10KgY=
=azz2
-----END PGP SIGNATURE-----

--ocFmQVxThrfwbmsg--
