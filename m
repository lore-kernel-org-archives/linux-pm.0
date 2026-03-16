Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF96FC5;
	Mon, 16 Mar 2026 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773619478; cv=none; b=ZqMYOJ6WvpfT3DLpWXw4w27qXzDVRHgiqhiCV+hlvZHIvm2VE1Flj1nEkpsZh1aCxmyh2xhGMbVKddM/vR2cj1yZQYC8SyAyTHb3aK1Itw5rCOwEkcjieyxVX/8IfEJJKLffsq9QT9tfqT+5bqi/6YbNR3D43sebtYVMuj/fMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773619478; c=relaxed/simple;
	bh=3o+gGe99TZv8RINaC9nz7hSilQG2AT71OHB1FuHh9gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5zwd/515/+SrS0ebDiQK2PMvE402DtlCHv29PVRnZBq4WLuIgpYZTLPWaey+X3ttmYyCio2pJty2oh3+2YHC66RD0WKepLJEQUQK0HPc8fKIBlo373PgMDTUArQHP1m2HJoiqQ6nrcprk+g3fF1zwWuuW0UkiR2RqnrJGqI590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdokdVwp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdokdVwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D377DC4CEF7;
	Mon, 16 Mar 2026 00:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773619478;
	bh=3o+gGe99TZv8RINaC9nz7hSilQG2AT71OHB1FuHh9gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdokdVwpTtaFts9B4qLc6wl08nFQrr+4mWtJKAsJhki3MKwc2R+I+Gc2qgnR0oveE
	 UfXD93q6liIulCFfE/07pmrsZ/bRs5nxHXMueUoAareimbkTAqZYIoHlpvqtLLSHxX
	 tunrxsVU1mLRfZRojcIqUUl7mxtdsLDy7ih7xyUsZNT+Pcti8Au5bF4Lbq1Dni8t/z
	 2zVvcTVPoJgJ7SS4pVuksAVD+CJzfJyt/BlpBXBps1MB3yl3IqULcgBf0m0dtZeNSq
	 Ecw3fJm8zINbC8CBqBi8McJKTc//xWbvrXWf3Q9gi2UCQq0TERPnZG0Ajl4dvFSADS
	 vQc8nkV5xOX5A==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 0EC7A1AC565F; Mon, 16 Mar 2026 00:04:35 +0000 (GMT)
Date: Mon, 16 Mar 2026 00:04:35 +0000
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
Message-ID: <abdJE4BsrzGDTVZT@sirena.co.uk>
References: <CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com>
 <20260307170929.153892-1-ojeda@kernel.org>
 <CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nA21Vm5bsqwLn646"
Content-Disposition: inline
In-Reply-To: <CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com>
X-Cookie: Identify your visitor.


--nA21Vm5bsqwLn646
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 15, 2026 at 10:21:04PM +0100, Miguel Ojeda wrote:

> (We will see how hard it is to keep all these versions clean in the
> medium-term future when more Rust is in the kernel: we have the MSRV
> bump cadence now with Debian Stable, so it may be doable, but worst
> case we could consider relaxing the policy to just the latest stable
> release and whatever linux-next runs).

At the minute whatever linux-next runs is whatever Debian stable has!

--nA21Vm5bsqwLn646
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm3SRIACgkQJNaLcl1U
h9BMrQf+LEKRkeghaGMCKZd0vU/fdix1FY/mQieM3lXawSu8CsyC2tuxuS+4H8jp
mGFUJJVQ3HfuSvymsLbGqDM9V4f60VM/WVAxzN8ehFV+d+PTykCod4dTnlcRVWkB
SSVzx6AP8sQeACG4m0sIjvy3bhiywMQBTPoBgHRKKIa9lo2se5Uxx316rsXoGX86
RQSkLJhpf41BCYNLxtLBl3fCvJ+x7opddhliGriFp+qepWzbM1pgbpEWimzIDudw
IkkdAZ85RDB+lUn3QiecHL99KO+yVXV7b/8QBu8YFCijYTqCP56wIXgICnDQTQgZ
19psfgXCmcxNeA00jwiGoDeJzUTTUw==
=4khz
-----END PGP SIGNATURE-----

--nA21Vm5bsqwLn646--
