Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF66353EEE;
	Fri, 30 Jan 2026 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769796597; cv=none; b=Z8ZgEfyV2ami9IbxXC0VHiCT3uDQnT63GvI4iXhqA4P6cmXABTe56Z0ATHyj67rXjD8FcZsM0ADGdk0g8k7H/f8uNc006WwvylvDGNbJxIS/eIqkwhYjVF0U521+CmQ29cE+LKxcRRjxs5bhIbGiI6+EML62glPUbqR4aobTVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769796597; c=relaxed/simple;
	bh=MSbKY6pZES0SMLEWWw4wzn+AjZxxHvsbyDNLwZhZHak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu/IMKk/U6aViYq3x+zfpWFMqT5qRpPMWY8lJV0YUR74nXF+Qf7/DHeacJfAe4iAVvXydMTJO/bEL2dH8AWnlpCOV55fRLvUE9r4mJh/kGUePu1jwM6urppKlkncJGm9zY6SCRuTtPtuulamSlWZxxCPC3g3BJcOBtd7UF/Urfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS30ZewC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS30ZewC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E746C4CEF7;
	Fri, 30 Jan 2026 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769796596;
	bh=MSbKY6pZES0SMLEWWw4wzn+AjZxxHvsbyDNLwZhZHak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JS30ZewCuDhTyBpzKmyXALuelN4PRb8VTvr3iCpfRqC6+ksKET0D1vys7/OD20QPp
	 IJydvxr8opdz1St7TkvYQL+EHD0XX7zaIXLJhDPOGYHvLNT4fpYuU2eBMWarBEyB8R
	 gDCOr0lSmzLnBQhfNKiay+KjvrGorgniKWGvW3LI2obDAWBNBzWGGxFYlmHEqQnGX5
	 wyCZ8V6bfuZjAxGrHmVAjdVRInOIksO/dV2cIVOT1wal1E8Gh5iyUYV60BkSDqak/v
	 F88O1Ci3/WYAcb1ZSpY3YPOCYsHcUmkcqX+3u+zSLCwnIdP30YfP2YQ9lpyj94avWm
	 yAgV/OYyeVZbA==
Date: Fri, 30 Jan 2026 18:09:51 +0000
From: Mark Brown <broonie@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH] thermal/drivers/qcom/lmh: Remove spurious IRQF_ONESHOT
Message-ID: <7b231d33-9c40-4f25-a693-8f2e08280ce4@sirena.org.uk>
References: <20260130-thermal-lmh-oneshot-v1-1-9b132204ef1b@kernel.org>
 <CAJZ5v0h5CKydWU-o-Zu2z6mCtEcCszkfpL4Vuz_VmSqhxKbozg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sd/cRMV/VdkPJ11W"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h5CKydWU-o-Zu2z6mCtEcCszkfpL4Vuz_VmSqhxKbozg@mail.gmail.com>
X-Cookie: War is an equal opportunity destroyer.


--sd/cRMV/VdkPJ11W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 07:06:06PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 30, 2026 at 5:55=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > This warning is there because IRQF_ONESHOT is only meaningful when ther=
e is
> > a threaded interrupt handler and this driver does not register one. Just
> > remove IRQF_ONESHOT, it wasn't doing anything.

> Daniel, do you want me to pick up this one?  I can still push it for
> 6.19 as a fix.

FWIW the WARN_ON() is introduced in -next so won't be seen in v6.19
(though the issue has been there since forever).

--sd/cRMV/VdkPJ11W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAml88+4ACgkQJNaLcl1U
h9DdIAf+KMWayBwlaGyH3nnLGQHBjrJhJLqlxBKX2enxvnaKonms1Hn3JDv6Xphx
BGhp0dTxj0hRwWDPSfLemvoQ9hKW1elkWoDPL94LYtUdbIDcHt7Ycs1WS/ALyuPw
XdIQF//WtGhK6T0aLz41zaOwDSJ94cOOASiLWJ7uY47QzQk+65/q8YrIHn+0u823
OB2XXH6BcJ+m7mPoiOZLk9Fs8mDW9UnKrBsU8y2MnFdJ3xpdbLDd1ZeoZ3mkqi51
E7kGhPKsnx9sG9dY/gJJgp83GBokzn3ctzdau8DPJgDFJ9FW5ZQnBhokaBohBPnW
FZiBuGbVD+9FiUA1oxEvrFk6frTetw==
=HmMy
-----END PGP SIGNATURE-----

--sd/cRMV/VdkPJ11W--
