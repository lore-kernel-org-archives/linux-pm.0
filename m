From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH RFC] PM / Runtime: Better support for nested irq_safe
 drivers
Date: Wed, 3 Dec 2014 17:53:52 +0200
Message-ID: <547F3210.2010604@ti.com>
References: <Pine.LNX.4.44L0.1412031018300.1538-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9XMi52Vjv8MSaMHnoh2EDME1sPQ9gtiND"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60501 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbaLCPyF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Dec 2014 10:54:05 -0500
In-Reply-To: <Pine.LNX.4.44L0.1412031018300.1538-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Jyri Sarha <jsarha@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, pavel@ucw.cz, t-kristo@ti.com

--9XMi52Vjv8MSaMHnoh2EDME1sPQ9gtiND
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/12/14 17:22, Alan Stern wrote:
> On Tue, 2 Dec 2014, Jyri Sarha wrote:
>=20
>> Is there something seriously wrong with the code part too? Or is this =

>> just a matter of updating the comment (sorry that I missed that)?
>>
>> If the thing I am doing somehow fundamentally flawed, I 	apologize.=20
>> However, this was an RFC patch after all and the problem I am trying t=
o=20
>> solve is real.
>=20
> What exactly _is_ the problem you are trying to solve?
>=20
> When I first wrote the irq_safe stuff, I considered doing something=20
> like what you want.  But there was no demand for it at the time, and=20
> leaving it out seemed simpler and safer.
>=20
> However, if you have a genuine use case then I don't object to allowing=

> parents of irq-safe devices to enter runtime suspend, provided the
> parents are also irq-safe.

OMAP Display subsystem hardware has one main module (dss) and multiple
submodules (dispc being the important one here). The submodules require
the main module to be enabled and configured to work. These are modeled
as a dss parent platform device, and a number of child platform devices.

The DRM driver for OMAP (omapdrm uses the dispc device, and uses runtime
PM to control dispc's power state. Unfortunately on some cases omapdrm
wants to access the hardware from atomic context, and needs to enable
the dispc first.

omapdrm could be changed not to touch the hardware from atomic context,
but that is a big change, requiring rewrite of its core logic. I hope we
get that done some day, as it would be a performance boost also. But as
for today, omapdrm will crash in some cases when it happens to call
runtime_get from atomic context.

So... If what's proposed in this patch is messy and risky, I think we
should skip it and try to change omapdrm as soon as we manage to. If so,
I'd still be interested to hear what problems this might cause, as we're
planning to apply it to our internal tree to fix the issue with omapdrm.

But as the functionality in this patch sounded sane and something which
could be usable for others also, we wanted to try this approach.

 Tomi



--9XMi52Vjv8MSaMHnoh2EDME1sPQ9gtiND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfzIQAAoJEPo9qoy8lh71O0wP/iC5qLU6UMD5VsaNDnJkETPY
3vTlG3fSO/qOqJ9W7oWIN0YbZPdemMqR8MBApX1Cl4dJ7lnubi3WG/u5pkVfw+wl
hv/XkBH1Zuc19SBFGixV4UIOprjfTYGnbTNrHP9zKd6H/ly3FPnNeztORW75HFIO
kttkhhedxbiJ1AJUjskcztrjFBVoXW1t8cZKNMpzT2G8417hdi19lAHVg83CheoB
V8qyNQp87srjM+Le7acqy+qJcsEREAtQWOa6R4COC7hGIVHmRWENPh/kpux6xxUm
j7FEeWUluIIs6vN++PhAH7XlebeHMXAoJct5tJobzZAUjC6ck/F9y4qTttxp8tuP
UvZCXvsDPhGeiKO01ctLMCJEIzAn2+tzTgW1UwHPdwYGZNvGnXVhBlTuwz44Ewi0
J1dx6KnlAYeAQ8T5bsp3DKDTNEw8v53SmQh2PRjwUjO4t9UHne89dvrT0KdmWLsf
n4R6IdX9aD8bRDkOAO3/pnAYqcAX/fiDKGYRPAjxZjRv0rkINBQILzPQ7EGUlNuE
XJqVAU+ZrmT2d1GwwDFuzQJLWjqimF33QKR8RjhzoRkQ2QB9FIvo3DZUeqCiKPoK
VLVic0g5HVZDgqYz25toliHd6emnBXIfxbt95A87yZQ0LTR7g4+aHTICaw1V2uCL
VwS/hUENqHln2Py7LvCG
=nBip
-----END PGP SIGNATURE-----

--9XMi52Vjv8MSaMHnoh2EDME1sPQ9gtiND--
