From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/10] i2c: move handling of suspended adapters to the
 core
Date: Tue, 8 Jan 2019 21:09:38 +0100
Message-ID: <20190108200937.bratvsbz4grk6m4e@ninjato>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mwtdafiryfs7cnw6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--mwtdafiryfs7cnw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 05:48:16PM +0100, Wolfram Sang wrote:
> Finally, here is the implementation Hans and I agreed on. Plus, all poten=
tial
> users I could spot already converted. Renesas R-Car driver was added on t=
op.
> This series was tested on a Renesas Lager board (R-Car H2). I had to hack=
 some
> error cases into the code to verify the workings. Thanks for all the test=
s so
> far. Of course, more testing never hurts ;)
>=20
> Please comment, review, test... a branch can be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/c=
ore-pm-helpers
>=20
> Thanks,
>=20
>    Wolfram
>=20
> Changes since RFC:
>=20
> * don't use bitfields anymore but an unsigned long flags variable which i=
s only
>   meant for flags to be changed when the adapter lock is held
>=20
> * split the genereic accessor into _mark_suspended() and _mark_resumed()
>=20
> * added kerneldoc and noted that using these helpers is optional
>=20
> * documented -ESHUTDOWN as the error code when trying to transfer using an
>   already suspended adapter
>=20
> * added acks from last series. Changes were minor enough to keep them. Pl=
ease let
>   me know if you disagree.
>=20
>=20
> Wolfram Sang (10):
>   i2c: add suspended flag and accessors for i2c adapters
>   i2c: reject new transfers when adapters are suspended
>   i2c: synquacer: remove unused is_suspended flag
>   i2c: brcmstb: use core helper to mark adapter suspended
>   i2c: zx2967: use core helper to mark adapter suspended
>   i2c: sprd: don't use pdev as variable name for struct device *
>   i2c: sprd: use core helper to mark adapter suspended
>   i2c: exynos5: use core helper to mark adapter suspended
>   i2c: s3c2410: use core helper to mark adapter suspended
>   i2c: rcar: add suspend/resume support

After a long road, I applied this series now to for-next. I only
squashed patches 1+2 to have the functionality in one place. And fixed a
typo in patch 1. Thanks to the testers and reviewers, and especially
Hans, for the input and discussions.

This will now get a full test cycle in -next. Let's see what happens...

And let's move on to how to add 'very late transfers without irqs' on
top of this series.

Happy hacking,

   Wolfram


--mwtdafiryfs7cnw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw1A30ACgkQFA3kzBSg
KbbxWw/8CGkkrx9NPVQwRLHRnix2QucE3r9aD0Df5ybapZtzhPdInKj5cJ6rtJjO
Ly0VQzmjKc+6FirBXJKF2Zdu35+/8k4y7owr0oh8fNxRjeWU0Pukp4n9NoX9+CsO
kXyzFEmbx8goTH1zzJgVz1yytO8ebGDCXX086M7D8MDW5ULx0mgzlIWcHkgy81Aj
gUEmnOjbw/JbmeBL0l+gseT2gO5GWArBv/mUFNkuz7pH0AjV/BbkImZ7BuhlYpOV
pvWM2PI2/7xbxpsjFIhIQbOs7hHY1iNkQjONftMT2sjCm8PKFRvf1Il+9K8AA/tp
N13Jn7IGI/lRrxlxGZZ3zr8o715PohfdI4G1OPFpjSorTBs1UV4f8BatsodHk8bh
fAKKjAkPw5/qRcMA8HnkyIrszoM7qCToOYFkBiMtv8+Drdtn5W13HCKL52PGiOds
sE9QS5at1rGWtzQX1fkLpq93GQTyNvFMURJ21YvXnU2U47o1hVLQNQKLQFjNNaLj
k9SOHjoI9xM7PWRgVghphFuUYqQMlHID9GHR1R0bS9uA++CxHzzP4/OTBwTIVBBl
YpTlg4+UtKgmSTWmWR/QSjGAIpRGiAOSIt2mz8YcCF2E9QtLFm2wMTWXxe48Wavt
9n/kVEg/kVdxR2yHZWu5guX3AmiPxUBiZxHhfKCYkrlFUuqL97Y=
=Vtra
-----END PGP SIGNATURE-----

--mwtdafiryfs7cnw6--
