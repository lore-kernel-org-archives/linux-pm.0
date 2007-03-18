From: Marcus Better <marcus@better.se>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Sun, 18 Mar 2007 20:38:05 +0100
Message-ID: <200703182038.08374.marcus@better.se>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<20070318184919.GW752@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0982148553=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070318184919.GW752@stusta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============0982148553==
Content-Type: multipart/signed; boundary="nextPart3340993.n2nKbGebX1";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3340993.n2nKbGebX1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Subject    : ThinkPad R60: suspend broken
> References : http://lkml.org/lkml/2007/3/16/57
> Submitter  : Marcus Better <marcus@better.se>
> Status     : unknown

=46WIW, it's still broken as of commit cd05a1f818073a623455a58e756c5b419fc9=
8db9.

The in-kernel suspend to disk or RAM both hang after "Suspending consoles",=
=20
with the fan stopped.

--nextPart3340993.n2nKbGebX1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBF/ZUgXjXn6TzcAQkRAsVjAJsFa1jZRFH1X5q9L80VivQluNkeZgCggzQf
EWtxmhQH5WFCaAEmY2niYhA=
=FZMB
-----END PGP SIGNATURE-----

--nextPart3340993.n2nKbGebX1--



--===============0982148553==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0982148553==--
