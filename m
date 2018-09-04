From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v9 0/8] Introduce on-chip interconnect API
Date: Wed, 5 Sep 2018 09:36:20 +1000
Message-ID: <20180905093620.6d9162ca@canb.auug.org.au>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
        <CAHLCerNd0hrLKgbni95_RSYOtsNufMCVtHbAKa4W+eo8H2cL2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=t3Ckflr7nTyHhTekgg8jUB"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHLCerNd0hrLKgbni95_RSYOtsNufMCVtHbAKa4W+eo8H2cL2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, abailon@baylibre.com, maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lakml <linux-a>
List-Id: linux-pm@vger.kernel.org

--Sig_/=t3Ckflr7nTyHhTekgg8jUB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Sep 2018 15:54:27 +0530 Amit Kucheria <amit.kucheria@linaro.org> =
wrote:
>
> I'm currently reviewing this patchset (long overdue), but considering
> that we haven't added any major new features to the framework for the
> last couple of revisions, can you get this patchset merged into
> linux-next to see how things shake out there? We've had this merged
> branch merged into a CI build on kernelci for a while now w/o any
> major incident so we should increase its exposure.
>=20
> You could ask Stephen Rothwell if he'll accept the a branch directly
> from you or he needs an upstream maintainer (GregKH?) to carry it.

Since it appears to have been well reviewed and tested, I can take it
if you send me a git URL and the names of contacts in case of issues
with the branch.  Once Greg has merged it, I will try to drop it again
(unless you think there will be an ongoing reason to keep it in
linux-next separately), but a prompting email would also be nice in
case I forget.
--=20
Cheers,
Stephen Rothwell

--Sig_/=t3Ckflr7nTyHhTekgg8jUB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluPFvQACgkQAVBC80lX
0Gxn4ggAgxqb5TVFn2+jl3s9fpEEFIlsoN7E8DJBp0ITdp2Eew7vGhicleD6YMg+
dBefTyw3AzyxamsW04KDqI/7z28vPNySy27SHYLB+wjfrW2QHhCTByl86kBRmNhA
K+Vc3T9qnaoAXN0tHLJpEm56HWI7/hR2r7UOJYlhsW/6ztXN6ul2ZGp4UQgFsKwv
1TaiRH1civVVuL6Po153iPiuJcoixSjwgpdRk1rM9aW0so4sXO1LF044HSECKu1q
ygklVH2mXEgH5nhSxFXnxLaxvdQaPFWJBy7nzxJi4qoEhKglohpYXEHjS0v66+Jq
I3EJyAvfSR49Z9jB3DFEXyAW6ZCvaQ==
=X8VW
-----END PGP SIGNATURE-----

--Sig_/=t3Ckflr7nTyHhTekgg8jUB--
