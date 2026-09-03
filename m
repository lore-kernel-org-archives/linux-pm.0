Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140544B129F;
	Thu,  3 Sep 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456134; cv=none; b=pkXJNFxNXcr1qKY8mhTeLwffLe7w5fD2Z2NnTCHyJQJQKXWolzQG2gGQADTuE+PWzGl2bV7awz0c0MCowNfF43TdQ9t1JGB+jUeibgsUovAab3/pIJTXYoZiXyljDXmNIOv/Dwg7Zhq2D24BtCcBE/WXPnnB3qSsbTJSvv6fLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456134; c=relaxed/simple;
	bh=XvnTQxFgY61UGE2ft9tFLjsbyTsoA/BlZA8xRu7UTQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm0cbk0LLOfPjez8eKU+EcG7ZfXNEg89mQ5pmRncMUkdZX92PWhTbGrST4cffIh1+rV92ePuc4P7sVvAwRetPCwFe1OD3OxAsk8KNyeDyT2ImBgdI74MQoTKLS1gtKyLSNsjbIU12NzC70hWxfvTULk3V9QJ95lcQqEypf7GnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErbWB4XT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErbWB4XT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912221F000E9;
	Thu,  3 Sep 2026 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788456132;
	bh=XvnTQxFgY61UGE2ft9tFLjsbyTsoA/BlZA8xRu7UTQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ErbWB4XTfH7lCfPrEIvBxWogp6UT8r8sszDuSVROiVrapPMIQcWAuDUkh6TPKIyj4
	 Ag9K+G9m+UdsTMKVqGCkMs/i5mJ3OEef0zxKEOil/hqZmcwGZwzsIMtxXNfqrWbKCT
	 dxHTxFzICPetVasAc06M5E5nNZIHVPAuG9Gm4mJLu/QIu+YiU5Pcuefx9k+VHD+zuv
	 Xy6ud/R1y3BZkgvCObAdksFDsaR8FfPnJWid/d8Qs5Y4ToNyZACRTsU2acPiKSV9hB
	 EzkbBq1uEes6CuEaDnv2Lps0oxZXTv8LV4Tqlj4ZMggbv6yk/L+dDDZ9dvt8dUJczW
	 A/pGv391wmCHQ==
Date: Thu, 3 Sep 2026 18:22:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: rahul@summations.net, anup@brainfault.org, lftan.linux@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ulfh@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: power: Add RPMI device power service
Message-ID: <20260903-devotedly-expire-fdd219021952@spud>
References: <20260903092347.620060-1-joshua.yeong@starfivetech.com>
 <20260903092347.620060-2-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c9aX6c3GUC1XB7Kb"
Content-Disposition: inline
In-Reply-To: <20260903092347.620060-2-joshua.yeong@starfivetech.com>

--c9aX6c3GUC1XB7Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026 at 05:23:45PM +0800, Joshua Yeong wrote:
> Add device tree bindings for the RISC-V Platform Management Interface
> (RPMI) device power service group, both for the supervisor-facing power
> domain controller and for the SBI MPXY channel which the SBI
> implementation uses to expose the service group.
>=20
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--c9aX6c3GUC1XB7Kb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapmsvwAKCRB4tDGHoIJi
0lQTAP9vjD/TR3Hm8070BSAXKYtk9ZWy43AOda42jG73y7bb/wD9FKdr/H+YxfY/
F6O5StnbAOkwixw2NJaxoL4sqBbzyQA=
=RWhM
-----END PGP SIGNATURE-----

--c9aX6c3GUC1XB7Kb--
