Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB361389E17;
	Thu, 26 Feb 2026 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130254; cv=none; b=OD2hHpY0oDNclkT9r+JekT+xExg4GV7Yowly3yagJ0dw1NFEOpmEqNjeeYNKHRr/cspd20S6B87NCSbYa9EzdyNNt63Q0quywidDUSDeEqRNp36eAAcBScHGbeldK8rd7MCy13EP9/uHlHg8LYHniGtaY72bXFStbDKa6Qv2e24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130254; c=relaxed/simple;
	bh=k4x6Z48xzF/dV2/cT3V3wABHH6+zjo6WJHix8CU51Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/FtSjHsKFD92hkQPt0Gx6znPcz1h+w2UK2EmEqki8bQ0luVUj9kpOXdzeIqjoC1Q/gt2NG5CV7j2f8bVP1Wm+nI7WyhdSikv1xICyhHxXCXxzXWt1rIo/10KgSYszISxvX4kw24Ayu0g8++kMT1CRkfnpeQMiM45BwiSAETQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lchl6h57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lchl6h57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A241C116C6;
	Thu, 26 Feb 2026 18:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772130254;
	bh=k4x6Z48xzF/dV2/cT3V3wABHH6+zjo6WJHix8CU51Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lchl6h579PjTlVx42QI3hNgmYN9p1UNid6l9UrbAt/1N4PMGDOndVcIw5zVww0b2G
	 Nx5W5vhDCLs44pMA+kjn/UQftur2LQpuH9vMwQq0Xb4hZ85bnjJ6KjDHjxUbbyFi6R
	 3J2u+2Bma52RXrNU03+VbTDYNyV+fa0bAIzrtN/5u3PJocBSP3SbGYOAZt6VInHWGC
	 TXCzG2PwFlSLFbSZtUpo6pPh3QY8LGXqELM3vJ1AwbkucMbVu0+4SCYytySVk/76oA
	 25bnq7cyHAOaMn7bHLa2GYG9kW2r2gLR3NmW1QhN3Y9Sq4qMx8ryIRZQ1wrytoXDtR
	 s212HROfmblcA==
Date: Thu, 26 Feb 2026 18:24:09 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] power: supply: max17042: support Maxim MAX77759
 fuel gauge
Message-ID: <20260226-qualify-spearman-7741366b58ac@spud>
References: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oda9qLIMzkgF0K8p"
Content-Disposition: inline
In-Reply-To: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>


--oda9qLIMzkgF0K8p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 01:11:34PM +0000, Andr=E9 Draszik wrote:
>       dt-bindings: power: supply: max17042: add support for max77759
>       dt-bindings: power: supply: max17042: support shunt-resistor-micro-=
ohms
>       dt-bindings: power: supply: max17042: drop formatting specifier |

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--oda9qLIMzkgF0K8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaCPyAAKCRB4tDGHoIJi
0jpUAP9Zppf7acAo4CSV+04+ovg36wKjPF5F9zaxo+PPgQiVYQEArucCX74458Mt
6czH8AoktNoXxEisV1VHkkpKlV2Pvww=
=iLcK
-----END PGP SIGNATURE-----

--oda9qLIMzkgF0K8p--
