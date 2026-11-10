Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330466;
	b=XHc7EXf6wvUREexF6IoEovzE3vOwdVhDK++dCohbxPGfCwt/3orsoCkuAc4rbZE7hMmK
	 NY3NHMm1+6FzShaBpYmPBxIQJt/eqY6AfJlJVcMYZHO1PKPqZcDVICrO7oHu0DaUmUTdo
	 WD2tj4dX6yJ3Nkx+ChzU5MqOGzZzA1NZEd1kQtEGqvLabWTPzjIjrqBN0KRpFNCBux9p2
	 +WE2w4FZq2+ns0amZ1t2yuSjsQq9YVnkkw4HdBLuNAfz57e+zGNZrMyDEqjCWmXT6Q2gA
	 XMLO3Q73CxK2iMvO5z7hofRtIYcqSHoyS/4QKXInpXmD61+IfFj82abXrfoDDMggsuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330466;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=ZXhsyN0jvn3wgH916KLvhvMEDB7UaDYQ5hgxCXHOlzY=;
	b=Gq6zcoZvAldZNQ/rLKLqh+k3IcYT8xZ+OaO2Pdg6RXpfCnoBk6CU8+ApK4hLOS9lu8vD
	 jYE8t6yDjaflWXC7fufCg+hEozVQWEVW53lExzCdzvfDTT1+YtTYmjJ/tU3XxZW4f109C
	 yN6ZoezdGyfq/HI87PiErjZ3SjmfA/3NyBPYz8Rp4vCJfHchsjxcMLUJJ47mvMkAiYNux
	 UxbCaV/zU2hi8kswSLQjVBlheRpt3iaSIn4cqqDbe5PPX0HTgEPudbXmSAxaVmjLP2umz
	 D/dQDXnOn9/RtpyNCyAQ0TGqfkdfIqNVxHgYJJRZCz4vDpfjNKX+GmmBFLHmuj00HbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gh7PPnye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A9606A320;
	Tue, 10 Nov 2026 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gh7PPnye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AD41F0089F;
	Tue, 10 Nov 2026 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330465;
	bh=ZXhsyN0jvn3wgH916KLvhvMEDB7UaDYQ5hgxCXHOlzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gh7PPnyesmd/WHuhz0uZyGiYjk/KZH56wXrXAamBS5wlcIkBkiJSFLVQpj5X36IH4
	 rUbMhzMur2ZNK1M9trqYVK5m2NqCCnykLJMsIiA2L8pDPqpOsl1PlTaOJrgPeSr9ZP
	 rpIDqwW/K3crWAmBXMzg5tAqEYsg+3nX+QFYlY0DXlLy1o04g9eCp9bw5Bt8u7y0OY
	 ENQuw9oDeURt0kiFS9m2Z1F4ooD3uJdzawCb0/hz0cWgnBF/C7nji6HwOmc5+aIUDQ
	 jaCcJMa057f0/DUZ2CpAWTtdavXCa/6zhk8CliROWABIt8n813XxNf0wblmyK2SyP4
	 pP8rBEBG7Gt8Q==
Date: Tue, 10 Nov 2026 17:07:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ulf Hansson <ulfh@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pmdomain-fixes tree
Message-ID: <7438b2e6-86f1-426f-a4d5-eda258c8c6df@sirena.org.uk>
References: <avNHazNbGtMQJ5pV@sirena.org.uk>
 <20261110170253.2694265-1-sashal@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1a5ZGukAzOeeNJ5v"
Content-Disposition: inline
In-Reply-To: <20261110170253.2694265-1-sashal@kernel.org>
X-Cookie: You can't take damsel here now.


--1a5ZGukAzOeeNJ5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2026 at 12:02:53PM -0500, Sasha Levin wrote:
> On Tue, Nov 10, 2026 at 04:33:47PM +0000, Mark Brown wrote:
> >AFAICT this is caused by commit
> >
> >   d7262971a2acc (pmdomain: imx: gpc: remove all initialized power domains)
> >
> >though I don't really see how.  I have used the tree from next-20261109
> >instead.

> The while loop that commit adds to imx_gpc_remove() is never closed, so
> the function is still open at the end of the file:

Ah, that'd do it.  I didn't look terribly hard.

--1a5ZGukAzOeeNJ5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzT1wACgkQJNaLcl1U
h9CrVgf+LeTxsL9HzKanu6tPhTPmqT2aGiVIee38NxtDW0QqWhk+qZgupw0IcxkD
YRDFzKfcVLVCHv1M8qDDv6eNuWf5/kOg6Q4RfDeLpmyxlrCY+hXvYteYUX3iokyk
2cvRBsFINmN5vlH9sbWKO57bzRFqpmiRz3Sz2jBTS1pH+OEtLk71NKCAHj1MewGC
qiYgF+zNw9TZLFlB2XSyzWETdITuqQttFT2u9DzuwYC7EQbRbe/R+JvB9/2LXj1Z
UqGviC7uErdJPF98gHWUzLZJA9s+aPg2+5KklH7LFl+3snuYNxnkP5KBmMN6Ia/U
qr9u4TBMByXqYdvly0lkCzZela6Uvg==
=ld+H
-----END PGP SIGNATURE-----

--1a5ZGukAzOeeNJ5v--
