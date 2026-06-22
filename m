Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AC175A74;
	Mon, 22 Jun 2026 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146724; cv=none; b=hBcoLh3GXVQFaEHRnicl8wDlu0tkh5KknF5cGmR6zBDWw0gbSoEQop+G7f0zdQMDbIYyXPj7rD6ktipZkJMnQtFAYL7cUgav8TmqWqnVJEykTOlqBhXHBJoofoR65MnLpXA/4VMS7AukhZ+1LVq+v6hFJeUpBgdyMwoAkPsGo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146724; c=relaxed/simple;
	bh=Xqk2PHK3QCcWR0jjFn371IClVpNTBYwDv1jn3DNcUe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaQfLvxw5I3HheqYWe6FH0FPPM9Y/HhTac7kH+8kWoIAe7uL+lgIptN9Vr6QBKcZWPej2KA+P6YVZxvO4SnqxjeaTctbOpls9pNzlxbpCErGB055eft0dC+kgYqIHQ/spphNaN8OnyuAUJXA0Uy8xkY9aUBO3nCJZJQOwXqdEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVKaku24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVKaku24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F521F000E9;
	Mon, 22 Jun 2026 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146723;
	bh=Xqk2PHK3QCcWR0jjFn371IClVpNTBYwDv1jn3DNcUe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AVKaku24GCYD0nsAW1vZxZNtgMsHsrm+c73K7AuXemZwpiQO9iNpfup9UXM5t0jk0
	 /vlizguXb05465Sg1/NmG6OZ7v4yrp8T3es4NTdmMV50mTBnFGAR5tQ0/4q7fhlU3G
	 F9Uk2OJopCOIUSkIJRlAipr7r2+cSjm2Foohgj34szBtTGuAs1OOyiXb5f+qC6lKXC
	 iSOV4Ltl7h18n7JYVmpGqpyZxWE5NehTCqqKfsEyUnyZK6L+shScDUZvWdLdtjSZPb
	 WOkexDPObYafzBfZPrZUFjeB6Q9M/yQErD9lmgCpeU+Eew90c5YbkAiOr8SugerzmM
	 xMNJiaTdPV/Eg==
Date: Mon, 22 Jun 2026 17:45:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: thermal: amlogic: Correct 'reg' in the
 example
Message-ID: <20260622-lance-handset-56a9a04b21a2@spud>
References: <20260622100231.438435-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260622100231.438435-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VxYsUdreCsY5xfN/"
Content-Disposition: inline
In-Reply-To: <20260622100231.438435-4-krzysztof.kozlowski@oss.qualcomm.com>


--VxYsUdreCsY5xfN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--VxYsUdreCsY5xfN/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajlmngAKCRB4tDGHoIJi
0nnnAQCxwPKlfC+6wk698cBtgGy7NFD5m7eCQqgTcIXn4ktJNwD/SkCKrgG+s3Z1
Hi/BvoQbiP07o27QsROG7/bcxrfXqAs=
=JdwR
-----END PGP SIGNATURE-----

--VxYsUdreCsY5xfN/--
