From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Date: Thu, 22 Nov 2012 11:06:51 +0900
Message-ID: <20121122020649.GH4371@opensource.wolfsonmicro.com>
References: <20121120215429.B621F3E1821@localhost>
 <13540495.epaCf4JVn9@percival> <50ACB59B.4090404@iki.fi>
 <20121121114018.GA31576@avionic-0098.adnet.avionic-design.de>
 <50ACC341.3090204@ti.com>
 <20121121130039.GA12191@avionic-0098.adnet.avionic-design.de>
 <50ACD7DC.5060405@ti.com>
 <CAAVeFuJofYwj926=3v0ApBCq_vNhCdC1PnzDc-B3d=LL_L40Uw@mail.gmail.com>
 <20121121151209.GA4048@avionic-0098.adnet.avionic-design.de>
 <CAAVeFuK_V6nb874bygioi35mFNxaWuveKOedLT=YYsP4JfVqgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5978505942544391717=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAAVeFuK_V6nb874bygioi35mFNxaWuveKOedLT=YYsP4JfVqgA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomba-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--===============5978505942544391717==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtJ+CqYNzKB4ukR4"
Content-Disposition: inline


--vtJ+CqYNzKB4ukR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2012 at 11:01:34AM +0900, Alexandre Courbot wrote:

> The thing I don't understand here is why would anyone want power
> sequences without the DT representation. Guys, that's the whole point! :)

> If we are to implement things into drivers, then callback functions
> are going to serve us just as well - even better, for they are more
> flexible. All we need to do is define a dedicated ops structure and
> have the driver plug the right callback functions depending on the
> "compatible" property of the DT device node. We don't need a framework
> for that.

It allows drivers (both board drivers and actual drivers) to write these
things in a semi-scripted form instead of having to open code everything
each time, it'd save a bunch of tedious stuff with resource requesting
for example.

--vtJ+CqYNzKB4ukR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrYiyAAoJELSic+t+oim9lEYP/RCc5Z/AauPvx91pM4fh+5Io
O1P01XB1dVyYEyJsiKe3WjUoocupWroppYio1DRNMvkvdzOYdT9MyGbFZFxNoHs3
1/o5UGOQalOv6WQVBE+aV6RLL2RaPL1/J5v2JqrS+cwt1zzmMZDxV5FpcKYEzxxu
Zq9PAwph7w97LulDBLc8730DSDcoLrSFiVGxLZe3SXHKCl4tWMz+w30a0U7vsNqV
PwO1HI2Nx5MGjiVAqgohD//SrAx/5YLTxPpTk2NgTEgwVi2bmQtBv5oPwsLtIjme
IjWaOHpKISzVwD5imCKhO9L04oqPxrB89Bc2QLbUfmWWOKjU9fXeh1YDivLbIEky
DcPxAvA9oLClau8YMxe3i7NKTu/FmxNlLVbVIQ/6Tixm6goQNDpo7XdqmVPLGzvM
AwkKJnapcgcxfZmfoG7FZKvZ7UjjaigOWyaEuhFmYytrZPdSbwYnfqsU6JzA2TmW
t1xq3jY/ceA6O63p2+vyGUfXBsrrrvapUIU4Bi288cmqzntzwHFSxOY15tdvbQ7C
S4lT/5LbqljK7hIU6wZ4UXKudq4lXRHYCV8zxYhmjUxn7MbgqZV+QdMZU8sdXgZB
qDmSXklyF3rHalFofvoSMKRyJ/T4uHRfpdSSwP6ULGpdWZnj++9rZW4PUpjv6Rg+
qbOCHrqC5zYUScEkOdUn
=bngD
-----END PGP SIGNATURE-----

--vtJ+CqYNzKB4ukR4--

--===============5978505942544391717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5978505942544391717==--
