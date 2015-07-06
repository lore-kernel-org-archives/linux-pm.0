From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 2/4] mfd: axp20x: Add missing registers,
 and mark more registers volatile
Date: Mon, 6 Jul 2015 12:21:21 +0200
Message-ID: <20150706102121.GG3269@lukather>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-2-git-send-email-hdegoede@redhat.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBBFP5GWAKGQEM2XFNTY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435316357-26606-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2015 at 12:59:15PM +0200, Hans de Goede wrote:
> From: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
>=20
> Add an extra set of registers which is necessary tu support the PMICs
> battery charger function, and mark registers which contain status bits,
> gpio status, and adc readings as volatile.
>=20
> Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVmlahAAoJEBx+YmzsjxAgu1IP/Aw24HZwaq2BP4EeKLyXRQSR
ju6kHrdjKhM05mCBfTwjiKPUBw1lVQnSCtDiQGointHdRKzOGDjLUYEgBj19eMo3
4pYX3PI+RMaA/2iRr5I5lCZzH5YaVuk7KvKEQ4dkJhm24j4IddiKs9HiJGGThQ0s
R1Hpfc2h/dkcNWL/MulPuLzeQXU4D9jlJlMrDbCYq8tAzaL2rFCNpSbdmdCsIcYv
2H27EYpULi0JuDFLzQzo5EOkOAWEl6rB/YdLNJZrQPw5qp+7KZlzmmHd/lDzK4BI
VoS0FM3ilbAlRHWCjGXDCSjO/OkOZpVpMUmm0IKyo8sXyu/pXHTgcn9BUIe+/LTG
njFi5Spcp/00Hzf6i462V3fwS9GeLufy0eoDl6wOBsXAXNihFcYsuvCp4ooCLLaz
wK8i9zoRw/wFv25QykpQN35LhlsQ0kgtjw9VYv9JkpiBgRSciJX92cKmEkNLFzWb
MDo7fLu75ZulSolHaxl210++NsTrvKMx5+8ZpUrp4C1dww+QpXMg0BT7mKg2PUwr
ohtfGRmPh/8oQ8K1u7ZwND1x9B4VcjUpV+79/tOoPeYNeBCIZDvAY6o60eRenhxJ
Zz9oc6ufyq8YDG9+zXoDRlRyYTLkY7Gt/kHl+GdXefVlld79nKszh2srrbq7xMeq
Rs45tPYuxQJJu+t1QP+C
=g717
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
