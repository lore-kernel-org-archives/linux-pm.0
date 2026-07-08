Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68943079A;
	Wed,  8 Jul 2026 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528331; cv=none; b=FMV2m/T4OnyO4WEEmLqeqWJdz/0YSGZ49X5+o32U850gKmBCmLLTW6ATKjm24aN1I0Oo7IsDTobn4hOP8VLegGd4cNj3ve9GW2pEWQBq5+v0AOtDcvtazr8DTwjQJMmK1kK7hUhiBD/PUCMwk9uXlwyEmydqqYQrXXbArWEjcew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528331; c=relaxed/simple;
	bh=zFss4/S/yICf8SJT5ZkocKJZ9yfXRXHEIAWnYp4S8eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NANwvSkhArEwJh7vL8YAbWKU8z+fnNq/pdNKmlavrONtY5uI2pLX7uLqaHFnW3RJPhz3l6HAzUa16g1W/3NoHM39J4hUVDafWYYUNsnvCNN4Su7CTz50GDgq4lYFoIC23b6n9VVqEcm/F4KcDTiMjb0VnwqM7gTLseEW4gvLKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAP8EYUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAP8EYUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8DE1F000E9;
	Wed,  8 Jul 2026 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783528329;
	bh=zFss4/S/yICf8SJT5ZkocKJZ9yfXRXHEIAWnYp4S8eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZAP8EYUweI8vZ2h5UcuFPR8loWnsmjyNJ4N61SKwTa9UMG2G9e4qzXcDgkXuFtiU1
	 8Q5JChIk4/07ORmx6DnL8cpQtfVdK9g4qftdyyC17KFBqnzzz+bIkNm+T+nPtJ9hmp
	 6tST/6SipTtE5Qef5JsvDUF6ZVRsClYuSsaQTl/kMY3xIBUPxAVtblUa6ljSJaWFOp
	 62piQNPCiV/pyvCPwLEV0h69TRPMt4FMEQ4chFhuC9Tm+mk539em3g5BvzkWhxgQAa
	 lL0GvaArFiACjM6FtVxCn1N97Pi69ebrZ+X/VKznN0KrD/obxDdH29Hl1rXTFRE7fN
	 RHWdwuO02IEwA==
Date: Wed, 8 Jul 2026 17:32:04 +0100
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
Subject: Re: [PATCH v2 2/6] dt-bindings: power: Document Renesas R-Car X5H
 Module Controller
Message-ID: <20260708-sloppily-await-9056ac43f82f@spud>
References: <cover.1783505142.git.geert+renesas@glider.be>
 <1d79020a5eb2f269ea7ebb354cdfdf880049721c.1783505142.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9S5YLxV5XE/gLITr"
Content-Disposition: inline
In-Reply-To: <1d79020a5eb2f269ea7ebb354cdfdf880049721c.1783505142.git.geert+renesas@glider.be>

--9S5YLxV5XE/gLITr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--9S5YLxV5XE/gLITr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak57hAAKCRB4tDGHoIJi
0q79AQCJny6b8ULtU4s5HEzRTQXsdH21tOGDifiLLTrYxwzSOAEAjIk+aGMPyEn1
V/vEagzuhyvClTV9b5nPCGrzfvLaBAU=
=oD0t
-----END PGP SIGNATURE-----

--9S5YLxV5XE/gLITr--
