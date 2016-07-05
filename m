From: "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/4] power: add axp20x-battery driver
Date: Tue, 5 Jul 2016 11:25:10 +0200
Message-ID: <20160705092510.GL7643@lukather>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
 <20160701092926.32005-2-icenowy@aosc.xyz>
 <577B44FD.6040404@mailbox.org>
 <4101467707611@web7h.yandex.ru>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lZZ4ablUVnt2XgAh"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBAP25W5QKGQEVFLBH6A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <4101467707611-tvSLaYVQeptuio3avFS2gg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Michael Haas <michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>, "wens-jdAy2FN1RRM@public.gmane.org" <wens-jdAy2FN1RRM@public.gmane.org>, "sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--lZZ4ablUVnt2XgAh
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 04:33:31PM +0800, Icenowy Zheng wrote:
>=20
>=20
> 05.07.2016, 13:26, "Michael Haas" <michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>:
> > Hi,
> >
> > nice work! Is this in any way related to Bruno Pr=C3=A9monts driver for=
 the
> > axp20x?
> >
> > I've got a reworked version of that lying around, but it's not quite
> > ready for submission. Do you know what pieces are missing in your drive=
r
> > for axp20x support - as opposed to axp22x, which is already working?
>=20
> Therotically, it can run on axp20x. However, I have currently no
> test device. (Still waiting for my C.H.I.P.)  So I can only promise
> it to run on axp22x.

Still, it looks like you just took Bruno's driver, stripped out the
axp20x parts and added the one to deal with axp22x.

This makes the driver look weird, by being called axp20x, without
actually supporting those PMICs, but having some axp22x variables
right in the middle. And that's awfully inconsistent.

I'd rather have you add the AXP20x driver directly, and then add the
needed stuff for the AXP22x.

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

--lZZ4ablUVnt2XgAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXe3z2AAoJEBx+YmzsjxAgArUP/Rkq3WX0vQ0EbAct4GueGkug
t+x4elgqXHafCLpNN5ZVJBappYw92qcC473xXqIM/NR7h0TLUnzxYGtjFY0P/Ny3
yCRwu3nkhSHqia+PMciDfXs6ihl0hywIOjbk/BEooL6KtW2Zp3bG04aczH3kttpv
dnhEV819jXrYCXD2Do9bATpagrQ9gDU8S1odwdRfwTjDHRVUaEm8Zqa3mybv6rxE
pfqXnNDEi9kw3vr0RQSekG/lonwaD2r6CXQ97oOYaalMHwEYZ9kh1vlyhBgCxkDZ
FCb6rKXMnc2psi0SfsA0LubHCZ4wcIuJqV3sZGtQrR2cndLKq4Bh681hEWsJjwPv
8U5K5CVlyurV9L6eUeMmsn5rAnidq15UBdRF6bpymZYJQ51ed8EUlPjd0cD7ufYu
qorxJsAPSUTuX3rWzlsNLPlebIHH9do+u3W0J0hYRin3bCoQ5DkKzQDFE0sBqcsO
0s3w878IRgH8nS5FsWghZBd2EP3aAsIRq9IWvG9IZxGQkI23/Y+dSC8CIGocY8Z1
vqnN2LEB3i6haCs1JY2JhpPY0XQ0ugA9kkERnPxfUxwZubkPvaEPFm10OmEitEwK
QAxaD6vwWi0hrGnWRPofweNDCa7uMjIpuNMYY/I3R7ozRv8nYbnAYp/9YlrKGmk1
mX18o9cSjgmYZ0cs+cGZ
=v/Am
-----END PGP SIGNATURE-----

--lZZ4ablUVnt2XgAh--
