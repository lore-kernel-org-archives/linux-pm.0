Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEAA46EF98;
	Wed,  7 Oct 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369333; cv=none; b=k0+ECiYffwnE9CrjuKwSXNMeriDsr7qrgoc9hw3ygpZvV8uUnYsGMeOzfQ20EtojzYmBTXEk8J02FO8yJutCg2wExua/RpRUMg48a8QVBr5Nh3zGITvU9yPPL9x0PwyOqwfLfwgpwRa4gVqhXFNTz3hqf6k/aPOLVHdptM4LPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369333; c=relaxed/simple;
	bh=ncIs41s2ktp8uTT/AXGaEijsgYHDEVjydfK9usBaFZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQQGrx7ddFgcXxBef2bwYpp5tr3cvqLmygkas4hRRyFUcl+XvrKevgiMl5DGvV9sCmNEZ3E0hGSeAwk2QK/IO0YNg9XVQcxLlx5ClAOEpeM2nmxIVhA1YIDv33iruiGf079Y9STkc2uaxX4tJ+6NuU+fKCoJ9t+O1RnOHGI6CKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/hUUrBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/hUUrBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E579E1F0089C;
	Wed,  7 Oct 2026 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791369298;
	bh=ncIs41s2ktp8uTT/AXGaEijsgYHDEVjydfK9usBaFZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C/hUUrBU1NdXxYORBhaBUE0oxlcwUquWsccAazvzffTBHh8d5s9dhs/3znZMtLNEE
	 rMFNXm3lIrroVMCeUpriHsLnNpGXSc0qGfaatCgt04AkhW627Lfa4JoRVGn7jd6QTk
	 YjKTW//iazwCaNfGvCLMMEY57QDAQmS6xIFZc6SLhLC15kZT9Q0PISy3ErwSHnhkja
	 7qCmh1JvcHdD6sXGpOvp0UTuV3cJtXlLC+FdSArFeP8npYGCZH0razcZVor8E7llvl
	 goM1AyrLg7ZYhf8aLUkrw+hkspTr/DALLA0Q6yBSBwh3zS2gu9Fxja77dWCL+ePDNe
	 qlbW/EbcF6Q5w==
Date: Wed, 7 Oct 2026 11:34:53 +0100
From: Conor Dooley <conor@kernel.org>
To: servpol@tuta.io
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add GL.iNet GL-E750 MCU
Message-ID: <20261007-ab78044c69a86a7749f8afec@squawk>
References: <20261005-gl-e750-mcu-v1-0-499d2e31f786@tuta.io>
 <20261005-gl-e750-mcu-v1-1-499d2e31f786@tuta.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Otyx4jKhsW++8nqj"
Content-Disposition: inline
In-Reply-To: <20261005-gl-e750-mcu-v1-1-499d2e31f786@tuta.io>

--Otyx4jKhsW++8nqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Otyx4jKhsW++8nqj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasYgTQAKCRB4tDGHoIJi
0lyPAQDwteIZcJ6VK6RZ5wCMbM6Pl4gMMBx5kVWPNQbph89BVgD+KojMcHR/tBvk
MkXPbjlgOkcbKsqPmrfsF83lOXuPPA0=
=UyAP
-----END PGP SIGNATURE-----

--Otyx4jKhsW++8nqj--
