From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v6 08/18] cpufreq: exynos: Use device tree to determine
 if cpufreq cooling should be registered
Date: Sun, 25 Jan 2015 17:27:31 +0100
Message-ID: <20150125172731.7ee2b7ae@jawa>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
	<1422015260-14225-1-git-send-email-l.majewski@samsung.com>
	<CAKohpok1EacvJ3PCOZYnz81D3=P04apRp7VOxPFE1QxYF4Wydg@mail.gmail.com>
	<20150123145744.3dc47a47@amdc2363>
	<CAKohponvCzJrseb7UW1szYc=1M9BA=A8nVpocOQVyr1c=zO6VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/9lb/ef6UNwoAeykz50R2a7X"; protocol="application/pgp-signature"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKohponvCzJrseb7UW1szYc=1M9BA=A8nVpocOQVyr1c=zO6VQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

--Sig_/9lb/ef6UNwoAeykz50R2a7X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Jan 2015 19:31:14 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 23 January 2015 at 19:27, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
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
> >                         #cooling-cells =3D <2>; /* min followed by
> > max */ };
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
> >                         #cooling-cells =3D <2>; /* min followed by
> > max */ };
> >
> >                 cpu@901 {
> >                 };
> >         };
> >
> > Exynos 5250:
> >         cpus {
> >                 cpu0: cpu@0 {
> >                         #cooling-cells =3D <2>; /* min followed by
> > max */ };
> >
> >                 cpu@1 {
> >                 };
> >         };
> >
> >
> > As you can see different cpu@XXY nodes we have and simply calling
> > cpu@0 won't work.
>=20
> I wasn't asked you to get the cpu0 node from dt but this:
>=20
> cpu_dev =3D get_cpu_dev(0);
> np =3D of_node_get(cpu_dev->of_node);

Ingenious simplicity :-)

>=20
> Wouldn't this work? You only need to guarantee that the cooling-cells
> is added onto the boot CPUs node.

I will test it tomorrow and share results.

Viresh, thanks for tip.

Best regards,
Lukasz Majewski

--Sig_/9lb/ef6UNwoAeykz50R2a7X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlTFGXgACgkQf9/hG2YwgjEvDgCfThj8A2EoIlulQWFQavbmaEax
v9oAoLM6CJEoTbpqcmoX7529F3bbEP4x
=BjuW
-----END PGP SIGNATURE-----

--Sig_/9lb/ef6UNwoAeykz50R2a7X--
