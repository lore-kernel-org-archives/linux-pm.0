From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 6/7] devicetree: power: bq27xxx: add monitored battery
 documentation
Date: Tue, 17 Jan 2017 01:59:22 +0100
Message-ID: <20170117005921.3bpakc2xnvt4euqf@earth>
References: <20170111062003.10110-1-matt@ranostay.consulting>
 <20170111062003.10110-7-matt@ranostay.consulting>
 <20170113172821.noogiax7bqwhkoev@rob-hp-laptop>
 <CAJ_EiSRnU1q8QPKO43hk3ajS=RaAtQ2tVJ-060GcmPoPA6Ranw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tixt4ret36njhgb3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ_EiSRnU1q8QPKO43hk3ajS=RaAtQ2tVJ-060GcmPoPA6Ranw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--tixt4ret36njhgb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, Jan 13, 2017 at 10:07:32PM -0800, Matt Ranostay wrote:
> On Fri, Jan 13, 2017 at 9:28 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Tue, Jan 10, 2017 at 10:20:02PM -0800, Matt Ranostay wrote:
> >> Depends-On: http://marc.info/?l=3Dlinux-pm&m=3D148392292830015&w=3D2
> >> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> >> ---
> >>  Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 8 ++++++=
++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.tx=
t b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> >> index b0c95ef63e68..0472a2db0f13 100644
> >> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> >> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> >> @@ -28,9 +28,17 @@ Required properties:
> >>   * "ti,bq27621" - BQ27621
> >>  - reg: integer, i2c address of the device.
> >>
> >> +Optional properties:
> >> +- monitored-battery: phandle of battery information devicetree node
> >
> > We need a common way to describe charger/monitor to battery connections,
> > not yet another way. The battery and power supply related bindings are a
> > bit of a mess from what I've looked at.
>=20
> Sebastian, your thoughts here?

On what part? Did you receive my comment on patch 1 from this
patchset? There I wrote basically the same:

> I think we should mandate the property name of the phandle in the
> generic binding instead of each potential fuel-gauge/charger.
> Maybe something like the following paragraph:
>=20
> Batteries are supposed to be referenced by chargers and/or
> fuel-gauges using a phandle. The phandle's property should
> be named "monitored-battery".

If you mean the second sentence: Yes, DT bindings for the
power-supply subsystem are a mess unfortunately. It's partially
my fault, but the (IMHO) really bad ones were already there when
I took over the power-supply subsystem (e.g. charger-manager,
which does not even describe real HW).

One of the problems is, that the power-supply subsystem does not
know about the difference between a fuel-gauge and a battery, since
smart batteries contain a fuel-gauge.

Regarding the phandles: We do have a standard property for the
battery <-> charger connection, which is described in

Documentation/devicetree/bindings/power/supply/power_supply.txt

Like most of the power-supply subsystem it expects, that battery
is a smart-battery with fuel-gauge. It does not really fit for
the battery <-> fuel-gauge connection, though.

TLDR: I suggest you implement the changes suggested by me and Rob
in patch 1 and resend the patch series. Then let's see if Rob is
ok with it.

-- Sebastian

--tixt4ret36njhgb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh9bGcACgkQ2O7X88g7
+podbA//ersXlE+xhT0aoLRCTEvst7uKW/UiAZwp24YbJCpGBrAB8ZIk6+TY6SQF
1mrTE88pNKBcFoEHet6ojp9WAEkBcVgglcU5gP88HfEZZmN8zT0vyhq0+kt3TiLC
RhjFLUoBw7vh9yIk63lDwqGNci6e2KeCFck8sHToJTH+J4D7S1Vs8Dxt98hKDxN7
iEsGaSzRfiF4w8HDqbm0a8oJb4nCO1b42s3r1SyfW12X3WhiXRaK2sQM5S0Ai9ZY
UuAV7djBuFLjBwoODBGWMldiD39yX7DtbEKluR0pb2oYn1qfh3SCLFe27ffPoJL0
ojojF68gYKHzFJeo2tu91RPHYx+NtUJanQlOPyZtiQbEfN45fB5/qfP0JWStdX6B
EbGyJwM6uhyrO1qmanyrjzFnkZeev/pEZ+rVJS4i3dM4A3wA7tjrEtSK40k7xTWS
OOlCFHDwV9nBDYJTLo2tUem2VGCc4gPMKZ/lWk4+as5e2hoBk+k5hDcKvbZWEEGf
zqaAul7JKxv8eqyLXBYHU+NbSl5v1W7xsJsqd1RD4tl4yhoTTjB4atvzEPIZ8EKs
gBB9s8hC9W4nf85pL5XJHkJZ2ILVhlszMeQ5wrhkfIMsOgFnD70KO8JVdouP38cE
I4io03S7irYQ7AdGrPvf/xdo71QwaPkBGOnrjQZ4j1J1BCBfSJg=
=51/x
-----END PGP SIGNATURE-----

--tixt4ret36njhgb3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
