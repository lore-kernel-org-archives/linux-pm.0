From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] power: surface3_power: MSHW0011 rev-eng
 implementation
Date: Mon, 15 Aug 2016 23:58:50 +0200
Message-ID: <20160815215850.3g7mvrquvooojr7x@earth>
References: <1469807366-24642-1-git-send-email-benjamin.tissoires@redhat.com>
 <1469807366-24642-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pubkjadzdhgfcvxh"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469807366-24642-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: Stephen Just <stephenjust@gmail.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--pubkjadzdhgfcvxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 29, 2016 at 05:49:26PM +0200, Benjamin Tissoires wrote:
> MSHW0011 replaces the battery firmware by using ACPI operation regions.
> The values have been obtained by reverse engineering, and are subject to
> errors. Looks like it works on overall pretty well.
>=20
> I couldn't manage to get the IRQ correctly triggered, so I am using a
> good old polling thread to check for changes.

With CONFIG_ACPI_BATTERY being in drivers/acpi/ and this not
using the power-supply subsystem's framework at all, I wonder
if this driver should also go to drivers/acpi/.

-- Sebastian

--pubkjadzdhgfcvxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXsjsXAAoJENju1/PIO/qaC0EQAJbtOgztd3Pjaff1FpJsXY8S
Qjmg5QVfJKgN2GPNN6EgfdCH0pWDRbvBCh0mRuLy2uaSChWFirsSRoAdwuqHbQOr
y5VRwVMlHBpcPiXilh5FBdCGfP4c0W0Fhx9lzd0Smzj5js+CO7HQuTR0GLAaYMOG
+S7b6gSiGSBVvL0qdPvEsGf7ajuaVbHWrhLd3L2OC96DLINziZmH3nai9izKIvq7
SqZ/pzeutYEcGYr+ZEyl62COYsE7ILAaz/T3iD3WPO2IjsL65ueZpQIsFUoC4irr
4nh5iEqVCdOir6hmOLdIQIQCENq7zQPS8csIDoco99DyGwIDA22/yLigLOOLsiOg
H5zSJ47qsUO4yMBrsgXPX1Yxg+LoQzzO2lqAMG0SWc5dTCQ8ej/Iqyxs78O/qswl
DbNJ6/4BM+tGOop2SBXXEdHm2wGBNkL/7cr6ZDKKpPLpkrIGQfN7XHGOWSMp4Mv2
uwSgHnB0Thccg13KXHYn9Sian1yqtafgjUBjXZuQATLIZSGZaMhUohyBIUymqZAm
6d3taQSIDQMvcPBKOAljxe9Rj2wBkYSIpCyZe6rAb93Q262vL2Zosk5pWw6WpvT4
H6NQ7QDGghvH/YiNoOx4cpgLeIjb8dNa+Pivg4ePYBf6tfbYgRY5z58R/gQi9WJf
bfJyNjau2Ysu75lt0rr6
=9ziK
-----END PGP SIGNATURE-----

--pubkjadzdhgfcvxh--
