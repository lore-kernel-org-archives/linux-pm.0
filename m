Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC137B007;
	Thu, 27 Aug 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851992; cv=none; b=AXNBa1vSziItipA+6bkLL04mlq6cwVOEms5NnUSc1CoJuvOfIE+VHIuCcY0PaNSxDmQ5xnO3x1l8C5HC9jLmvWC65PXX5QELyAoA0bUGLPCZCcVTSFX9xtgdC+xGvzbX4rUcsO/I4MOO8ELrLJzeOIvL8IujvoQPGQo+wf3gACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851992; c=relaxed/simple;
	bh=+s0gZwEVs+NNGL8SgUBqt8+kdikbnE8E+z4ksacIbUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maoBmjDeRq7kCdesvm5XhAbDwBhNr9BUJnEtm713n0NCLl9An6LdWZOkctKs+RA6HAle6JIZoBlFkm5sLUSxw22u0Y/jV6saD/QEGa3UNGWD/tSICyXZk9Gq8DMXs69GmrIwY8splQamBtw8+xel3/hn1FlV27UpESMjRJ73aBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6CPT8M8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6CPT8M8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611B11F000E9;
	Thu, 27 Aug 2026 17:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787851990;
	bh=+s0gZwEVs+NNGL8SgUBqt8+kdikbnE8E+z4ksacIbUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q6CPT8M8A1oGqfOeZ9xjZFHLIeCJdiHHtXX8nUg7UiQQ0DX0xc+ccyrOeQpQN0fy+
	 HMPoQco++J17+F4K+Qz/ckq7OC6+uv/giwDZbY1K38bnRh+vfq/jGXkpG4RyIZicqk
	 iQIMm0sRp+Qh2TfEQzkeIDfIZWxS7pXmKitY+zs3wUiTZOJhFXfPrejk8NHNP/WQtY
	 AUK0iUobs7qqfsfziE3exfOu8GQk2BcdFOolcF2SmCRa1ayEHah4HOd1V1vXEWuWqM
	 QjE6U56dUqj2FlJNIvE4fhn1HfhwSMZKol5qjVmXMbsfXwFBahBdvb1WpGQsB+A9hx
	 3m3xwZpklPeEQ==
Date: Thu, 27 Aug 2026 18:33:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/4] dt-bindings: thermal: Add Tegra264 header
Message-ID: <20260827-disband-retrain-ad995df47784@spud>
References: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
 <20260827-tegra264-fan-v1-2-3c55f0c748b1@nvidia.com>
 <20260827-riverbank-cinema-d898d4e5a522@spud>
 <apBwZwOkctBETKVJ@orome>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UzhbiDLoeUae/VAg"
Content-Disposition: inline
In-Reply-To: <apBwZwOkctBETKVJ@orome>

--UzhbiDLoeUae/VAg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 07:17:15PM +0200, Thierry Reding wrote:
> On Thu, Aug 27, 2026 at 05:35:28PM +0100, Conor Dooley wrote:
> > On Thu, Aug 27, 2026 at 05:07:51PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > This header file defines the set of thermal zones exposed by the BPMP=
 on
> > > Tegra264.
> >=20
> > Does this need to be a binding, since you're just using it in the dts?
> > Can it just go into your dts directory insteaD?
>=20
> I don't think we've ever used these headers outside of DTS files, so,
> yes, they could go into the DTS directory.
>=20
> We've never done that before and there's a bunch of Tegra-specific files
> that would be in the same basket. What's your recommendation for any of
> the existing headers? Should I move those into the DTS directory, too?
> If they are not used outside, that is? Or not worth the churn?

Up to you re: churn I think, but were it my platform I'd probably move
them.=20

--UzhbiDLoeUae/VAg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapB00gAKCRB4tDGHoIJi
0t7NAQD0sDGi1VUfV9Utq6HbCWKUJKS+cT4Lxg1zNAgkj+/hZwD/SOfR7S7mJATc
yY8irvYGTrJhqtvHRfYaLyxMvy4Kewc=
=JTpm
-----END PGP SIGNATURE-----

--UzhbiDLoeUae/VAg--
