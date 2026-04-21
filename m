Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A899246783;
	Tue, 21 Apr 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789805; cv=none; b=e7mPox3KBgaPcYi50pW+x4nOmXKNVlP1IN4zXNZgoqCcgoBheoU55Dj7e33vL8ciWJ8TqGk7J0H38C0U+YLlt0A+se01CdHysc3JBjSv7zMnDGZ0UgHXU7xP93dWAajxoNDuJC6Dcq4NdIVSYkG0RLFjS/uarpTAWnSqTAcJvPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789805; c=relaxed/simple;
	bh=4DpCwv4bQ34CzEvMEIPOxMEDG8nKZt4dIwwtd1eT0TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeOwuYJe8jCFjagfVKG3R7hIt9PGuptbjjzZbRTm+HVBPnsT7X5DbHT/AtYzru1GYL4y4k8t2ki/LpCpTpJIvl8gGbbgnBJb29EU6AU9oO+tfvZOgepie4pFuUOK2ayG3p8YAX1Q1ufzL6E+wN8ps1ZNHoWCBUGOobIL/WIDr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYcmQyTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYcmQyTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCE3C2BCB0;
	Tue, 21 Apr 2026 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776789805;
	bh=4DpCwv4bQ34CzEvMEIPOxMEDG8nKZt4dIwwtd1eT0TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYcmQyTctxxAQnBqas4fS5OXWdt3+cIYFVzOS6LqRhwJchFIcfOqEevthO/u/zoP5
	 J58Yip/BuYyrclfkwD/xsE5GgnlnZoJRP/IdqmkjtAqHOon27ksyVBXIN63HeyPcXg
	 oRTw/9oYL3Rkjzv2qkECkyVkFVo7eea32DbeoZwEvoL5Z2nI7TLp88P0JO6l4kq9On
	 Sth+bFQ49EAdchOLov4D12SS8iMuHZKmjpV9I6F8h7lLwnJ7g7h/MmyqOBP/yeHuSC
	 aqHaeMuCpmGPnzOMDrGd5TlLnCB5ixbStsg5iBYxUo/vKmuDB/KAdWFHyjWZkX9ZKo
	 1EA12sjsPDBTQ==
Date: Tue, 21 Apr 2026 17:43:18 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-kernel-dev@aliel.fr
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
Message-ID: <20260421-mayflower-scratch-c861c20ecc11@spud>
References: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
 <20260421-add-mcu-fan-khadas-vim4-v4-1-447114a28f2d@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vF6WveZDFwhhwK8a"
Content-Disposition: inline
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-1-447114a28f2d@aliel.fr>


--vF6WveZDFwhhwK8a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 01:49:18PM +0200, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>=20
> The Khadas VIM4 MCU register is slightly different
> from previous boards' MCU.
> This board also features a switchable power source for its fan.
>=20
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--vF6WveZDFwhhwK8a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeepIwAKCRB4tDGHoIJi
0m+GAQDP6Yhk+Ye2KmmQ30PRruDFLVUcEar4ReZCG96CAq3ZqgD/UXwYeykc1wq3
5TfXvdpglW+/eDOGF8e5A5zNvpB7JgM=
=SG9m
-----END PGP SIGNATURE-----

--vF6WveZDFwhhwK8a--
