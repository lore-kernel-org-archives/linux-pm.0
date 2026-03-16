Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427014D719;
	Mon, 16 Mar 2026 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773665415; cv=none; b=Cd1S7L1aN9TMGGb1f9UKo922ZbpEndQr3heoIjPy2H3NrDP0/KwBw5g3ITc7wjUXPiMqZXE8sBW+NYxKBkE8ssBWKzbbEFT03rbePyoDscCzab0Hm7bhxkg5SXWmH9+QPou16StFgOfoYm0AVSZg1vaE2K6gDS/NqFFqnrtRvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773665415; c=relaxed/simple;
	bh=TY6+GPytpM+fDaSqXtkR7fFnCEXa2SXEClBOtBWukyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRZ0IB+bz4d8v7ZUBJlSf2R4BBuNuHJh8UhYrmQlP5sTkzMgWCv/fP5r8JRa0MTBaD2Err6qFCcVVliqBQ1hKcEhdqc3FgMQzoxeib4h45os2CA/ksKBXwkCaulaZwWz28JU5/gWV02n7wIxZv9sKqkWbRCo3LO8yM1mu/xfgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1CX075q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1CX075q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CEDC19421;
	Mon, 16 Mar 2026 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773665415;
	bh=TY6+GPytpM+fDaSqXtkR7fFnCEXa2SXEClBOtBWukyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1CX075qo+YJu9n0XiCpPH5my5b9IoV3/rmFPndwX7te59lbxIybgWRbeg2VZ/5W1
	 Q0jMtiAMeDr16BIG0uOFjhQ8cSyIJAXTbJfVwxO/IgMAbXVY/6GjFGnhqAcy99ygiQ
	 C38ZQbt+rjJmsFh5/wOxLMEGhIpuu7hF4X88jFanoD265/RkI99AqRkxgc5VQRTCzw
	 9aSUS7c9ADzSveJcmIn+Og9LJ+BgsLI/C8l7e4K4onw/3dmlFZnRe3G5xGXeMYg/gL
	 osOxVmTmX0D0ZGB/MHQM1A/Bw6rEzSr1Y6hr1tm97mwIRvX3DOCy2VUzhPlXUqg1Ca
	 7AIVMWpwWOdOg==
Date: Mon, 16 Mar 2026 12:50:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org,
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
	dakr@kernel.org, gary@garyguo.net, jhubbard@nvidia.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lossin@kernel.org, rafael@kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	viresh.kumar@linaro.org
Subject: Re: [RFC PATCH] rust: kbuild: support global per-version flags
Message-ID: <ffd14e81-c64e-42fa-aa18-60c8036f13e8@sirena.org.uk>
References: <CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com>
 <20260307170929.153892-1-ojeda@kernel.org>
 <CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com>
 <abdJE4BsrzGDTVZT@sirena.co.uk>
 <CANiq72nXMbP2ZbyNE6voWXrEXg85s99pXLj5LeybZry4eAyzEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wltTrBsPR9Xo62IN"
Content-Disposition: inline
In-Reply-To: <CANiq72nXMbP2ZbyNE6voWXrEXg85s99pXLj5LeybZry4eAyzEQ@mail.gmail.com>
X-Cookie: Not a flying toy.


--wltTrBsPR9Xo62IN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 05:49:02AM +0100, Miguel Ojeda wrote:
> On Mon, Mar 16, 2026 at 1:04=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > At the minute whatever linux-next runs is whatever Debian stable has!

> Great, that would mean we are effectively keeping the minimum one
> clean, which is in a way the best we can do (apart from the maximum)
> if we don't try to keep every single version clean between them.

Note that I've not started running with clippy yet, currently due to
Linus' tree having:

error: current MSRV (Minimum Supported Rust Version) is `1.78.0` but this i=
tem is stable since `1.79.0`
  --> /tmp/next/build/rust/kernel/ptr/projection.rs:79:26
   |
79 |         if self >=3D slice.len() {
   |                          ^^^^^
   |
   =3D help: for further information visit https://rust-lang.github.io/rust=
-clippy/master/index.html#incompatible_msrv
   =3D note: `-D clippy::incompatible-msrv` implied by `-D warnings`
   =3D help: to override `-D warnings` add `#[allow(clippy::incompatible_ms=
rv)]`

error: current MSRV (Minimum Supported Rust Version) is `1.78.0` but this i=
tem is stable since `1.79.0`
  --> /tmp/next/build/rust/kernel/ptr/projection.rs:95:29
   |
95 |         if self.end > slice.len() {
   |                             ^^^^^
   |
   =3D help: for further information visit https://rust-lang.github.io/rust=
-clippy/master/index.html#incompatible_msrv

error: current MSRV (Minimum Supported Rust Version) is `1.78.0` but this i=
tem is stable since `1.79.0`
   --> /tmp/next/build/rust/kernel/ptr/projection.rs:121:28
    |
121 |         (self.start..slice.len()).get(slice)
    |                            ^^^^^
    |
    =3D help: for further information visit https://rust-lang.github.io/rus=
t-clippy/master/index.html#incompatible_msrv

error: current MSRV (Minimum Supported Rust Version) is `1.78.0` but this i=
tem is stable since `1.79.0`
   --> /tmp/next/build/rust/kernel/ptr.rs:253:11
    |
253 |         p.len() * size_of::<T>()
    |           ^^^^^
    |
    =3D help: for further information visit https://rust-lang.github.io/rus=
t-clippy/master/index.html#incompatible_msrv

error: aborting due to 4 previous errors

--wltTrBsPR9Xo62IN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm3/IAACgkQJNaLcl1U
h9BBrQf/egG8kuSTgLi7oprWrzoSfOEfWKbDB2sb7E5DcvUeQKGcxK2NU4JUyDGJ
r7G/WsKS4mwkrl/asogqq4xgN6MPYopYG517mmpo3pQJ2MkiwIl0D1eipD1RQxv0
63Bo1OReEKUnVmB1FEr4bVeY6uKuMNT/xt3f0BjQbX3YTtE6Sc7fMVnsT1+vh71y
eTCM57a7RQq8qjLHjYlD6RfrbB9rEiiQxgkD4L/E7Xmaiybfybs0WcjGElY6BG+r
y/Lb8Hvy3d8H/biVp/ExM3ZeTWYAdHrpw/mfXeDKw9tgUCH4fVywlXCNX52k6/8m
5PWeeasOM8l4c1HP6VMx1397rpvv7Q==
=IeVP
-----END PGP SIGNATURE-----

--wltTrBsPR9Xo62IN--
