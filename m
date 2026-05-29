Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3461F78E6
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067568; cv=none; b=WK/lD9qy+mKMTgm3uMMpfq/cnQ2rBJetFaxgOEg8ni+LufPhhUConSiISsY8E819pFBIFVLKg1QKvXZO5bUv/n0EYTILCiO4yqvYSK7/WbxAvL+MfWP53kSTtxcfHXgwABc3vofxZqNfGssJZdg1gdfRrGdA/L2TuYthonQhog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067568; c=relaxed/simple;
	bh=1LRHL6RRpJa0AYgbeSc6zbjpQR62nFvpYHbdzZFF2VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSaRLR9FhhyGXODzw+6eB+HROgRdXXCX1l1iotPhxcr11IEC/TBpBOdh2HsPKDna7HxUzOyKE4yMXHL4NOGbUkpKXzFOfcHcbp3Hj3CUUm9KpMUTZJxtpk1pJJSKJaykhSw9XLptJVQzRKFZFeOtbLpLDKOR04H/5hR4lyCTQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XebJQFSN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XebJQFSN"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa5e0d57e5so223772e87.1
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780067565; x=1780672365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSvmsh1X8DGwld71F0x2qMjZ7xR4u2IApS8ys+IPUa4=;
        b=XebJQFSN9Dfn8gr3oL8O+YvkZBjCrqkxf7yRlW8gZuNsKLWQ44Q64HbXb/sucNl5Ah
         pOOgd12IfS6urnTD7hwUdD2qt0X1UGdIgbbL71BH8wFU4sy4dCbwJG+lUhbjl99TUtii
         SJA1pL4IPERdObAhoUMhIygvc/oaEUBBuAkCihgKxLpHKo58Hxvpa34hw/5N35cg3lyr
         xLP1gFhYIcVJrrZVrvAi+D42KYWn7ueDw+cA8uphD2wbBOs5r/ReFDQ8cc42q1Qxd0Zh
         D2x/zrb/xfkRZ+n816mzxGAuspZOtKke9EXm4MNDTd2Lij/pCHK5sBLo8pgHPoIbZmiA
         VwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067565; x=1780672365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSvmsh1X8DGwld71F0x2qMjZ7xR4u2IApS8ys+IPUa4=;
        b=D1am7KlC8RnNE4YcwkLMvyGhWj7Re4KpC4pU8KMS4b/2rAxR7ISboTJdJBuk/+pmB+
         kvGa4Pa/a7rD9zExPPNPvV7ijwXL7dP863yBW/8k+MYvk0GZJTUhiEeOTcm3NYyS4Tpw
         R3r768JZEmZckjqpT9sJVMFCgKPYQJkRfmvM4FLuQ48uj/bFAWTW+DQeva9n57t0mRRS
         DJT3seDDYJ78UMFwuLnpVGPxtvdPwtKqVQG2sEp3hgFQmNZ6dst7ckdBY7CvicXkFIse
         DXWnuX2uLEUm+BJSUqqkGD1LWB83VwC+QeB7ZJSHueJGDwRX6H0DMvTq4n1rRh9MdEPk
         p+lw==
X-Forwarded-Encrypted: i=1; AFNElJ9O5Gtb4Bf4yldnU0lSHCi6Wvm9AwH5gAW4AvrQDfme6YsAHkJ9lkj71OCSwN2WMRYg6EoIGbgNbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcvStj4zwNQb56VF8dqSEkSm6433OPt6bXGtQRsLL935Jyprg
	uawzFsNcYgYLWBh520wCMGTfl4fYokci9tOb0g8Z0FMQhvgOPXDZ/tNI
X-Gm-Gg: Acq92OEhrKYL+a26djfryDrPlkGtKkz5fK3YuZtwkZOWSnWLaS1ZQhFHIv3s9/PU0eK
	5P6mOlY3Jzn7wStfqFvDfR++cMIIGawdXMAJ/Ew+Z67YsUnVUtLbHzbGqr60J9aJwKOw4apopPE
	VNIDKDU6qzjId/wlHe8XtG4Rnpo/WGWnppCHvQaFt0itE2VAPdHthOmRITiuvQyqR1axFUqpzX0
	jCmtyRaNysa6kEQod7O5gxbRL+j4vCLWNMBoj7PDAq2sSCstrS1kFh6+i2jcn85tBlS9oVmSb4D
	qAZxb3EXJC7/T+c39tdJDXrtT5+0jA6bIaPZD7FbVdlmc3nsOhZ9HHbqL/s8F/Y6AGJfnf4oj4H
	QdjgyZrpf1DTF3zFf2jIt/7vVov1Hh/5VU5LN1wx0er9sOEwVFbGmLCXlJLg8Gx4B3m1xg6/nd+
	f5DuW67bMQZITGQ2GeRRwwudSfqmNFX+SbP51e63lioxeV8qoc1RzL8n9zITltX56+kT6t2ZBi6
	ANOwjlYRIil1e1ksxOC6cfIQvDaooeLCxM=
X-Received: by 2002:a05:6512:401f:b0:5aa:5082:6884 with SMTP id 2adb3069b0e04-5aa607c5450mr104267e87.15.1780067564557;
        Fri, 29 May 2026 08:12:44 -0700 (PDT)
Received: from orome (p200300e41f1bda00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:da00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b06877dsm339340e87.3.2026.05.29.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:12:42 -0700 (PDT)
Date: Fri, 29 May 2026 17:12:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] pmdomain: tegra: Add support for multi-socket platforms
Message-ID: <ahmsDANt8D7RSYdK@orome>
References: <20260522160251.76862-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wjcahtt7h7qov7lc"
Content-Disposition: inline
In-Reply-To: <20260522160251.76862-1-jonathanh@nvidia.com>


--wjcahtt7h7qov7lc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pmdomain: tegra: Add support for multi-socket platforms
MIME-Version: 1.0

On Fri, May 22, 2026 at 05:02:51PM +0100, Jon Hunter wrote:
> On multi-socket platforms each socket has its own BPMP that is
> registered with the kernel. For such platforms append the NUMA ID for
> each socket to the BPMP powergate name to ensure there is a unique name
> for each power-domain. Note that we only append the NUMA ID for
> powergates that return a valid name because an invalid name indicates
> that the powergate ID is not supported.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pmdomain/tegra/powergate-bpmp.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/t=
egra/powergate-bpmp.c
> index 8cde4f384846..1faaa92a5b02 100644
> --- a/drivers/pmdomain/tegra/powergate-bpmp.c
> +++ b/drivers/pmdomain/tegra/powergate-bpmp.c
> @@ -137,6 +137,11 @@ static char *tegra_bpmp_powergate_get_name(struct te=
gra_bpmp *bpmp,
>  	if (err < 0 || msg.rx.ret < 0)
>  		return NULL;
> =20
> +	if (response.get_name.name[0] !=3D '\0' &&
> +	    dev_to_node(bpmp->dev) !=3D NUMA_NO_NODE)
> +		return kasprintf(GFP_KERNEL, "%s.%d", response.get_name.name,
> +				 dev_to_node(bpmp->dev));

I just remembered that for GPIO we decided to use %d- with the node ID
as a prefix, rather than .%d as a suffix. Maybe we should unify on that
naming scheme? I remember we were going back and forth over it and
ultimately decided on this because it was more distinct from other
naming schemes.

For GPIO in particular we have <port>.<pin> already for the pin names,
so adding another .%d for the NUMA ID would've made for really confusing
names. This doesn't apply for clocks, but it might still be good to
stick to that naming.

I admit that I haven't been paying very close attention to this, so we
might need to revisit any patches in flux that are adding multi-socket
support.

Thierry

--wjcahtt7h7qov7lc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoZrOQACgkQ3SOs138+
s6FbDxAAt1WdKWI4UCAG0yoWHTNP22VLZjGguCxZDl+N/r7yvPeMabfwxrssvgYG
hvX3YMO54Sy5sNQ9ckd/45Yvf05TuSk/zM2foKJb9rpmZbnJB9Ynhn+y0WBz/Udz
DxH1hlIMxbp7PFS+TiZaG0rLYXRIl9QQfbc0v81IF+pTSeLq12ARyKVBwL/1bo0M
VmahKBXjsoXwYJAGhVVxxopZNYvEz+iv/ZAplX1VdeXpMJ9qbv96HU3p1oN44CbM
cQKjnaQrv6peWJ9s3goQ04GTU5umzER02NrQbzbQv+rNuUVD5GbUg+dWsm0Vom5W
NcC42wlE0JvzXixXNri3qsgcfJS21NQJshjQFDEDdLTXSyt0+O7WdC+Wgac+fPXE
QiKWyq5ky0E+h17+Gtw2MPVM/t43xjVx79qNRV95J3Q/uVwxmmn/VF+x/wPSE+AZ
MKm4T8AvJZbVWfHfXE+NxrSx1iYOYb5vnLCpM9HwAfGvWaDM1naiwIBOegzYVYNy
H2hC2IhviWihDoJHuddPL0uQNkquPe+fZtFKd5lLU5vMBlo22Fy7BQtYpl+2Zx0U
2x8RFjoGVkxYhx9h0QqMjoOLo6EVh1L6ofDX+JYkQGbUh7dtgefWYS4ueWaVEWyk
DzVujli9Dw+h5ykkdC9r9fCIWuE80sAZImJGeJb7FOgi/s197+k=
=VtYS
-----END PGP SIGNATURE-----

--wjcahtt7h7qov7lc--
