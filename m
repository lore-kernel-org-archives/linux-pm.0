Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35F416D03;
	Mon, 15 Jun 2026 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542152; cv=none; b=VM5Iti4Dyp0rglbBYWRkzP3J92jQkOzeCYaOxxGIZ8aPLgkgVUL1I9ocCu1CL/zD02H8/kDcBsdihxltY+3YgTSY3YkDwXNMXp9mBrKLAMO8A2L85ZL41Ll5mON1NB8POQYB7h9wgxWJ2pVafPyIMHGnOEWdo/9VxkY3nQ685GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542152; c=relaxed/simple;
	bh=rL3bZLrnUYURF8thqtoxReFNhkZUU/y7H9FUEGpZHlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzmKJs5cXvxpkMPnJgaCPzM/F/2ATJ/PFhZdTeGN1mmzziEQLe2MoHAw1XKWY2JisbEIqdjH0S3SMqgNcL7MuC4mSAVnXcrzy+sIHPKM7Yq6L1j+EURe1EKcVXcY/wP41KPwy/Hw4tKLwylWtQKbU7yWBIFjWKb9VwTOQBRBVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8LcJjd/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8LcJjd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60B41F000E9;
	Mon, 15 Jun 2026 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542151;
	bh=rL3bZLrnUYURF8thqtoxReFNhkZUU/y7H9FUEGpZHlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f8LcJjd/1HjAnpmX20Vn9djIiVGiZCV/WTc3HJ/wfaEmbciM09pyS4RAPgOhcfF/j
	 IJL/Tlx6f87EiSalmrO8wzxxYefAy4aeCCWtl0SCdOy2Cpu0jQFCfZqsF4nZYix5lm
	 sIURhYzU2tWr3Mkw4DzebDua/cQ9LjMAGWX7GEC5jSjf+A9l0EkUSqf709XLumEfjQ
	 ChScSOOykIT35cJu0rYeX9FPqhvGFwfvmfzcPE3WjCpJ/nu+EPSJ9vvx26tJ43wT43
	 gOtMN/srrm53JcLut48+BgAjo+xmTUnNspwRY5WpwH5bwiP06SjBMd6gAAqzy/9Ivw
	 cPfZdf0OUzvWQ==
Date: Mon, 15 Jun 2026 17:49:06 +0100
From: Conor Dooley <conor@kernel.org>
To: MidG971 <midgy971@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ulf.hansson@linaro.org, dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	xxm@rock-chips.com, chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com, diederik@cknow-tech.com,
	jonas@kwiboo.se
Subject: Re: [RFC PATCH v4 6/9] dt-bindings: npu: rockchip,rk3588-rknn-core:
 Add RK3568
Message-ID: <20260615-drift-dreamlike-0323a8dc5ce9@spud>
References: <20260613070116.438906-1-midgy971@gmail.com>
 <20260613070116.438906-7-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CNSFopl0nkQ6YS29"
Content-Disposition: inline
In-Reply-To: <20260613070116.438906-7-midgy971@gmail.com>


--CNSFopl0nkQ6YS29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--CNSFopl0nkQ6YS29
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajAtAQAKCRB4tDGHoIJi
0jbdAP4q0Xsijjrii0xb5mKoYRM8X3GV+zM9Ls2VeJvRKSouvQEAiryegcy5biWz
HQrV9PRAFwdCKCO1WUIBrZR7rlOn1Ao=
=kTnb
-----END PGP SIGNATURE-----

--CNSFopl0nkQ6YS29--
