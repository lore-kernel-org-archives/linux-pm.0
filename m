From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v6 08/18] cpufreq: exynos: Use device tree to determine
 if cpufreq cooling should be registered
Date: Sun, 25 Jan 2015 12:46:21 -0400
Message-ID: <20150125164559.GA29600@developer.hsd1.ca.comcast.net>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1422015260-14225-1-git-send-email-l.majewski@samsung.com>
 <CAKohpok1EacvJ3PCOZYnz81D3=P04apRp7VOxPFE1QxYF4Wydg@mail.gmail.com>
 <20150123145744.3dc47a47@amdc2363>
 <CAKohponvCzJrseb7UW1szYc=1M9BA=A8nVpocOQVyr1c=zO6VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38835 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbbAYQq2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 11:46:28 -0500
Content-Disposition: inline
In-Reply-To: <CAKohponvCzJrseb7UW1szYc=1M9BA=A8nVpocOQVyr1c=zO6VQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2015 at 07:31:14PM +0530, Viresh Kumar wrote:
> On 23 January 2015 at 19:27, Lukasz Majewski <l.majewski@samsung.com> wro=
te:
> > Please pay a note about following problem:
> >
> > Previously we got: cpu0: cpu@0 for all Exynos devices.
> >
> > Now, however, cpu numbering has changed (due to GIC rework).
> > For example:
> >
> > Exynos4412:
> >         cpus {
> >                 cpu0: cpu@A00 {
> >                         ...
> >                         #cooling-cells =3D <2>; /* min followed by max =
*/
> >                 };
> >
> >                 cpu@A01 {
> >                 };
> >
> >                 cpu@A02 {
> >                 };
> >
> >                 cpu@A03 {
> >                 };
> >         }
> >
> > Exynos 4210:
> >         cpus {
> >                 cpu0: cpu@900 {
> >                         #cooling-cells =3D <2>; /* min followed by max =
*/
> >                 };
> >
> >                 cpu@901 {
> >                 };
> >         };
> >
> > Exynos 5250:
> >         cpus {
> >                 cpu0: cpu@0 {
> >                         #cooling-cells =3D <2>; /* min followed by max =
*/
> >                 };
> >
> >                 cpu@1 {
> >                 };
> >         };
> >
> >
> > As you can see different cpu@XXY nodes we have and simply calling cpu@0
> > won't work.
>=20
> I wasn't asked you to get the cpu0 node from dt but this:
>=20
> cpu_dev =3D get_cpu_dev(0);
> np =3D of_node_get(cpu_dev->of_node);
>=20
> Wouldn't this work? You only need to guarantee that the cooling-cells is =
added
> onto the boot CPUs node.

Lukasz,

I agree with Viresh here, you can simplify your code.

I, somehow, missed this conversation and already applied v6 of this
patch in my -fixes branch. Can you please fix this by sending a
differential patch on top of this one applying Viresh's commit?

Viresh, my bad, I missed your comments.

Thanks


Eduardo=20

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUxR3QAAoJEMLUO4d9pOJW3soIAJvyrMrHTpWHjZbm61P1f6MX
go3z2rUcv9p+a1a0eRUsug2FO3GalTfySsJ/2XOZsFBUE32cVnqAa1umKF5FoZbg
do99gF9k7/kh6fJFPtGC9Dd5EplpqJSqlfRQnZdva7NbBD3Obc+NvmtEig5L/aIv
K95Q1iU42jqRckdJhSMXjHMBc/azRzV1vhKxr8pTooWav8nwyV+5c+egLy0wmaIB
yrnNahDaW54ex8kUVIfK72bfZh9rxgmxZQNgygzlrSsxfXpw6cRyygVTs38OdUX+
Tmv3hqRWQJniHcTVHwS8sG395HpPp2pJ4RQzzXf5esxWgpR7aM6RWQmtBfDo0sE=
=V3ks
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
