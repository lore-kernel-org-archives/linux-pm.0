From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Wed, 22 Jan 2014 11:52:14 +0000
Message-ID: <20140122115214.GG17314@sirena.org.uk>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
 <CAP245DXdFS5FEkrDvSw07aDDuZDqFPZXF=CoBLPrBB4JuYE8cQ@mail.gmail.com>
 <20140121152358.GD28801@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bx5ViS+GRvveobEU"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:57973 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbaAVLwW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 06:52:22 -0500
Content-Disposition: inline
In-Reply-To: <20140121152358.GD28801@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Antti Miettinen <ananaza@iki.fi>, Tomasz Figa <t.figa@samsung.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Dave P Martin <Dave.Martin@arm.com>, Lists LAKML <linux-arm-kernel@lists.infradead.org>, Charles


--bx5ViS+GRvveobEU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2014 at 03:23:59PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Jan 21, 2014 at 02:35:11PM +0000, Amit Kucheria wrote:

> > DT-newbie here. What would happen if a vendor does not characterise
> > the latency at each OPP? IOW, the table only contains latency values
> > for a subset of the OPPs.

> The bindings are explicit, so the kernel will barf. Adding a LUT to map
> latencies to OPPs make me cringe, so I would not change the current
> bindings.

Actually looking at the OPP binding I do wonder if it might not be
better to have a v2/rich binding for them which is extensible - the fact
that it's not possible to add additional information seems like an
issue, this can't be the only thing anyone might want to add and lining
up multiple tables is never fun.

--bx5ViS+GRvveobEU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS37DrAAoJELSic+t+oim9BKwP/jU7EhCv2zPdZG9BisnCV3NI
NOx+deCuUuA6n2LyNpBCmnp2z4xaseFVz0timD2cDOYKqVLVUAKbM6E2vXHlJD0d
fBNA0UNN7KV6kOYHCQySnz/lk73FjlnHEsz0nS5759VzXxOiUlUSHE5tkr7fiXXC
2AVr1lUk5pfC5E7m2ATQmeTv+0+YymbgpXHdLiVQLADKCGB5mZXicSceOVkeHAXy
VlUcjq7azjorzonLxomlpuX3tExSEtMX43R2d6FKTEqoI1AsVHWFutqzCdjlDU44
HVLUunT5ulQzrrG04Q4qM2sSSz4zJqXdcw6g56kLRGmW4XvR6CWJwe3Z79z51MA8
mV1FGRP3CAtprfMWi164SxHmNWoq8r/yhNAJ6xiJmCDBvAZQBDuWZD8iwIXZbO+A
FOKFFZxto5ZEDZjKTNCi7WvLIwgQ8OelJiDUodHQ7xLzJ+IR10/ZpcY69wFgNnuE
uHuncwoGVRIpY7ExW9yfCE5Qm3FjZvfKf/B5KNk6gayYG/Ey4gU/8EU5FpMeqy8h
pjv/YtQt92Kl1hS4pNaKfIAze/Z2mk7gydnUkq/fwtb5P5WywTnv8F9pJzxVY+Iw
c64OXEElagG6ubj1j8SmTugEQ/zkgmiIRgOO6zcBGkRw2rqqsVQc8tWuZT7KZTHm
CrngDMSo2qTALXkfa4pp
=nefn
-----END PGP SIGNATURE-----

--bx5ViS+GRvveobEU--
