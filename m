Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF92E22B5;
	Sun, 17 May 2026 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051175; cv=none; b=fe0iPtur6HPp14P4IKmtwcOTuFsCbFjtRVdmY1QD2Qet8kGSPz4rEK8MUUte1dUjDPOvIDAhmCFxQAxiYIJlKXwLCeo1oBgnFUIIoxrlJHv0CIzD8u30fJtqTjFCbVQj8DhgjB+gtAhNkli6J3cLFCb2PBAIFKh0UhVganHdwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051175; c=relaxed/simple;
	bh=lBEeLCufjUUnTEWi6mtgR5ByJUe7zVY3tuV617Ah3d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFgb0L7y9sgdQnRcp37+dmMt4fF68ucKP9TDBB5EEaI2Qhsk/12qvzq+RgHLM/bhMonAT70L+K7VBGoNkse9NvrstXVIegufVE7N+HL6u8QVsiyEYvrrkrgtAZHauGBkLtA3wwVepMkmyTaHfzMrQavC8utHNHrdMn2jCXutXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1U9qA2w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1U9qA2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F526C2BCB0;
	Sun, 17 May 2026 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779051175;
	bh=lBEeLCufjUUnTEWi6mtgR5ByJUe7zVY3tuV617Ah3d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1U9qA2wlrxkU1CVjCYWp0GerjGb58s+WTSjtIxE4BYp205CYsDTMhzesKrolDoo/
	 TFJS4XQrJEHSq0UlwBOKu35k4/Ym2x/IhXgqG7mVe3rInRiLsHU6yIDKMjDTZzv1K6
	 olHE1gOBmu3UyZXD0A54izrgMjiBR1QD1IrGAvhscaMAZyRb0oZrCv6N//q79US14E
	 NIPQMvlfadSGb4l35ubjJgz2l3a9rB1XHJKjXdOWhqrFhrJY9qZry7KxzuzzrojXMH
	 XNJbsBNbQv+i2nIvpVdM8tpyxTm+epmF6qI1XojxM6k9eUL4T4eYqVnH2JTItSVo8a
	 v1Bu0rudI0qNg==
Date: Sun, 17 May 2026 21:52:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Nam Tran <trannamatk@gmail.com>,
	=?utf-8?B?xYF1a2FzeiBMZWJpZWR6acWEc2tp?= <kernel@lvkasz.us>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 03/11] dt-bindings: mfd: add documentation for S2MU005
 PMIC
Message-ID: <20260517-corrode-tuesday-a598ca734b38@spud>
References: <20260515-s2mu005-pmic-v6-0-1979106992d4@disroot.org>
 <20260515-s2mu005-pmic-v6-3-1979106992d4@disroot.org>
 <20260515-justly-recite-6028f4bfb24a@spud>
 <DIJK5FTQ5KWG.HOKZAOXHTGU7@disroot.org>
 <20260516-esquire-chitchat-0fffa597e2f3@spud>
 <DIKZ5L2HC2CV.YL3MZUJQ2EV6@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yhm6/mFYCWLfhh+J"
Content-Disposition: inline
In-Reply-To: <DIKZ5L2HC2CV.YL3MZUJQ2EV6@disroot.org>


--yhm6/mFYCWLfhh+J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 06:39:37PM +0530, Kaustabh Chakraborty wrote:
>> >> >> +
> >> >> +    properties:
> >> >> +      compatible:
> >> >> +        const: samsung,s2mu005-rgb
> >> >> +
> >> >> +    required:
> >> >> +      - compatible
> >> >> +
> >> >> +    unevaluatedProperties: false
> >> >> +
> >> >> +  reg:
> >> >> +    maxItems: 1
> >> >
> >> > Move this above the child nodes please.
> >>=20
> >> But properties are sorted in lex order?
> >
> > Typically the binding is sorted in the same order as properties go in
> > nodes. Common stuff like reg/clocks/interrupts therefore send up above
> > child nodes.
>=20
> So, do I change this? For one, I don't see the same being followed in
> other schemas of samsung in the same dir (not that I'm trying to pose it
> as an argument against your suggestion), and this was reviewed by
> Krzysztof and is adderssed in v7.

If Krzysztof doesn't care, then I won't ask you to change it.

--yhm6/mFYCWLfhh+J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagoqoAAKCRB4tDGHoIJi
0leuAP9Buz9rPpNnrPIjeAGYrA+vCW1UrZH0CEH0SKms57TxVgD9HnOrK1jIz9c2
mx+0ei2gI/uPCPc7CzLafRs+JazK+QQ=
=GxqQ
-----END PGP SIGNATURE-----

--yhm6/mFYCWLfhh+J--
