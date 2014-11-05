From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC Patch 1/4] mfd: AXP20x: Add power supply
 bindings documentation
Date: Wed, 5 Nov 2014 15:48:32 +0100
Message-ID: <20141105144832.GB2989@lukather>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home>
 <20141021101503.GE26842@x1>
 <20141021180916.432f02e1@neptune.home>
 <20141021191905.GR21108@lukather>
 <20141103210244.1425e0c7@neptune.home>
 <20141104143117.GC26729@lukather>
 <20141104220827.773c53d0@neptune.home>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBGXS5CRAKGQEFXMHQHA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141104220827.773c53d0-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
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


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2014 at 10:08:27PM +0100, Bruno Pr=E9mont wrote:
> On Tue, 04 November 2014 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>=
 wrote:
> > On Mon, Nov 03, 2014 at 09:02:44PM +0100, Bruno Pr=E9mont wrote:=20
> > > Doing something like this?:
> > >=20
> > > --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> > > +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> > > @@ -126,9 +126,11 @@
> > >                                 interrupt-controller;
> > >                                 #interrupt-cells =3D <1>;
> > > =20
> > > -                               backup =3D <3000000 200>;
> > > -                               battery.resistance =3D <100>;
> > > -                               battery.capacity =3D <2000>;
> > > +                               x-powers,backup =3D <3000000 200>;
> >=20
> > I don't really remember what was that property used for. Would it make
> > sense to put it into the battery node?
>=20
> The backup/rtc battery is completely distinct from main battery.
>=20
> It's presence is in no way related to that of the main battery,
> thus I would not put it into the same node.
> As all the information needed is included in the property I see
> no reason to move it into a separate node.

Oh. So it is to model some button battery that might be here to keep
the RTC state while the board is unpowered?

How is that related to the PMIC?

Maybe modeling as a fixed regulator would be more accurate.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWjjAAAoJEBx+YmzsjxAgeXQQAKU+V+oHZvhwAyjcGqJ2MUJs
DrEtIt8u5+9EVhe0voAIKfndlIuPUDHfZWg2D9+FoKHidU4msYL7IgpDEecGPtVs
lGzuEQnwCC3YqqgG1oOWDOZDUu+6HYwHf3HhnzB3jDJu/tn8O6rBK5x5kFrwanVb
R49xsTIQzkFl6LqWQ55khqaUFy6jrcrrsCQLjdmdVzh7AEndZ1G89p59tBqNS++Q
eufNCnmAAPAFpFBhmOh28+KkYIcfIq+8f4Sl2Sqlfxk+dfHEoBj5eOVz0NEsoiZ6
3DdT7umXa474xFch4zeEnL/ktV3H1VBGXPFFtpyQZ6GzB+ngSsgR0zFMNXDK7xiU
H+o147T7jzmkKAsq4/JZCvqug3A23fhr5soV9jpzQPQqW+FyMYWvhSw9O5UhirIa
uolS4RldMNiEwe8/tarWcavt4aQlQGJROLdiJOCfkgMyTGWyg2rUQtM+r/L+fVDr
a7aiNRxGCPMltdAFKBKZcoxO1wqd86y7Ut5ioezvxCXIsJ/MYlixOYNXPa+/hQK0
UPUs60k9p5OFYsERwE+/Bua7tc7qpaJC225n6LW2nz1rPDfDJykF2E6uHatm/bOa
u9DcJ4W7kzt63VGMrh79bwLV7tavSGqdfq136RxjyEuDPEVVc+Yah42h4MUz8WcR
xGwCAVrIa+T+8ER2E8cW
=OMKw
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
