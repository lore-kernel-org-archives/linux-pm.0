From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: Add MFD_SYSCON depends for brcmstb
Date: Fri, 1 May 2015 22:54:16 +0200
Message-ID: <20150501205416.GA27735@earth>
References: <1430423702-6320-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45889 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbbEAUyZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 May 2015 16:54:25 -0400
Content-Disposition: inline
In-Reply-To: <1430423702-6320-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dwmw2@infradead.org, dbaryshkov@gmail.com, computersforpeace@gmail.com, bcm-kernel-feedback-list@broadcom.com


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 30, 2015 at 12:55:02PM -0700, Florian Fainelli wrote:
> The Broadcom STB reboot driver depends on MFD_SYSCON, it uses
> syscon_regmap_lookup_by_phandle() which will not lookup syscon phandles
> if MFD_SYSCON is disabled, and instead will return -ENOSYS since it is
> turned into an inline stub.
>=20
> Fixes: 030494e75064c ("power: reset: Add reboot driver for brcmstb")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks, queued into fixes branch.

P.S.: Please rebase patches to current tree before sending them. It
had a conflict with 4f5fd6404698 ("power/reset: brcmstb: Make the
driver buildable on MIPS").

-- Sebastian

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVQ+f1AAoJENju1/PIO/qaZvgP+weHU8wg8suTlN56T7E25Frl
vd01CeDWtsVB1qYj0l0O37/SJnnEBoc5vu/d/KimqVwNJb1bLqPeCo+OIXMxlxA1
Ys46TdL6uRHgcLyKrXSKqb1bKA4ojRbOqpC77VpmDpFEP8RA2o9sC+Ls79SPztem
tLOniLHPohtYWzTUwB8Rv96g06U+yB8YmSOzlRmBvy4fGWp/EfEp5xalxIuuGRDw
e071fILxiSQEb8RQzZgoousSEZ+s997O4VjnUtCwd+0RqMIvNSRHmyhLmo9gEDVa
uXzv0r4kEAbkW0wxCc5covuJon5mhDrGWzlcCZ/59pvheNm+Z85JamOwz6NVv7P8
hk3A6I6wU8WWNIe1PXXYvFOQas3fvLMvgT2uU3JILNf9fakMi58/PF9af+lvqvO9
UL7MFDke9FqYyHKNVlqrzWiwP6J6/uzPmVvUpFrunYvd1Ui8Gyc9l51rzorsRDAw
neWq9EV7oUSgAkUc9nxPBDK0yZp5u2sxtKOJnhLI4CmsvGhT+ygQSMn+PRA5x9N6
khdrjdgSXnrp+yKZlCsrOqDWD3tNw9dskbuTtCDN9TcZhoniVMW3mf1H5KL9mh16
DrWbv38h5IXdL9TqjmWAbxOgfWbb/BYsaJALzYnFLk10VH1xqZVi4beYA6E3hFZx
JVjhmaPkYGR/ZrCQPNHL
=5nEv
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
