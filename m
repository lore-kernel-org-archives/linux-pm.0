Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E440B6DB;
	Thu, 11 Jun 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198546; cv=none; b=DU31QJKXOhLdwsEHlfz0jeth2IERfWpDyDdz5lLNA7O9rbI8tCxrOU3JlcMXjx4j66M8KzGme1Q1CHYBUT5babdXn4zvHsFpFaAVfhAiB71GeOeMXl+hycylsOjx9MSimQbzjdBYT3nb5Ed4Nuf/GtZEFa9Jw83GJqDBsjqQ7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198546; c=relaxed/simple;
	bh=KdWDhxFqpyK1ExaLMvzw0M+RE0xOM5zE+5Ap11B9AYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te6d730HnfxVl4SWWZZvKbeUBAmPCv9o/fR12vHeJEJTjC0vragYVLg46uAsBcc28n0iy8uKR7okQsCrwNSg45b2h+PyNuwoAuchNodEQu/kdMf5LBO/C0dFJtkaYdcThpVtSuV9ixSG4wjNp2eB/3SpmONSBifmmKbFU3cfJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQG9tRUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQG9tRUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9351F00893;
	Thu, 11 Jun 2026 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198542;
	bh=KdWDhxFqpyK1ExaLMvzw0M+RE0xOM5zE+5Ap11B9AYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aQG9tRUlJP0O+Sd1fT0nlt7WRopgp33SXyAE4qF3jz3ZTjUjfZeejs/nBQM5g+QR0
	 LXG0TitQNUIZXakKtCp2BTi08j8WexRYvM6omta+DVAk4WLkYU5imHgkuhhVmCDnzg
	 LC4QWKB7GWXxfwhmCwf+MsQ/0i5KVsERKciUTHj0EY2BHCHoH711MMcpfWzegs1cPX
	 N0JjRTnmhZtcKJyPdtQmUklA1b6aq/oXr5mhWaNcLVXXBgkc9wJGjykRw9Qh/EbwhB
	 Xwyy2ziCIUeQDWT+pSLwW3ssf9lKptBLCi7mXkENNk8VP5HAa9MWWInsVYg+RG3z8t
	 s/j0OBmMxXnRg==
Date: Thu, 11 Jun 2026 18:22:17 +0100
From: Conor Dooley <conor@kernel.org>
To: rva333@protonmail.com
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC
 EFUSE
Message-ID: <20260611-density-hamper-2b89bac89312@spud>
References: <20260611-mt6323-nvmem-v1-0-b5e1b9ce51f2@protonmail.com>
 <20260611-mt6323-nvmem-v1-1-b5e1b9ce51f2@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8jlD8HCh7FfdJwQ5"
Content-Disposition: inline
In-Reply-To: <20260611-mt6323-nvmem-v1-1-b5e1b9ce51f2@protonmail.com>


--8jlD8HCh7FfdJwQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--8jlD8HCh7FfdJwQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCairuyAAKCRB4tDGHoIJi
0mk7AP9Mb5T4kei+ZQb9DUhcF53VPvmUwgHWElm07FdeB+BdKQD/Q2pgevrbI0it
++Mc/nhVwa+UmM4gJxL5PlSgYKXFDQs=
=bEoR
-----END PGP SIGNATURE-----

--8jlD8HCh7FfdJwQ5--
