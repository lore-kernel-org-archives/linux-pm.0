From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] jz4740-battery: Correct voltage change check
Date: Thu, 3 Mar 2016 15:21:09 +0100
Message-ID: <20160303142109.GC29689@earth>
References: <1456675548-16692-1-git-send-email-maarten@treewalker.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34976 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693AbcCCOVO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Mar 2016 09:21:14 -0500
Content-Disposition: inline
In-Reply-To: <1456675548-16692-1-git-send-email-maarten@treewalker.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Maarten ter Huurne <maarten@treewalker.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 28, 2016 at 05:05:48PM +0100, Maarten ter Huurne wrote:
> The check is supposed to avoid redundant update notifications, so it
> should check for the difference between old and new voltage exceeding
> a threshold.
>=20
> Also make sure the result of a failed read is never stored.

Thanks, queued.

-- Sebastian

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW2EhVAAoJENju1/PIO/qagXEP/RhkwVSP/+OhbtjsL4C3LtxT
64fDRTRsi94jIVUUWMCR5g4Fuh8UNo9iOmzhfV0pZQNf/EaTb+iojChqOM6do4Q2
9AeooP4aKEfFO5gmXNCEQECdVL6XROte0kofwFaX04KATLdIacu5m+A/joBunQ+r
nJWjhDSCIfEtsI8M46WTnmJrSvJh98NS0c2rjJ4hCswZCEytRzylvGRA+vHTLpqj
oEDiJkJPzdtyyBgqeftT4ZPKbxD1YBp/0h9JbuMirOjCPQMWuZRY8yFZAcVaVyoF
oOpJ8SZU98Qkvh+T9l+WBW38DkcgUZwDTjL6bPpmP7TMWR/WNxfg7/ATCaxZ7ZBY
q7678PTm/VX6qvSV4UfKx7TEE0KhweCG9SRK2KoUmiuGs5PjsCNru4deAg4ApPQd
uP/GkGXtjNcQ82dabmnWBAX/2em2P2hilFANJcmMeEjkog68olHB34zdaJoC/pnh
GwKzyy21RWK/WieBGVlBfGIDbRayk90JRHSrklyRG9TGbs+MIrk2lNppXD16qRct
743uo2XN5GzNRhqNfaG45sSr7OA8MaXfRHoT5EB6otNeeUTWBwsbOrTjEPq1ld3d
eRGqkoM5MwdK16KmhT3cgDKwvM90zML+Zyxw9AfOlUgUcHBRAxVcFCB2AQ7OzVbW
evsew5iedvYCEoUVmw4s
=Aqs6
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
