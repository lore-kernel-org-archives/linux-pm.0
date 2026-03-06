Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B719352C22;
	Fri,  6 Mar 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825793; cv=none; b=mn25yzQzZRdwjqs7vORH/n0jGgqT4InI2q8io1o+1H2LSo1O0XslCfXoUJh4xfb+ikZ+0wii+y+LwahxK3+Sp2GzDSg5rPp8a11yo5PPdLA6/DtNDxgZdZ4kBG39YzaxPYyLzdFUJY928s057QHnyIqsTlo44Q7FbftcB7IIcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825793; c=relaxed/simple;
	bh=ewzpiXOFV699/AiIq9n56RjtsRJdWafj7gQulN4FXxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvdxnncB5OtD75qT28yFhy+MQrNNeHlfsCVKvGfy2nrl8Mq5w49rblNZTEmedZVfdW/yoONT07bph0sgv1lxtui0dO7F5/WgSouzRVmesGRq1ykVDfjUngqoM6bcqZV6Nm321NxVJmcI8IU4tRbbAcC4mNDNXofSHHvGCzvdV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKALYIpu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKALYIpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E41C4CEF7;
	Fri,  6 Mar 2026 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772825793;
	bh=ewzpiXOFV699/AiIq9n56RjtsRJdWafj7gQulN4FXxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKALYIpunfZf14somh/XkOE/XN40M+STbgk7XD/imKAzy1pNAUjWvc9xesEm3qRJ3
	 Vjo/T2qUGgRY5gKp4GhNCdFoX70E74SG6SNchZM4NjjqVxux79i2++hZ0/eHdrTRwb
	 SPfJx6ISRojGguSwKG6Awi7eJnHPwa95gw+C/acHjIsAIwT0nMBiznkMJu69yqR8dk
	 W4DJnmhHOkCKq/5X0HLpCkWsGqb9dCjGq4zGbZOBto6vKBDQU5qA51NQiHatO4wcBw
	 pBIU8Cy9dXtiBn8DeUVNSgdifSZAm2W2wgbuadTugxuO3E5oLei01QIdCak8G/6Bgg
	 FavdRnDIwOIJQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BFF441AC52D3; Fri, 06 Mar 2026 19:36:28 +0000 (GMT)
Date: Fri, 6 Mar 2026 19:36:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] regulator: bq257xx: Make OTG enable GPIO really
 optional
Message-ID: <aassvAsgFTlFnD8M@sirena.co.uk>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
 <20260306-bq25792-v2-4-6595249d6e6f@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YGVsl/3Kb/Fedt+6"
Content-Disposition: inline
In-Reply-To: <20260306-bq25792-v2-4-6595249d6e6f@flipper.net>
X-Cookie: Think big.  Pollute the Mississippi.


--YGVsl/3Kb/Fedt+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 06:33:04PM +0400, Alexey Charkov wrote:
> The bindings describe the OTG enable GPIO as optional, but the driver
> gets upset if it's not provided in the device tree.
>=20
> Make the driver accept the absence of the GPIO, and just use register
> writes to handle OTG mode in that case, skipping the error message for
> -ENOENT.

Acked-by: Mark Brown <broonie@kernel.org>

--YGVsl/3Kb/Fedt+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmrLLsACgkQJNaLcl1U
h9AgBwf/eP3Uy+cd/aIEV4nv6djq35BjM2gDBYO0epVm/ofey5WZb4u4ebhDev+5
KVSf5H3J0DRu+2ODQl+T/eJI28OSZsax3ZlLPIltoj1UWt7ZkPXJvW3LNVOb1Ufr
CrRGwpZ6Gmn9uqLwcFM1eXZv9DeGjeqQ9+nrHFTnIAIOI9fvqFNblls4xJLYQkJe
jOM+AnlkkwAl3sjLBPextS1NJU/4q8lhVIgzHbrFXzB8Qo8Rl1VUtrVydfMJ8beH
9s3osMMLvEtMdVwYYMx4QPkoZHY/8KHKc7Zihm6gTKaLLTxtVMy7jZn64A2vVF35
ItbRhTAAEgV5AhggrqansZE+aXLZ+w==
=i+Kt
-----END PGP SIGNATURE-----

--YGVsl/3Kb/Fedt+6--
