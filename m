From: Marcus Better <marcus@better.se>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Thu, 3 May 2007 13:41:02 +0200
Message-ID: <200705031341.05023.marcus@better.se>
References: <f129n6$mro$1@sea.gmane.org> <200705021341.32454.marcus@better.se>
	<200705031006.27068.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8276674300116000013=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705031006.27068.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============8276674300116000013==
Content-Type: multipart/signed; boundary="nextPart2109531.K2XbVXg9qb";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2109531.K2XbVXg9qb
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Rafael J. Wysocki wrote:
> Could you please test the appended patch instead of the previous one?

It doesn't work. The suspend LED flashed for a while but the screen was bla=
nk=20
and didn't show any messages. It powered down after a while, without writin=
g=20
anything to disk.

Marcus

--nextPart2109531.K2XbVXg9qb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGOcpQXjXn6TzcAQkRAvP2AKC6CU+g0Uvjdtd/5BFwXxPD72R8uwCdEuPE
mJJP9+oh28kDexp3rUwWPOU=
=t6MH
-----END PGP SIGNATURE-----

--nextPart2109531.K2XbVXg9qb--



--===============8276674300116000013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8276674300116000013==--
