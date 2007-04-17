From: Marcus Better <marcus@better.se>
Subject: Re: [3/3] 2.6.21-rc6: known regressions
Date: Tue, 17 Apr 2007 10:17:06 +0200
Message-ID: <200704171017.07012.marcus@better.se>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<200704160823.39074.marcus@better.se>
	<1176705924.5129.1.camel@daplas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1437511274=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176705924.5129.1.camel@daplas>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

--===============1437511274==
Content-Type: multipart/signed; boundary="nextPart2229691.KJKIlgKNhY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2229691.KJKIlgKNhY
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Have you tried other combinations?
>
> s2ram -m -p -f
> s2ram -s -p -f

Yes, I tried these slightly different combinations:

s2ram -f -a3 -s: Works! The screen becomes green but is restored quickly. I=
t=20
prints the following messages:
Allocated buffer at 0x11000 (base is 0x0)
ES: 0x1100 EBX: 0x0000
Save video state failed
Calling restore_state_from
=46unction not supported?
Restore video state failed
Switching back to vt1

s2ram -f -a3 -p: Screen goes green and then blank. Everything hangs, doesn'=
t=20
react to keyboard input.

s2ram -f -a3 -m: Works!

(Tested with 2.6.21-rc7.)

Thanks,

Marcus

--nextPart2229691.KJKIlgKNhY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGJIKCXjXn6TzcAQkRAlH0AKD6Unv2+1+zuthQtx7n+WmIdnhQsACg+YzJ
3zsX5tHjG7rv5ZlzSUxPyMM=
=+y5Q
-----END PGP SIGNATURE-----

--nextPart2229691.KJKIlgKNhY--



--===============1437511274==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1437511274==--
