Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5C046A5E8;
	Mon, 14 Sep 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392275; cv=none; b=IdbruQ1oYetLnVbLXgyemRx66ijmYoFh3s3QgFnMBgkAUR0qtMr9LjOWlQwXyb166B/3W8863k7dc6YM+yIWrmmrlcdKuNihUSdvI7yRV5gnEWSZXS3uKqvXHePs5laMwq6HtP+nJEJ2DCwyeVNXoOxQ5btS8zwj9zXkmxdWddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392275; c=relaxed/simple;
	bh=AGo0cQe5RUvA1pEqpyWe0VKk5fAHVfkva3qo0Book8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZQjVCqYrJmb/In3ijfYrKBKKAmoacBqOz7KLS/sA3FyFdtD+4b7xgAeTYnRkl6ptiVWNMcl3NTn/k/AElgefCsd8tiYWs8jMCc1rDNIPQY40B1oSNvlZc2/AuaYlfZ2XArCvi4Ai4Z95XifB5NdtAYh9ZilYhDRzgyR047rzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH29AyMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH29AyMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680D71F000FF;
	Mon, 14 Sep 2026 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789392273;
	bh=AGo0cQe5RUvA1pEqpyWe0VKk5fAHVfkva3qo0Book8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RH29AyMADeBplUhRdzuH322YE0rBY5mwfxaEv0Ylx1nB+3oV2jCQPYturbnXStjsh
	 dc+kPfy+CxkFGZtDfAlJeCwG949WVoOKZ6S1HctP9GweSiUwTDb8gkdbZD8mtwbO5U
	 RcX6A7XTODILEC201Df9+m3klYZOoTUuG8b2eazn+kYOeqTEQ88Xv5V3qAGN1fgYwz
	 rTpQj/DaeMtWPmU//3mn1SlDXA+NP+fZJwsZhIzzGO+//Y4K3qM5UdYnCeiL3r8jv/
	 rBkGFOhWNi+vOcUpiGEmHrfFSMUXxT8UJ3Q2VLHVOiA+2DrL8NoQpikf1pPTLWMYHS
	 VDmWbki8quvsQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id C0AD01AC52F1; Mon, 14 Sep 2026 14:24:30 +0100 (BST)
Date: Mon, 14 Sep 2026 14:24:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 18/20] mfd/regulator: db8500-prcmu: Remove EPOD
 regulators
Message-ID: <aqf1jhI0UdHQYnl5@sirena.co.uk>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-18-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M0B3+yp1tc+tP1Jj"
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-18-9d0c17e1f816@kernel.org>
X-Cookie: My vaseline is RUNNING...


--M0B3+yp1tc+tP1Jj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 01:54:46PM +0200, Linus Walleij wrote:
> Remove the obsolete DB8500 PRCMU regulator drivers.
>=20
> Drop the regulator build hooks and the db8500-prcmu-regulators MFD
> cell now that EPODs are power domains.

Acked-by: Mark Brown <broonie@kernel.org>

--M0B3+yp1tc+tP1Jj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqn9Y0ACgkQJNaLcl1U
h9BdoAf/dEOtWG3iotyx06v4OT6lFrlCgXHtzOOsPxGmNV34ytKFoJrP0cOuA5q9
QwgdN+JAxDdLrMOYl3BY99HAiOC3pQYBnJhzFn03SON+5xF/NaMJxQQcs1hItfFW
QpTcJmRGscNzHghHIGD+8hFEa2wiFj4+7wpe+QfESFAbP9vun4Aw2UKMyWHaCTTp
XxKXQuj0SARuoSju/Yz7b3luP5JLWfRgaAwb5cmfs99V36iAolC18X3LdFW9Y/6G
16IArek7oOkNl0dlBBgRcO+yT809lQePpzJ+tYRTSDs4YTBvJTR+jXq/JXBo0jik
fDcwJRSoK93znfZkRuA8X2U1YRHsiA==
=uRjg
-----END PGP SIGNATURE-----

--M0B3+yp1tc+tP1Jj--
