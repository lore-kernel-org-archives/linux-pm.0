Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C8179A3;
	Thu, 12 Feb 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915018; cv=none; b=BFR4K6Z0mLTCRoTE5Bn/9KQ30RxjIxrJtGa6AB5TdWjrf9y2IhtNzz3DunX7xFM+U3pRlJOV3mSHtdUvXb2dWdoqgb3desLtsIZbUiRey4Gfzswiphf8Iro/w/DeoOUB5SlULaX51CkEFdn+/tKWFMMIK1sjI0KmRNvThmo9Q1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915018; c=relaxed/simple;
	bh=6/L3qcDz13lCIx9mHbD9dGJB0TmFBixrjcOzhn9oAHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTlRHjYmFqjo3EFQu1AWMvLaPkXN7vCl/19jVyaSQAPWYbaEYAcnbZrI8WVZ25kt6Dp6tjeRR/B8fg45IHCLh6/Cp+oyMJckWu3gULtbSrK9VdzN4GIckPy+ajdhFj6PslmYlVaCVnrsXIsZMzUMxj/vPZRqtCexIvPq9WS6vvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFLa3Oj9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFLa3Oj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B66FC4CEF7;
	Thu, 12 Feb 2026 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770915017;
	bh=6/L3qcDz13lCIx9mHbD9dGJB0TmFBixrjcOzhn9oAHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFLa3Oj9PqL9cz3jw6Wo+dftv5fsqlrlMjW8+KMHeWJOyculKI2Ccdr+L8ODeCO8c
	 aKcjlwFCZL/rwCaNRxCJR7r14DZ9Q1HGJOWyO5W5oGiWZEq+jInCIlC5rW9zVVIc/C
	 1kRbOlQ1/QTJI6SnTBgg+GLFJSMI3hP0dWQhATKK+4sWgDf+Cy+OQwFv8zT2kloIGW
	 FQCZfVbA1JNvxlDQP/eBwO9HXvR3vEU0B9JcqWPyniJUSbCzV+3nydO4YsEB1QvK7r
	 vPTKASg8d2D4Hr6HYmsjfQ8BuVrXVQ8GBfxx4az66OZR+BP/qRwtE287jArd/19VMU
	 HlCkl7ht4vidw==
Date: Thu, 12 Feb 2026 17:50:15 +0100
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
Message-ID: <20260212-married-cuscus-of-purring-d981df@houat>
References: <2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com>
 <20260204-nickel-seal-of-poetry-8fdefb@houat>
 <91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com>
 <20260204-angelic-vermilion-beagle-fd1507@houat>
 <20260209105047.693f2515@fedora>
 <20260211-flawless-feathered-boar-0b87ad@houat>
 <DGCAAE4YEDLO.299F5M641E90B@kernel.org>
 <20260212-obedient-faithful-koel-d8aaf6@houat>
 <DGCVH2B2OSFR.1C912TO7G7DGL@kernel.org>
 <DGD1E42JOSQ3.28RPL84IP5R9I@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="mdnefkmb6s5e2wir"
Content-Disposition: inline
In-Reply-To: <DGD1E42JOSQ3.28RPL84IP5R9I@kernel.org>


--mdnefkmb6s5e2wir
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
MIME-Version: 1.0

On Thu, Feb 12, 2026 at 03:01:31PM +0100, Danilo Krummrich wrote:
> On Thu Feb 12, 2026 at 10:23 AM CET, Danilo Krummrich wrote:
> > In particular, I don't think we need an unsafe API until we see a concr=
ete
> > example where the proposed safe API does not work (and no other safe AP=
I would
> > work either).
>=20
> One additional note for clarification, I'm not saying that I'm against an=
 unsafe
> API if it is necessary.
>=20
> In fact, I have added an unsafe API for drivers myself with the dma::Devi=
ce
> trait [1]. This was not an easy decision and I discussed this back and fo=
rth
> with a lot of people and, unfortunately, we had to come to the conclusion=
 that
> any attempt to make this safe from the Rust side of things would cause
> unreasonable overhead and can't be considered an overall improvement.
>=20
> But as I said, I am convinced that need clear evidence that an unsafe API=
 is
> actually needed and that there is no reasonable alternative.
>=20
> [1] https://rust.docs.kernel.org/kernel/dma/trait.Device.html

Ok, it works for me then.

Maxime

--mdnefkmb6s5e2wir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaY4ExgAKCRAnX84Zoj2+
dqhKAX93rIM2qpVkVlwviOQI6S+T7Ts6iHOS+UqsVha/4UcNl5FYG/A6dAI0eZoR
lADDMTcBgIJWnQpTYiIe9pJBJvuvlLDabMuss9c/GAY08Fj167fMF9+GQXhc0PUG
eqTQtmHvrA==
=U1en
-----END PGP SIGNATURE-----

--mdnefkmb6s5e2wir--
