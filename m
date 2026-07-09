Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843FF4DC534;
	Thu,  9 Jul 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618736; cv=none; b=RjUdoKDhwLmSAMyjsJgDc3TG/WnjYnEMmM2Fa/AXwapRWzQoPuZP8HEKKoLqHNfqU87fLNfTItYm1yloK8nYy43MVVa6w8d9P+A9V958i+eBfqSY4R0u8/4XWKWOgLG6TJkjiUJCcSwRxOqEE9nrBg7nodvD1rRQBRAQ4G98Dpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618736; c=relaxed/simple;
	bh=d/nBdYKTwprwwPJWcQhYAi+50uqZV7XmaVBvqS1J6Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLxQpZNgSSUU7jq+aK79SlOnQlhamP7S/XwWQd/E/vne3nN2a4FTQcHANGsVovplgFCx12kmRxxKCOXChyVhWy7U7ci0YOovuUwYiTx5N8dpI80sJmS1ah1a9Mpw9vInJd7q5CZyg9EtbG0TJMwBNnUyHThnXtUawOdr7Ii0r3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr0UF5V0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr0UF5V0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80DB1F00A3E;
	Thu,  9 Jul 2026 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618734;
	bh=z+xPqrbAsOxm0DoB+mXHkly4JM60YdduBZSXbhphp04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jr0UF5V0p3i+9ZoqP0v0r2WyARA9522xwnGYD61df1lV1vCbW2OjbYUdWSaM+bUAd
	 oWoi2JnH6QXswGH/TWXGVBUt+S7Dtih4h2f6oQnrIv+a+GdME1HCJLLEEQmeqQOKv7
	 hVsIbj+o3cvsC7UmJvkHdaohkuU9ljjr7YINohew6ExMt/ZFmC/Sz+9Id3IL4ftMao
	 r34QjORWG4vjo7UOzplInFPiSa0oWBzNteOD1SpDWDDa92xkOS8+xEvHRtzowTpq0Y
	 PUx1rCK5Qnx1L8YCsWt2ULOe1XOXltJsamXa8GVj92V7aaCe+vG3BPVA3dJQDvqKmC
	 ge2Iv5gC/uClw==
Date: Thu, 9 Jul 2026 18:38:48 +0100
From: Mark Brown <broonie@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Girish Mahadevan <girishm@codeaurora.org>,
	Alok Chauhan <alokc@codeaurora.org>,
	bjorn.andersson@oss.qualcomm.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Douglas Anderson <dianders@chromium.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	aniket.randive@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com,
	jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v3 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
Message-ID: <f199663d-cb74-4117-9dd8-f7384e74a87a@sirena.org.uk>
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-1-92feb5a7b926@oss.qualcomm.com>
 <ae915278-2f21-4bd0-8651-d2e02ac04aae@sirena.org.uk>
 <CAJZ5v0ga8qqYg79+hQVtO8T=FOCj8XLmTz3HpEKoOykV_K-HSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Llcw7u8OMnNrmMC"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ga8qqYg79+hQVtO8T=FOCj8XLmTz3HpEKoOykV_K-HSQ@mail.gmail.com>
X-Cookie: MS-DOS must die!


--/Llcw7u8OMnNrmMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 07:35:18PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Thu, Jul 9, 2026 at 6:35=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > runtime_pm.rst still says

> >   * If the resume callback returns an error code, the PM core regards t=
his as a
> >     fatal error and will refuse to run the helper functions described i=
n Section
> >     4 for the device, until its status is directly set to either 'activ=
e', or
> >     'suspended' (by means of special helper functions provided by the P=
M core
> >     for this purpose).

> > which needs an update now?

> Yeah, it would be good to update this one.

> That can be done in a separate patch though as far as I'm concerned.

Oh, totally - didn't mean to suggest we should block the original
change.

--/Llcw7u8OMnNrmMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpP3KcACgkQJNaLcl1U
h9Cs0gf/flegjsijkwicZIndylDYxISil3P2eLNwMvbiukKiLEGBGfM9/nNk+Kjb
wgvh9F1Ov3Dy/Z/UBn24b/1bGwS9R/PWTccpI6ZmYDvesGQnf12CSeiVLYha7ESS
ybJ565nJHSJN5SXWiySj5dJQB5286epdYfx38homHKz1aoK7KnCeCwcGwLkouvOW
Uk/KWYn0BUw4BAjfQov+UkkPmrs6wt421YAFnzzdIyTOchNgvzYguWyjaLPay3U9
OhdvP71afhbeEmM93DNLuVEVxMZ99KZCu2cp7lyhreCBD3XuZuXmhOQy5l48MJsI
WH8YEI0kPIk5pmi3uHDY4nh0l7+oMQ==
=BP5F
-----END PGP SIGNATURE-----

--/Llcw7u8OMnNrmMC--
