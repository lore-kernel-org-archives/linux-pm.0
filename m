Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69239C621
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121053; cv=none; b=hMi9ashGH6lb0+2lD5XK89Ff2GWh0K/gXO1IdHaCbhFNlkWCg7ibVGSceNi9p5v25bSvTB3Xz1edPYxMoWc6L+bmq4ZqISJrq2JYS+OsYnvfhIRF74SQzNbqA60Brs9xTeB97rsGpmHZaemCIsvgENzaXbWDW+wyG0hoSSoKm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121053; c=relaxed/simple;
	bh=BICkZlTsSMBUEIiJP3C8eGN+Xpq7rBa68RhPQ88ofA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3S02J+/wIGZQG0MGo3ddX0ZN4wJfZE6PQOcx/Sp4lbrc2LY0qyi6lWcSoGiznl8jplhZdoyjUwIdnrkBbxuEnSLqePbYkhZGjWwgmDQfIOIjPcrGraHzeBomm5WyjX9sIsKmg9wkJr7YlgadSJxAJE9XoOafXtO6B0gLT1X7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OkCNM6OD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OkCNM6OD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-46019edc13dso1840369f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782121050; x=1782725850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BICkZlTsSMBUEIiJP3C8eGN+Xpq7rBa68RhPQ88ofA0=;
        b=OkCNM6ODQ2wfwIMTzsr9mBn+XLGNJxe2jqRhb0iwT8NegB16qZ+KsQtSE2X9PZrqmK
         XkKsTkyOj6+Vu3AD1Btn6lLwX3yEpRULxeAmqIi3S5s5SY+bLKwGP8i4RAQ6M0qMMrI9
         kRQ4ABTmNZwd7L36+kON/tdXmCrjHFGGK/LwohZIrHWuBWWl+CNmDkYCIhwobgAIjSS/
         drQV8sqBWV5Mu2rvhsWlBG0Plnbnb7nyjtVS2MtQzvXx7fwr6qfSemf+E5IvN8F9huhm
         g8HMBgKbGM/pQSyHacrT1UpPydzQ2oP7UPrXFEPU3Dk56Zi/Ab/JaCIAnRMyYi3nsqpa
         YgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782121050; x=1782725850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BICkZlTsSMBUEIiJP3C8eGN+Xpq7rBa68RhPQ88ofA0=;
        b=iUZTLBPEgsnBelrMZ1uYpt/FELer88MbRfulPKwuMNAJ92/becL9eDV3GcEGDcnrT8
         MKbd95s4IeIero3N2m1P4tn7Jb//Hy77WlVFqG1rNX0eKzef2gZsqNyBY3imgGXCIZMy
         DTbm/Xz/5neyhIKrlFpBxCZwpABHLVxObYQFZBey4Q9tspM8zgJNur4pbczl/ekOmV6Y
         HzZSpDNvyxlvyC9C1pfZycpMjYbZgjssKc9pl0u1Xt4vGzr3JYO5C6QNSGUgA0IjVBTy
         +iqfb36TOP1LkaIxGGrrJXa4KxFCRVm3poJvKveOWbNwORIDIs3MPBBSC1dg7PTcJQeS
         PNRA==
X-Forwarded-Encrypted: i=1; AHgh+RohZUSQmOZ9Vwyx2KSG2HYy+sfOC7KNTDPqDf4zhLtwxW6f/JKPdjCBQuxZD6znuT4aocQdOxER4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YySLa7SIko/62ivWVu/zfa6UPOQ7/TrFLeA7RJMOIqQmClkiWuq
	4vWCqBmkL7ZDPxyxIFaVh1ZsoGu59J9sL6cOuXbRMvAyciaqTOAZNp8j4S0sE9WFtPPsthTcuXz
	02JF2
X-Gm-Gg: AfdE7cloj1HiRPUtmmN3Ok0aMnOY/ysncnTkOquPoTsDpcyy3hUptsQQ+S+oOX5ucbt
	OQJPwSfi4ib1kLahBISixhhjwN12PvRhMO4Crjcbn+UOmcQbacH45jtRQHCQnebEimF5GmWTfvO
	WR41Zgu4H/h/IupyxS5X+RXTvMJ5egpYUKcTXs5zfp6spiZwuXNN1lBp+dSR0UvoX+r6H5CYIyR
	FcCeB7sXMP9Fc8h3nm5DSyXQDe6DMOJB98y0T5Od3tHsRC8koQ/4scYTPOO6/iHojuBwhFtNfI8
	xshhfRqudNwVR3Jvv5UpeaSoDzD9zlFIlpPyBKtrH1OBbFY9NiiM018oQIQeJOh3ffX4UIGMVzK
	jcXbZY2zosEoMTULaz+2W3PCwz3vg02EpY0I/I+bZQ+qk+6b5rHXp0J1wAjJOhZN/883qbocATj
	3Ekms3Xnmdi8xnbW+MJyqrUMr98oZeGQ8EGe7ewcWrGAnEpsXUz12KWqLs7b9MWWigUfi/DP1qG
	4I=
X-Received: by 2002:a05:6000:4286:b0:446:db72:e8ec with SMTP id ffacd0b85a97d-4656e0e69c2mr18760389f8f.23.1782121050161;
        Mon, 22 Jun 2026 02:37:30 -0700 (PDT)
Received: from localhost (p200300f65f47db0402a454298f09593b.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2a4:5429:8f09:593b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-466667881b4sm22878548f8f.24.2026.06.22.02.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 02:37:28 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:37:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] power: supply: surface_{battery,charger}:
 Consistently define ssam_device_ids using named initializers
Message-ID: <ajkB7UUJt7JCA16c@monoceros>
References: <bc8eff03b2f36c82af5a75fc7114c277228921db.1781526433.git.u.kleine-koenig@baylibre.com>
 <19647fe8-c520-4160-bf74-d398c6b642b4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n64qcxyzm66nvlps"
Content-Disposition: inline
In-Reply-To: <19647fe8-c520-4160-bf74-d398c6b642b4@gmail.com>


--n64qcxyzm66nvlps
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] power: supply: surface_{battery,charger}:
 Consistently define ssam_device_ids using named initializers
MIME-Version: 1.0

Hello Maximilian,

On Sun, Jun 21, 2026 at 03:32:45PM +0200, Maximilian Luz wrote:
> Am 15.06.2026 um 14:51 schrieb Uwe Kleine-K=F6nig (The Capable Hub):
> > The .driver_data member of the the two struct ssam_device_id arrays were
> > initialized by list expressions. This isn't easily readable if you don't
> > work with the Surface System Aggregator core regularily. Using named
> > initializers is more explicit and thus easier to parse and also more
> > robust to changes of the struct definition. This robustness is relevant
> > for a planned change to struct ssam_device_id replacing .driver_data
> > by an anonymous union.
> >=20
> > While touching these arrays, also drop the comma after the list
> > terminators.
> >=20
> > This change doesn't introduce changes to the compiled ssam_device_id
> > arrays.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
> > ---
> > Hello,
> >=20
> > the mentioned change to ssam_device_id is similar to
> > https://lore.kernel.org/all/cover.1779878004.git.u.kleine-koenig@baylib=
re.com/.
> >=20
> > That allows to get rid of the casts in these two drivers and thus
> > benefits a bit more of the (admittedly weak) type safety of C.
>=20
> As in the prior patch: I assume that will be a separate change or am I
> missing something in this patch?

Yes, this can only happen when all drivers use a named initializer for
=2Edriver_data. As this requires adaptions to many subsystems, it's not
included here.

Best regards
Uwe

--n64qcxyzm66nvlps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo5AlUACgkQj4D7WH0S
/k74Qwf+MKCOs6Z2AQ2AR9kA/WJ7f3u3nJ32l31uIDWg5NI7h1NPbH/BjSYaWaEU
EdnMdGTkiyxYPzjj0sI0QEIaLPEVAnpWIlMO0W3r8wUOwuRQFGuEuSIyfXIgEqo/
5ByA4iUBb+WvA6+iwt5TbaY6RoA352FIDBOW2bik4WHicegCm3wkHwl03gzNLz8K
T2RrbZuGsVVXFBd7+n0k/UFVi2s6v4bz5WCjfpTju9LRHj29FEZdy9raCtkfZZxk
jHCmvwjthk8eFgCjEqesXyVuzRnyoZ5rNgsgLSG8qqvhRZbdgkth3cTWPFHQAHqu
rz3dopI1k4vDQvZS+ozEPQPtB0mzlg==
=sC9O
-----END PGP SIGNATURE-----

--n64qcxyzm66nvlps--
