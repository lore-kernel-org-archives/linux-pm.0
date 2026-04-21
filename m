Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89995364038;
	Tue, 21 Apr 2026 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791124; cv=none; b=M1Gmj5WMrvMEJdX9QxNLW5BUOV/oVfz4RJg+buDTfVypAdpf1OMflYj3T5tttGAr0k6BUbdKBPcJiLkATLr3gly+LdwtRc+RmGGFwO4TNcFEqMaUywi/tZXNC49ohI/sogGRntS9co5ZiFDVoEKaSzvtv8HgIoKtNb9i7FBWEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791124; c=relaxed/simple;
	bh=Z1ylYruYbhjfnpeCNaQ89mNWV1yukc5kkoI0lUofjuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvJpsmTdxlQF37YoIhbqJ/mSZ3q62rAy28AFS3C47rvYe6yHKo28jAkrlOvoMi6Hlc+Mn2VQOgYO/Kc0AbYPIvmpH6vutKB6RUECRmlS0u+vFKCSLbC5mPbcVBc7Gic/PO/AgEcnX6epLTFdQbSx1HiVugmfuIk1Y09kw99Bwbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkzXN6rX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkzXN6rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD50C2BCB0;
	Tue, 21 Apr 2026 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776791124;
	bh=Z1ylYruYbhjfnpeCNaQ89mNWV1yukc5kkoI0lUofjuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkzXN6rXLrqbPaKzFrZVA5O7xIxtH4nkHCu15azhXJ0NWdls3ios/GdzaRlM6uE7I
	 9geCxENEEi/Y633zBDxaLCHopnhQ7PXsohfM6dxswZv88ojXMJ9F0offWnWZmm86hC
	 5rNODIAwQp14JLnzNM9C/NSRb3sPVtPuqIUyDxox/kG91DWmD5q7/7rdy+C3AdLPBg
	 UhPgZVbCxc/F5fuLXZeF3AdBtIeTK5AnC5nCKLcNQKi1HqIzHwcEgDMwxa/iUyVu9I
	 g19f++9oev8llXhdNyq4zP7CEXyqb6TQL86JnASJtgQtmKva7ov213Hbowegv2+Ul2
	 ICxIejn9MK1Ag==
Date: Tue, 21 Apr 2026 18:05:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/8] dt-bindings: thermal: amlogic: Add support for T7
Message-ID: <20260421-nullify-volley-5ba0e5e8070b@spud>
References: <20260421-add-thermal-t7-vim4-v3-0-a2e7215ed003@aliel.fr>
 <20260421-add-thermal-t7-vim4-v3-1-a2e7215ed003@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m1dzShhxAayQS2fO"
Content-Disposition: inline
In-Reply-To: <20260421-add-thermal-t7-vim4-v3-1-a2e7215ed003@aliel.fr>


--m1dzShhxAayQS2fO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 09:19:43AM +0200, Ronald Claveau wrote:
> Add the amlogic,t7-thermal compatible for the Amlogic T7 thermal sensor.
>=20
> Unlike existing variants which use a phandle to the ao-secure syscon,
> the T7 relies on a secure monitor interface described by a phandle and
> a sensor index argument.
>=20
> The T7 integrates multiple thermal sensors, all accessed through the
> same SMC call. The sensor index argument is required to identify which
> sensor's calibration data the secure monitor should return, as a single
> SM_THERMAL_CALIB_READ command serves all of them.
>=20
> Introduce the amlogic,secure-monitor property as a phandle-array and
> make amlogic,ao-secure or amlogic,secure-monitor conditionally required
> depending on the compatible.
>=20
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--m1dzShhxAayQS2fO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeeuTgAKCRB4tDGHoIJi
0qYWAQDxAFHuGm57LUVlyryh3ibC8pwBHTnLzI4xPChCJGGMdgEAvu7/hlYMeKT/
TdukkKtxdAjY7R/Dxiwo8NmDWA850gI=
=3G3u
-----END PGP SIGNATURE-----

--m1dzShhxAayQS2fO--
