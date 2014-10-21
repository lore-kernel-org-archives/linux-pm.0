From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC Patch 1/4] mfd: AXP20x: Add power supply
 bindings documentation
Date: Tue, 21 Oct 2014 21:19:05 +0200
Message-ID: <20141021191905.GR21108@lukather>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home>
 <20141021101503.GE26842@x1>
 <20141021180916.432f02e1@neptune.home>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0Qexx6XJGNEACt6j"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBY7DTKRAKGQETDLN4EI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141021180916.432f02e1-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--0Qexx6XJGNEACt6j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bruno,

Thanks a lot for working on this!

On Tue, Oct 21, 2014 at 06:09:16PM +0200, Bruno Pr=C3=A9mont wrote:
> On Tue, 21 October 2014 Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On Mon, 20 Oct 2014, Bruno Pr=C3=A9mont wrote:
> > > ---
> > > Note: the OCV values seem to have some defaults build into the
> > > PMIC though may need adjustment if the used battery has a different
> > > open circuit voltage curve.
> > > As far as understood (these values are set in vendor driver but not
> > > mentioned in chip documentation) they represent charge percentage
> > > for some predefined voltages.
> > >=20
> > > If prefixing these values with "x-power," is preferred the following
> > > patch should becomes a dependency:
> > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267=
606.html
> > > and users in patch 2/4, 4/4 need adjusting.
> > >=20
> > >=20
> > >  Documentation/devicetree/bindings/mfd/axp20x.txt |   20 +
> > >  1 files changed, 20 insertions(+), 0 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Docum=
entation/devicetree/bindings/mfd/axp20x.txt
> > > index cc9e01b..8ea681c 100644
> > > --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > > @@ -28,6 +28,20 @@ Required properties:
> > >  		      (range: 750-1875). Default: 1.5MHz
> > > =20
> > >  Optional properties for DCDCs:
> > > +- backup: Settings for backup/RTC battery charger
> > > +	  (Voltage in =C2=B5V, current in =C2=B5A)
> > > +	  If not present, charger will be left untouched
> > > +- battery.ocv: OCV capacity curve points (16 data values)
> > > +- battery.resistance: internal battery resistance in m=CE=A9
> > > +                      (defaults to 100m=CE=A9)
> > > +- battery.capacity: Battery capacity in mAh
> > > +		    If this attribute is missing, charger will be disabled
> > > +		    unless there is a battery connected.
> > > +- battery.temp_sensor: Description of temperautre sensor, 3 values
> > > +		       - driver current (20=C2=B5A, 40=C2=B5A, 60=C2=B5A or 80=C2=
=B5A)
> > > +		       - low temperature warning level (in =C2=B5V)
> > > +		       - high temperature warning level (in =C2=B5V)
> > > +		       If missing, temperature sensor gets disabled
> > >  - x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO mode
> > >  			  Default: AUTO mode
> > > =20
> > > @@ -49,6 +63,12 @@ axp209: pmic@34 {
> > >  	ldo3in-supply =3D <&axp_ipsout_reg>;
> > >  	ldo5in-supply =3D <&axp_ipsout_reg>;
> > > =20
> > > +	backup =3D <3000000 200>;
> > > +	battery.ocv =3D <0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
> > > +	battery.resistance =3D <0>;
> > > +	battery.capacity =3D <2000>;
> > > +	battery.temp_sensor =3D <20 1000000 4000000>;
> >=20
> > Since when do we use '.'s in property names?
>=20
> I've not found guidelines on this, but whatever is the right way to
> name them, I'm open for suggestions.

You can take a look at the ePAPR specs. Even if it's quite outdated,
it still puts you in the right mindset.

That being said, since they are driver-specific properties, they
should be prefixed by the vendor name (here x-powers).

And I think they all belong in a sub-node, just like what's been done
for the regulators.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--0Qexx6XJGNEACt6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJURrGpAAoJEBx+YmzsjxAgV/0P/056X81uFoE2015HfixK2A+i
mTOW6B9huJcaXVEjKTi5vOM9ds+H2NgLEwcqmoFOCO50CWe/G4qWakr8EGW2cq/5
E5/YvMIChVfz74AIp4XaUR86h59z8Ykxiy0MjjWEqCZvm+K1yy0K3filwHw4VDr7
axBBVOidNm4nc2v4Izi2l++8umvsY0h3IqKU76aX44151EXbmzty68DJQanVMBid
/VKzj3B6NtBFZzVlYka8YAoeQHMx9EEl8b8MfmWBJIpm9wz0AEEhWYAcvoXAQj+z
IyJbhh9lGWJbjhPdfyx/b2XTwZ1DFJCnoSNqwy1xrz7RAyYIUCvpoozIpZT64zzc
pXbY2SzQxHrTyzJ8g/Cet40xYPZ7+n+vsIL1WxjnycJ12zvVWnIbYUow4ag5ka1Z
Ey95g82/096pvZiE2v1SiNQoBvmGh14ICWpSQgXPGUvEgmW8eOowokdCyExhEM+z
W5v8aqaW9L/5fzKHh+c+dpphYuteQD8rPOMDr9MciNf+XapBgSdYOL+GhZVCckmh
cvP4HpRj5r3R/X5JmyHI6Og0KwlSXkH79RZ++0P0FVoXnw3VQIc5fonFUfgYPIu7
m1fVvP1n1i3aayqhAR8fJ4pIWpYSTgqBSavqzLHvVAdDPbG89PECzPUdD2IDDh+q
ldvTpk4hS9sk3RcgCTo7
=pKGx
-----END PGP SIGNATURE-----

--0Qexx6XJGNEACt6j--
