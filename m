From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v9 0/8] Introduce on-chip interconnect API
Date: Thu, 6 Sep 2018 01:05:34 +1000
Message-ID: <20180906010534.329d0fca@canb.auug.org.au>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
        <CAHLCerNd0hrLKgbni95_RSYOtsNufMCVtHbAKa4W+eo8H2cL2A@mail.gmail.com>
        <20180905093620.6d9162ca@canb.auug.org.au>
        <fe9f3e91-93f9-d7d5-1643-dc09543e2850@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ov_.S6vdszHnU9RnU1g=UU+"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fe9f3e91-93f9-d7d5-1643-dc09543e2850@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, abailon@baylibre.com, maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lakml <linux-a>
List-Id: linux-pm@vger.kernel.org

--Sig_/Ov_.S6vdszHnU9RnU1g=UU+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Georgi,

On Wed, 5 Sep 2018 17:50:28 +0300 Georgi Djakov <georgi.djakov@linaro.org> =
wrote:
>
> On 09/05/2018 02:36 AM, Stephen Rothwell wrote:
> >=20
> > On Tue, 4 Sep 2018 15:54:27 +0530 Amit Kucheria <amit.kucheria@linaro.o=
rg> wrote: =20
> >>
> >> I'm currently reviewing this patchset (long overdue), but considering
> >> that we haven't added any major new features to the framework for the
> >> last couple of revisions, can you get this patchset merged into
> >> linux-next to see how things shake out there? We've had this merged
> >> branch merged into a CI build on kernelci for a while now w/o any
> >> major incident so we should increase its exposure.
> >>
> >> You could ask Stephen Rothwell if he'll accept the a branch directly
> >> from you or he needs an upstream maintainer (GregKH?) to carry it. =20
> >=20
> > Since it appears to have been well reviewed and tested, I can take it
> > if you send me a git URL and the names of contacts in case of issues
> > with the branch.  Once Greg has merged it, I will try to drop it again
> > (unless you think there will be an ongoing reason to keep it in
> > linux-next separately), but a prompting email would also be nice in
> > case I forget. =20
>=20
> Thank you! Below is the git URL to pull from and you can use my e-mail
> as contact for any issues.
>=20
> git://git.linaro.org/people/georgi.djakov/linux.git#icc-next
>=20
> I expect this to be a continuing effort with some upcoming users of this
> API, so i plan to maintain this branch and occasionally put some
> reviewed/tested patches to get wider integration testing. But let's see
> what happens now.
>=20
> In any case, if this increases your burden, feel free to drop it.

Added from (later) today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/Ov_.S6vdszHnU9RnU1g=UU+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluP8L4ACgkQAVBC80lX
0GyFTQf+OsZLutdzyWpL9/ua0OrFaZjWQLoQeo/YknRXDu5SO0JlHhQtsukHUSe/
cPCri2wHriSgRgrk48t17jA8p2MF9pkzblLrrmqJ4fYxdf3eSFsyZ6DKqGKSQzLs
rtEdSUs/+RFLyNF6p3cuv+vIPwkDrqI+TiXPJ4EAOjvrQMut5nCGv9TanC64eK8i
CnS7RJjcjM8fvwk+TeQGuFzmvJmyMvE3KUbPpachalE3bCFPDVrhHaHeFebp7yaa
wkPwFvhqKzp8NPiBEG+MikqsZLWvk+jkg3TqhE2+IadgeMXRJaSmeY1Ef8chq1xs
smB3W0PLpekjgxm8Tb33iIe22c351Q==
=6HXW
-----END PGP SIGNATURE-----

--Sig_/Ov_.S6vdszHnU9RnU1g=UU+--
