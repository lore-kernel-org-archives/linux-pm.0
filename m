From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 5/7] power: supply: Add 'connected_type' property and
 supporting code
Date: Fri, 9 Feb 2018 16:01:48 +0100
Message-ID: <20180209150148.624fb4qb34wuml6l@earth.universe>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <3af7db87e0e6bdfa46ef3c1c9053297f711aee5a.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
 <20180208213054.oqgoktru3lzjiyyn@earth.universe>
 <2E89032DDAA8B9408CB92943514A0337014C1C1FDA@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ia2pxk24in2rjaux"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1C1FDA@SW-EX-MBX01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org


--ia2pxk24in2rjaux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 09, 2018 at 11:28:42AM +0000, Adam Thomson wrote:
> On 08 February 2018 21:31, Sebastian Reichel wrote:
> > On Tue, Jan 02, 2018 at 03:50:53PM +0000, Adam Thomson wrote:
> > > This commit adds the 'connected_type' property to represent supplies
> > > which can report a number of different types of supply based on a
> > > connection event.
> > >
> > > Examples of this already exist in drivers whereby the existing 'type'
> > > property is updated, based on an event, to represent what was
> > > connected (e.g. USB_DCP, USB_ACA, ...). Current implementations
> > > however don't show all supported connectable types, so this knowledge
> > > has to be exlicitly known for each driver that supports this.
> > >
> > > The 'connected_type' property is intended to fill this void and show
> > > users all possible types supported by a driver. The property, when
> > > read, shows all available types for the driver, and the one currently
> > > chosen is highlighted/bracketed. It is expected that the 'type'
> > > property would then just show the top-level type, such as 'USB', and
> > > this would be static.
> > >
> > > Currently the 'conn_type' enum contains all of the USB variant types
> > > that exist for the 'type' enum at this time, and in addition has
> > > the PPS type. In the future this can be extended further for other
> > > types which have multiple connected types supported. The mirroring
> > > is intentional so as to not impact existing usage of the 'type'
> > > property.
> > >
> > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> >
> > Thanks for the patch. I think, that it's a good idea to provide the
> > subtype in its own property and just set the type property to "USB".
> > I would prefer to name this "usb_type". Otherwise
> >
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >
> > -- Sebastian
>=20
> Thanks for your review. I chose 'connected_type' as I thought this would =
be more
> generic in case other main types would have some dynamic connection eleme=
nt to
> them and could also benefit from this. If we don't see that as being some=
thing
> we want though then I can make this just for USB.

If such a thing appears at some point we can add another property.
I think usb_type is easier to understand from a user point of view
and it helps to keep our enums clean.

-- Sebastian

--ia2pxk24in2rjaux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp9t9kACgkQ2O7X88g7
+pqIsw//YTGtow/RCInDMNnwvWIWwJ4pGDvT6FhQ+nnEx1Gz8z9e5rxKEHoY7why
Akq5tfsto87k4vcO3w68zAhlJuHfwlY36VXlP253ao2cj0X4MM9IPWZ/FupDhkex
ZwB9Hl/OHkyJNRSXyni0b+mV7fDTwYK9fH3xexeqqlPfSpuGC68asTH95Bq5ixX3
g33rT5KC4U3WLcs69qTRIPnd1vgLGilfSM81l+mm4kdp34qaIIvodeg6r6hCSPrf
iUGxM61C54TRtxqMQ9UDR5qbPRfloX2lsBgxWX4QndgUqfXyFjDS4zudyePE2RV3
Nt1oGtTBHaT8fmif3NaCZt6VWfVJqzd7cVQ0EQhl7dZ89Ea50o6gR5ThR3vLKDN5
mevRiuLzvQbezd/IdlvT+5eMLZgLRCu/JSJg3zK83hnkIfuFGlfB/w1aFd/CSBV5
z7ixEnxWW15/F6CZtOUsoZqikbToUkEAHOQKH2t8WDLsS+s/iZeA29A77DVqe167
/LivgymItXpZ9F2vzkaWtfmdMlQHOmNjb1zEg2anW/VRd4nfzkhB8G4fTVusmDQe
+c+GnU6ulbao+QJqhanQmVuQyThuwRikDK0pThRp7H+mY+kD2X4B/8mVsFNsbu9/
qHTMDFEfaNgO9pR9r2PEC1dY4g1r8fdDgDWSTSaxCzZDF5hTRBs=
=ClSJ
-----END PGP SIGNATURE-----

--ia2pxk24in2rjaux--
