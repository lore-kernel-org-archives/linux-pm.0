From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] i915 / PM: Fix hibernate regression caused
 by suspend/resume splitting
Date: Mon, 22 Feb 2010 11:36:36 -0500
Message-ID: <87hbp9b52j.fsf__46139.970367267$1266856745$gmane$org@pollan.anholt.net>
References: <74fd948d1002171047g70d2bba0l957e264dfbc8ea23@mail.gmail.com>
	<201002172320.57491.rjw@sisk.pl>
	<74fd948d1002171629v7e86371cna4441e8feb27c326@mail.gmail.com>
	<201002182306.28052.rjw@sisk.pl>
	<alpine.LFD.2.00.1002220746260.4141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5953704353904526276=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1002220746260.4141@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pedro Ribeiro <pedrib@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

--===============5953704353904526276==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Feb 2010 07:47:53 -0800 (PST), Linus Torvalds <torvalds@linux-fo=
undation.org> wrote:
>=20
> Jesse, Eric, what's the status of this patch?=20
>=20
> Should I take it directly (I'd really like an Ack) or is it queued up in=
=20
> some tree waiting for me to pull? Or is there some reason not to have it,=
=20
> despite it fixing things for some people?

Acked-by: Eric Anholt <eric@anholt.net>

I just reviewed the rest of my tag:todo and I don't think I have
anything else I want to pull request for this kernel (finally), so if
you could just grab this patch it would be great.

(Well, there's also "quit trying to _LID on 855 because it's always a
pack of lies", but I'd rather do it as a backport later in case someone
screams)

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuCspQACgkQHUdvYGzw6ve4ugCeOGhREYyfd4NszfhiKiGda/OP
usIAnRQkBw81tfG3bmEGBNruqqmWJQ4t
=0Nxr
-----END PGP SIGNATURE-----
--=-=-=--

--===============5953704353904526276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5953704353904526276==--
