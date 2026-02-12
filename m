Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D3221D9E;
	Thu, 12 Feb 2026 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770883185; cv=none; b=TvJl+7rMbaqb5Rit8MpG/UITW6OXXQ1TYXoHvShoKsk8q2PFujHFNRbT0wgMx0qhhqNw7nLr4RVFtKZJ4/E7iAqrnWIFxsZnel1t3BQGteCiTOA/FyT3TzrNWp/xyFdduX82pJyFxlpMX8Vzk9dP9BfKQKXETaq8KI9T380+OKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770883185; c=relaxed/simple;
	bh=LJheg+1Lg6iUUverc5R9e3b/E+Zn96jS/50T1K8tIOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhxZskdYcrS8bJpkAKYJPbj+CV0xfpAp65A3P05oB0HR9YpbQnuhfSDzzwtYIxYdS7BvKxuo5RrdCHLipb1mrzdF/EMqm6JxkchJ9tRRYGFaxKIMppXuvGLfH8WqdmjvOScGhX0Uah/R9fXPIepWqHsEixtw8mgnApJZxcnHC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttK4hrrU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttK4hrrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A9CC4CEF7;
	Thu, 12 Feb 2026 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770883184;
	bh=LJheg+1Lg6iUUverc5R9e3b/E+Zn96jS/50T1K8tIOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ttK4hrrUAk9Se4Kpm1hdtQ0fM5zBEuqymzqkEsY7MPfJlVtzyId3ENAhGqJTKxHJ9
	 qk208j5OhxM/VJh96rLEhX9/GlU/phYgceJLrZbONswdhiGwIdX5dS/TcPuYtxrizC
	 uFGBTCzuznFlBWgsHGk7zbkdKPw5a8WRpKTTgomhmDFQM4iOD4J1k3xPSEh3nlOi4W
	 Z/zqkvFTnL13LBUEX+UXQCDRAt+9R/ZWr347UbIwpgC7VDoBln2hE+534MN6bUWXd1
	 tcU5oSB09ywdfm7aSQX1nuaburzzjrUcRU9bme+LtMd2MCdx1H9NtHxE71PkIxIOvy
	 rn077zqo3xnHA==
Date: Thu, 12 Feb 2026 08:59:37 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260212-obedient-faithful-koel-d8aaf6@houat>
References: <20260119-weightless-pelican-of-anger-190db0@houat>
 <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org>
 <20260122-majestic-masterful-jaguarundi-d0abde@houat>
 <2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com>
 <20260204-nickel-seal-of-poetry-8fdefb@houat>
 <91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com>
 <20260204-angelic-vermilion-beagle-fd1507@houat>
 <20260209105047.693f2515@fedora>
 <20260211-flawless-feathered-boar-0b87ad@houat>
 <DGCAAE4YEDLO.299F5M641E90B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="33m6meqnrfzcdzlc"
Content-Disposition: inline
In-Reply-To: <DGCAAE4YEDLO.299F5M641E90B@kernel.org>


--33m6meqnrfzcdzlc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
MIME-Version: 1.0

On Wed, Feb 11, 2026 at 05:47:09PM +0100, Danilo Krummrich wrote:
> On Wed Feb 11, 2026 at 5:37 PM CET, Maxime Ripard wrote:
> > I do think we can find a compromise though. Miguel suggested for example
> > to make the current enable/prepare/disable/unprepare function unsafe,
> > and that's totally reasonable to me.
> >
> > Then we can implement the "managed" clock version on that unsafe API,
>=20
> What do you mean with "managed" clock? Do you mean devres managed? If so,=
 I
> don't think there is any reason to switch to the unsafe API to be able to
> implement devres managed APIs (see also [1]).
>=20
> [1] https://lore.kernel.org/all/DFVW9MS5YLON.CVJDBYQKJ0P6@kernel.org/

By that, I mean what Daniel has been proposing to achieve with this series.

> > and we would end up with a "raw", unsafe, version kind of equivalent to
> > the one we have today, and where callers would have to justify why their
> > usage of the API is actually safe, or the new, managed, variant that is
> > safe and can be easily used by most drivers.
> >
> > And we can call these RawClk vs Clk, or Clk vs ManagedClk, or whatever.
> >
> > How does that sound?
>=20
> What about we just wait until we have a user that really requires an unsa=
fe API
> for some reason? And if it never appears, even better. :)

It works *today*.

And the "oh but driver is using the API" is kind of ironic in the
context of the Rust bindings which have globally been in that situation
for years. You can't argue it both ways.

Either way, I'm not sure what the point of that submission was if you
will just dismiss diverging opinions, including attempts to compromise.

Do whatever you want, but it's really hard to root for you some times.

Maxime

--33m6meqnrfzcdzlc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaY2IZAAKCRAnX84Zoj2+
dgqqAX9ZKKvbeCpd4Vk6D0P2PgLPgXEzVbGysMUart7lUZ4iDk9GcFwLa7X8pXMl
DWKl2eEBf3hYz3Rv+1FNd/mQ9KtcUckYXXnZxYqCguLOzqUcX4VORUfxwQwckRE4
yTfjWW6Akw==
=V0pG
-----END PGP SIGNATURE-----

--33m6meqnrfzcdzlc--
