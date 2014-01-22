From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Wed, 22 Jan 2014 18:11:06 +0000
Message-ID: <20140122181106.GQ17314@sirena.org.uk>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
 <20140122114232.GB20247@sirena.org.uk>
 <20140122163322.GF24288@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p9mNGPlHbodNIlPs"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58211 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbaAVSLY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 13:11:24 -0500
Content-Disposition: inline
In-Reply-To: <20140122163322.GF24288@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Antti Miettinen <ananaza@iki.fi>, Amit Kucheria <amit.kucheria@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Dave P Martin <Dave.Martin@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>, Charl


--p9mNGPlHbodNIlPs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2014 at 04:33:22PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 22, 2014 at 11:42:32AM +0000, Mark Brown wrote:

> > Would it not be sensible to define a PSCI binding that extends this and
> > other bindings - ISTR some other properties getting scattered into
> > bindings for it?

> You mean adding the properties in the PSCI bindings instead of defining
> them here ? Let me think about this, I really reckon these are C-state

Yes.

> specific properties that belong in here (but actually I have to add
> a statement related to PSCI - ie bindings require a PSCI node to be
> present and valid), I will look into this.

It depends how you think about it - something like PSCI is going to to
define properties used in a bunch of different parts of the low level
code, it seems reasonable for things like this to say that the user
should refer to the binding for the firmware to find out what options
that firmware requires and can support rather than having to refer to
each individual place and have those places enumerate the options for
each firmware.

--p9mNGPlHbodNIlPs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4Am2AAoJELSic+t+oim9p1gP/Algqqod3b8awFi6JqTv6pSP
B2Fb6OXW6MsMGaaA3FVsB2XLv/dma/6qaRDBfLMyoFIQTVYe/cdAjRRzrOdp/25P
/V0DuFGk5r5DXUMb9bi+8kWpTTcInza811RYc4hcdXbquU5nwvLrKQ5/Sl0mYTvp
Hi+np9Kfp7KuxGaY+ir5suNoeYVDnB5YPfDoeZagWplDfte7cashe042ng2RNpY9
psVrXg6Vc8qRMYr+cqll9NumfqP4RwaTo3n8UIpVH69B8KLvohXl7hB63K2Dh8XY
7i1g9gJAEn0SaOFLOXBhNcf8sKaWnnnskPk1C8nB/EK0bacoXefrS5R5RgDyGBNa
WwQQyT+LmjP3z0zTIetDdzy0k6LVS0en23c2aur2FlFxX8+T75xXK7ZzpvNh1dH6
HhuK4h6SCfRDPkF8Sl6fGc4DF94oIhx3hjHJljtJYivLyIvqVww+7pHc2Yt4kiAv
gb/DAZUPV1bS4yCY8FC7G6f3bv8ShDUVpFBRwMV6PbFu0gAY+UtazVYqSTDDseYJ
3SCGASQkTlWepWynusvnxMcZrd4RUHRLi2Ac2qyXTsl9ER5/JqQHj9HAeKjwrLay
ljNMWWi1D8ikWNPkPLUz6OB/j2uzu2DgpV0NfzlHNSTPlg7VtPwPrDLTTQW2a9jx
Pw36h4EgZZgIUAUhYATT
=qoFF
-----END PGP SIGNATURE-----

--p9mNGPlHbodNIlPs--
