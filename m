From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Bug#763320: linux-image-3.16-2-amd64: intel_idle enabled for
 Intel Atom S1260, causes high CPU temperature when idle
Date: Tue, 30 Sep 2014 01:13:07 +0100
Message-ID: <1412035987.9388.72.camel@decadent.org.uk>
References: <20140929095709.3255.93208.reportbug@izoard.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-/x80jG4m5tRqm08w3KHg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60438 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754178AbaI3ANb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 20:13:31 -0400
In-Reply-To: <20140929095709.3255.93208.reportbug@izoard.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Len Brown <len.brown@intel.com>
Cc: Christophe Thil <christophe@thil.de>, 763320@bugs.debian.org, linux-pm@vger.kernel.org


--=-/x80jG4m5tRqm08w3KHg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2014-09-29 at 11:57 +0200, Christophe Thil wrote:
> Package: src:linux
> Version: 3.16.3-2
> Severity: normal
>=20
> Dear Maintainer,
>=20
> with Kernel 3.16, intel_idle is enabled for the Intel Atom S1260 CPU
> (Centerton SoC). This leads to a +20=C2=B0C temperature increase when the=
 CPU
> is idle, exceeding the 100=C2=B0C alarm threshold for passive cooled syst=
ems
> like the Supermicro X9SBAA-F.
>=20
> With 3.14, intel_idle was blacklisted for this CPU, which runs fine. If
> 3.16 is booted with intel_idle.max_cstate=3D0 processor.max_cstate=3D0,
> which disables the intel_idle, the CPU also stays cool.
[...]

It looks like the relevant change is:

commit acead1b0fac5b10d0ae3f1cc5f7820b9f9f924f5
Author: Jan Kiszka <jan.kiszka@siemens.com>
Date:   Sat Jan 25 22:24:22 2014 +0100

    intel_idle: Add CPU model 54 (Atom N2000 series)
   =20
    Add CPU ID for Atom N2600/N2800 processors. Datasheets indicate support
    for this, detailed information about potential quirks or limitations ar=
e
    missing, though. So we just reuse the definition for the previous ATOM
    series. [...]

as those processors are part of the same Atom generation as Centerton.

I think that more specific ID matching is required here.

Ben.

--=20
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.

--=-/x80jG4m5tRqm08w3KHg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVCn1nee/yOyVhhEJAQroqw/+KEwvGXlohmb2l2YqW4gpZQdGGPis3sFY
IDWDeI2prwTuPw4k4XvarZiyjjZHAVyhaYYRDMCUUoEf/JbN42SDYtbkSeA8806+
nRDnUdoxrsEDNSp0hs9YmaVLQiofT/5FDo10bOExmqEUX7mkALHjpCuDjcty1wZI
yfNdBpCYsXaguKoF48lm4e3wfirjr+Alktp0ToHWW9y4PXFYiBIiVSoKB9Nrrp7F
J8TGHrn5ZuTYGlzhl+GjG9Ktdh/irxrQUPc27+ThUrc61FYXX9JxXsm+H4LAtzAM
N8O1lJxtVqxDpirVUdeKcN3qIKXfLwFbL321eKighRBh4xR6+tbIWZkFYKQsYBKk
z11cvgdrBxZmr8AI+7qBpTlnE83aXlDKtLLyWSRRmJ/s/urZ+LXreg9tZ3FY5Iu0
A//nTyfq/3iT1m94GGhHO47bZOdS1XSqQ31sXhWgMnOaej4U1eh9XT7a16GrJ99d
w5FMguMv/4ZP9TsqDeJ0xjAZ+2jnx8uETqlFSD89b8jf/Q/UXYCV4LnXEH5JqDl+
+IrpujI9rCEURiJJm471O8gBIRDvyebKyh05Q1magQNy6H+njgdaocAtZ+MAz+Le
X+uxfXJmtjaGL3eFFv0wtJW+xUhI6q3s7nTMxvZ399FRXYJ4q6WvY6ctuKE2NM2G
219lZxsxxWE=
=1leu
-----END PGP SIGNATURE-----

--=-/x80jG4m5tRqm08w3KHg--
