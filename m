From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: armada: read stable temp on Armada XP
Date: Wed, 25 Feb 2015 14:39:03 -0400
Message-ID: <20150225183901.GD2306@developer.amazonguestwifi.org>
References: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com>
 <20150224183616.GD3448@developer.amazonguestwifi.org>
 <CAOjnSCaH5NtcYGdfQ+=XY9ZJtjYEEgLWKCGUeFXBsM1f+va-LA@mail.gmail.com>
 <54EDF3E6.6040409@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54EDF3E6.6040409@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Tyler Hall <tylerwhall@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 05:10:14PM +0100, Gregory CLEMENT wrote:
> Hi Tyler, Eduardo,
>=20
> On 24/02/2015 20:56, Tyler Hall wrote:
> > Eduardo,
> >=20
> > On Tue, Feb 24, 2015 at 1:36 PM, Eduardo Valentin <edubezval@gmail.com>=
 wrote:
> >> The fix seams reasonable. Although, it remains the question what is
> >> applicability to other Armada chips? Besides, shouldn't we simply use =
it
> >> by default? Also, do you plan to send updates in the DTS files?
> >=20
> > As far as I can tell, Armada 370 is already using the equivalent of
> > this register I'd like to use in Armada XP. I'm not sure about the
> > other mvebu platforms. I couldn't just change the device tree for XP
> > to instantiate the 370 sensor, however, as they have different
> > initialization routines. Possibly Eziquiel can comment on the
> > significance of the differences between armadaxp_init_sensor() and
> > armada370_init_sensor().
> >=20
> > I would like to change the default going forward, but I don't think it
> > can be changed on platforms using an older DTB.
>=20
> Here you introduced a new kind of thermal sensor, at least from the point
> of view of the device tree. You used a new compatible string associated to
> a different register.
>=20
> By using it by default do you mean removing marvell,armadaxp-thermal
> and adding armadaxp-filtered-thermal instead ?
>=20
> Does that new thermal sensors only improve the stability or does it
> also modify the value?
>=20
> In the second case it will more or less break the user space expectation.

Yeah, I agree here. We need to understand if this is:
(1) a fix of which register to use. In that case, the old dtbs are
essentially wrong, and the driver would need to adapt, I would say.
(2) a way to report better temperature extrapolations. then, this is
essentially a new temp sensor, and we should have two separated
compatible. in other words, just keep the patch the way it is.

>=20
> >=20
> > I had planned to submit the dts change separately. It's not clear to
> > me how that's supposed to be handled if they might go through
> > different trees.
>=20
> For this, there is no problem be handled in a different tree. At the end
> we will need both the a new dts and a new driver to use it, so the fact t=
hat
> the dts or the driver patch is merged in mainline first is not important.
>=20
>=20


Yes. Typically I ask to see the complete series, even if I am not taking
the DTS changes. That is, you send a complete series, with changes in
the kernel code and in the DTS, copying the required audience (from
kernel side and from DT side). Once the changes are accepted, the
patches will be picked by the correct tree maintainer. It is common that
DTS changes go via the platform tree, to avoid conflicts though.

In this way, we can have a look if the whole set of
changes are going to make sense, instead of guessing if future DTS
changes will be correct.

> Thanks,
>=20
> Gregory
>=20
>=20
> >=20
> > Thanks,
> > Tyler
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
>=20
> --=20
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7ha1AAoJEMLUO4d9pOJWBIkH/1BvFBRU2ODqSU+2vCSN48HZ
B3oXZFnd29x4TkkjQ3NL9YyE3LDqERc2KPsrhd8e4R/Jr5rLIzl+gUgF7YbmNESU
t+mOQnjTBRKwBW2j2SBN7TF7vC5akgphtIbD1+fHFU9e7WzVCA8AS6fKG6FyJRPd
5KHHarmFf+WZKfRy/Thp0pyp5TGc4PpU9uNis7kydVJcE1lp7ZiWUZxvppznNUua
nKvRqkFBMKrR3WHTLdq3ZG2WrI4UUHeRsOeBARztTdCGYho4mrhRlSLkJvGiWmHN
3z5MNmb9AsEEhF3DREgzGlyiRDO1f0E9cufYvL5HaYiySyc49v+eNPdjyDbgU7c=
=yLD1
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
