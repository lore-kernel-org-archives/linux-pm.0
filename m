Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26793F23B9;
	Wed,  8 Jul 2026 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528372; cv=none; b=M5yGF3Cl54AXwRFeGPXxhEYpHahzs0tb2yMohLcptvko4mBFRCd4hzCmycuL2ysx/K+S9K+wl78rImt4VH1MGxP9/uOlnN/0u8c5lafiksCPRiu0WOa22ug6XgDXtv+7itqO8BVk1Dl+Bjx4p6MYKyU0tux+ADHeUPRHoPlrVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528372; c=relaxed/simple;
	bh=mDggZD+QJqlEA2zRqaI2SGJsu6BDMXf4CbvxFZeGk4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db9o8Oh4HotwlpWU2HD9OlrPI1o0N7ZvKOjFpf5i6PzaqnhPCEnGGYcHnexCA0QjlnPCf7iGo2cyuQhkc6WnWrtjOpFNkuXTjqkcjG/TDcgBB5KFO0fBk7KSC2qVwL2kOTuQ4wZfZH//JvjKhW/aNvTLB7CKyUjZDGPfamrMqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWBUVJVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWBUVJVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B411F000E9;
	Wed,  8 Jul 2026 16:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783528371;
	bh=mDggZD+QJqlEA2zRqaI2SGJsu6BDMXf4CbvxFZeGk4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PWBUVJVZn2RpPmIcNCiUj29WhFoz0zJiRDBkfpHwALAC5AMAA+a1dA+fqt9VsgdYN
	 tsoe/6XGzIIVm0P1For4mrZkz1TNTHI81ILetovOyCEy1x8LfAJPGEUV4kLBF0Hh6C
	 ZU4ZwAGnjeD5KeNEKq7zHwd50RB/5US3BUf1lD38Vgyv/LAJ5WYheF+2E7/Yiq50mX
	 pJTn1Zrjd2WQvsvYrk4RUjHcewf7ZWj400z/vGjD2ZX5EsQzM+uVYFklwKz143DdDE
	 EsVtkutYxc95WgF90qb3IaAtaUzV6gxdfFu4cPUMTbw9qUCbzqTCU5IG5smSEN1q5t
	 7RWD+vKUGrgMA==
Date: Wed, 8 Jul 2026 17:32:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: Document Renesas R-Car X5H
 Clock Pulse Generator
Message-ID: <20260708-valley-lazy-5c330630485a@spud>
References: <cover.1783505142.git.geert+renesas@glider.be>
 <f0f2e810b249a60ff7c27d508366d66be061fed2.1783505142.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+js/rSO4/JLZe+iv"
Content-Disposition: inline
In-Reply-To: <f0f2e810b249a60ff7c27d508366d66be061fed2.1783505142.git.geert+renesas@glider.be>

--+js/rSO4/JLZe+iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--+js/rSO4/JLZe+iv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak57rgAKCRB4tDGHoIJi
0suDAP0Y7kKxguK/KmeWU+H6eYs6+NPHihHz7U8UE2vznOiVFAD/QFYF6YnnLV6J
OVFcr+QJR9wTl3FiI/QmhyUL3Gk76Ao=
=aiCV
-----END PGP SIGNATURE-----

--+js/rSO4/JLZe+iv--
