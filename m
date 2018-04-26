From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 0/6] typec: tcpm: Add sink side support for PPS
Date: Thu, 26 Apr 2018 12:54:27 +0200
Message-ID: <20180426105427.kewn6s4kmnzuwtn6@earth.universe>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
 <20180424135749.GA21610@kroah.com>
 <20180424232633.s475bsccxjhm7lpy@earth.universe>
 <20180425123045.GA22950@kroah.com>
 <20180426073326.GA12261@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7loneb5mrk3j6aec"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180426073326.GA12261@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org


--7loneb5mrk3j6aec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 26, 2018 at 09:33:26AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 25, 2018 at 02:30:45PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 25, 2018 at 01:26:33AM +0200, Sebastian Reichel wrote:
> > > Hi Greg,
> > >=20
> > > On Tue, Apr 24, 2018 at 03:57:49PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Apr 23, 2018 at 03:10:55PM +0100, Adam Thomson wrote:
> > > > > This patch set adds sink side support for the PPS feature introdu=
ced in the
> > > > > USB PD 3.0 specification.
> > > > >=20
> > > > > The source PPS supply is represented using the Power Supply frame=
work to provide
> > > > > access and control APIs for dealing with it's operating voltage a=
nd current,
> > > > > and switching between a standard PDO and PPS APDO operation. Duri=
ng standard PDO
> > > > > operation the voltage and current is read-only, but for APDO PPS =
these are
> > > > > writable as well to allow for control.
> > > > >=20
> > > > > It should be noted that the keepalive for PPS is not handled with=
in TCPM. The
> > > > > expectation is that the external user will be required to ensure =
re-requests
> > > > > occur regularly to ensure PPS remains and the source does not har=
d reset.
> > > >=20
> > > > Sebastian, any objection from me taking this series through my USB =
tree?
> > >=20
> > > I currently have the power-supply bits in a local branch for
> > > testing. I would like to have this in the power-supply
> > > tree, since there is at least one pending driver which could
> > > directly use the newly introduced usb_type.
> > >=20
> > > I can either provide an immutable branch with a signed tag, or
> > > you can merged it and provide me an immutable branch.
> > >=20
> > > If you merge it via the USB tree patch 2-4 are
> > >=20
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >=20
> > I've applied these to a testing branch in my usb tree, and if they
> > survive the 0-day bot, I'll move them to a branch that you can pull from
> > that will not change.
> >=20
> > Oh, I had to add a follow-on patch to fix up a gcc warning that really
> > wasn't a warning, but it saves us problems of people complaining about
> > it.
>=20
> All looks good now.
>=20
> Here's the signed tag you can pull from, with the full information of
> all of the other USB patches that you are going to be getting here
> (sorry about that).

Thanks, merged.

-- Sebastian

--7loneb5mrk3j6aec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrhr+EACgkQ2O7X88g7
+po0nxAAh5JHbqs4WFnbr0TSQH+y/cBcOFv9SHvCPekhiK93DEujAhF4WvqjYAMW
3LukRNDJd/D7UtcBTHJqDsP6p2AXCPCZ+AuX2Qt95fniOQUEKXH6sC9MakAYQU4G
+3CVzrx4K8Q1voXAn4N6RT9Y2BEEs3Ma74h25gZuQe4e1Ms0pvMRcPbqTmwCE0Du
ZGLIUQtaXhebkHNkxglAekbW2Lw2rGztwLoA+q+TATZG4bGWOCqHEgbGnnysiMee
yW5YJ9D16+zzolM02QF8Th29T2Qa0gGMpLUZc6D/npG0Elhdd3v+xF0ZrUY6Zcsb
GBmAXlcbwsINSItSXm0a9P+S1CqFAgawGJWpL84x8yCgH/rFxRy6p9Em5r1ESlzC
C5GIhaC1UMqdS37dL/CE9RjQdWhYbKfo6E2xePICBgUo3EciihmgD7psdFp38dN1
Po/W/U5gPa78AM/Uj2r7fmzll+zVp0foaOsdZs29apLfQFNEyG51J8lfrxenpsTs
3m/ZxeZoT9nMni3ZxuhhhPfvnyTa5XnDKa/QG9A3SnzIrkE4BHWbwsI8ny9VVlys
J5jwT/we0FuZ2/WtfIJ/7gskALBng7DFvLTIxWAdZ+tpDd4UXtr0/KGJGAh5yeAT
B7IcJf8Ct3o+3+rPahiXTcJ40Z5c0UB+Wqa3SiPaGekmgYT+kqM=
=+2Tj
-----END PGP SIGNATURE-----

--7loneb5mrk3j6aec--
