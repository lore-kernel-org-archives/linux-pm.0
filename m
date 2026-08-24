Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8639144AB7F;
	Mon, 24 Aug 2026 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588723; cv=none; b=jHp0JsaUsRg/PiJfqB0CJRLn9fjd9xKDsuiH4ctxvNH7ehIkgAUYWHiorYMVv72UB52aHHyb737TPNPCmzluxea43QkwsxK//qC364dbhCopSBssN4U+qC9UIqQN1IJzoY9VuwQqmEFThgMzsGIdoyHytpuWgOU/YghgCk+fONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588723; c=relaxed/simple;
	bh=eOwcnwcBgL2171fXf1o4A56Z56V4W/kvFkYHiWltHnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtxZptbLwA6o/tnL4q7oXUu+Az6muONb5krY15Aemw3x4+pbTIRiznWrRe/+LQFAPd2HxtGChVYmb0xvJc7jW48CI+dD930XKi2XFdsDEXhRugGD74iUgMObSgAMU84uEmsCzOOYDazXPInFM8eZcbQT7PSjWrQf19FOJEh5uRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOi8rxGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOi8rxGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EFB1F000E9;
	Mon, 24 Aug 2026 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787588722;
	bh=eOwcnwcBgL2171fXf1o4A56Z56V4W/kvFkYHiWltHnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bOi8rxGCRtIsp72YOkwt5Otm/GuE2t7ZjXMmvAAa1OHC/8X7N7SFXkR4Ajpf3C7da
	 XLrJGfHIpIrsdqp7dHaviqhfo4GG7VCOO72XqbL9U+IHRUfkO+sGPBoPvyBJDd1KI+
	 77MyhHgvTydsbuP0oeEzNmuA0TPSkBUT9Nw10a6dOlnePpEdd/Ck/d4jaN97NTaEJy
	 lH11SLFiGjzz/5vsvJZDvLjMS+dTtxDlrzff1/MJmQF/hf07bsr1VzzbEGLENCvwOY
	 oTGha4vxnG3+0toCy2IryrMHp5Hh+q3/P4HwyV2W1XD5lxit0XZSJQZ6rk4c+2lljI
	 0w7Mrd1aNJsqw==
Date: Mon, 24 Aug 2026 17:25:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
	p.zabel@pengutronix.de, ogabbay@kernel.org,
	zhangqing@rock-chips.com, royalnet026@gmail.com,
	u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com, alchark@flipper.net,
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 07/13] dt-bindings: iommu: rockchip: describe the
 RK3576 NPU MMU
Message-ID: <20260824-escalator-troubling-faf3f76c6f1b@spud>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <34a972915214bfc4034c797df1c4a033f3b03e2a.1787568944.git.gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gIsQ7pRGBBCsrD0n"
Content-Disposition: inline
In-Reply-To: <34a972915214bfc4034c797df1c4a033f3b03e2a.1787568944.git.gahing@gahingwoo.com>

--gIsQ7pRGBBCsrD0n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--gIsQ7pRGBBCsrD0n
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoxwawAKCRB4tDGHoIJi
0r4ZAQCgvqwxN4H0y9vjDm6H5Qz9wNkjzupTdKxbNmtqb5quIQEAhNrHBdyG9MkZ
rPagrV/g3+iX9zZ0bfM6xTN/98yU1wM=
=CG+w
-----END PGP SIGNATURE-----

--gIsQ7pRGBBCsrD0n--
