From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 11/14] power: supply: bq24190_charger: Get
 input_current_limit from our supplier
Date: Tue, 29 Aug 2017 14:12:24 +0200
Message-ID: <20170829121224.5djjfrj7azpp3gll@earth>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-12-hdegoede@redhat.com>
 <20170829114003.rcj6l5up4277urxq@earth>
 <b5d695fc-49dc-c4fd-7470-19e82a859bf5@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pkp2w7fxscuh5fwc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56350 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdH2MM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 08:12:29 -0400
Content-Disposition: inline
In-Reply-To: <b5d695fc-49dc-c4fd-7470-19e82a859bf5@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org


--pkp2w7fxscuh5fwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 29, 2017 at 01:53:24PM +0200, Hans de Goede wrote:
> Hi,
>=20
> Thank you for your reviews / queuing!
>=20
> On 29-08-17 13:40, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, Aug 15, 2017 at 10:04:59PM +0200, Hans de Goede wrote:
> > > On some devices the USB Type-C port power (USB PD 2.0) negotiation is
> > > done by a separate port-controller IC, while the current limit is
> > > controlled through another (charger) IC.
> > >=20
> > > It has been decided to model this by modelling the external Type-C
> > > power brick (adapter/charger) as a power-supply class device which
> > > supplies the charger-IC, with its voltage-now and current-max represe=
nting
> > > the negotiated voltage and max current draw.
> > >=20
> > > This commit adds support for this to the bq24190_charger driver by ca=
lling
> > > power_supply_set_input_current_limit_from_supplier helper if the
> > > "input-current-limit-from-supplier" device-property is set.
> > >=20
> > > Note this replaces the functionality to get the current-limit from an
> > > extcon device, which will be removed in a follow-up commit.
> >=20
> > I'm fine with the general approach, but ...
> >=20
> > > [...]
> > > +	bdi->input_current_limit_from_supplier =3D
> > > +		device_property_read_bool(dev,
> > > +					  "input-current-limit-from-supplier");
> > > [...]
> >=20
> > I wonder if we actually need this. I think we can just enable it
> > unconditionally when we have a parent power supply providing the
> > information.
>=20
> I was thinking the same when implementing this, so this is fine with
> me. I think it is best to just unconditionally call
> power_supply_set_input_current_limit_from_supplier from the
> external_power_changed callback, that will only get called if we've
> a parent supply and that function will check that the parent has
> a current-max property itself.
>=20
> Please let me know if just unconditionally calling
> power_supply_set_input_current_limit_from_supplier from the
> external_power_changed callback is ok with you then I will do that
> for v3 of the patch-set (from which I will drop the patches you've
> already queued).

Makes sense to me.

-- Sebastian

--pkp2w7fxscuh5fwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlWigACgkQ2O7X88g7
+ppHNg/+Nhoc+YVYMJ9E11zbPgWDgUevK8D79kdJCk8ZvBrVSqarPXXzN0dVIZvq
FKhS+cs4JhGHuxNYP0SmrQlhMNYyrrBhreLNLP78N8QQUnL9paMsQopE4eSmA3NP
ZdotH9AuK7JOWgJa0S9ui2m672MCW8+DcHIOX7XT/myBzvQF1/1GFzsSgADifeZk
yUVXa1WLbueneL/tkBv1Gnzsbs45wiimxNDlqt1CvcuIZiobs5ZcDlHJ3+QFCFtL
04YTgH7DivoroYbBDLz8nFIY6B3s/suna38/VWCt0DhAoWdUlF495sJkmN/CfRP1
G5xX6cB2ahQ4so5R5vXHJyLlBxgZfR68ZRm0ZrUMSirbBAJvyon87nnsfs80Lb31
3tT/5QR/lSgk6ZyIyODXsPX7bosjeW1zIY7GsSSmNCyCs7PkqbJpLWVqfA/rrBbJ
P+LlF5ePPadpNnMC9I7PXsBQ7ukCdr/9+E/fYXV1IbFVlMD0yG/1xySFvAYaQRh4
uzB2FltUfjHvhVc3ksnRaQQP0JuOHu2XX2Y04BsWKLCZihkO/+0iAzK5omJ0U2x7
udmVBQg59OpiQcMYHxHX0PQLYcughzqHCEKo7K0QUWjLb1Mc2xhF3qqD7+Nhgb4V
RoZb42DN7uuHPzSbyO2M2jDkN/k3M6/S9JOBg7DpEJ+c0rtjWwo=
=qo2Q
-----END PGP SIGNATURE-----

--pkp2w7fxscuh5fwc--
