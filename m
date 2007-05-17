From: Marcus Better <marcus@better.se>
Subject: Re: Re: 2.6.22-rc1 suspend to RAM problem
Date: Thu, 17 May 2007 10:44:23 +0200
Message-ID: <200705171044.26662.marcus@better.se>
References: <f2evir$8n1$1@sea.gmane.org> <f2f02b$a47$1@sea.gmane.org>
	<200705161534.42740.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8276579432107553477=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705161534.42740.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============8276579432107553477==
Content-Type: multipart/signed; boundary="nextPart3444941.NxUVblQzc7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3444941.NxUVblQzc7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> On Wednesday, 16 May 2007 15:13, Marcus Better wrote:
> > Marcus Better wrote:
> > > my Thinkpad R60 (x86_64, SMP, XFS) has failed to resume from RAM twic=
e,
> >
> > I should probably add that I have applied the Rafael's patch [1] for the
> > suspend-to-disk issue.
>
> Please revert it.  It's a debug-only patch and it fiddles with too many
> things.

Ok, so the resume-from-RAM problem appears on 2.6.22-rc1, but not on 2.6.20=
,=20
and probably not in 2.6.21. I may try to bisect it if I can find some time.=
=2E.

Also, it works correctly with "init=3D/bin/sh", but not when booting=20
with "single". Perhaps a driver issue?

Marcus

--nextPart3444941.NxUVblQzc7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGTBXqXjXn6TzcAQkRApHZAJ43WorEUmkzPCr5zhsa3gEj+L8/eQCfWQLA
Ah/9GYdSJSjQQSZy6s7lOz4=
=xK6j
-----END PGP SIGNATURE-----

--nextPart3444941.NxUVblQzc7--

--===============8276579432107553477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8276579432107553477==--
