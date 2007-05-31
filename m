From: Marcus Better <marcus@better.se>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Thu, 31 May 2007 12:38:21 +0200
Message-ID: <200705311238.25399.marcus__20739.3633471385$1180607973$gmane$org@better.se>
References: <200705181207.45868.marcus@better.se>
	<200705210725.55299.marcus@better.se>
	<tkrat.e22d2cc8f9fe7f8a@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8043584567016107806=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <tkrat.e22d2cc8f9fe7f8a@s5r6.in-berlin.de>
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
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============8043584567016107806==
Content-Type: multipart/signed; boundary="nextPart4119394.Brk1zaVbvA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4119394.Brk1zaVbvA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Stefan Richter wrote:
> Marcus, please test:

> From: =3D?utf-8?q?Kristian_H=3DC3=3DB8gsberg?=3D <krh@redhat.com>

I have trouble applying this patch, perhaps due to the encoding. Can you=20
resend it without quoted-printable? (Or am I doing something wrong?)

$ patch -p1 --dry-run < /home/marcus/fw.diff
patching file drivers/firewire/fw-card.c
patch: **** malformed patch at line 11: --- 408,407 ----

Marcus

--nextPart4119394.Brk1zaVbvA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGXqWhXjXn6TzcAQkRAshGAKDGWquFsVsIx6r3vJJnZS9jQGkQEgCeNpjQ
ccADXfmoKS2L8AyXcbAaH94=
=twLj
-----END PGP SIGNATURE-----

--nextPart4119394.Brk1zaVbvA--

--===============8043584567016107806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8043584567016107806==--
