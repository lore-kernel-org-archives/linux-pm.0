From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery
 device .type=unknown
Date: Fri, 24 Mar 2017 10:39:49 +0100
Message-ID: <20170324093949.rno2olzywz4cds6k@earth>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-8-liam@networkimprov.net>
 <20170323105221.qnyw2m4cgjcb24cl@earth>
 <CAKvHMgROkDF43sGgvPG8Eb+z=yjuTOL9UXkOREkd=APL47DMvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="afq4nr55w54cdkiu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753963AbdCXJjz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 05:39:55 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgROkDF43sGgvPG8Eb+z=yjuTOL9UXkOREkd=APL47DMvw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>


--afq4nr55w54cdkiu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2017 at 01:47:23PM -0700, Liam Breck wrote:
> On Thu, Mar 23, 2017 at 3:52 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > That still leaves the health status reading, though. From
> > userspace's point-of-view this should be merged into the
> > battery device, if fuel-gauge can't provide that information.
>=20
> You mean merged into the -charger device? -battery is the one
> we're dropping.
>=20
> If you did mean -battery, could you elaborate?

I was not talking about bq24190-battery. I meant the battery
device provided by the fuel-gauge. From userspace's point of
view a battery device, which is usually derived from the
fuel-gauge should contain battery related information.

Since the battery health information is battery related it
should somehow be merged into the data from the fuel-gauge.
That's what Hans implemented with the function-pointer
construct and what you suggested to implement in this mail:

http://marc.info/?l=3Dlinux-pm&m=3D149026871313238&w=3D2

-- Sebastian

--afq4nr55w54cdkiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljU6WAACgkQ2O7X88g7
+pplgBAAg7dHPbFGZEdxgHNmeHyrV4bQjTiyuMeRNN1u/3TqVb5uZgf6TP+NdORI
i7D9MTQrITMm2s08VbyfrKtKyMRt7AwXO3eh4GW3D3eVooLokLXGl4r/fFkksg+z
Y57Z26GcsPaWeB4D4zZMY848Xrp7VW2l6+Gbi+qifRyq3HhIo/hS3Im47JqibipC
XH2t7E2FJJnLR8jhJNTfL8P/gYaQ2nQPEmMLJ6MY1YQBGIuTHWdMT75cOLT1Pls7
OerXF/OqB2qaN4IKEiNGEjbHt0LJB9niHVVxPF7hftdKIdVucO+SOHmM1vZe4nPq
Y8rXJUyYzZgAErxOQ7Xx/rZXpEZ2mR8ahwtYk6NQhRXuNAtuips5K4GDT0yGuRh4
SuVFxKWDhcV/4wCXFeNwxoOrUfzHtjvhLgIIfm6u+c2SVIZ56hGjQaGBBKsdzOJ1
7iE55hS+HRcHHD87NMq6DMlZmmWsrkEiekarVP9U3kN3WXCUqDKAOc0zrP6G1oyz
KJj/0tyq6kvIGpdEHCX78GMXQjOI7jerM99+AEy0Mysm0C+UMjZ9MiSg7P/8sZ/R
Jhlf9QwBk9GGGGMBMJqIp53uYLrwOvnSG/rWOmViehbsrqD0gfSTJ/G8l3SHxlVX
aBcEZk3MmCaJgI1x6d7bwRtybZxEeVMItHm7kRNLYyTD3l8uN5I=
=LKIC
-----END PGP SIGNATURE-----

--afq4nr55w54cdkiu--
