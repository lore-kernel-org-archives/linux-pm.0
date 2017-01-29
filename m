From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 08/25] dt-bindings: power: supply: add AXP20X/AXP22X
 AC power supply
Date: Sun, 29 Jan 2017 17:22:55 +0100
Message-ID: <20170129162255.if2o2ta4wt2vetad@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-9-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1930141511616263303=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127085458.18270-9-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============1930141511616263303==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="glly4zgcqyavd4xc"
Content-Disposition: inline


--glly4zgcqyavd4xc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 27, 2017 at 09:54:41AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs have an AC entry to supply power to
> the board. They have a few registers dedicated to the status of the AC
> power supply.
>=20
> This adds the DT binding documentation for the AC power supply for
> AXP20X and AXP22X PMICs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Thanks, I queued this into power-supply's for-next branch.

-- Sebastian

--glly4zgcqyavd4xc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOFt8ACgkQ2O7X88g7
+poOxA//csQTqNEfRMTnV6ZIYYcCy6RntNXATJ2wJ5wbH+X98r7MsrrUYdBP1B30
Y6/TI64oE3VLdAcG+8XLEWM0YAXeCH3MGRR3YJzP7QsPxWps0SXUHTgimmXNMki5
9BKvqi5LRwzBYLBRn4uvpJF1P0lDQT1n7lWLSBB6vRETrD9Ztg1bNVYRR7NSmf/P
3HLOsSGon9ayxl9DfxObcwWW6a4NsvKLlRwYxUmhqmzRkLAjpXnTGrLnI6RZLL5+
/SItb4k41RQblHOzO1HhfgfmTusKmosuOIt6bnci0VxA8Hip4ZBMwmDZGSP0nLse
VcWQ8v83zyJx5Z6m1aksNp1XoVbo9lwbSuSRsn2OL4jeuxmD9Fyt91ZT+PySVlvo
vJD/Feleuu8IhHnGMjSUq/vlqC4rgzU+X6cxmWEiJnP3OxvyYcsw9WLg73b2qWnk
LQkFypqjsBqDxwghucyubQGsfzHyUf08RymcfFHXE0cRfxa94aOxoCjc1TJR1BGX
Vm58ZEY29WcVn/DNj9HHdOhJHnWHna/UOnRpBYYfaYche+B/qe3QqWrBuaNM6teA
EFxX10pPYlIFaKUjAiVT52Mtwc1UefAb/Tgf6zDNPplzk1cKBTz+ZsMTZVvOP7MW
za9X7zdzdT/qha4e+8RJtjPtGFUJxGj2OFD7seyExa5ihTIvFy8=
=xeUO
-----END PGP SIGNATURE-----

--glly4zgcqyavd4xc--


--===============1930141511616263303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1930141511616263303==--
