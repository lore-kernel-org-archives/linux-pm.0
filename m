Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69D274FC2;
	Tue, 10 Feb 2026 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731181; cv=none; b=gRdVocXFxbb1Kxj+EI/Ayd54phMoGGU3zmThjnWsWyuo0HGEhk9v3aT7CAiiN8XjRSbhX2SGHjAfYfrVlq1izydyXzxFiV93DZS7yx1j/lH64fTeQltBe/nTR0a9r8q+ipOLlsTKkkjP9yg+W4DMbLlpLCnKm4qa0fT65moZyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731181; c=relaxed/simple;
	bh=xIaQ9mE9WjsV1VOYv4AKH7JPw5sBhHo25m45P5YuLnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3eShUEC82ZU9XGF3B9tjbTCkLOz8shAE4R0AZfdVJBnPt492Cz2zthmbTZTjit9MTg3XCHivGK1cgmWQtZ2HEZnOmSOmxWNqnYPXFsYsDYiBDs0VJAO/S/32/6+bYyDSMgM9Hy7KWWHL/XDby6WROayaGjJsWFiohoH9WHghUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4GDjjMx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4GDjjMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E451BC116C6;
	Tue, 10 Feb 2026 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770731180;
	bh=xIaQ9mE9WjsV1VOYv4AKH7JPw5sBhHo25m45P5YuLnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4GDjjMx9ExKObk//2ynhkUbzHEc8JT53zI0gYJ5qUL6cpwAj0IwBtuFouObf8qnQ
	 oSwMhHcvGJ2+g7P+5KPatHDXSekFVce9ad584Kc/u3eHiWeh9tsF4AH9RvIyuGKzr0
	 5hT5mE1EeLqEHRKRw0trUTwp23RRqNnIDC5wemF0CdyQ2Rq54GBNrR2mUcOxg3fwEp
	 M9PJ5LYq5G8BruPPS5aWglIIQ7thDxbO6X7BPxH+6Q2QCnyNimskjR5mo5FT5Xy8Hp
	 hE0lxFinbvHjJGppAc7GfRUrdY4AbpGOjj4CICWSx1NbNU/UWXU0es+vynEmShNRiF
	 ot+xJoHCH8P9w==
Date: Tue, 10 Feb 2026 13:46:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Ford <aford173@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Laura Nao <laura.nao@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] regulator: mt6363: Fix interrmittent timeout
Message-ID: <0d1dbeb1-68b5-4b1d-a07d-10f8bb47c105@sirena.org.uk>
References: <20260210053708.17239-1-aford173@gmail.com>
 <20260210053708.17239-4-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+IzQx6Pjw2gHNQNh"
Content-Disposition: inline
In-Reply-To: <20260210053708.17239-4-aford173@gmail.com>
X-Cookie: Spelling is a lossed art.


--+IzQx6Pjw2gHNQNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2026 at 11:37:04PM -0600, Adam Ford wrote:
> Sometimes, the mt6363 regulator would fail to initialize and return with
> a TIMEOUT error, so add an extra instruction to wake up the bus before
> issuing the commands.

Please don't mix patches for multiple subsystems in a single series if
there's no dependencies, it just makes it look like there's dependencies
and makes it more complicated to get things applied.  You should also
supply a cover letter.

--+IzQx6Pjw2gHNQNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmLNqYACgkQJNaLcl1U
h9BGZgf9GnEYtgwFfeWahWxOc9AG8aitDWEbX+AJrF/pojwMi6gx3YagpFAspqI0
2hHMTFIbbWRI67L9BCM5ETXn/MKFrJr6IxfpMI7+Q6gVYKiWAGlHUmCzQ0FfiBy2
YHsAVdWVj/ZIiLJB5Riwx2iPBYHFgv7bu8jWsMilz6U2vGSQDSiPjYq4jXb0kSJm
TqY8to2aMwY4wOeaF10k5zFHdqoLvVfInytKQWZ/LDHjzXI29x0elTdDNfilHtDK
rWjTWy0oPDqK1gKI9/CN2ZiD3lFfMy1NYyntf3C9NSOgGhZrIYmcc/RtC2ujwP2P
rchKSyFTT4qJVxQU/irY7eD8sdIOkw==
=krKu
-----END PGP SIGNATURE-----

--+IzQx6Pjw2gHNQNh--
