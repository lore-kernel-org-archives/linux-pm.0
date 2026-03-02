Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D3A59;
	Mon,  2 Mar 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467609; cv=none; b=uErhFtEhR95P5uOASXip+q8Mq9ve0c6kJD4IoBxtICNRK3/MyaLph6+wMbZRPDuB1vl68Py15hYmKy3QIRw6Axm7b3m9IegdL7RyOtqgY6Q2wUMZ7diVI1MG8Fh9oFqnI3FzTaLD2nCxUso8QUWiQJ0qJ5jP8YkRm6A6DSL/lmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467609; c=relaxed/simple;
	bh=By/PDl9+CvMkNxTG04yP+kp4bi7UohfYU/0crSM2TNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaHUvWbzinSKjext2GuTI3xN6utaOuIaHl/b+eHiu5CMDs8jazxhQvSltWkuTAQIv2Mltn0RUGwO8kK2jsvgl9EF4Ff5R+Qm9Jmfjy857CyVxLVcnleVGALYf9A0LbxIR3HlGQRQOrMiDf6Knw+YRjxWAH+OHoJSNkVR1g75KhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9StW/Zi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9StW/Zi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0F2C19423;
	Mon,  2 Mar 2026 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772467609;
	bh=By/PDl9+CvMkNxTG04yP+kp4bi7UohfYU/0crSM2TNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9StW/ZipxjizjygnpZ17z6iY7ZtboddVfsZrQhYHj3y/ituuONCyPTnR7PwNslxu
	 UpOP42G4uPG1YGmtL38tb28jkArVzWMUhnwiIRTCC4aNSTBf3KydsLe6ViELBPaIH7
	 p5HyI9vfCgcfFLP7yd4XZB21Hb62T5A+L0hxlpI02IfM0RRnQJArZ6vfhgtmwqeRKb
	 /LJMV9NDyhW0PM4V+iAZ/maSLQ82NdO0/Zt8cDEKlXliHOpTzgtZYs9mk8NTyHq0d5
	 KZPAMWpDocwlLXu4oMe2V4kdJKe30lYtTxHWmSCyZiG1/GreJAtM/zsv9Ke0LnkAfp
	 mmuLTpPndjZig==
Date: Mon, 2 Mar 2026 16:06:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/6] regulator: sc2731: Add platform_device_id table
Message-ID: <5488a445-12f9-4bcd-b986-5527a06f6ad4@sirena.org.uk>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
 <20260222-sc27xx-mfd-cells-v1-6-69526fe74c77@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lvV0yQFmPEda+Bv"
Content-Disposition: inline
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-6-69526fe74c77@abscue.de>
X-Cookie: You love peace.


--2lvV0yQFmPEda+Bv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 02:16:50PM +0100, Otto Pfl=FCger wrote:
> Make the regulator driver for the SC2731 PMIC probe automatically. Using
> a platform_device_id table instead of DT compatible matching avoids the
> need for a separate compatible property in the "regulators" node, which
> simplifies the DT bindings and makes the parent MFD device responsible
> for selecting the correct regulator driver for the PMIC.

Acked-by: Mark Brown <broonie@kernel.org>

--2lvV0yQFmPEda+Bv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmltZIACgkQJNaLcl1U
h9Ab7Qf/Qh9EgRDjk9nq9Ce8hDIc7se9taGQZ7bvpKC2ljVz+hqmenkoqW3/Y61j
yoFvJFXZLNCyKPrEveZmeG03sWXqk1v/oP6sGycWjUtEEYMXsljSi9dTVPd6q1Dx
QkfzGp3OY44vmQUKkGbfkPznDxUD3Yhm8hJGL0EE25uJsVCk7sSfYU8cd+Ax3K2T
uaSK/LMs7vWOIwuQhOKFDPPISHfYjZLuinFcMkJw2nTXBO+9X5MFC+8jvEAKVqKn
yFTxfmzex/bsvESNowk2AxGkznX8/X1vKK9A1sbcRwYfEBPwJG8kt6ZqbUcAVjHo
2YXBbXuFprhAR93coA593mq9jsw2CQ==
=2GRy
-----END PGP SIGNATURE-----

--2lvV0yQFmPEda+Bv--
